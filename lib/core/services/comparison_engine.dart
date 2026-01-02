import 'dart:io';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart'; // For compute
import 'package:localizer_app_main/data/parsers/file_parser_factory.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart'; // Import new model
import 'package:localizer_app_main/data/models/app_settings.dart'; // Import AppSettings
import 'package:localizer_app_main/core/services/diff_calculator.dart';
import 'package:localizer_app_main/core/services/file_cache_service.dart';

// Data structure to hold comparison results
class ComparisonResult {
  final Map<String, String> file1Data;
  final Map<String, String> file2Data;
  final Map<String, ComparisonStatusDetail> diff;

  ComparisonResult(this.file1Data, this.file2Data, this.diff);
}

// enum StringComparisonStatus is REMOVED from here, will use the one from comparison_status_detail.dart

// _ParseRequest and _parseFileIsolate are not used if we stick to compute.
// Can be removed or kept if direct Isolate management is planned later for finer progress.
// For now, let's assume compute is sufficient as per existing code.

class ComparisonEngine {
  final FileParserFactory _parserFactory = FileParserFactory();

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

    final suffix = extractionMode.toString();

    // Check cache
    final cached = await FileCacheService().getCached(file, keySuffix: suffix);
    if (cached != null) {
      developer.log('Cache hit for ${file.path} ($suffix)', name: 'ComparisonEngine');
      return cached;
    }

    // Using compute for simplicity, which manages its own Isolate.
    // For more complex progress reporting or cancellation, direct Isolate management is better.
    final result = await compute(
      _performParse,
      _ComputeParseParams(
        filePath: file.path,
        forcedFormat: format,
        settingsAsJson: settings.toJson(),
        extractionModeName: extractionMode.name,
        requireBilingual: requireBilingual,
      ),
    );

    // Cache result
    try {
      final stat = await file.stat();
      FileCacheService().cache(file, result, stat.modified, keySuffix: suffix);
    } catch (e) {
      developer.log('Failed to cache file: $e', name: 'ComparisonEngine');
    }

