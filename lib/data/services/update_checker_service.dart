import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:localizer_app_main/core/services/dio_client.dart';

/// Represents the result of an update check.
class UpdateCheckResult {
  final bool updateAvailable;
  final String currentVersion;
  final String latestVersion;
  final String? changelog;
  final String? downloadUrl;
  final DateTime checkedAt;
  final String? error;

  const UpdateCheckResult({
    required this.updateAvailable,
    required this.currentVersion,
    required this.latestVersion,
    this.changelog,
    this.downloadUrl,
    required this.checkedAt,
    this.error,
  });

  factory UpdateCheckResult.error(String currentVersion, String errorMessage) {
    return UpdateCheckResult(
      updateAvailable: false,
      currentVersion: currentVersion,
      latestVersion: currentVersion,
      checkedAt: DateTime.now(),
      error: errorMessage,
    );
  }
}

/// Service for checking application updates from GitHub Releases.
class UpdateCheckerService {
  static const String _owner = 'KhazP';
  static const String _repo = 'LocalizerAppMain';
  static const String _apiBaseUrl = 'https://api.github.com';

  final DioClient _dioClient;
  String? _cachedCurrentVersion;
  UpdateCheckResult? _lastResult;

  UpdateCheckerService({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  /// Gets the cached last update check result.
  UpdateCheckResult? get lastResult => _lastResult;

  /// Checks for updates by comparing current version with latest GitHub release.
  Future<UpdateCheckResult> checkForUpdates() async {
    try {
      // Get current app version
      final currentVersion = await _getCurrentVersion();

      // Fetch latest release from GitHub with retry
      final response = await _fetchWithRetry(
        '$_apiBaseUrl/repos/$_owner/$_repo/releases/latest',
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'User-Agent': 'LocalizerApp/$currentVersion',
        },
      );

      if (response.statusCode == 404) {
        // No releases found
        _lastResult = UpdateCheckResult(
          updateAvailable: false,
          currentVersion: currentVersion,
          latestVersion: currentVersion,
          checkedAt: DateTime.now(),
          changelog: 'No releases available yet.',
        );
        return _lastResult!;
      }

      if (response.statusCode != 200) {
        throw Exception('GitHub API returned ${response.statusCode}');
      }

      final data = response.data as Map<String, dynamic>;

      // Parse release info
      final tagName = data['tag_name'] as String? ?? '';
      final latestVersion = _cleanVersionString(tagName);
      final changelog =
          data['body'] as String? ?? 'No release notes available.';
      final htmlUrl = data['html_url'] as String?;

      // Find download URL (prefer Windows installer, then any asset)
      String? downloadUrl = htmlUrl;
      final assets = data['assets'] as List<dynamic>? ?? [];
      for (final asset in assets) {
        final name = (asset['name'] as String? ?? '').toLowerCase();
        if (name.contains('.exe') ||
            name.contains('.msix') ||
            name.contains('.zip')) {
          downloadUrl = asset['browser_download_url'] as String?;
          break;
        }
      }

      // Compare versions
      final updateAvailable = _isNewerVersion(latestVersion, currentVersion);

      _lastResult = UpdateCheckResult(
        updateAvailable: updateAvailable,
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        changelog: changelog,
        downloadUrl: downloadUrl,
        checkedAt: DateTime.now(),
      );

      developer.log(
        'Update check complete: current=$currentVersion, latest=$latestVersion, updateAvailable=$updateAvailable',
        name: 'UpdateCheckerService',
      );

      return _lastResult!;
    } catch (e, stackTrace) {
      developer.log(
        'Update check failed: $e',
        name: 'UpdateCheckerService',
        error: e,
        stackTrace: stackTrace,
      );

      final currentVersion = await _getCurrentVersion();
      _lastResult = UpdateCheckResult.error(currentVersion, e.toString());
      return _lastResult!;
    }
  }

  /// Gets the current app version from package info.
  Future<String> _getCurrentVersion() async {
    if (_cachedCurrentVersion != null) {
      return _cachedCurrentVersion!;
    }

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _cachedCurrentVersion = packageInfo.version;
      return _cachedCurrentVersion!;
    } catch (e) {
      return '1.0.0';
    }
  }

