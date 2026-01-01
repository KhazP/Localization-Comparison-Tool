import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/services/localization_file_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

void main() {
  group('LocalizationFileService', () {
    late Directory tempDir;
    late LocalizationFileService service;
    late AppSettings settings;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('localizer_test_');
      service = LocalizationFileService();
      settings = AppSettings.defaultSettings().copyWith(autoBackup: false);
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('upsertEntry writes nested JSON keys', () async {
      final file = File('${tempDir.path}/strings.json');
      await file.writeAsString(
        jsonEncode({
          'greetings': {'hello': 'Hello'}
        }),
      );

      final result = await service.upsertEntry(
        file: file,
        key: 'greetings.goodbye',
        value: 'Bye',
        settings: settings,
        encodingName: settings.defaultSourceEncoding,
        forcedFormat: 'json',
      );

      expect(result['greetings.goodbye'], 'Bye');

      final decoded = json.decode(await file.readAsString());
      expect(decoded['greetings']['goodbye'], 'Bye');
    });

    test('deleteEntry removes JSON keys', () async {
      final file = File('${tempDir.path}/strings.json');
      await file.writeAsString(
        jsonEncode({
          'greetings': {'hello': 'Hello', 'goodbye': 'Bye'}
        }),
      );

      final result = await service.deleteEntry(
        file: file,
        key: 'greetings.hello',
        settings: settings,
        encodingName: settings.defaultSourceEncoding,
        forcedFormat: 'json',
      );

      expect(result.containsKey('greetings.hello'), isFalse);

      final decoded = json.decode(await file.readAsString());
      expect(decoded['greetings'].containsKey('hello'), isFalse);
    });

    test('upsertEntry updates CSV files', () async {
      final file = File('${tempDir.path}/strings.csv');
      await file.writeAsString('Key,Value\nhello,Hello\n');

      final result = await service.upsertEntry(
        file: file,
        key: 'goodbye',
        value: 'Bye',
        settings: settings,
        encodingName: settings.defaultSourceEncoding,
        forcedFormat: 'csv',
      );

      expect(result['goodbye'], 'Bye');
      expect(await file.readAsString(), contains('goodbye'));
    });
  });
}
