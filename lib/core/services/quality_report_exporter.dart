import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';

class QualityReportExporter {
  List<int> toExcelBytes(QualityDashboardData data) {
    final excel = Excel.createExcel();
    // Use Sheet1 directly to avoid corruption from renaming
    final reportSheet = excel['Sheet1'];
    excel.setDefaultSheet('Sheet1');

    final sectionTitleStyle = CellStyle(
      bold: true,
      fontSize: 14,
      verticalAlign: VerticalAlign.Center,
    );

    _buildReport(
      sheet: reportSheet,
      data: data,
      sectionTitleStyle: sectionTitleStyle,
    );

    return excel.encode() ?? <int>[];
  }

  void _buildReport({
    required Sheet sheet,
    required QualityDashboardData data,
    required CellStyle sectionTitleStyle,
  }) {
    sheet.setDefaultRowHeight(18);
    _configureColumns(sheet);

    var rowIndex = 0;

    rowIndex = _writeSectionTitle(sheet, 'Report Summary', rowIndex, sectionTitleStyle);
    rowIndex = _buildSummarySection(
      sheet: sheet,
      data: data,
      startRow: rowIndex,
    );
    rowIndex = _addSectionSpacing(rowIndex);

    rowIndex = _writeSectionTitle(sheet, 'Translation Coverage by Language', rowIndex, sectionTitleStyle);
    rowIndex = _buildLanguagesSection(
      sheet: sheet,
      data: data,
      startRow: rowIndex,
    );
    rowIndex = _addSectionSpacing(rowIndex);

    rowIndex = _writeSectionTitle(sheet, 'Detected Quality Issues', rowIndex, sectionTitleStyle);
    rowIndex = _buildIssuesSection(
      sheet: sheet,
      data: data,
      startRow: rowIndex,
    );
    rowIndex = _addSectionSpacing(rowIndex);

    rowIndex = _writeSectionTitle(sheet, 'Progress Over Time', rowIndex, sectionTitleStyle);
    _buildTrendSection(
      sheet: sheet,
      data: data,
      startRow: rowIndex,
    );
  }

  void _configureColumns(Sheet sheet) {
    sheet.setColumnWidth(0, 24);
    sheet.setColumnWidth(1, 18);
    sheet.setColumnWidth(2, 60);
    sheet.setColumnWidth(3, 28);
    sheet.setColumnWidth(4, 40);
    sheet.setColumnWidth(5, 40);
    sheet.setColumnWidth(6, 30);
    sheet.setColumnWidth(7, 16);
    sheet.setColumnWidth(8, 40);
    sheet.setColumnWidth(9, 16);
  }

  int _addSectionSpacing(int rowIndex) {
    return rowIndex + 3;
  }

