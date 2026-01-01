import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/core/services/language_detector.dart';
import 'package:localizer_app_main/core/services/problem_detector.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';
import 'package:localizer_app_main/data/parsers/file_parser_factory.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

/// Builds analytics data for the quality dashboard.
class QualityMetricsService {
  /// Creates a quality metrics service.
  QualityMetricsService({FileParserFactory? parserFactory})
      : _parserFactory = parserFactory ?? FileParserFactory();

  final FileParserFactory _parserFactory;

  /// Builds dashboard data from comparison history and settings.
  Future<QualityDashboardData> buildDashboardData({
    required List<ComparisonSession> history,
    required AppSettings settings,
  }) async {
    final warnings = <String>{};
    final languageSessions = _latestSessionsByLanguage(history);
    final languageReports = <LanguageQualityReport>[];

    for (final entry in languageSessions.entries) {
      final report = await _buildLanguageReport(
        session: entry.value,
        languageCode: entry.key,
        settings: settings,
        warnings: warnings,
      );
      if (report != null) {
        languageReports.add(report);
      }
    }

    languageReports.sort(
      (a, b) => a.languageLabel.compareTo(b.languageLabel),
    );

    final wordTrend = _buildWordTrend(history);
    final activityTrend = _buildActivityTrend(history);
    final burnUpTrend = _buildBurnUpTrend(history);

    return QualityDashboardData(
      languages: languageReports,
      wordTrend: wordTrend,
      activityTrend: activityTrend,
      burnUpTrend: burnUpTrend,
      warnings: warnings.toList()..sort(),
      generatedAt: DateTime.now(),
    );
  }

  /// Calculates coverage metrics from in-memory maps.
  CoverageMetrics calculateCoverageFromMaps({
    required Map<String, String> sourceData,
    required Map<String, String> targetData,
    required AppSettings settings,
  }) {
    var sourceKeyCount = 0;
    var translatedKeyCount = 0;
    var sourceWordCount = 0;
    var translatedWordCount = 0;

    for (final entry in sourceData.entries) {
      if (_shouldIgnoreKey(entry.key, settings.ignorePatterns)) {
        continue;
      }
      sourceKeyCount++;
      sourceWordCount += _countWords(entry.value);
      final targetValue = targetData[entry.key];
      if (targetValue != null && targetValue.trim().isNotEmpty) {
        translatedKeyCount++;
        translatedWordCount += _countWords(targetValue);
      }
    }

    return CoverageMetrics(
      sourceKeyCount: sourceKeyCount,
      translatedKeyCount: translatedKeyCount,
      sourceWordCount: sourceWordCount,
      translatedWordCount: translatedWordCount,
    );
  }

  /// Detects issue metrics from in-memory maps.
  IssueMetrics detectIssuesFromMaps({
    required Map<String, String> sourceData,
    required Map<String, String> targetData,
    required AppSettings settings,
    int? issueLimit,
  }) {
    final placeholderIssues = <QualityIssue>[];
    final lengthIssues = <QualityIssue>[];
    final duplicateIssues = <QualityIssue>[];

    var placeholderCount = 0;
    var lengthCount = 0;

    final duplicateBuckets = <String, _DuplicateBucket>{};

    for (final entry in sourceData.entries) {
      if (_shouldIgnoreKey(entry.key, settings.ignorePatterns)) {
        continue;
      }
      final targetValue = targetData[entry.key];

      if (ProblemDetector.hasPlaceholderMismatch(entry.value, targetValue)) {
        placeholderCount++;
        if (_withinLimit(placeholderIssues, issueLimit)) {
          placeholderIssues.add(
            QualityIssue(
              key: entry.key,
              sourceValue: entry.value,
              targetValue: targetValue,
              description: _describePlaceholderMismatch(
                entry.value,
                targetValue ?? '',
              ),
              type: QualityIssueType.placeholderMismatch,
            ),
          );
        }
      }

      if (ProblemDetector.hasSuspiciousLength(entry.value, targetValue)) {
        lengthCount++;
        if (_withinLimit(lengthIssues, issueLimit)) {
          lengthIssues.add(
            QualityIssue(
              key: entry.key,
              sourceValue: entry.value,
              targetValue: targetValue,
              description: _describeLengthOutlier(
                entry.value,
                targetValue ?? '',
              ),
              type: QualityIssueType.lengthOutlier,
            ),
          );
        }
      }

      if (targetValue == null || targetValue.trim().isEmpty) {
        continue;
      }

      final normalized = _normalizeValue(targetValue);
      if (normalized.isEmpty) {
        continue;
      }
      duplicateBuckets
          .putIfAbsent(
            normalized,
            () => _DuplicateBucket(
              displayValue: targetValue,
              keys: <String>[],
            ),
          )
          .keys
          .add(entry.key);
    }

    final duplicateEntries = duplicateBuckets.entries
        .where((entry) => entry.value.keys.length > 1)
        .toList();
    duplicateEntries.sort(
      (a, b) => b.value.keys.length.compareTo(a.value.keys.length),
    );

    var duplicateCount = 0;
    for (final entry in duplicateEntries) {
      final keys = [...entry.value.keys]..sort();
      duplicateCount += keys.length;
      if (_withinLimit(duplicateIssues, issueLimit)) {
        duplicateIssues.add(
          QualityIssue(
            key: _formatDuplicateKeySummary(keys),
            sourceValue: null,
            targetValue: entry.value.displayValue,
            description: _describeDuplicateKeys(keys),
            type: QualityIssueType.duplicateValue,
            relatedKeys: keys,
          ),
        );
      }
    }

    return IssueMetrics(
      placeholderMismatchCount: placeholderCount,
      lengthOutlierCount: lengthCount,
      duplicateValueCount: duplicateCount,
      placeholderMismatchIssues: placeholderIssues,
      lengthOutlierIssues: lengthIssues,
      duplicateValueIssues: duplicateIssues,
    );
  }

