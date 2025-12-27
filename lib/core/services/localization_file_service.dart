import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:localizer_app_main/core/services/backup_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/file_parser_factory.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:path/path.dart' as path;
import 'package:xml/xml.dart' as xml;
import 'package:yaml/yaml.dart';

enum _LocalizationFileFormat {
  json,
  yaml,
  csv,
  properties,
  resx,
  xml,
  xliff,
  tmx,
  plainText,
  docx,
  unknown,
}

enum _PlainTextKind { xmlStrings, lines }

/// Reads and edits localization files while preserving settings and backups.
class LocalizationFileService {
  /// Creates a new localization file service.
  LocalizationFileService({
    FileParserFactory? parserFactory,
    BackupService? backupService,
  })  : _parserFactory = parserFactory ?? FileParserFactory(),
        _backupService = backupService ?? BackupService();

  final FileParserFactory _parserFactory;
  final BackupService _backupService;

  /// Returns true when the file format supports editing.
  bool canEditFile(File file, {String? forcedFormat}) {
    final format = _resolveFormat(file, forcedFormat: forcedFormat);
    return format != _LocalizationFileFormat.unknown &&
        format != _LocalizationFileFormat.docx;
  }

  /// Updates or creates a key in the file and returns the refreshed map.
  Future<Map<String, String>> upsertEntry({
    required File file,
    required String key,
    required String value,
    required AppSettings settings,
    required String encodingName,
    String? forcedFormat,
    String? relatedValue,
  }) async {
    final format = _resolveFormat(file, forcedFormat: forcedFormat);
    _throwIfUnsupported(format);

    if (!await file.exists()) {
      throw FileSystemException('File not found', file.path);
    }

    await _backupService.createBackupIfNeeded(
      targetPath: file.path,
      settings: settings,
    );

    final encoding = Encoding.getByName(encodingName) ?? utf8;

    switch (format) {
      case _LocalizationFileFormat.json:
        await _updateJsonFile(
          file: file,
          key: key,
          value: value,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.yaml:
        await _updateYamlFile(
          file: file,
          key: key,
          value: value,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.csv:
        await _updateCsvFile(
          file: file,
          key: key,
          value: value,
          settings: settings,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.properties:
        await _updatePropertiesFile(
          file: file,
          key: key,
          value: value,
          settings: settings,
          encoding: encoding,
          forcedFormat: forcedFormat,
        );
        break;
      case _LocalizationFileFormat.resx:
        await _updateResxFile(
          file: file,
          key: key,
          value: value,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.xml:
        await _updateXmlFile(
          file: file,
          key: key,
          value: value,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.xliff:
        await _updateXliffFile(
          file: file,
          key: key,
          value: value,
          encoding: encoding,
          relatedValue: relatedValue,
        );
        break;
      case _LocalizationFileFormat.tmx:
        await _updateTmxFile(
          file: file,
          key: key,
          value: value,
          encoding: encoding,
          relatedValue: relatedValue,
        );
        break;
      case _LocalizationFileFormat.plainText:
        await _updatePlainTextFile(
          file: file,
          key: key,
          value: value,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.docx:
      case _LocalizationFileFormat.unknown:
        _throwIfUnsupported(format);
        break;
    }

    return _parseFile(file, settings, forcedFormat: forcedFormat);
  }

  /// Deletes a key from the file and returns the refreshed map.
  Future<Map<String, String>> deleteEntry({
    required File file,
    required String key,
    required AppSettings settings,
    required String encodingName,
    String? forcedFormat,
  }) async {
    final format = _resolveFormat(file, forcedFormat: forcedFormat);
    _throwIfUnsupported(format);

    if (!await file.exists()) {
      throw FileSystemException('File not found', file.path);
    }

    await _backupService.createBackupIfNeeded(
      targetPath: file.path,
      settings: settings,
    );

    final encoding = Encoding.getByName(encodingName) ?? utf8;

    switch (format) {
      case _LocalizationFileFormat.json:
        await _deleteJsonFile(file: file, key: key, encoding: encoding);
        break;
      case _LocalizationFileFormat.yaml:
        await _deleteYamlFile(file: file, key: key, encoding: encoding);
        break;
      case _LocalizationFileFormat.csv:
        await _deleteCsvFile(
          file: file,
          key: key,
          settings: settings,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.properties:
        await _deletePropertiesFile(
          file: file,
          key: key,
          settings: settings,
          encoding: encoding,
          forcedFormat: forcedFormat,
        );
        break;
      case _LocalizationFileFormat.resx:
        await _deleteResxFile(file: file, key: key, encoding: encoding);
        break;
      case _LocalizationFileFormat.xml:
        await _deleteXmlFile(file: file, key: key, encoding: encoding);
        break;
      case _LocalizationFileFormat.xliff:
        await _deleteXliffFile(file: file, key: key, encoding: encoding);
        break;
      case _LocalizationFileFormat.tmx:
        await _deleteTmxFile(file: file, key: key, encoding: encoding);
        break;
      case _LocalizationFileFormat.plainText:
        await _deletePlainTextFile(
          file: file,
          key: key,
          encoding: encoding,
        );
        break;
      case _LocalizationFileFormat.docx:
      case _LocalizationFileFormat.unknown:
        _throwIfUnsupported(format);
        break;
    }

    return _parseFile(file, settings, forcedFormat: forcedFormat);
  }

  _LocalizationFileFormat _resolveFormat(
    File file, {
    String? forcedFormat,
  }) {
    final extension = _resolveExtension(file, forcedFormat: forcedFormat);
    switch (extension) {
      case '.json':
      case '.arb':
        return _LocalizationFileFormat.json;
      case '.yaml':
      case '.yml':
        return _LocalizationFileFormat.yaml;
      case '.csv':
        return _LocalizationFileFormat.csv;
      case '.properties':
        return _LocalizationFileFormat.properties;
      case '.resx':
        return _LocalizationFileFormat.resx;
      case '.xml':
        return _LocalizationFileFormat.xml;
      case '.xliff':
      case '.xlf':
        return _LocalizationFileFormat.xliff;
      case '.tmx':
        return _LocalizationFileFormat.tmx;
      case '.txt':
      case '.lang':
        return _LocalizationFileFormat.plainText;
      case '.docx':
        return _LocalizationFileFormat.docx;
      default:
        return _LocalizationFileFormat.unknown;
    }
  }

  String _resolveExtension(File file, {String? forcedFormat}) {
    if (forcedFormat != null &&
        forcedFormat.isNotEmpty &&
        forcedFormat.toLowerCase() != 'auto') {
      final trimmed = forcedFormat.trim().toLowerCase();
      return trimmed.startsWith('.') ? trimmed : '.${trimmed}';
    }
    return path.extension(file.path).toLowerCase();
  }

  void _throwIfUnsupported(_LocalizationFileFormat format) {
    if (format == _LocalizationFileFormat.docx ||
        format == _LocalizationFileFormat.unknown) {
      throw UnsupportedError('Editing is not supported for this format.');
    }
  }

  Future<Map<String, String>> _parseFile(
    File file,
    AppSettings settings, {
    String? forcedFormat,
  }) async {
    final LocalizationParser? parser =
        _parserFactory.getParserForFile(file, format: forcedFormat);
    if (parser == null) {
      throw UnsupportedError('No parser available for ${file.path}.');
    }
    return parser.parse(file, settings);
  }

  Future<String> _readFileContent(
    File file,
    Encoding encoding,
  ) async {
    return file.readAsString(encoding: encoding);
  }

  Future<void> _writeFileContent(
    File file,
    String content,
    Encoding encoding,
  ) async {
    if (encoding == utf8 && await _hasUtf8Bom(file)) {
      final bytes = <int>[0xEF, 0xBB, 0xBF, ...utf8.encode(content)];
      await file.writeAsBytes(bytes);
      return;
    }
    await file.writeAsString(content, encoding: encoding);
  }

  Future<bool> _hasUtf8Bom(File file) async {
    try {
      if (!await file.exists()) {
        return false;
      }
      final bytes = await file.openRead(0, 3).first;
      return bytes.length >= 3 &&
          bytes[0] == 0xEF &&
          bytes[1] == 0xBB &&
          bytes[2] == 0xBF;
    } catch (_) {
      return false;
    }
  }

  Future<void> _updateJsonFile({
    required File file,
    required String key,
    required String value,
    required Encoding encoding,
  }) async {
    final content = await _readFileContent(file, encoding);
    final root = _decodeJsonRoot(content);
    _setDottedKey(root, key, value);
    final output = const JsonEncoder.withIndent('  ').convert(root);
    await _writeFileContent(file, output, encoding);
  }

  Future<void> _deleteJsonFile({
    required File file,
    required String key,
    required Encoding encoding,
  }) async {
    final content = await _readFileContent(file, encoding);
    final root = _decodeJsonRoot(content);
    _removeDottedKey(root, key);
    final output = const JsonEncoder.withIndent('  ').convert(root);
    await _writeFileContent(file, output, encoding);
  }

  Map<String, dynamic> _decodeJsonRoot(String content) {
    if (content.trim().isEmpty) {
      return <String, dynamic>{};
    }
    final decoded = json.decode(content);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw const FormatException('JSON root is not an object.');
  }

  Future<void> _updateYamlFile({
    required File file,
    required String key,
    required String value,
    required Encoding encoding,
  }) async {
    final content = await _readFileContent(file, encoding);
    final root = _decodeYamlRoot(content);
    _setDottedKey(root, key, value);
    final output = _encodeYaml(root);
    await _writeFileContent(file, output, encoding);
  }

  Future<void> _deleteYamlFile({
    required File file,
    required String key,
    required Encoding encoding,
  }) async {
    final content = await _readFileContent(file, encoding);
    final root = _decodeYamlRoot(content);
    _removeDottedKey(root, key);
    final output = _encodeYaml(root);
    await _writeFileContent(file, output, encoding);
  }

  Map<String, dynamic> _decodeYamlRoot(String content) {
    if (content.trim().isEmpty) {
      return <String, dynamic>{};
    }
    final decoded = loadYaml(content);
    if (decoded == null) {
      return <String, dynamic>{};
    }
    if (decoded is YamlMap) {
      return _convertYamlMap(decoded);
    }
    throw const FormatException('YAML root is not a map.');
  }

  Map<String, dynamic> _convertYamlMap(YamlMap map) {
    final result = <String, dynamic>{};
    map.nodes.forEach((keyNode, valueNode) {
      final key = keyNode is YamlScalar
          ? keyNode.value.toString()
          : keyNode.toString();
      result[key] = _convertYamlNode(valueNode);
    });
    return result;
  }

  dynamic _convertYamlNode(dynamic node) {
    if (node is YamlMap) {
      return _convertYamlMap(node);
    }
    if (node is YamlList) {
      return node.nodes.map(_convertYamlNode).toList();
    }
    if (node is YamlScalar) {
      return node.value;
    }
    return node;
  }

  String _encodeYaml(Map<String, dynamic> root) {
    final buffer = StringBuffer();
    for (final entry in root.entries) {
      _writeYamlEntry(buffer, entry.key, entry.value, 0);
    }
    return buffer.toString().trimRight();
  }

  void _writeYamlEntry(
    StringBuffer buffer,
    String key,
    dynamic value,
    int indent,
  ) {
    final prefix = '  ' * indent;
    if (value is Map<String, dynamic>) {
      buffer.writeln('$prefix${_escapeYamlKey(key)}:');
      for (final entry in value.entries) {
        _writeYamlEntry(buffer, entry.key, entry.value, indent + 1);
      }
      return;
    }
    if (value is List) {
      buffer.writeln('$prefix${_escapeYamlKey(key)}:');
      for (final item in value) {
        _writeYamlListItem(buffer, item, indent + 1);
      }
      return;
    }
    buffer.writeln(
      '$prefix${_escapeYamlKey(key)}: ${_yamlScalar(value)}',
    );
  }

  void _writeYamlListItem(StringBuffer buffer, dynamic value, int indent) {
    final prefix = '  ' * indent;
    if (value is Map<String, dynamic>) {
      buffer.writeln('$prefix-');
      for (final entry in value.entries) {
        _writeYamlEntry(buffer, entry.key, entry.value, indent + 1);
      }
      return;
    }
    if (value is List) {
      buffer.writeln('$prefix-');
      for (final item in value) {
        _writeYamlListItem(buffer, item, indent + 1);
      }
      return;
    }
    buffer.writeln('$prefix- ${_yamlScalar(value)}');
  }

  String _yamlScalar(dynamic value) {
    if (value == null) {
      return 'null';
    }
    if (value is bool || value is num) {
      return value.toString();
    }
    final text = value.toString();
    if (text.isEmpty) {
      return '""';
    }
    final needsQuotes = text.contains(':') ||
        text.contains('#') ||
        text.contains('\n') ||
        text.startsWith(' ') ||
        text.endsWith(' ');
    if (!needsQuotes) {
      return text;
    }
    final escaped = text.replaceAll('"', r'\"');
    return '"$escaped"';
  }

  String _escapeYamlKey(String key) {
    if (key.isEmpty) {
      return '""';
    }
    final needsQuotes = key.contains(':') ||
        key.contains('#') ||
        key.contains(' ') ||
        key.contains('\n');
    if (!needsQuotes) {
      return key;
    }
    final escaped = key.replaceAll('"', r'\"');
    return '"$escaped"';
  }

  Future<void> _updateCsvFile({
    required File file,
    required String key,
    required String value,
    required AppSettings settings,
    required Encoding encoding,
  }) async {
    final data = await _readCsvMap(
      file: file,
      settings: settings,
      encoding: encoding,
    );
    data[key] = value;
    await _writeCsvMap(
      file: file,
      data: data,
      settings: settings,
      encoding: encoding,
    );
  }

  Future<void> _deleteCsvFile({
    required File file,
    required String key,
    required AppSettings settings,
    required Encoding encoding,
  }) async {
    final data = await _readCsvMap(
      file: file,
      settings: settings,
      encoding: encoding,
    );
    data.remove(key);
    await _writeCsvMap(
      file: file,
      data: data,
      settings: settings,
      encoding: encoding,
    );
  }

  Future<LinkedHashMap<String, String>> _readCsvMap({
    required File file,
    required AppSettings settings,
    required Encoding encoding,
  }) async {
    final content = await _readFileContent(file, encoding);
    final result = LinkedHashMap<String, String>();
    if (content.trim().isEmpty) {
      return result;
    }
    final converter = CsvToListConverter(
      fieldDelimiter: settings.csvDelimiter,
      shouldParseNumbers: false,
    );
    final rows = converter.convert(content);
    if (rows.isEmpty) {
      return result;
    }
    final startIndex = rows.length > 1 ? 1 : 0;
    for (var i = startIndex; i < rows.length; i++) {
      final row = rows[i];
      if (row.length >= 2) {
        final rowKey = row[0].toString().trim();
        final rowValue = row[1].toString().trim();
        if (rowKey.isNotEmpty) {
          result[rowKey] = rowValue;
        }
      }
    }
    return result;
  }

  Future<void> _writeCsvMap({
    required File file,
    required LinkedHashMap<String, String> data,
    required AppSettings settings,
    required Encoding encoding,
  }) async {
    final rows = <List<dynamic>>[
      ['Key', 'Value'],
      ...data.entries.map((entry) => [entry.key, entry.value]),
    ];
    final converter = ListToCsvConverter(
      fieldDelimiter: settings.csvDelimiter,
    );
    final csvString = converter.convert(rows);
    await _writeFileContent(file, csvString, encoding);
  }

  Future<void> _updatePropertiesFile({
    required File file,
    required String key,
    required String value,
    required AppSettings settings,
    required Encoding encoding,
    String? forcedFormat,
  }) async {
    final data = await _parseFile(file, settings, forcedFormat: forcedFormat);
    final ordered = LinkedHashMap<String, String>.from(data);
    ordered[key] = value;
    await _writePropertiesMap(file, ordered, encoding);
  }

  Future<void> _deletePropertiesFile({
    required File file,
    required String key,
    required AppSettings settings,
    required Encoding encoding,
    String? forcedFormat,
  }) async {
    final data = await _parseFile(file, settings, forcedFormat: forcedFormat);
    final ordered = LinkedHashMap<String, String>.from(data);
    ordered.remove(key);
    await _writePropertiesMap(file, ordered, encoding);
  }

  Future<void> _writePropertiesMap(
    File file,
    LinkedHashMap<String, String> data,
    Encoding encoding,
  ) async {
    final buffer = StringBuffer();
    for (final entry in data.entries) {
      final escapedKey = _escapeProperties(entry.key);
      final escapedValue = _escapeProperties(entry.value);
      buffer.writeln('$escapedKey=$escapedValue');
    }
    await _writeFileContent(file, buffer.toString().trimRight(), encoding);
  }

  String _escapeProperties(String value) {
    var result = value.replaceAll(r'\', r'\\');
    result = result
        .replaceAll('\t', r'\t')
        .replaceAll('\n', r'\n')
        .replaceAll('\r', r'\r')
        .replaceAll('\f', r'\f');
    result = result
        .replaceAll('=', r'\=')
        .replaceAll(':', r'\:')
        .replaceAll('#', r'\#')
        .replaceAll('!', r'\!');
    if (result.startsWith(' ')) {
      result = '\\$result';
    }
    return result;
  }

  Future<void> _updateResxFile({
    required File file,
    required String key,
    required String value,
    required Encoding encoding,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final root = document.rootElement;
    final dataElement = _findResxData(root, key);
    if (dataElement != null) {
      final valueElement = dataElement.findElements('value').firstOrNull;
      if (valueElement != null) {
        valueElement.children
          ..clear()
          ..add(xml.XmlText(value));
      } else {
        dataElement.children.add(
          xml.XmlElement(xml.XmlName('value'), [], [xml.XmlText(value)]),
        );
      }
    } else {
      final newElement = xml.XmlElement(
        xml.XmlName('data'),
        [
          xml.XmlAttribute(xml.XmlName('name'), key),
          xml.XmlAttribute(xml.XmlName('space', 'xml'), 'preserve'),
        ],
        [
          xml.XmlElement(
            xml.XmlName('value'),
            [],
            [xml.XmlText(value)],
          ),
        ],
      );
      root.children.add(newElement);
    }
    await _writeXmlDocument(file, document, encoding);
  }

  Future<void> _deleteResxFile({
    required File file,
    required String key,
    required Encoding encoding,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final root = document.rootElement;
    final dataElement = _findResxData(root, key);
    if (dataElement != null) {
      dataElement.parent?.children.remove(dataElement);
    }
    await _writeXmlDocument(file, document, encoding);
  }

  xml.XmlElement? _findResxData(xml.XmlElement root, String key) {
    for (final element in root.findAllElements('data')) {
      if (element.getAttribute('name') == key) {
        return element;
      }
    }
    return null;
  }

  Future<void> _updateXmlFile({
    required File file,
    required String key,
    required String value,
    required Encoding encoding,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final root = document.rootElement;
    final stringElement = _findAndroidString(root, key);
    if (stringElement != null) {
      stringElement.children
        ..clear()
        ..add(xml.XmlText(value));
      await _writeXmlDocument(file, document, encoding);
      return;
    }
    final genericElement = _findGenericXmlKey(root, key);
    if (genericElement != null) {
      genericElement.children
        ..clear()
        ..add(xml.XmlText(value));
      await _writeXmlDocument(file, document, encoding);
      return;
    }
    if (_isValidXmlTag(key)) {
      root.children.add(
        xml.XmlElement(xml.XmlName(key), [], [xml.XmlText(value)]),
      );
      await _writeXmlDocument(file, document, encoding);
      return;
    }
    throw FormatException('Key is not a valid XML tag name.');
  }

  Future<void> _deleteXmlFile({
    required File file,
    required String key,
    required Encoding encoding,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final root = document.rootElement;
    final stringElement = _findAndroidString(root, key);
    if (stringElement != null) {
      stringElement.parent?.children.remove(stringElement);
      await _writeXmlDocument(file, document, encoding);
      return;
    }
    final genericElement = _findGenericXmlKey(root, key);
    if (genericElement != null) {
      genericElement.parent?.children.remove(genericElement);
    }
    await _writeXmlDocument(file, document, encoding);
  }

  xml.XmlElement? _findAndroidString(xml.XmlElement root, String key) {
    for (final element in root.findAllElements('string')) {
      if (element.getAttribute('name') == key) {
        return element;
      }
    }
    return null;
  }

  xml.XmlElement? _findGenericXmlKey(xml.XmlElement root, String key) {
    for (final element in root.children.whereType<xml.XmlElement>()) {
      if (element.name.local == key && element.attributes.isEmpty) {
        return element;
      }
    }
    return null;
  }

  bool _isValidXmlTag(String key) {
    final regex = RegExp(r'^[A-Za-z_][A-Za-z0-9_.-]*$');
    if (!regex.hasMatch(key)) {
      return false;
    }
    return !key.toLowerCase().startsWith('xml');
  }

  Future<void> _updateXliffFile({
    required File file,
    required String key,
    required String value,
    required Encoding encoding,
    String? relatedValue,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final unit = _findXliffUnit(document, key);
    final target = _ensureXliffTarget(document, unit, key, relatedValue);
    target.children
      ..clear()
      ..add(xml.XmlText(value));
    await _writeXmlDocument(file, document, encoding);
  }

  Future<void> _deleteXliffFile({
    required File file,
    required String key,
    required Encoding encoding,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final unit = _findXliffUnit(document, key);
    if (unit != null) {
      unit.parent?.children.remove(unit);
    }
    await _writeXmlDocument(file, document, encoding);
  }

  xml.XmlElement? _findXliffUnit(xml.XmlDocument document, String key) {
    for (final unit in document.findAllElements('unit')) {
      if (unit.getAttribute('id') == key) {
        return unit;
      }
    }
    for (final unit in document.findAllElements('unit')) {
      final source = unit.findAllElements('source').firstOrNull?.innerText;
      final target = unit.findAllElements('target').firstOrNull?.innerText;
      if (source == key || target == key) {
        return unit;
      }
    }
    return null;
  }

  xml.XmlElement _ensureXliffTarget(
    xml.XmlDocument document,
    xml.XmlElement? unit,
    String key,
    String? relatedValue,
  ) {
    final resolvedUnit =
        unit ?? _createXliffUnit(document, key, relatedValue);
    final segment = resolvedUnit.findAllElements('segment').firstOrNull ??
        _createXliffSegment(resolvedUnit, relatedValue);
    final target = segment.findAllElements('target').firstOrNull ??
        _createXliffTarget(segment);
    return target;
  }

  xml.XmlElement _createXliffUnit(
    xml.XmlDocument document,
    String key,
    String? relatedValue,
  ) {
    final unit = xml.XmlElement(
      xml.XmlName('unit'),
      [xml.XmlAttribute(xml.XmlName('id'), key)],
    );
    final container = document.findAllElements('file').firstOrNull ??
        document.rootElement;
    container.children.add(unit);
    _createXliffSegment(unit, relatedValue);
    return unit;
  }

  xml.XmlElement _createXliffSegment(
    xml.XmlElement unit,
    String? relatedValue,
  ) {
    final segment = xml.XmlElement(xml.XmlName('segment'));
    if (relatedValue != null && relatedValue.isNotEmpty) {
      segment.children.add(
        xml.XmlElement(
          xml.XmlName('source'),
          [],
          [xml.XmlText(relatedValue)],
        ),
      );
    }
    unit.children.add(segment);
    return segment;
  }

  xml.XmlElement _createXliffTarget(xml.XmlElement segment) {
    final target = xml.XmlElement(xml.XmlName('target'));
    segment.children.add(target);
    return target;
  }

  Future<void> _updateTmxFile({
    required File file,
    required String key,
    required String value,
    required Encoding encoding,
    String? relatedValue,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final tu = _findTmxUnit(document, key) ??
        _createTmxUnit(document, key, relatedValue);
    final target = _ensureTmxTarget(document, tu);
    target.children
      ..clear()
      ..add(xml.XmlText(value));
    await _writeXmlDocument(file, document, encoding);
  }

  Future<void> _deleteTmxFile({
    required File file,
    required String key,
    required Encoding encoding,
  }) async {
    final document = await _loadXmlDocument(file, encoding);
    final tu = _findTmxUnit(document, key);
    if (tu != null) {
      tu.parent?.children.remove(tu);
    }
    await _writeXmlDocument(file, document, encoding);
  }

  xml.XmlElement? _findTmxUnit(xml.XmlDocument document, String key) {
    for (final tu in document.findAllElements('tu')) {
      if (tu.getAttribute('tuid') == key) {
        return tu;
      }
      final seg = tu.findAllElements('seg').firstOrNull?.innerText;
      if (seg == key) {
        return tu;
      }
    }
    return null;
  }

  xml.XmlElement _createTmxUnit(
    xml.XmlDocument document,
    String key,
    String? relatedValue,
  ) {
    final tu = xml.XmlElement(
      xml.XmlName('tu'),
      [xml.XmlAttribute(xml.XmlName('tuid'), key)],
    );
    final body = document.findAllElements('body').firstOrNull ??
        document.rootElement;
    body.children.add(tu);
    final langs = _detectTmxLangs(document);
    if (relatedValue != null && relatedValue.isNotEmpty) {
      tu.children.add(_createTmxTuv(relatedValue, langs.$1));
    }
    tu.children.add(_createTmxTuv('', langs.$2));
    return tu;
  }

  (String?, String?) _detectTmxLangs(xml.XmlDocument document) {
    final tu = document.findAllElements('tu').firstOrNull;
    if (tu == null) {
      return (null, null);
    }
    final tuvList = tu.findAllElements('tuv').toList();
    final sourceLang = tuvList.isNotEmpty
        ? tuvList.first.getAttribute('xml:lang')
        : null;
    final targetLang =
        tuvList.length > 1 ? tuvList[1].getAttribute('xml:lang') : null;
    return (sourceLang, targetLang);
  }

  xml.XmlElement _ensureTmxTarget(
    xml.XmlDocument document,
    xml.XmlElement tu,
  ) {
    final tuvList = tu.findAllElements('tuv').toList();
    if (tuvList.length >= 2) {
      return _ensureTmxSeg(tuvList[1]);
    }
    final langs = _detectTmxLangs(document);
    if (tuvList.isEmpty) {
      tu.children.add(_createTmxTuv('', langs.$1));
    }
    final newTarget = _createTmxTuv('', langs.$2);
    tu.children.add(newTarget);
    return _ensureTmxSeg(newTarget);
  }

  xml.XmlElement _createTmxTuv(String value, String? lang) {
    final attributes = <xml.XmlAttribute>[];
    if (lang != null && lang.isNotEmpty) {
      attributes.add(xml.XmlAttribute(xml.XmlName('xml:lang'), lang));
    }
    return xml.XmlElement(
      xml.XmlName('tuv'),
      attributes,
      [
        xml.XmlElement(xml.XmlName('seg'), [], [xml.XmlText(value)]),
      ],
    );
  }

  xml.XmlElement _ensureTmxSeg(xml.XmlElement tuv) {
    final seg = tuv.findAllElements('seg').firstOrNull ??
        xml.XmlElement(xml.XmlName('seg'));
    if (!tuv.children.contains(seg)) {
      tuv.children.add(seg);
    }
    return seg;
  }

  Future<void> _updatePlainTextFile({
    required File file,
    required String key,
    required String value,
    required Encoding encoding,
  }) async {
    final content = await _readFileContent(file, encoding);
    final kind = _detectPlainTextKind(content);
    if (kind == _PlainTextKind.xmlStrings) {
      final updated = _updateXmlStringFragment(content, key, value);
      await _writeFileContent(file, updated, encoding);
      return;
    }
    final lines = _parsePlainTextLines(content);
    final index = lines.indexOf(key);
    if (index >= 0) {
      lines[index] = value;
    } else {
      lines.add(value);
    }
    await _writeFileContent(file, lines.join('\n'), encoding);
  }

  Future<void> _deletePlainTextFile({
    required File file,
    required String key,
    required Encoding encoding,
  }) async {
    final content = await _readFileContent(file, encoding);
    final kind = _detectPlainTextKind(content);
    if (kind == _PlainTextKind.xmlStrings) {
      final updated = _deleteXmlStringFragment(content, key);
      await _writeFileContent(file, updated, encoding);
      return;
    }
    final lines = _parsePlainTextLines(content);
    lines.removeWhere((line) => line == key);
    await _writeFileContent(file, lines.join('\n'), encoding);
  }

  _PlainTextKind _detectPlainTextKind(String content) {
    final pattern = RegExp(
      r'<string\s+name="([^"]+)"[^>]*>([^<]*)</string>',
      multiLine: true,
    );
    return pattern.hasMatch(content)
        ? _PlainTextKind.xmlStrings
        : _PlainTextKind.lines;
  }

  List<String> _parsePlainTextLines(String content) {
    final lines = <String>[];
    for (final line in content.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.isEmpty ||
          trimmed.startsWith('//') ||
          trimmed.startsWith('#')) {
        continue;
      }
      lines.add(trimmed);
    }
    return lines;
  }

  String _updateXmlStringFragment(String content, String key, String value) {
    final escapedKey = RegExp.escape(key);
    final pattern = RegExp(
      '(<string\\s+name="$escapedKey"[^>]*>)([^<]*)(</string>)',
      multiLine: true,
    );
    final escapedValue = xml.XmlText(value).toXmlString();
    if (pattern.hasMatch(content)) {
      return content.replaceAllMapped(pattern, (match) {
        return '${match.group(1)}$escapedValue${match.group(3)}';
      });
    }
    final suffix = content.endsWith('\n') ? '' : '\n';
    return '$content$suffix<string name="$key">$escapedValue</string>';
  }

  String _deleteXmlStringFragment(String content, String key) {
    final escapedKey = RegExp.escape(key);
    final pattern = RegExp(
      '<string\\s+name="$escapedKey"[^>]*>[^<]*</string>\\s*',
      multiLine: true,
    );
    return content.replaceAll(pattern, '').trimRight();
  }

  Future<xml.XmlDocument> _loadXmlDocument(
    File file,
    Encoding encoding,
  ) async {
    final content = await _readFileContent(file, encoding);
    if (content.trim().isEmpty) {
      throw const FormatException('XML file is empty.');
    }
    return xml.XmlDocument.parse(content);
  }

  Future<void> _writeXmlDocument(
    File file,
    xml.XmlDocument document,
    Encoding encoding,
  ) async {
    final content = document.toXmlString(pretty: true, indent: '  ');
    await _writeFileContent(file, content, encoding);
  }

  void _setDottedKey(Map<String, dynamic> root, String key, String value) {
    final parts = key.split('.');
    var current = root;
    for (var i = 0; i < parts.length; i++) {
      final part = parts[i];
      if (i == parts.length - 1) {
        current[part] = value;
        return;
      }
      final next = current[part];
      if (next is Map<String, dynamic>) {
        current = next;
      } else {
        final newMap = <String, dynamic>{};
        current[part] = newMap;
        current = newMap;
      }
    }
  }

  void _removeDottedKey(Map<String, dynamic> root, String key) {
    final parts = key.split('.');
    _removeDottedKeyRecursive(root, parts, 0);
  }

  bool _removeDottedKeyRecursive(
    Map<String, dynamic> current,
    List<String> parts,
    int index,
  ) {
    final part = parts[index];
    if (index == parts.length - 1) {
      current.remove(part);
      return current.isEmpty;
    }
    final next = current[part];
    if (next is Map<String, dynamic>) {
      final shouldRemove = _removeDottedKeyRecursive(next, parts, index + 1);
      if (shouldRemove) {
        current.remove(part);
      }
    }
    return current.isEmpty;
  }
}