  int _writeSectionTitle(
    Sheet sheet,
    String title,
    int rowIndex,
    CellStyle style,
  ) {
    final cell = sheet.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex),
    );
    cell.value = _textCell(title);
    cell.cellStyle = style;
    sheet.setRowHeight(rowIndex, 25);
    return rowIndex + 1;
  }

  int _buildSummarySection({
    required Sheet sheet,
    required QualityDashboardData data,
    required int startRow,
  }) {
    _writeHeader(sheet, ['Metric', 'Value', 'Notes'], startRow);

    var rowIndex = startRow + 1;
    _writeRow(
      sheet,
      rowIndex++,
      [
        _textCell('Generated At'),
        _textCell(_formatDateTime(data.generatedAt)),
        _textCell('Local time'),
      ],
    );

    _writeRow(sheet, rowIndex++, [
      _textCell('Total Languages'),
      IntCellValue(data.totalLanguages),
      _textCell(''),
    ]);
    _writeRow(
      sheet,
      rowIndex++,
      [
        _textCell('Average Coverage'),
        _textCell(_formatPercent(data.averageCoveragePercent)),
        _textCell(''),
      ],
    );
    _writeRow(sheet, rowIndex++, [
      _textCell('Total Issues'),
      IntCellValue(data.totalIssues),
      _textCell(''),
    ]);

    final totalSourceKeys = data.totalSourceKeys;
    final totalTranslatedKeys = data.totalTranslatedKeys;
    final totalSourceWords = data.languages.fold<int>(
      0,
      (sum, report) => sum + report.coverage.sourceWordCount,
    );

    _writeRow(sheet, rowIndex++, [
      _textCell('Total Source Keys'),
      IntCellValue(totalSourceKeys),
      _textCell(''),
    ]);
    _writeRow(sheet, rowIndex++, [
      _textCell('Total Translated Keys'),
      IntCellValue(totalTranslatedKeys),
      _textCell(''),
    ]);
    _writeRow(sheet, rowIndex++, [
      _textCell('Total Source Words'),
      IntCellValue(totalSourceWords),
      _textCell(''),
    ]);
    _writeRow(sheet, rowIndex++, [
      _textCell('Total Translated Words'),
      IntCellValue(data.totalTranslatedWords),
      _textCell(''),
    ]);

    if (data.warnings.isNotEmpty) {
      for (final warning in data.warnings) {
        _writeRow(
          sheet,
          rowIndex++,
          [
            _textCell('Warning'),
            _textCell(''),
            _textCell(warning),
          ],
        );
      }
    }

    return rowIndex;
  }

  int _buildLanguagesSection({
    required Sheet sheet,
    required QualityDashboardData data,
    required int startRow,
  }) {
    _writeHeader(
      sheet,
      [
        'Language',
        'Code',
        'Coverage %',
        'Source Keys',
        'Translated Keys',
        'Source Words',
        'Translated Words',
        'Placeholder Issues',
        'Length Issues',
        'Duplicate Issues',
      ],
      startRow,
    );

    var rowIndex = startRow + 1;
    for (final language in data.languages) {
      final coverage = language.coverage;
      final issues = language.issues;
      _writeRow(
        sheet,
        rowIndex++,
        [
          _textCell(language.languageLabel),
          _textCell(language.languageCode),
          _textCell(_formatPercent(coverage.coveragePercent)),
          IntCellValue(coverage.sourceKeyCount),
          IntCellValue(coverage.translatedKeyCount),
          IntCellValue(coverage.sourceWordCount),
          IntCellValue(coverage.translatedWordCount),
          IntCellValue(issues.placeholderMismatchCount),
          IntCellValue(issues.lengthOutlierCount),
          IntCellValue(issues.duplicateValueCount),
        ],
      );
    }

    return rowIndex;
  }

  int _buildIssuesSection({
    required Sheet sheet,
    required QualityDashboardData data,
    required int startRow,
  }) {
    _writeHeader(
      sheet,
      [
        'Language',
        'Code',
        'Type',
        'Key',
        'Source',
        'Translation',
        'Error',
        'Review Required',
        'Note',
      ],
      startRow,
    );

    var rowIndex = startRow + 1;
    for (final language in data.languages) {
      rowIndex = _appendIssues(
        sheet: sheet,
        rowIndex: rowIndex,
        languageLabel: language.languageLabel,
        languageCode: language.languageCode,
        issues: language.issues.placeholderMismatchIssues,
      );
      rowIndex = _appendIssues(
        sheet: sheet,
        rowIndex: rowIndex,
        languageLabel: language.languageLabel,
        languageCode: language.languageCode,
        issues: language.issues.lengthOutlierIssues,
      );
      rowIndex = _appendIssues(
        sheet: sheet,
        rowIndex: rowIndex,
        languageLabel: language.languageLabel,
        languageCode: language.languageCode,
        issues: language.issues.duplicateValueIssues,
      );
    }

    return rowIndex;
  }

  int _appendIssues({
    required Sheet sheet,
    required int rowIndex,
    required String languageLabel,
    required String languageCode,
    required List<QualityIssue> issues,
  }) {
    var row = rowIndex;
    for (final issue in issues) {
      _writeRow(
        sheet,
        row++,
        [
          _textCell(languageLabel),
          _textCell(languageCode),
          _textCell(_issueLabel(issue.type)),
          _textCell(issue.key),
          _textCell(
            _displayValue(
              issue.sourceValue,
              _sourceFallback(issue),
            ),
          ),
          _textCell(
            _displayValue(issue.targetValue, _targetFallback(issue)),
          ),
          _textCell(issue.description),
          _textCell('Yes'),
          _textCell(_noteForIssue(issue.type)),
        ],
      );
    }
    return row;
  }

  int _buildTrendSection({
    required Sheet sheet,
    required QualityDashboardData data,
    required int startRow,
  }) {
    _writeHeader(sheet, ['Timestamp', 'Words', 'Coverage %'], startRow);

    var rowIndex = startRow + 1;
    for (final point in data.wordTrend) {
      _writeRow(
        sheet,
        rowIndex++,
        [
          _textCell(_formatDateTime(point.timestamp)),
          IntCellValue(point.words),
          _textCell(_formatPercent(point.coveragePercent)),
        ],
      );
    }

    return rowIndex;
  }

  void _writeHeader(Sheet sheet, List<String> headers, int rowIndex) {
    for (var col = 0; col < headers.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
      );
      cell.value = _textCell(headers[col]);
    }
    sheet.setRowHeight(rowIndex, 22);
  }

  void _writeRow(Sheet sheet, int rowIndex, List<CellValue> values) {
    for (var col = 0; col < values.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
      );
      cell.value = values[col];
    }
  }

  TextCellValue _textCell(String value) {
    return TextCellValue(_sanitizeText(value));
  }

  String _sanitizeText(String value) {
    return value.replaceAll(
      RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'),
      '',
    );
  }

  String _formatPercent(double value) {
    return '${value.toStringAsFixed(2)}%';
  }

  String _formatDateTime(DateTime value) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(value.toLocal());
  }

  String _issueLabel(QualityIssueType type) {
    switch (type) {
      case QualityIssueType.placeholderMismatch:
        return 'Placeholder Mismatch';
      case QualityIssueType.lengthOutlier:
        return 'Length Outlier';
      case QualityIssueType.duplicateValue:
        return 'Duplicate Value';
    }
  }

  String _displayValue(String? value, String fallback) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return fallback;
    }
    return trimmed;
  }

  String _sourceFallback(QualityIssue issue) {
    if (issue.type == QualityIssueType.duplicateValue) {
      return 'Multiple source texts';
    }
    return 'Source text not available';
  }

  String _targetFallback(QualityIssue issue) {
    if (issue.type == QualityIssueType.duplicateValue) {
      return 'Shared translation not available';
    }
    return 'Translation not available';
  }

  String _noteForIssue(QualityIssueType type) {
    switch (type) {
      case QualityIssueType.placeholderMismatch:
        return 'Markers like {name} should match the source.';
      case QualityIssueType.lengthOutlier:
        return 'Big length changes can affect how text fits on screen.';
      case QualityIssueType.duplicateValue:
        return 'Same translation is used for different keys.';
    }
  }
}
