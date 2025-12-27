import 'dart:io';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart'; // For compute
import 'package:localizer_app_main/data/parsers/file_parser_factory.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart'; // Import new model
import 'package:localizer_app_main/data/models/app_settings.dart'; // Import AppSettings
import 'package:localizer_app_main/core/services/diff_calculator.dart';

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
    // Using compute for simplicity, which manages its own Isolate.
    // For more complex progress reporting or cancellation, direct Isolate management is better.
    return await compute(
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

  // We need a top-level function or static method for compute
  static Future<Map<String, String>> _performParse(
    _ComputeParseParams params,
  ) async {
    // Reconstruct a plain AppSettings object from the JSON map.
    // This new object is not a HiveObject and is safe to use in the isolate.
    final settings = AppSettings.fromJson(params.settingsAsJson);
    return await params.parser.parse(
      File(params.filePath),
      settings,
      extractionMode: params.extractionMode,
      requireBilingual: params.requireBilingual,
    );
  }

  Future<ComparisonResult> compareFiles(File file1, File file2, AppSettings settings) async {
    developer.log('Starting comparison', name: 'ComparisonEngine', error: '${file1.path} vs ${file2.path}');

    final file1DataFuture = _parseFile(
      file1,
      settings,
      format: settings.defaultSourceFormat,
    );
    final file2DataFuture = _parseFile(
      file2,
      settings,
      format: settings.defaultTargetFormat,
    );

    final results = await Future.wait([file1DataFuture, file2DataFuture]);
    final file1Data = results[0];
    final file2Data = results[1];

    final diff = DiffCalculator.calculateDiff(
      data1: file1Data,
      data2: file2Data,
      ignoreCase: settings.ignoreCase,
      ignorePatterns: settings.ignorePatterns,
      ignoreWhitespace: settings.ignoreWhitespace,
      comparisonMode: settings.comparisonMode,
      similarityThreshold: settings.similarityThreshold,
    );
    developer.log('Comparison finished', name: 'ComparisonEngine');
    return ComparisonResult(file1Data, file2Data, diff);
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

    final diff = DiffCalculator.calculateDiff(
      data1: sourceData,
      data2: targetData,
      ignoreCase: settings.ignoreCase,
      ignorePatterns: settings.ignorePatterns,
      ignoreWhitespace: settings.ignoreWhitespace,
      comparisonMode: settings.comparisonMode,
      similarityThreshold: settings.similarityThreshold,
    );
    developer.log('Bilingual comparison finished', name: 'ComparisonEngine');
    return ComparisonResult(sourceData, targetData, diff);
  }
}

// Helper class for parameters to compute function
class _ComputeParseParams {
  final String filePath;
  final LocalizationParser parser;
  final Map<String, dynamic> settingsAsJson;
  final ExtractionMode extractionMode;
  final bool requireBilingual;
  _ComputeParseParams(
    this.filePath,
    this.parser,
    this.settingsAsJson,
    this.extractionMode,
    this.requireBilingual,
  );
}
