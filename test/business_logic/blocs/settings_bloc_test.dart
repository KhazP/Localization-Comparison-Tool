import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'settings_bloc_test.mocks.dart';

@GenerateMocks([SettingsRepository, SecureStorageService])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late MockSecureStorageService mockSecureStorageService;
  late SettingsBloc settingsBloc;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    mockSecureStorageService = MockSecureStorageService();
  });

  tearDown(() {
    settingsBloc.close();
  });

  group('SettingsBloc', () {
    final initialSettings = AppSettings();
    final settingsWithKeysInHive = AppSettings(
      googleTranslateApiKey: 'hive_google_key',
      deeplApiKey: 'hive_deepl_key',
    );

    test('initial state is correct', () {
      settingsBloc = SettingsBloc(
        settingsRepository: mockSettingsRepository,
        secureStorageService: mockSecureStorageService,
      );
      expect(settingsBloc.state, SettingsState.initial());
    });

    blocTest<SettingsBloc, SettingsState>(
      'emits [loaded] with migrated keys when keys exist in Hive but not in Secure Storage',
      build: () {
        when(mockSettingsRepository.loadSettings())
            .thenAnswer((_) async => settingsWithKeysInHive);
        when(mockSecureStorageService.getGoogleTranslateApiKey())
            .thenAnswer((_) async => null);
        when(mockSecureStorageService.getDeeplApiKey())
            .thenAnswer((_) async => null);
        when(mockSecureStorageService.saveGoogleTranslateApiKey(any))
            .thenAnswer((_) async {});
        when(mockSecureStorageService.saveDeeplApiKey(any))
            .thenAnswer((_) async {});
        when(mockSettingsRepository.saveSettings(any))
            .thenAnswer((_) async {});

        return SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
        );
      },
      act: (bloc) => bloc.add(LoadSettings()),
      verify: (_) {
        verify(mockSecureStorageService.saveGoogleTranslateApiKey('hive_google_key')).called(1);
        verify(mockSecureStorageService.saveDeeplApiKey('hive_deepl_key')).called(1);
        // Verify that settings are saved back to Hive WITHOUT keys (this is harder to verify exactly without capturing the argument, but we can verify saveSettings was called)
        verify(mockSettingsRepository.saveSettings(any)).called(1); 
      },
      expect: () => [
        isA<SettingsState>().having((s) => s.status, 'status', SettingsStatus.loaded)
            .having((s) => s.appSettings.googleTranslateApiKey, 'googleKey', 'hive_google_key')
            .having((s) => s.appSettings.deeplApiKey, 'deeplKey', 'hive_deepl_key'),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'emits [loaded] with keys from Secure Storage when available',
      build: () {
        when(mockSettingsRepository.loadSettings())
            .thenAnswer((_) async => initialSettings);
        when(mockSecureStorageService.getGoogleTranslateApiKey())
            .thenAnswer((_) async => 'secure_google_key');
        when(mockSecureStorageService.getDeeplApiKey())
            .thenAnswer((_) async => 'secure_deepl_key');

        return SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
        );
      },
      act: (bloc) => bloc.add(LoadSettings()),
      expect: () => [
        isA<SettingsState>()
            .having((s) => s.appSettings.googleTranslateApiKey, 'googleKey', 'secure_google_key')
            .having((s) => s.appSettings.deeplApiKey, 'deeplKey', 'secure_deepl_key'),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'UpdateGoogleTranslateApiKey saves to Secure Storage and clears from Hive',
      build: () {
        when(mockSettingsRepository.loadSettings())
            .thenAnswer((_) async => initialSettings);
        when(mockSecureStorageService.getGoogleTranslateApiKey())
            .thenAnswer((_) async => null);
        when(mockSecureStorageService.getDeeplApiKey())
            .thenAnswer((_) async => null);
        when(mockSecureStorageService.saveGoogleTranslateApiKey(any))
            .thenAnswer((_) async {});
        when(mockSettingsRepository.saveSettings(any))
            .thenAnswer((_) async {});

        return SettingsBloc(
          settingsRepository: mockSettingsRepository,
          secureStorageService: mockSecureStorageService,
        );
      },
      act: (bloc) async {
        bloc.add(LoadSettings());
        await Future.delayed(Duration.zero); // Wait for load
        bloc.add(UpdateGoogleTranslateApiKey('new_google_key'));
      },
      skip: 1, // Skip load event
      verify: (_) {
        verify(mockSecureStorageService.saveGoogleTranslateApiKey('new_google_key')).called(1);
        // Verify saveSettings is called with empty keys
        verify(mockSettingsRepository.saveSettings(argThat(
          predicate<AppSettings>((settings) => settings.googleTranslateApiKey.isEmpty && settings.deeplApiKey.isEmpty),
        ))).called(greaterThanOrEqualTo(1));
      },
      expect: () => [
        isA<SettingsState>().having((s) => s.appSettings.googleTranslateApiKey, 'googleKey', 'new_google_key'),
      ],
    );
  });
}