  /// Cleans a version string by removing 'v' prefix and other non-numeric prefixes.
  String _cleanVersionString(String version) {
    var cleaned = version.trim();
    if (cleaned.startsWith('v') || cleaned.startsWith('V')) {
      cleaned = cleaned.substring(1);
    }
    return cleaned;
  }

  /// Compares two semantic versions.
  /// Returns true if [newVersion] is newer than [currentVersion].
  bool _isNewerVersion(String newVersion, String currentVersion) {
    try {
      final newParts = _parseVersion(newVersion);
      final currentParts = _parseVersion(currentVersion);

      // Compare major, minor, patch
      for (var i = 0; i < 3; i++) {
        final newPart = i < newParts.length ? newParts[i] : 0;
        final currentPart = i < currentParts.length ? currentParts[i] : 0;

        if (newPart > currentPart) return true;
        if (newPart < currentPart) return false;
      }

      return false; // Versions are equal
    } catch (e) {
      developer.log(
        'Version comparison failed: $e',
        name: 'UpdateCheckerService',
      );
      return false;
    }
  }

  /// Parses a version string into a list of integers.
  List<int> _parseVersion(String version) {
    // Remove any suffix after hyphen (e.g., "1.0.0-beta" -> "1.0.0")
    final mainVersion = version.split('-').first;

    return mainVersion
        .split('.')
        .map((part) => int.tryParse(part) ?? 0)
        .toList();
  }

  /// Fetches a URL with retry logic for network errors.
  Future<Response<Map<String, dynamic>>> _fetchWithRetry(
    String url, {
    Map<String, String>? headers,
    int retries = 3,
    Duration initialDelay = const Duration(seconds: 1),
  }) async {
    var delay = initialDelay;
    for (var i = 0; i < retries; i++) {
      try {
        return await _dioClient.get<Map<String, dynamic>>(url,
            headers: headers);
      } on DioException catch (e) {
        if (i == retries - 1) rethrow; // Rethrow on last attempt

        // Only retry on network/timeout errors
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionError) {
          developer.log(
            'Update check failed (attempt ${i + 1}/$retries). Retrying in ${delay.inSeconds}s...',
            name: 'UpdateCheckerService',
            error: e,
          );

          await Future.delayed(delay);
          delay *= 2; // Exponential backoff
        } else {
          rethrow;
        }
      } catch (e) {
        if (i == retries - 1) rethrow;

        developer.log(
          'Update check failed (attempt ${i + 1}/$retries). Retrying in ${delay.inSeconds}s...',
          name: 'UpdateCheckerService',
          error: e,
        );

        await Future.delayed(delay);
        delay *= 2;
      }
    }
    throw Exception('Failed to fetch after $retries attempts');
  }

  /// Fetches all releases for the changelog history.
  Future<List<Map<String, String>>> getRecentReleases({int limit = 5}) async {
    try {
      final currentVersion = await _getCurrentVersion();
      final response = await _fetchWithRetry(
        '$_apiBaseUrl/repos/$_owner/$_repo/releases?per_page=$limit',
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'User-Agent': 'LocalizerApp/$currentVersion',
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      // The response for releases list is an array, need to handle differently
      final data = response.data;
      if (data is! List) {
        return [];
      }

      return (data as List<dynamic>).map((release) {
        return {
          'version': _cleanVersionString(release['tag_name'] as String? ?? ''),
          'name': release['name'] as String? ?? '',
          'body': release['body'] as String? ?? '',
          'published_at': release['published_at'] as String? ?? '',
          'html_url': release['html_url'] as String? ?? '',
        };
      }).toList();
    } catch (e) {
      developer.log(
        'Failed to fetch releases: $e',
        name: 'UpdateCheckerService',
      );
      return [];
    }
  }

  /// Disposes the HTTP client.
  void dispose() {
    _dioClient.close();
  }
}