  Future<LanguageQualityReport?> _buildLanguageReport({
    required ComparisonSession session,
    required String languageCode,
    required AppSettings settings,
    required Set<String> warnings,
  }) async {
    final file1 = File(session.file1Path);
    final file2 = File(session.file2Path);

    if (!await file1.exists() || !await file2.exists()) {
      warnings.add('Some files were skipped because they were not found.');
      return null;
    }

    try {
      final isBilingual = session.file1Path == session.file2Path;
      final sourceFormat = isBilingual ? null : settings.defaultSourceFormat;
      final targetFormat = isBilingual ? null : settings.defaultTargetFormat;
      final sourceData = await _parseFile(
        file1,
        settings,
        format: sourceFormat,
        extractionMode: ExtractionMode.source,
        requireBilingual: isBilingual,
      );
      final targetData = await _parseFile(
        file2,
        settings,
        format: targetFormat,
        extractionMode: ExtractionMode.target,
        requireBilingual: isBilingual,
      );

      final coverage = calculateCoverageFromMaps(
        sourceData: sourceData,
        targetData: targetData,
        settings: settings,
      );
      final issues = detectIssuesFromMaps(
        sourceData: sourceData,
        targetData: targetData,
        settings: settings,
      );

      return LanguageQualityReport(
        languageCode: languageCode,
        languageLabel: LanguageDetector.displayName(languageCode),
        coverage: coverage,
        issues: issues,
      );
    } on InvalidBilingualFileException {
      warnings.add('Some bilingual files could not be read.');
      return null;
    } catch (error, stackTrace) {
      developer.log(
        'Failed to build quality report',
        name: 'QualityMetricsService',
        error: error,
        stackTrace: stackTrace,
      );
      warnings.add('Some files could not be read.');
      return null;
    }
  }

  List<WordTrendPoint> _buildWordTrend(List<ComparisonSession> history) {
    final points = history
        .where((session) => session.translatedWordCount != null)
        .map((session) {
          double coverage = 0;
          if (session.sourceKeyCount != null &&
              session.sourceKeyCount! > 0 &&
              session.translatedKeyCount != null) {
            coverage =
                (session.translatedKeyCount! / session.sourceKeyCount!) * 100;
          }

          return WordTrendPoint(
            timestamp: session.timestamp,
            words: session.translatedWordCount ?? 0,
            coveragePercent: coverage,
          );
        })
        .toList();

    points.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return points;
  }

  List<ActivityTrendPoint> _buildActivityTrend(List<ComparisonSession> history) {
    final points = history.map((session) {
      return ActivityTrendPoint(
        timestamp: session.timestamp,
        added: session.stringsAdded,
        modified: session.stringsModified,
        removed: session.stringsRemoved,
      );
    }).toList();

    points.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return points;
  }

  List<BurnUpPoint> _buildBurnUpTrend(List<ComparisonSession> history) {
    final points = <BurnUpPoint>[];
    for (final session in history) {
      if (session.sourceKeyCount != null && session.translatedKeyCount != null) {
        points.add(
          BurnUpPoint(
            timestamp: session.timestamp,
            totalKeys: session.sourceKeyCount!,
            translatedKeys: session.translatedKeyCount!,
          ),
        );
      }
    }
    points.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return points;
  }

  Map<String, ComparisonSession> _latestSessionsByLanguage(
    List<ComparisonSession> history,
  ) {
    final sorted = [...history]
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    final latest = <String, ComparisonSession>{};

    for (final session in sorted) {
      final languageCode = LanguageDetector.detectFromPath(session.file2Path);
      latest.putIfAbsent(languageCode, () => session);
    }

    return latest;
  }

