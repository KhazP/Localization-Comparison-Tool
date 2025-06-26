import 'dart:io';
import 'dart:async';
// import 'dart:isolate'; // Not directly used if only using compute
import 'package:flutter/foundation.dart'; // For compute
import 'package:localizer_app_main/data/parsers/file_parser_factory.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart'; // Import new model
import 'package:localizer_app_main/data/models/app_settings.dart'; // Import AppSettings
import 'package:string_similarity/string_similarity.dart'; // Import for similarity calculation
import 'package:localizer_app_main/core/services/diff_calculator.dart';

// Data structure to hold comparison results
class ComparisonResult {
  final Map<String, String> file1Data;
  final Map<String, String> file2Data;
  final Map<String, ComparisonStatusDetail> diff; // Changed type
  // TODO: Add more details like added, removed, modified counts

  ComparisonResult(this.file1Data, this.file2Data, this.diff);
}

// enum StringComparisonStatus is REMOVED from here, will use the one from comparison_status_detail.dart

// _ParseRequest and _parseFileIsolate are not used if we stick to compute.
// Can be removed or kept if direct Isolate management is planned later for finer progress.
// For now, let's assume compute is sufficient as per existing code.

class ComparisonEngine {
  final FileParserFactory _parserFactory = FileParserFactory();

  Future<Map<String, String>> _parseFile(File file, AppSettings settings) async {
    final parser = _parserFactory.getParserForFile(file);
    if (parser == null) {
      throw Exception('Unsupported file type: ${file.path}');
    }
    // Using compute for simplicity, which manages its own Isolate.
    // For more complex progress reporting or cancellation, direct Isolate management is better.
    return await compute(_performParse, _ComputeParseParams(file.path, parser, settings.toJson()));
  }

  // We need a top-level function or static method for compute
  static Future<Map<String, String>> _performParse(_ComputeParseParams params) async {
    // Reconstruct a plain AppSettings object from the JSON map.
    // This new object is not a HiveObject and is safe to use in the isolate.
    final settings = AppSettings.fromJson(params.settingsAsJson);
    return await params.parser.parse(File(params.filePath), settings);
  }

  Future<ComparisonResult> compareFiles(File file1, File file2, AppSettings settings) async {
    // TODO: Implement progress reporting via ProgressBloc
    print('Starting comparison between ${file1.path} and ${file2.path}');
    print('Comparison settings: ignoreCase: ${settings.ignoreCase}, ignoreWhitespace: ${settings.ignoreWhitespace}, ignorePatterns: ${settings.ignorePatterns}');

    final file1DataFuture = _parseFile(file1, settings);
    final file2DataFuture = _parseFile(file2, settings);

    final results = await Future.wait([file1DataFuture, file2DataFuture]);
    final file1Data = results[0];
    final file2Data = results[1];

    final diff = DiffCalculator.calculateDiff(
      data1: file1Data,
      data2: file2Data,
      ignoreCase: settings.ignoreCase,
      ignorePatterns: settings.ignorePatterns,
      ignoreWhitespace: settings.ignoreWhitespace,
    );
    print('Comparison finished.');
    return ComparisonResult(file1Data, file2Data, diff);
  }

  // TODO: Implement directory-level recursive comparison
  // This would involve:
  // 1. Scanning directories for matching file pairs (e.g., based on name, locale in path)
  // 2. Running compareFiles for each pair
  // 3. Aggregating results
}

// Helper class for parameters to compute function
class _ComputeParseParams {
  final String filePath;
  final LocalizationParser parser;
  final Map<String, dynamic> settingsAsJson;
  _ComputeParseParams(this.filePath, this.parser, this.settingsAsJson);
} 