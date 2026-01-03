import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart'; // For compute
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:localizer_app_main/data/parsers/file_parser_factory.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart'; // Import new model
import 'package:localizer_app_main/data/models/app_settings.dart'; // Import AppSettings
import 'package:localizer_app_main/core/services/diff_calculator.dart';
import 'package:localizer_app_main/core/services/file_cache_service.dart';

// Data structure to hold comparison results
// Uses IMap for the diff field for better performance with large translation maps (50k+ keys).
// IMap provides O(log n) operations with structural sharing, reducing memory overhead
// and improving iteration speed compared to standard Map.
class ComparisonResult {
  final Map<String, String> file1Data;
  final Map<String, String> file2Data;
  final IMap<String, ComparisonStatusDetail> diff;

  ComparisonResult(this.file1Data, this.file2Data, this.diff);
}

/// Callback for reporting comparison progress.
/// [percentage] is 0-100 indicating overall progress.
/// [stage] describes the current operation.
/// [bytesProcessed] and [totalBytes] are optional for file reading stages.
typedef ComparisonProgressCallback = void Function(
  int percentage,
  String stage, {
  int? bytesProcessed,
  int? totalBytes,
});

/// Message types for isolate communication
class _IsolateProgressMessage {
  final int processed;
  final int total;
  _IsolateProgressMessage(this.processed, this.total);
}

class _IsolateResultMessage {
  final Map<String, Map<String, Object?>> result;
  _IsolateResultMessage(this.result);
}

class _IsolateErrorMessage {
  final String error;
  _IsolateErrorMessage(this.error);
}

class ComparisonEngine {
  final FileParserFactory _parserFactory = FileParserFactory();

