import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:xml/xml.dart' as xml;

/// A simple statistics snapshot for the translation memory.
class TranslationMemoryStats {
  /// Creates a translation memory stats object.
  const TranslationMemoryStats({
    required this.entryCount,
    required this.storageBytes,
  });

  /// The total number of translation units stored.
  final int entryCount;

  /// The database size in bytes.
  final int storageBytes;
}

/// A fuzzy match result from translation memory.
class TranslationMemoryMatch {
  /// Creates a translation memory match.
  const TranslationMemoryMatch({
    required this.targetText,
    required this.score,
  });

  /// The translated text to reuse.
  final String targetText;

  /// The similarity score for the match.
  final double score;
}

class _TranslationUnit {
  const _TranslationUnit({
    required this.sourceLang,
    required this.targetLang,
    required this.sourceText,
    required this.targetText,
  });

  final String sourceLang;
  final String targetLang;
  final String sourceText;
  final String targetText;
}

/// Manages a local translation memory with SQLite storage.
class TranslationMemoryService {
  static const String _dbName = 'translation_memory.db';
  static const String _tableName = 'translation_units';
  static const String _unknownLanguage = 'und';

  static bool _databaseFactoryInitialized = false;

  sqflite.Database? _database;
  Future<sqflite.Database>? _databaseFuture;
  String? _databasePath;

  /// Stores a translation unit in the local database.
  Future<void> addTranslationUnit({
    required String sourceLang,
    required String targetLang,
    required String sourceText,
    required String targetText,
  }) async {
    if (sourceText.trim().isEmpty || targetText.trim().isEmpty) {
      return;
    }
    final db = await _getDatabase();
    await _upsertTranslationUnit(
      db,
      _TranslationUnit(
        sourceLang: _normalizeLanguage(sourceLang),
        targetLang: _normalizeLanguage(targetLang),
        sourceText: sourceText.trim(),
        targetText: targetText.trim(),
      ),
    );
  }

  /// Finds the best fuzzy match for the given source text.
  Future<TranslationMemoryMatch?> findBestMatch({
    required String sourceText,
    required String sourceLang,
    required String targetLang,
    double minScore = 0.85,
  }) async {
    if (sourceText.trim().isEmpty) {
      return null;
    }
    final db = await _getDatabase();
    final normalizedSource = _normalizeLanguage(sourceLang);
    final normalizedTarget = _normalizeLanguage(targetLang);
    final rows = await db.query(
      _tableName,
      columns: ['id', 'source_text', 'target_text'],
      where: 'source_lang IN (?, ?) AND target_lang IN (?, ?)',
      whereArgs: [
        normalizedSource,
        _unknownLanguage,
        normalizedTarget,
        _unknownLanguage,
      ],
    );

    if (rows.isEmpty) {
      return null;
    }

    double bestScore = 0.0;
    String? bestTarget;
    int? bestId;
    for (final row in rows) {
      final candidate = (row['source_text'] as String?) ?? '';
      if (candidate.isEmpty) {
        continue;
      }
      final score = StringSimilarity.compareTwoStrings(
        sourceText,
        candidate,
      );
      if (score > bestScore) {
        bestScore = score;
        bestTarget = row['target_text'] as String?;
        bestId = row['id'] as int?;
      }
    }

    if (bestTarget == null || bestScore < minScore || bestId == null) {
      return null;
    }

    await db.rawUpdate(
      'UPDATE $_tableName SET usage_count = usage_count + 1 WHERE id = ?',
      [bestId],
    );

    return TranslationMemoryMatch(targetText: bestTarget, score: bestScore);
  }

