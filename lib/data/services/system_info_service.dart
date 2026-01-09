import 'dart:io';

/// Holds system information data for display in the About section.
class SystemInfo {
  final String flutterVersion;
  final String dartVersion;
  final String availableDiskSpace;
  final String memoryUsage;
  final String totalMemory;

  const SystemInfo({
    required this.flutterVersion,
    required this.dartVersion,
    required this.availableDiskSpace,
    required this.memoryUsage,
    required this.totalMemory,
  });

  factory SystemInfo.loading() => const SystemInfo(
        flutterVersion: 'Loading...',
        dartVersion: 'Loading...',
        availableDiskSpace: 'Loading...',
        memoryUsage: 'Loading...',
        totalMemory: 'Loading...',
      );

  factory SystemInfo.error() => const SystemInfo(
        flutterVersion: 'Unavailable',
        dartVersion: 'Unavailable',
        availableDiskSpace: 'Unavailable',
        memoryUsage: 'Unavailable',
        totalMemory: 'Unavailable',
      );
}

/// Service to retrieve system information for the About page.
class SystemInfoService {
  /// Gets the Dart SDK version from the Platform.
  String getDartVersion() {
    return Platform.version.split(' ').first;
  }

  /// Formats bytes to a human-readable string.
  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }

  /// Gets available disk space for the current drive/volume.
  Future<String> getAvailableDiskSpace() async {
    try {
      if (Platform.isWindows) {
        // Use WMIC to get free space on the system drive
        // SECURITY: Removed runInShell: true, using hardcoded safe arguments
        final result = await Process.run(
          'wmic',
          ['logicaldisk', 'where', 'DeviceID="C:"', 'get', 'FreeSpace'],
        );
        if (result.exitCode == 0) {
          final output = result.stdout.toString().trim();
          final lines = output.split('\n');
          if (lines.length > 1) {
            final freeSpace = int.tryParse(lines[1].trim());
            if (freeSpace != null) {
              return _formatBytes(freeSpace);
            }
          }
        }
      } else if (Platform.isMacOS || Platform.isLinux) {
        // Use df command for Unix-like systems
        // SECURITY: Removed runInShell: true, using hardcoded safe arguments
        final result = await Process.run('df', ['-k', '/']);
        if (result.exitCode == 0) {
          final lines = result.stdout.toString().trim().split('\n');
          if (lines.length > 1) {
            final parts = lines[1].split(RegExp(r'\s+'));
            if (parts.length >= 4) {
              // Available space is in 1K blocks
              final availableKb = int.tryParse(parts[3]);
              if (availableKb != null) {
                return _formatBytes(availableKb * 1024);
              }
            }
          }
        }
      }
      return 'Unavailable';
    } catch (e) {
      return 'Unavailable';
    }
  }

  /// Gets current memory usage of the application.
  Future<Map<String, String>> getMemoryInfo() async {
    try {
      if (Platform.isWindows) {
        // Get current process memory using tasklist
        final currentPid = pid;
        // SECURITY: Validate PID is a positive integer
        if (currentPid <= 0 || currentPid > 2147483647) {
          return {'usage': 'Unavailable', 'total': 'Unavailable'};
        }
        // SECURITY: Removed runInShell: true, PID is validated as numeric
        final result = await Process.run(
          'tasklist',
          ['/FI', 'PID eq $currentPid', '/FO', 'CSV', '/NH'],
        );
        if (result.exitCode == 0) {
          final output = result.stdout.toString().trim();
          // Parse CSV format: "Image Name","PID","Session Name","Session#","Mem Usage"
          final csvParts = output.split(',');
          if (csvParts.length >= 5) {
            final memUsage = csvParts[4]
                .replaceAll('"', '')
                .replaceAll(' K', '')
                .replaceAll(',', '')
                .trim();
            final memKb = int.tryParse(memUsage);
            if (memKb != null) {
              return {
                'usage': _formatBytes(memKb * 1024),
                'total': await _getSystemTotalMemory(),
              };
            }
          }
        }
      } else if (Platform.isMacOS || Platform.isLinux) {
        // Get process memory using ps command
        final currentPid = pid;
        // SECURITY: Validate PID is a positive integer
        if (currentPid <= 0 || currentPid > 2147483647) {
          return {'usage': 'Unavailable', 'total': 'Unavailable'};
        }
        // SECURITY: Removed runInShell: true, PID is validated as numeric
        final result = await Process.run(
          'ps',
          ['-o', 'rss=', '-p', '$currentPid'],
        );
        if (result.exitCode == 0) {
          final rssKb = int.tryParse(result.stdout.toString().trim());
          if (rssKb != null) {
            return {
              'usage': _formatBytes(rssKb * 1024),
              'total': await _getSystemTotalMemory(),
            };
          }
        }
      }
      return {'usage': 'Unavailable', 'total': 'Unavailable'};
    } catch (e) {
      return {'usage': 'Unavailable', 'total': 'Unavailable'};
    }
  }

  Future<String> _getSystemTotalMemory() async {
    try {
      if (Platform.isWindows) {
        // SECURITY: Removed runInShell: true, using hardcoded safe arguments
        final result = await Process.run(
          'wmic',
          ['OS', 'get', 'TotalVisibleMemorySize'],
        );
        if (result.exitCode == 0) {
          final lines = result.stdout.toString().trim().split('\n');
          if (lines.length > 1) {
            final totalKb = int.tryParse(lines[1].trim());
            if (totalKb != null) {
              return _formatBytes(totalKb * 1024);
            }
          }
        }
      } else if (Platform.isMacOS) {
        // SECURITY: Removed runInShell: true, using hardcoded safe arguments
        final result = await Process.run(
          'sysctl',
          ['-n', 'hw.memsize'],
        );
        if (result.exitCode == 0) {
          final totalBytes = int.tryParse(result.stdout.toString().trim());
          if (totalBytes != null) {
            return _formatBytes(totalBytes);
          }
        }
      } else if (Platform.isLinux) {
        // SECURITY: Removed runInShell: true, using hardcoded safe arguments
        final result = await Process.run(
          'grep',
          ['MemTotal', '/proc/meminfo'],
        );
        if (result.exitCode == 0) {
          final match = RegExp(r'(\d+)').firstMatch(result.stdout.toString());
          if (match != null) {
            final totalKb = int.tryParse(match.group(1)!);
            if (totalKb != null) {
              return _formatBytes(totalKb * 1024);
            }
          }
        }
      }
      return 'Unavailable';
    } catch (e) {
      return 'Unavailable';
    }
  }

  /// Gets all system information asynchronously.
  Future<SystemInfo> getSystemInfo() async {
    try {
      final diskSpace = await getAvailableDiskSpace();
      final memoryInfo = await getMemoryInfo();

      return SystemInfo(
        flutterVersion: _getFlutterVersion(),
        dartVersion: getDartVersion(),
        availableDiskSpace: diskSpace,
        memoryUsage: memoryInfo['usage'] ?? 'Unavailable',
        totalMemory: memoryInfo['total'] ?? 'Unavailable',
      );
    } catch (e) {
      return SystemInfo.error();
    }
  }

  /// Gets the Flutter version. This returns the embedded version
  /// that was used to build the app.
  String _getFlutterVersion() {
    // Flutter version is embedded at build time
    // We can only show the Dart version at runtime
    // For the Flutter version, we would need to read from a generated file
    // or use a build-time constant
    return 'See Dart Version';
  }
}
