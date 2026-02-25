import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart' hide Border;

import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

/// Service responsible for building export data from a [ComparisonResult].
///
/// Supports Excel (.xlsx), JSON, and CSV formats. This service is stateless and
/// produces raw bytes/strings from comparison data — the caller is responsible
/// for file I/O, dialogs, and user feedback.
class ExportService {
  const ExportService();

  /// Returns the default file name for the given [format] ("Excel", "JSON", "CSV").
  String exportFileName(String format) {
    switch (format) {
      case 'Excel':
        return 'comparison_report.xlsx';
      case 'JSON':
        return 'comparison_report.json';
      default:
        return 'comparison_report.csv';
    }
  }

  /// Builds export bytes for the given [format].
  Future<Uint8List> buildExportBytes(
    ComparisonResult result,
    String format,
  ) async {
    switch (format) {
      case 'Excel':
        return buildExcelBytes(result);
      case 'JSON':
        return Uint8List.fromList(utf8.encode(buildJsonString(result)));
      default:
        return Uint8List.fromList(utf8.encode(buildCsvString(result)));
    }
  }

  /// Builds an Excel workbook from comparison results and returns its bytes.
  Uint8List buildExcelBytes(ComparisonResult result) {
    final excel = Excel.createExcel();
    final sheetObject = excel['Sheet1'];

    sheetObject.appendRow([
      TextCellValue('Status'),
      TextCellValue('String Key'),
      TextCellValue('Old Value (Source)'),
      TextCellValue('New Value (Target)'),
      TextCellValue('Similarity')
    ]);

    for (final entry in result.diff.entries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = result.file1Data[key] ?? '';
      final file2Value = result.file2Data[key] ?? '';

      final statusText = status == StringComparisonStatus.added
          ? 'EXTRA'
          : status == StringComparisonStatus.removed
              ? 'MISSING'
              : 'CHANGED';
      final simText =
          similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';

      sheetObject.appendRow([
        TextCellValue(statusText),
        TextCellValue(key),
        TextCellValue(status == StringComparisonStatus.added ? '' : file1Value),
        TextCellValue(
            status == StringComparisonStatus.removed ? '' : file2Value),
        TextCellValue(simText)
      ]);
    }

    final fileBytes = excel.save();
    if (fileBytes == null) {
      return Uint8List(0);
    }

    return Uint8List.fromList(fileBytes);
  }

  /// Builds a pretty-printed JSON string from comparison results.
  String buildJsonString(ComparisonResult result) {
    final jsonData = <Map<String, dynamic>>[];
    for (final entry in result.diff.entries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = result.file1Data[key] ?? '';
      final file2Value = result.file2Data[key] ?? '';

      jsonData.add({
        'status': status == StringComparisonStatus.added
            ? 'extra'
            : status == StringComparisonStatus.removed
                ? 'missing'
                : status.name,
        'key': key,
        'old_value': status == StringComparisonStatus.added ? null : file1Value,
        'new_value':
            status == StringComparisonStatus.removed ? null : file2Value,
        'similarity': similarity
      });
    }

    return const JsonEncoder.withIndent('  ').convert(jsonData);
  }

  /// Builds a CSV string from comparison results.
  ///
  /// If [includeUtf8Bom] is true, a UTF-8 BOM is prepended to the output.
  String buildCsvString(
    ComparisonResult result, {
    bool includeUtf8Bom = false,
  }) {
    final csvData = <List<dynamic>>[
      [
        'Status',
        'String Key',
        'Old Value (Source)',
        'New Value (Target)',
        'Similarity'
      ]
    ];
    for (final entry in result.diff.entries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = result.file1Data[key] ?? '';
      final file2Value = result.file2Data[key] ?? '';

      final statusText = status == StringComparisonStatus.added
          ? 'EXTRA'
          : status == StringComparisonStatus.removed
              ? 'MISSING'
              : 'CHANGED';
      final simText =
          similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';

      csvData.add([
        statusText,
        key,
        status == StringComparisonStatus.added ? '' : file1Value,
        status == StringComparisonStatus.removed ? '' : file2Value,
        simText
      ]);
    }

    var csvString = const ListToCsvConverter().convert(csvData);

    if (includeUtf8Bom) {
      csvString = '\uFEFF$csvString';
    }

    return csvString;
  }
}