  /// Returns stats for the local translation memory database.
  Future<TranslationMemoryStats> getStats() async {
    await _getDatabase();
    final db = _database;
    if (db == null) {
      return const TranslationMemoryStats(entryCount: 0, storageBytes: 0);
    }
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM $_tableName',
    );
    final entryCount =
        (countResult.first['count'] as int?) ?? 0;
    final dbPath = await _resolveDatabasePath();
    final file = File(dbPath);
    final storageBytes = await file.exists() ? await file.length() : 0;
    return TranslationMemoryStats(
      entryCount: entryCount,
      storageBytes: storageBytes,
    );
  }

  /// Clears all stored translation units.
  Future<void> clearMemory() async {
    final dbPath = await _resolveDatabasePath();
    if (_database != null) {
      await _database?.close();
      _database = null;
      _databaseFuture = null;
    }
    await sqflite.deleteDatabase(dbPath);
    await _getDatabase();
  }

  /// Imports translation units from a TMX or CSV file.
  Future<int> importFromFile(File file) async {
    final extension = path.extension(file.path).toLowerCase();
    if (extension == '.tmx') {
      return importFromTmx(file);
    }
    if (extension == '.csv') {
      return importFromCsv(file);
    }
    return 0;
  }

  /// Imports translation units from a TMX 1.4b file.
  Future<int> importFromTmx(File file) async {
    try {
      final content = await file.readAsString(encoding: utf8);
      if (content.trim().isEmpty) {
        return 0;
      }
      final document = xml.XmlDocument.parse(content);
      final headerElement =
          _firstOrNull(document.findAllElements('header'));
      final sourceLanguage = headerElement?.getAttribute('srclang');

      final bodyElement =
          _firstOrNull(document.findAllElements('body'));
      if (bodyElement == null) {
        return 0;
      }
      final tuElements = bodyElement.findElements('tu');
      final targetLanguage =
          _detectTargetLanguage(tuElements, sourceLanguage);

      final db = await _getDatabase();
      int imported = 0;

      for (final tuElement in tuElements) {
        final tuvElements = tuElement.findElements('tuv').toList();
        if (tuvElements.isEmpty) {
          continue;
        }
        final sourceTuv = _findTuvForLanguage(
          tuvElements,
          sourceLanguage,
        );
        final targetTuv = targetLanguage == null || targetLanguage.isEmpty
            ? _findAlternateTuv(tuvElements, sourceTuv)
            : _findTuvForLanguage(tuvElements, targetLanguage);
        if (sourceTuv == null || targetTuv == null) {
          continue;
        }
        final sourceSeg = _firstOrNull(
          sourceTuv.findElements('seg'),
        );
        final targetSeg = _firstOrNull(
          targetTuv.findElements('seg'),
        );
        final sourceText = sourceSeg?.innerText.trim() ?? '';
        final targetText = targetSeg?.innerText.trim() ?? '';
        if (sourceText.isEmpty || targetText.isEmpty) {
          continue;
        }
        final resolvedSourceLang =
            _readLanguage(sourceTuv) ?? sourceLanguage;
        final resolvedTargetLang =
            _readLanguage(targetTuv) ?? targetLanguage;
        await _upsertTranslationUnit(
          db,
          _TranslationUnit(
            sourceLang: _normalizeLanguage(resolvedSourceLang),
            targetLang: _normalizeLanguage(resolvedTargetLang),
            sourceText: sourceText,
            targetText: targetText,
          ),
        );
        imported++;
      }

      return imported;
    } catch (e, s) {
      developer.log(
        'Failed to import TMX file.',
        name: 'translation_memory.import',
        error: e,
        stackTrace: s,
      );
      return 0;
    }
  }

  /// Imports translation units from a CSV file.
  Future<int> importFromCsv(File file) async {
    try {
      final content = await file.readAsString(encoding: utf8);
      if (content.trim().isEmpty) {
        return 0;
      }
      final rows = const CsvToListConverter().convert(content);
      if (rows.isEmpty) {
        return 0;
      }

      final db = await _getDatabase();
      int imported = 0;
      int startIndex = 0;
      if (_isHeaderRow(rows.first)) {
        startIndex = 1;
      }

      for (var i = startIndex; i < rows.length; i++) {
        final row = rows[i];
        if (row.length < 2) {
          continue;
        }
        final sourceText = row[0].toString().trim();
        final targetText = row[1].toString().trim();
        if (sourceText.isEmpty || targetText.isEmpty) {
          continue;
        }
        await _upsertTranslationUnit(
          db,
          _TranslationUnit(
            sourceLang: _unknownLanguage,
            targetLang: _unknownLanguage,
            sourceText: sourceText,
            targetText: targetText,
          ),
        );
        imported++;
      }
      return imported;
    } catch (e, s) {
      developer.log(
        'Failed to import CSV file.',
        name: 'translation_memory.import',
        error: e,
        stackTrace: s,
      );
      return 0;
    }
  }

  /// Exports translation units to a TMX 1.4b file.
  Future<void> exportToTmx(File file) async {
    final units = await _loadAllUnits();
    final sourceLang = _pickMostCommonLanguage(
      units.map((unit) => unit.sourceLang),
    );
    final targetLang = _pickMostCommonLanguage(
      units.map((unit) => unit.targetLang),
    );

    final builder = xml.XmlBuilder();
    builder.processing(
      'xml',
      'version="1.0" encoding="UTF-8"',
    );
    builder.element(
      'tmx',
      attributes: {'version': '1.4'},
      nest: () {
        builder.element(
          'header',
          attributes: {
            'creationtool': 'LocalizerAppMain',
            'creationtoolversion': '1.0',
            'segtype': 'sentence',
            'o-tmf': 'LocalizerAppMain',
            'adminlang': 'en-us',
            'srclang': sourceLang,
            'datatype': 'PlainText',
          },
        );
        builder.element('body', nest: () {
          for (final unit in units) {
            final resolvedSourceLang =
                unit.sourceLang == _unknownLanguage
                    ? sourceLang
                    : unit.sourceLang;
            final resolvedTargetLang =
                unit.targetLang == _unknownLanguage
                    ? targetLang
                    : unit.targetLang;
            builder.element('tu', nest: () {
              builder.element(
                'tuv',
                attributes: {'xml:lang': resolvedSourceLang},
                nest: () {
                  builder.element(
                    'seg',
                    nest: () => builder.text(unit.sourceText),
                  );
                },
              );
              builder.element(
                'tuv',
                attributes: {'xml:lang': resolvedTargetLang},
                nest: () {
                  builder.element(
                    'seg',
                    nest: () => builder.text(unit.targetText),
                  );
                },
              );
            });
          }
        });
      },
    );

    final document = builder.buildDocument();
    await file.writeAsString(
      document.toXmlString(pretty: true, indent: '  '),
      encoding: utf8,
    );
  }

  /// Exports translation units to a CSV file.
  Future<void> exportToCsv(File file) async {
    final units = await _loadAllUnits();
    final rows = <List<String>>[
      ['Source', 'Target'],
      ...units.map((unit) => [unit.sourceText, unit.targetText]),
    ];
    final csvText = const ListToCsvConverter().convert(rows);
    await file.writeAsString(csvText, encoding: utf8);
  }

  Future<sqflite.Database> _getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _databaseFuture ??= _openDatabase();
    _database = await _databaseFuture!;
    return _database!;
  }

  Future<sqflite.Database> _openDatabase() async {
    await _initDatabaseFactory();
    final dbPath = await _resolveDatabasePath();
    return sqflite.openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            source_lang TEXT NOT NULL,
            target_lang TEXT NOT NULL,
            source_text TEXT NOT NULL,
            target_text TEXT NOT NULL,
            created_at INTEGER,
            usage_count INTEGER DEFAULT 0
          )
        ''');
        await db.execute(
          'CREATE INDEX idx_source_text ON $_tableName(source_text)',
        );
      },
    );
  }

  Future<void> _initDatabaseFactory() async {
    if (_databaseFactoryInitialized) {
      return;
    }
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      sqflite.databaseFactory = databaseFactoryFfi;
    }
    _databaseFactoryInitialized = true;
  }

  Future<String> _resolveDatabasePath() async {
    if (_databasePath != null) {
      return _databasePath!;
    }
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory(path.join(directory.path, 'translation_memory'));
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    _databasePath = path.join(folder.path, _dbName);
    return _databasePath!;
  }

  String _normalizeLanguage(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'auto') {
      return _unknownLanguage;
    }
    return trimmed.toLowerCase();
  }

  String _pickMostCommonLanguage(Iterable<String> languages) {
    final counts = <String, int>{};
    for (final language in languages) {
      if (language == _unknownLanguage) {
        continue;
      }
      counts[language] = (counts[language] ?? 0) + 1;
    }
    if (counts.isEmpty) {
      return _unknownLanguage;
    }
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.first.key;
  }

  bool _isHeaderRow(List<dynamic> row) {
    if (row.length < 2) {
      return false;
    }
    final first = row[0].toString().toLowerCase();
    final second = row[1].toString().toLowerCase();
    return first.contains('source') && second.contains('target');
  }

  Future<void> _upsertTranslationUnit(
    sqflite.Database db,
    _TranslationUnit unit,
  ) async {
    final existing = await db.query(
      _tableName,
      columns: ['id', 'target_text'],
      where: 'source_lang = ? AND target_lang = ? AND source_text = ?',
      whereArgs: [unit.sourceLang, unit.targetLang, unit.sourceText],
      limit: 1,
    );

    if (existing.isEmpty) {
      await db.insert(_tableName, {
        'source_lang': unit.sourceLang,
        'target_lang': unit.targetLang,
        'source_text': unit.sourceText,
        'target_text': unit.targetText,
        'created_at': DateTime.now().millisecondsSinceEpoch,
        'usage_count': 0,
      });
      return;
    }

    final existingTarget = existing.first['target_text'] as String? ?? '';
    if (existingTarget != unit.targetText) {
      await db.update(
        _tableName,
        {'target_text': unit.targetText},
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    }
  }

  Future<List<_TranslationUnit>> _loadAllUnits() async {
    final db = await _getDatabase();
    final rows = await db.query(
      _tableName,
      columns: ['source_lang', 'target_lang', 'source_text', 'target_text'],
      orderBy: 'id ASC',
    );
    return rows
        .map(
          (row) => _TranslationUnit(
            sourceLang: row['source_lang'] as String? ?? _unknownLanguage,
            targetLang: row['target_lang'] as String? ?? _unknownLanguage,
            sourceText: row['source_text'] as String? ?? '',
            targetText: row['target_text'] as String? ?? '',
          ),
        )
        .toList();
  }

  xml.XmlElement? _firstOrNull(Iterable<xml.XmlElement> elements) {
    return elements.isEmpty ? null : elements.first;
  }

  String? _detectTargetLanguage(
    Iterable<xml.XmlElement> tuElements,
    String? sourceLanguage,
  ) {
    if (sourceLanguage == null || sourceLanguage.isEmpty) {
      return null;
    }

    for (final tuElement in tuElements) {
      for (final tuvElement in tuElement.findElements('tuv')) {
        final language = _readLanguage(tuvElement);
        if (language != null &&
            language.isNotEmpty &&
            !_matchesLanguage(language, sourceLanguage)) {
          return language;
        }
      }
    }

    return null;
  }

  xml.XmlElement? _findTuvForLanguage(
    List<xml.XmlElement> tuvElements,
    String? language,
  ) {
    if (tuvElements.isEmpty) {
      return null;
    }
    if (language == null || language.isEmpty) {
      return tuvElements.first;
    }

    return tuvElements.firstWhere(
      (element) => _matchesLanguage(_readLanguage(element), language),
      orElse: () => tuvElements.first,
    );
  }

  xml.XmlElement? _findAlternateTuv(
    List<xml.XmlElement> tuvElements,
    xml.XmlElement? sourceTuv,
  ) {
    if (tuvElements.length < 2) {
      return null;
    }
    final sourceLanguage =
        sourceTuv == null ? null : _readLanguage(sourceTuv);
    for (final tuv in tuvElements) {
      if (tuv == sourceTuv) {
        continue;
      }
      final language = _readLanguage(tuv);
      if (sourceLanguage == null ||
          language == null ||
          !_matchesLanguage(language, sourceLanguage)) {
        return tuv;
      }
    }
    return tuvElements.length > 1 ? tuvElements[1] : null;
  }

  String? _readLanguage(xml.XmlElement element) {
    return element.getAttribute('xml:lang') ?? element.getAttribute('lang');
  }

  bool _matchesLanguage(String? value, String other) {
    if (value == null) {
      return false;
    }
    return value.toLowerCase() == other.toLowerCase();
  }
}
