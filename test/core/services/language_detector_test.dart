import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/services/language_detector.dart';

void main() {
  group('LanguageDetector', () {
    test('detects language from file name tokens', () {
      final code = LanguageDetector.detectFromPath(
        'C:/project/assets/strings/app_en.json',
      );
      expect(code, 'en');
    });

    test('returns unknown when no language is found', () {
      final code = LanguageDetector.detectFromPath('C:/project/app.json');
      expect(code, 'und');
    });

    test('formats display names for known codes', () {
      expect(LanguageDetector.displayName('en'), 'English (en)');
    });
  });
}
