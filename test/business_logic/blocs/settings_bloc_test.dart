import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_scope.dart';
import 'package:localizer_app_main/data/models/project_settings.dart';

// Mock classes using mocktail
class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockApiKeyValidationService extends Mock
    implements ApiKeyValidationService {}

void main() {
  late MockSettingsRepository mockSettingsRepository;
  late MockSecureStorageService mockSecureStorageService;
  late MockApiKeyValidationService mockApiKeyValidationService;
  late SettingsBloc settingsBloc;

  setUpAll(() {
    registerFallbackValue(AppSettings.defaultSettings());
  });

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    mockSecureStorageService = MockSecureStorageService();
    mockApiKeyValidationService = MockApiKeyValidationService();
  });

  tearDown(() {
    settingsBloc.close();
  });

  group('SettingsBloc', () {
    // Use defaultSettings() factory constructor
    final initialSettings = AppSettings.defaultSettings();
    final settingsWithKeysInHive = AppSettings.defaultSettings().copyWith(
      googleTranslateApiKey: 'hive_google_key',
      deeplApiKey: 'hive_deepl_key',
    );

    test('initial state is correct', () {
      settingsBloc = SettingsBloc(
        settingsRepository: mockSettingsRepository,
        secureStorageService: mockSecureStorageService,
        apiKeyValidationService: mockApiKeyValidationService,
      );
      expect(settingsBloc.state.status, SettingsStatus.initial);
      expect(settingsBloc.state.appSettings, isA<AppSettings>());
    });

    blocTest<SettingsBloc, SettingsState>(
      'emits [loaded] with migrated keys when keys exist in Hive but not in Secure Storage',
      build: () {
        when(() => mockSettingsRepository.loadSettings())
            .thenAnswer((_) async => settingsWithKeysInHive);
        // Use correct method names: getGoogleApiKey, getDeepLApiKey, etc.
        when(() => mockSecureStorageService.getGoogleApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.getDeepLApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.getGeminiApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.getOpenAiApiKey())
            .thenAnswer((_) async => null);
        // Use correct method names: storeGoogleApiKey, storeDeepLApiKey, etc.
        when(() => mockSecureStorageService.storeGoogleApiKey(any()))
            .thenAnswer((_) async {});
        when(() => mockSecureStorageService.storeDeepLApiKey(any()))
            .thenAnswer((_) async {});
        when(() => mockSettingsRepository.saveSettings(any()))
            .thenAnswer((_) async {});

        return SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        );
      },
      act: (bloc) => bloc.add(LoadSettings()),
      verify: (_) {
        verify(() =>
                mockSecureStorageService.storeGoogleApiKey('hive_google_key'))
            .called(1);
        verify(() =>
                mockSecureStorageService.storeDeepLApiKey('hive_deepl_key'))
            .called(1);
        // Verify that settings are saved back to Hive WITHOUT keys
        verify(() => mockSettingsRepository.saveSettings(any())).called(1);
      },
      expect: () => [
        isA<SettingsState>()
            .having((s) => s.status, 'status', SettingsStatus.loading),
        isA<SettingsState>()
            .having((s) => s.status, 'status', SettingsStatus.loaded)
            .having((s) => s.appSettings.googleTranslateApiKey, 'googleKey',
                'hive_google_key')
            .having(
                (s) => s.appSettings.deeplApiKey, 'deeplKey', 'hive_deepl_key'),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'emits [loaded] with keys from Secure Storage when available',
      build: () {
        when(() => mockSettingsRepository.loadSettings())
            .thenAnswer((_) async => initialSettings);
        when(() => mockSecureStorageService.getGoogleApiKey())
            .thenAnswer((_) async => 'secure_google_key');
        when(() => mockSecureStorageService.getDeepLApiKey())
            .thenAnswer((_) async => 'secure_deepl_key');
        when(() => mockSecureStorageService.getGeminiApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.getOpenAiApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSettingsRepository.saveSettings(any()))
            .thenAnswer((_) async {});

        return SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        );
      },
      act: (bloc) => bloc.add(LoadSettings()),
      expect: () => [
        isA<SettingsState>()
            .having((s) => s.status, 'status', SettingsStatus.loading),
        isA<SettingsState>()
            .having((s) => s.appSettings.googleTranslateApiKey, 'googleKey',
                'secure_google_key')
            .having((s) => s.appSettings.deeplApiKey, 'deeplKey',
                'secure_deepl_key'),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'UpdateGoogleTranslateApiKey saves to Secure Storage and clears from Hive',
      build: () {
        when(() => mockSettingsRepository.loadSettings())
            .thenAnswer((_) async => initialSettings);
        when(() => mockSecureStorageService.getGoogleApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.getDeepLApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.getGeminiApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.getOpenAiApiKey())
            .thenAnswer((_) async => null);
        when(() => mockSecureStorageService.storeGoogleApiKey(any()))
            .thenAnswer((_) async {});
        when(() => mockSettingsRepository.saveSettings(any()))
            .thenAnswer((_) async {});

        return SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        );
      },
      act: (bloc) async {
        bloc.add(LoadSettings());
        await Future.delayed(const Duration(milliseconds: 50)); // Wait for load
        bloc.add(const UpdateGoogleTranslateApiKey('new_google_key'));
      },
      skip: 2, // Skip loading and first loaded state
      verify: (_) {
        verify(() =>
                mockSecureStorageService.storeGoogleApiKey('new_google_key'))
            .called(1);
      },
      expect: () => [
        isA<SettingsState>().having((s) => s.appSettings.googleTranslateApiKey,
            'googleKey', 'new_google_key'),
      ],
    );

    group('Project Overrides (Phase 2)', () {
      final projectSettings = const ProjectSettings(
        systemTranslationContext: 'Project Context',
        aiTranslationService: 'Gemini',
      );

      test('initial state has global scope', () {
        expect(settingsBloc.state.scope, SettingsScope.global);
        expect(settingsBloc.state.hasProject, isFalse);
      });

      blocTest<SettingsBloc, SettingsState>(
        'LoadProjectSettings loads settings and defaults to global scope',
        build: () => SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        ),
        act: (bloc) => bloc.add(LoadProjectSettings(
          projectId: 'p1',
          projectName: 'Test Project',
          settings: projectSettings,
        )),
        expect: () => [
          isA<SettingsState>()
              .having(
                  (s) => s.projectSettings, 'projectSettings', projectSettings)
              .having((s) => s.currentProjectId, 'id', 'p1')
              .having((s) => s.scope, 'scope', SettingsScope.global),
        ],
      );

      blocTest<SettingsBloc, SettingsState>(
        'SwitchSettingsScope switches scope if project loaded',
        build: () => SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        ),
        seed: () => SettingsState.initial().copyWith(
          projectSettings: projectSettings,
          currentProjectId: 'p1',
        ),
        act: (bloc) =>
            bloc.add(const SwitchSettingsScope(SettingsScope.project)),
        expect: () => [
          isA<SettingsState>()
              .having((s) => s.scope, 'scope', SettingsScope.project),
        ],
      );

      blocTest<SettingsBloc, SettingsState>(
        'SwitchSettingsScope ignores switch if no project loaded',
        build: () => SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        ),
        act: (bloc) =>
            bloc.add(const SwitchSettingsScope(SettingsScope.project)),
        expect: () => [],
      );

      blocTest<SettingsBloc, SettingsState>(
        'UpdateProjectOverridableSetting creates override in project scope',
        build: () => SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        ),
        seed: () => SettingsState.initial().copyWith(
          projectSettings: const ProjectSettings(),
          scope: SettingsScope.project,
          currentProjectId: 'p1',
        ),
        act: (bloc) => bloc.add(const UpdateProjectOverridableSetting(
          settingKey: 'systemTranslationContext',
          value: 'New Override',
        )),
        expect: () => [
          isA<SettingsState>().having(
            (s) => s.projectSettings?.systemTranslationContext,
            'override',
            'New Override',
          ),
        ],
      );

      blocTest<SettingsBloc, SettingsState>(
        'UpdateProjectOverridableSetting updates global setting in global scope',
        build: () {
          when(() => mockSettingsRepository.saveSettings(any()))
              .thenAnswer((_) async {});
          return SettingsBloc(
            settingsRepository: mockSettingsRepository,
            secureStorageService: mockSecureStorageService,
            apiKeyValidationService: mockApiKeyValidationService,
          );
        },
        seed: () => SettingsState.initial().copyWith(
          projectSettings: const ProjectSettings(),
          scope: SettingsScope.global,
        ),
        act: (bloc) => bloc.add(const UpdateProjectOverridableSetting(
          settingKey: 'systemTranslationContext',
          value: 'Global Context',
        )),
        verify: (_) {
          verify(() => mockSettingsRepository.saveSettings(
                any(
                    that: isA<AppSettings>().having(
                        (s) => s.systemTranslationContext,
                        'ctx',
                        'Global Context')),
              )).called(1);
        },
        expect: () => [
          isA<SettingsState>().having(
            (s) => s.appSettings.systemTranslationContext,
            'global',
            'Global Context',
          ),
        ],
      );

      blocTest<SettingsBloc, SettingsState>(
        'ResetSettingToGlobal clears specific override',
        build: () => SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        ),
        seed: () => SettingsState.initial().copyWith(
          projectSettings: projectSettings,
          scope: SettingsScope.project,
        ),
        act: (bloc) =>
            bloc.add(const ResetSettingToGlobal('systemTranslationContext')),
        expect: () => [
          isA<SettingsState>()
              .having(
                (s) => s.projectSettings?.systemTranslationContext,
                'cleared',
                isNull,
              )
              .having(
                (s) => s.projectSettings?.aiTranslationService,
                'kept',
                'Gemini',
              ),
        ],
      );

      blocTest<SettingsBloc, SettingsState>(
        'ResetAllProjectSettings clears all overrides',
        build: () => SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
          apiKeyValidationService: mockApiKeyValidationService,
        ),
        seed: () => SettingsState.initial().copyWith(
          projectSettings: projectSettings,
          scope: SettingsScope.project,
        ),
        act: (bloc) => bloc.add(const ResetAllProjectSettings()),
        expect: () => [
          isA<SettingsState>().having(
            (s) => s.projectSettings?.hasOverrides,
            'hasOverrides',
            isFalse,
          ),
        ],
      );
    });
  });
}
