import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/project_settings.dart';

void main() {
  group('ProjectSettings', () {
    group('constructor', () {
      test('empty constructor creates empty settings', () {
        const settings = ProjectSettings.empty();
        
        expect(settings.systemTranslationContext, isNull);
        expect(settings.aiTranslationService, isNull);
        expect(settings.defaultAiModel, isNull);
        expect(settings.hasOverrides, isFalse);
        expect(settings.overriddenSettings, isEmpty);
      });

      test('constructor with values stores them correctly', () {
        const settings = ProjectSettings(
          systemTranslationContext: 'Test context',
          aiTranslationService: 'Gemini',
          defaultAiModel: 'gemini-1.5-pro',
        );
        
        expect(settings.systemTranslationContext, 'Test context');
        expect(settings.aiTranslationService, 'Gemini');
        expect(settings.defaultAiModel, 'gemini-1.5-pro');
      });
    });

    group('overriddenSettings', () {
      test('returns empty set when no overrides', () {
        const settings = ProjectSettings.empty();
        expect(settings.overriddenSettings, isEmpty);
      });

      test('returns correct set with one override', () {
        const settings = ProjectSettings(
          systemTranslationContext: 'Custom context',
        );
        
        expect(settings.overriddenSettings, {'systemTranslationContext'});
      });

      test('returns correct set with multiple overrides', () {
        const settings = ProjectSettings(
          systemTranslationContext: 'Custom context',
          aiTranslationService: 'OpenAI',
          defaultAiModel: 'gpt-4o',
        );
        
        expect(settings.overriddenSettings, {
          'systemTranslationContext',
          'aiTranslationService',
          'defaultAiModel',
        });
      });
    });

    group('hasOverrides', () {
      test('returns false for empty settings', () {
        const settings = ProjectSettings.empty();
        expect(settings.hasOverrides, isFalse);
      });

      test('returns true when any setting is overridden', () {
        const settings = ProjectSettings(
          defaultAiModel: 'gemini-1.5-flash',
        );
        expect(settings.hasOverrides, isTrue);
      });
    });

    group('isOverridden', () {
      test('returns false for unset settings', () {
        const settings = ProjectSettings.empty();
        
        expect(settings.isOverridden('systemTranslationContext'), isFalse);
        expect(settings.isOverridden('aiTranslationService'), isFalse);
        expect(settings.isOverridden('defaultAiModel'), isFalse);
      });

      test('returns true for set settings', () {
        const settings = ProjectSettings(
          systemTranslationContext: 'Custom',
        );
        
        expect(settings.isOverridden('systemTranslationContext'), isTrue);
        expect(settings.isOverridden('aiTranslationService'), isFalse);
      });

      test('returns false for unknown settings', () {
        const settings = ProjectSettings(
          systemTranslationContext: 'Custom',
        );
        
        expect(settings.isOverridden('unknownSetting'), isFalse);
      });
    });

    group('JSON serialization', () {
      test('fromJson with null returns empty settings', () {
        final settings = ProjectSettings.fromJson(null);
        
        expect(settings.hasOverrides, isFalse);
      });

      test('fromJson with empty map returns empty settings', () {
        final settings = ProjectSettings.fromJson({});
        
        expect(settings.hasOverrides, isFalse);
      });

      test('fromJson parses values correctly', () {
        final settings = ProjectSettings.fromJson({
          'systemTranslationContext': 'Test context',
          'aiTranslationService': 'Gemini',
          'defaultAiModel': 'gemini-1.5-pro',
        });
        
        expect(settings.systemTranslationContext, 'Test context');
        expect(settings.aiTranslationService, 'Gemini');
        expect(settings.defaultAiModel, 'gemini-1.5-pro');
      });

      test('toJson only includes non-null values', () {
        const settings = ProjectSettings(
          systemTranslationContext: 'Test',
        );
        final json = settings.toJson();
        
        expect(json['systemTranslationContext'], 'Test');
        expect(json.containsKey('aiTranslationService'), isFalse);
        expect(json.containsKey('defaultAiModel'), isFalse);
      });

      test('toJson returns empty map for empty settings', () {
        const settings = ProjectSettings.empty();
        final json = settings.toJson();
        
        expect(json, isEmpty);
      });

      test('round-trip serialization preserves data', () {
        const original = ProjectSettings(
          systemTranslationContext: 'Complex context with\nline breaks',
          aiTranslationService: 'OpenAI',
          defaultAiModel: 'gpt-4-turbo',
        );
        
        final json = original.toJson();
        final restored = ProjectSettings.fromJson(json);
        
        expect(restored, equals(original));
      });
    });

    group('copyWith', () {
      test('creates copy with updated field', () {
        const original = ProjectSettings(
          systemTranslationContext: 'Original',
        );
        
        final updated = original.copyWith(
          aiTranslationService: 'Gemini',
        );
        
        expect(updated.systemTranslationContext, 'Original');
        expect(updated.aiTranslationService, 'Gemini');
      });

      test('clear flag removes override', () {
        const original = ProjectSettings(
          systemTranslationContext: 'To be cleared',
          aiTranslationService: 'Keep this',
        );
        
        final cleared = original.copyWith(
          clearSystemTranslationContext: true,
        );
        
        expect(cleared.systemTranslationContext, isNull);
        expect(cleared.aiTranslationService, 'Keep this');
      });
    });

    group('clearOverride', () {
      test('clears specific override', () {
        const original = ProjectSettings(
          systemTranslationContext: 'Test',
          aiTranslationService: 'Gemini',
        );
        
        final cleared = original.clearOverride('systemTranslationContext');
        
        expect(cleared.systemTranslationContext, isNull);
        expect(cleared.aiTranslationService, 'Gemini');
      });

      test('returns unchanged for unknown key', () {
        const original = ProjectSettings(
          systemTranslationContext: 'Test',
        );
        
        final result = original.clearOverride('unknownKey');
        
        expect(result.systemTranslationContext, 'Test');
      });
    });

    group('clearCategoryOverrides', () {
      test('clears all AI service overrides', () {
        const original = ProjectSettings(
          systemTranslationContext: 'Test',
          aiTranslationService: 'Gemini',
          defaultAiModel: 'gemini-1.5-pro',
        );
        
        final cleared = original.clearCategoryOverrides('aiServices');
        
        expect(cleared.hasOverrides, isFalse);
      });

      test('returns unchanged for other categories', () {
        const original = ProjectSettings(
          systemTranslationContext: 'Test',
        );
        
        final result = original.clearCategoryOverrides('otherCategory');
        
        expect(result.systemTranslationContext, 'Test');
      });
    });

    group('equality', () {
      test('equal settings are equal', () {
        const settings1 = ProjectSettings(
          systemTranslationContext: 'Test',
        );
        const settings2 = ProjectSettings(
          systemTranslationContext: 'Test',
        );
        
        expect(settings1, equals(settings2));
        expect(settings1.hashCode, settings2.hashCode);
      });

      test('different settings are not equal', () {
        const settings1 = ProjectSettings(
          systemTranslationContext: 'Test1',
        );
        const settings2 = ProjectSettings(
          systemTranslationContext: 'Test2',
        );
        
        expect(settings1, isNot(equals(settings2)));
      });

      test('empty settings are equal', () {
        const settings1 = ProjectSettings.empty();
        const settings2 = ProjectSettings.empty();
        
        expect(settings1, equals(settings2));
      });
    });

    group('toString', () {
      test('shows overridden settings', () {
        const settings = ProjectSettings(
          systemTranslationContext: 'Test',
          defaultAiModel: 'gpt-4o',
        );
        
        final str = settings.toString();
        expect(str, contains('overrides:'));
        expect(str, contains('systemTranslationContext'));
        expect(str, contains('defaultAiModel'));
      });
    });
  });
}