  Future<Map<String, String>> _parseFile(
    File file,
    AppSettings settings, {
    String? format,
    ExtractionMode extractionMode = ExtractionMode.target,
    bool requireBilingual = false,
    ComparisonProgressCallback? onProgress,
    int basePercentage = 0,
    int targetPercentage = 25,
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
      developer.log('Cache hit for ${file.path} ($suffix)',
          name: 'ComparisonEngine');
      onProgress?.call(targetPercentage, 'Using cached data...');
      return cached;
    }

    // Using compute for parsing, which manages its own Isolate.
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

    onProgress?.call(targetPercentage, 'Parsing complete');
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

  /// Run diff calculation in an isolate with progress reporting.
  ///
  /// This uses Isolate.spawn with SendPort/ReceivePort to receive
  /// progress updates during the calculation.
  Future<Map<String, Map<String, Object?>>> _runDiffWithProgress(
    _ComputeDiffParams params,
    ComparisonProgressCallback? onProgress,
    int basePercentage,
    int targetPercentage,
    String stageLabel,
  ) async {
    final receivePort = ReceivePort();

    // Calculate progress range for this stage
    final progressRange = targetPercentage - basePercentage;

    late Isolate isolate;
    try {
      // Spawn the isolate
      isolate = await Isolate.spawn(
        _diffIsolateEntryPoint,
        _DiffIsolateParams(
          sendPort: receivePort.sendPort,
          diffParams: params,
        ),
      );

      // Listen for messages from the isolate
      final completer = Completer<Map<String, Map<String, Object?>>>();

      receivePort.listen((message) {
        if (message is _IsolateProgressMessage) {
          // Calculate percentage within our range (50-90% for diff)
          if (message.total > 0) {
            final stageProgress = message.processed / message.total;
            final percentage =
                basePercentage + (progressRange * stageProgress).round();
            onProgress?.call(
                percentage.clamp(basePercentage, targetPercentage), stageLabel);
          }
        } else if (message is _IsolateResultMessage) {
          completer.complete(message.result);
        } else if (message is _IsolateErrorMessage) {
          completer.completeError(Exception(message.error));
        }
      });

      return await completer.future;
    } finally {
      receivePort.close();
      isolate.kill(priority: Isolate.immediate);
    }
  }

  /// Isolate entry point for diff calculation with progress reporting
  static void _diffIsolateEntryPoint(_DiffIsolateParams params) {
    try {
      final diff = DiffCalculator.calculateDiff(
        data1: params.diffParams.data1,
        data2: params.diffParams.data2,
        ignoreCase: params.diffParams.ignoreCase,
        ignorePatterns: params.diffParams.ignorePatterns,
        ignoreWhitespace: params.diffParams.ignoreWhitespace,
        comparisonMode: params.diffParams.comparisonMode,
        similarityThreshold: params.diffParams.similarityThreshold,
        onProgress: (processed, total) {
          params.sendPort.send(_IsolateProgressMessage(processed, total));
        },
      );

      // Convert to serializable format
      final serialized = diff.map((key, value) => MapEntry(key, value.toMap()));
      params.sendPort.send(_IsolateResultMessage(serialized));
    } catch (e) {
      params.sendPort.send(_IsolateErrorMessage(e.toString()));
    }
  }

  /// Compare two files with progress reporting.
  ///
  /// Progress stages:
  /// - 0-25%: Parsing source file
  /// - 25-50%: Parsing target file
  /// - 50-95%: Calculating differences (with granular progress)
  /// - 95-100%: Finalizing
  Future<ComparisonResult> compareFiles(
    File file1,
    File file2,
    AppSettings settings, {
    ComparisonProgressCallback? onProgress,
  }) async {
    developer.log('Starting comparison',
        name: 'ComparisonEngine', error: '${file1.path} vs ${file2.path}');

    // Stage 1: Parse source file (0-25%)
    onProgress?.call(0, 'Parsing source file...');
    final file1Data = await _parseFile(
      file1,
      settings,
      format: settings.defaultSourceFormat,
      extractionMode: ExtractionMode.source,
      onProgress: onProgress,
      basePercentage: 0,
      targetPercentage: 25,
    );

    // Stage 2: Parse target file (25-50%)
    onProgress?.call(25, 'Parsing target file...');
    final file2Data = await _parseFile(
      file2,
      settings,
      format: settings.defaultTargetFormat,
      extractionMode: ExtractionMode.target,
      onProgress: onProgress,
      basePercentage: 25,
      targetPercentage: 50,
    );

    // Stage 3: Calculate diff with progress (50-95%)
    onProgress?.call(50, 'Calculating differences...');

    final diffParams = _ComputeDiffParams(
      data1: file1Data,
      data2: file2Data,
      ignoreCase: settings.ignoreCase,
      ignorePatterns: settings.ignorePatterns,
      ignoreWhitespace: settings.ignoreWhitespace,
      comparisonMode: settings.comparisonMode,
      similarityThreshold: settings.similarityThreshold,
    );

    final rawDiff = await _runDiffWithProgress(
      diffParams,
      onProgress,
      50, // base percentage
      95, // target percentage
      'Calculating differences...',
    );

    onProgress?.call(95, 'Finalizing results...');
    developer.log('Comparison finished', name: 'ComparisonEngine');
    final diff = _deserializeDiff(rawDiff);

    onProgress?.call(100, 'Complete');
    return ComparisonResult(file1Data, file2Data, diff);
  }

  static IMap<String, ComparisonStatusDetail> _deserializeDiff(
    Map<String, Map<String, Object?>> rawDiff,
  ) {
    return rawDiff
        .map(
          (key, value) => MapEntry(key, ComparisonStatusDetail.fromMap(value)),
        )
        .toIMap();
  }

  static ExtractionMode _modeFromName(String name) {
    return ExtractionMode.values.firstWhere(
      (value) => value.name == name,
      orElse: () => ExtractionMode.target,
    );
  }

  /// Compares source and target text extracted from a single bilingual file.
  ///
  /// Progress stages:
  /// - 0-25%: Extracting source text
  /// - 25-50%: Extracting target text
  /// - 50-95%: Calculating differences (with granular progress)
  /// - 95-100%: Finalizing
  Future<ComparisonResult> compareBilingualFile(
    File file,
    AppSettings settings, {
    ComparisonProgressCallback? onProgress,
  }) async {
    developer.log(
      'Starting bilingual comparison',
      name: 'ComparisonEngine',
      error: file.path,
    );

    // Stage 1: Extract source text (0-25%)
    onProgress?.call(0, 'Extracting source text...');
    final sourceData = await _parseFile(
      file,
      settings,
      extractionMode: ExtractionMode.source,
      requireBilingual: true,
      onProgress: onProgress,
      basePercentage: 0,
      targetPercentage: 25,
    );

    // Stage 2: Extract target text (25-50%)
    onProgress?.call(25, 'Extracting target text...');
    final targetData = await _parseFile(
      file,
      settings,
      extractionMode: ExtractionMode.target,
      requireBilingual: true,
      onProgress: onProgress,
      basePercentage: 25,
      targetPercentage: 50,
    );

    // Stage 3: Calculate diff with progress (50-95%)
    onProgress?.call(50, 'Calculating differences...');

    final diffParams = _ComputeDiffParams(
      data1: sourceData,
      data2: targetData,
      ignoreCase: settings.ignoreCase,
      ignorePatterns: settings.ignorePatterns,
      ignoreWhitespace: settings.ignoreWhitespace,
      comparisonMode: settings.comparisonMode,
      similarityThreshold: settings.similarityThreshold,
    );

    final rawDiff = await _runDiffWithProgress(
      diffParams,
      onProgress,
      50, // base percentage
      95, // target percentage
      'Calculating differences...',
    );

    onProgress?.call(95, 'Finalizing results...');
    developer.log('Bilingual comparison finished', name: 'ComparisonEngine');
    final diff = _deserializeDiff(rawDiff);

    onProgress?.call(100, 'Complete');
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

// Helper class for parameters to diff calculation
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

// Parameters for the diff isolate
class _DiffIsolateParams {
  final SendPort sendPort;
  final _ComputeDiffParams diffParams;

  _DiffIsolateParams({
    required this.sendPort,
    required this.diffParams,
  });
}