    return result;
  }

  // We need a top-level function or static method for compute
  static Future<Map<String, String>> _performParse(
    _ComputeParseParams params,
  ) async {
    // Reconstruct a plain AppSettings object from the JSON map.
    // This new object is not a HiveObject and is safe to use in the isolate.
    final settings = AppSettings.fromJson(params.settingsAsJson);
    final parser = FileParserFactory().getParserForFile(
      File(params.filePath),
      format: params.forcedFormat,
    );
    if (parser == null) {
      throw Exception('Unsupported file type: ${params.filePath}');
    }
    if (params.requireBilingual && !parser.supportsBilingualExtraction) {
      throw InvalidBilingualFileException(
        'This file does not include both the original text and the '
        'translation.',
      );
    }
    return parser.parse(
      File(params.filePath),
      settings,
      extractionMode: _modeFromName(params.extractionModeName),
      requireBilingual: params.requireBilingual,
    );
  }

  Future<ComparisonResult> compareFiles(File file1, File file2, AppSettings settings) async {
    developer.log('Starting comparison', name: 'ComparisonEngine', error: '${file1.path} vs ${file2.path}');

    final file1DataFuture = _parseFile(
      file1,
      settings,
      format: settings.defaultSourceFormat,
      extractionMode: ExtractionMode.source,
    );
    final file2DataFuture = _parseFile(
      file2,
      settings,
      format: settings.defaultTargetFormat,
      extractionMode: ExtractionMode.target,
    );

    final results = await Future.wait([file1DataFuture, file2DataFuture]);
    final file1Data = results[0];
    final file2Data = results[1];

    // Run diff calculation in background isolate to prevent UI freeze
    final rawDiff = await compute(
      _performDiffCalculation,
      _ComputeDiffParams(
        data1: file1Data,
        data2: file2Data,
        ignoreCase: settings.ignoreCase,
        ignorePatterns: settings.ignorePatterns,
        ignoreWhitespace: settings.ignoreWhitespace,
        comparisonMode: settings.comparisonMode,
        similarityThreshold: settings.similarityThreshold,
      ),
    );
    developer.log('Comparison finished', name: 'ComparisonEngine');
    final diff = _deserializeDiff(rawDiff);
    return ComparisonResult(file1Data, file2Data, diff);
  }

  // Static method for compute isolate
  static Map<String, Map<String, Object?>> _performDiffCalculation(
    _ComputeDiffParams params,
  ) {
    final diff = DiffCalculator.calculateDiff(
      data1: params.data1,
      data2: params.data2,
      ignoreCase: params.ignoreCase,
      ignorePatterns: params.ignorePatterns,
      ignoreWhitespace: params.ignoreWhitespace,
      comparisonMode: params.comparisonMode,
      similarityThreshold: params.similarityThreshold,
    );
    return diff.map((key, value) => MapEntry(key, value.toMap()));
  }

  static Map<String, ComparisonStatusDetail> _deserializeDiff(
    Map<String, Map<String, Object?>> rawDiff,
  ) {
    return rawDiff.map(
      (key, value) => MapEntry(key, ComparisonStatusDetail.fromMap(value)),
    );
  }

  static ExtractionMode _modeFromName(String name) {
    return ExtractionMode.values.firstWhere(
      (value) => value.name == name,
      orElse: () => ExtractionMode.target,
    );
  }

  /// Compares source and target text extracted from a single bilingual file.
  Future<ComparisonResult> compareBilingualFile(
    File file,
    AppSettings settings,
  ) async {
    developer.log(
      'Starting bilingual comparison',
      name: 'ComparisonEngine',
      error: file.path,
    );

    final sourceDataFuture = _parseFile(
      file,
      settings,
      extractionMode: ExtractionMode.source,
      requireBilingual: true,
    );
    final targetDataFuture = _parseFile(
      file,
      settings,
      extractionMode: ExtractionMode.target,
      requireBilingual: true,
    );

    final results = await Future.wait([sourceDataFuture, targetDataFuture]);
    final sourceData = results[0];
    final targetData = results[1];

    // Run diff calculation in background isolate to prevent UI freeze
    final rawDiff = await compute(
      _performDiffCalculation,
      _ComputeDiffParams(
        data1: sourceData,
        data2: targetData,
        ignoreCase: settings.ignoreCase,
        ignorePatterns: settings.ignorePatterns,
        ignoreWhitespace: settings.ignoreWhitespace,
        comparisonMode: settings.comparisonMode,
        similarityThreshold: settings.similarityThreshold,
      ),
    );
    developer.log('Bilingual comparison finished', name: 'ComparisonEngine');
    final diff = _deserializeDiff(rawDiff);
    return ComparisonResult(sourceData, targetData, diff);
  }
}

// Helper class for parameters to compute function (parsing)
class _ComputeParseParams {
  _ComputeParseParams({
    required this.filePath,
    required this.forcedFormat,
    required this.settingsAsJson,
    required this.extractionModeName,
    required this.requireBilingual,
  });

  final String filePath;
  final String? forcedFormat;
  final Map<String, dynamic> settingsAsJson;
  final String extractionModeName;
  final bool requireBilingual;
}

// Helper class for parameters to compute function (diff calculation)
class _ComputeDiffParams {
  final Map<String, String> data1;
  final Map<String, String> data2;
  final bool ignoreCase;
  final List<String> ignorePatterns;
  final bool ignoreWhitespace;
  final String comparisonMode;
  final double similarityThreshold;

  _ComputeDiffParams({
    required this.data1,
    required this.data2,
    required this.ignoreCase,
    required this.ignorePatterns,
    required this.ignoreWhitespace,
    required this.comparisonMode,
    required this.similarityThreshold,
  });
}