  Future<Map<String, String>> _parseFile(
    File file,
    AppSettings settings, {
    String? format,
    ExtractionMode extractionMode = ExtractionMode.target,
    bool requireBilingual = false,
  }) async {
    final parser = _parserFactory.getParserForFile(file, format: format);
    if (parser == null) {
      throw Exception('Unsupported file type: ${file.path}');
    }
    if (requireBilingual && !parser.supportsBilingualExtraction) {
      throw InvalidBilingualFileException(
        'This file does not include both the original text and the '
        'translation.',
      );
    }

    return compute(
      _performParse,
      _ComputeParseParams(
        file.path,
        parser,
        settings.toJson(),
        extractionMode,
        requireBilingual,
      ),
    );
  }

  static Future<Map<String, String>> _performParse(
    _ComputeParseParams params,
  ) async {
    final settings = AppSettings.fromJson(params.settingsAsJson);
    return params.parser.parse(
      File(params.filePath),
      settings,
      extractionMode: params.extractionMode,
      requireBilingual: params.requireBilingual,
    );
  }

  static bool _shouldIgnoreKey(String key, List<String> ignorePatterns) {
    for (final pattern in ignorePatterns) {
      try {
        if (RegExp(pattern).hasMatch(key)) {
          return true;
        }
      } catch (_) {
        continue;
      }
    }
    return false;
  }

  static int _countWords(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 0;
    }
    final parts = trimmed.split(RegExp(r'\s+'));
    var count = 0;
    for (final part in parts) {
      if (part.trim().isNotEmpty) {
        count++;
      }
    }
    return count == 0 ? 1 : count;
  }

  static String _normalizeValue(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return '';
    }
    return trimmed.replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
  }

  static bool _withinLimit(
    List<QualityIssue> issues,
    int? issueLimit,
  ) {
    if (issueLimit == null) {
      return true;
    }
    return issues.length < issueLimit;
  }

  static List<String> _extractPlaceholders(String value) {
    final placeholderRegex = RegExp(r'\{[a-zA-Z0-9_]+\}');
    return placeholderRegex
        .allMatches(value)
        .map((match) => match.group(0))
        .whereType<String>()
        .toList();
  }

  static String _describePlaceholderMismatch(
    String source,
    String target,
  ) {
    final sourcePlaceholders = _extractPlaceholders(source);
    final targetPlaceholders = _extractPlaceholders(target);

    final missing = _placeholderDifference(
      sourcePlaceholders,
      targetPlaceholders,
    );
    final extra = _placeholderDifference(
      targetPlaceholders,
      sourcePlaceholders,
    );

    if (missing.isNotEmpty && extra.isNotEmpty) {
      return 'Missing ${missing.join(', ')}; extra ${extra.join(', ')}';
    }
    if (missing.isNotEmpty) {
      return 'Missing ${missing.join(', ')}';
    }
    if (extra.isNotEmpty) {
      return 'Extra ${extra.join(', ')}';
    }
    return 'Placeholder mismatch';
  }

  static List<String> _placeholderDifference(
    List<String> primary,
    List<String> secondary,
  ) {
    final secondaryCounts = <String, int>{};
    for (final placeholder in secondary) {
      secondaryCounts[placeholder] = (secondaryCounts[placeholder] ?? 0) + 1;
    }

    final diff = <String>{};
    for (final placeholder in primary) {
      final remaining = secondaryCounts[placeholder] ?? 0;
      if (remaining > 0) {
        secondaryCounts[placeholder] = remaining - 1;
      } else {
        diff.add(placeholder);
      }
    }
    return diff.toList();
  }

  static String _describeLengthOutlier(String source, String target) {
    final sourceLength = source.trim().length;
    final targetLength = target.trim().length;
    final sourceLabel = _formatCharCount(sourceLength);
    final targetLabel = _formatCharCount(targetLength);
    
    if (sourceLength == 0) return 'Source is empty';

    final diff = targetLength - sourceLength;
    final percent = (diff / sourceLength * 100).round();
    final sign = diff > 0 ? '+' : '';
    
    return 'Target is $targetLabel ($sign$percent%) vs source $sourceLabel';
  }

  static String _formatCharCount(int count) {
    if (count == 1) {
      return '1 char';
    }
    return '$count chars';
  }

  static String _formatDuplicateKeySummary(List<String> keys) {
    if (keys.isEmpty) {
      return 'Multiple keys';
    }
    if (keys.length <= 2) {
      return keys.join(', ');
    }
    final preview = keys.take(2).join(', ');
    return '$preview (+${keys.length - 2} more)';
  }

  static String _describeDuplicateKeys(List<String> keys) {
    if (keys.isEmpty) {
      return 'Shared by multiple keys';
    }
    return 'Keys: ${keys.join(', ')}';
  }
}

class _ComputeParseParams {
  _ComputeParseParams(
    this.filePath,
    this.parser,
    this.settingsAsJson,
    this.extractionMode,
    this.requireBilingual,
  );

  final String filePath;
  final LocalizationParser parser;
  final Map<String, dynamic> settingsAsJson;
  final ExtractionMode extractionMode;
  final bool requireBilingual;
}

class _DuplicateBucket {
  _DuplicateBucket({
    required this.displayValue,
    required this.keys,
  });

  final String displayValue;
  final List<String> keys;
}
