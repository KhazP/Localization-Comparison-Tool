import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart' hide ComparisonResult;
import 'package:bloc_test/bloc_test.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/views/comparison_result_dialog.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

class MockThemeBloc extends MockBloc<ThemeEvent, AppThemeState>
    implements ThemeBloc {}

class FakeThemeEvent extends Fake implements ThemeEvent {}

void main() {
  late MockSettingsBloc mockSettingsBloc;
  late MockThemeBloc mockThemeBloc;
  late ComparisonResult testResult;

  setUpAll(() {
    registerFallbackValue(FakeSettingsEvent());
    registerFallbackValue(FakeThemeEvent());
  });

  setUp(() {
    mockSettingsBloc = MockSettingsBloc();
    mockThemeBloc = MockThemeBloc();

    final defaultSettings = AppSettings.defaultSettings();
    final settingsState = SettingsState(
      status: SettingsStatus.loaded,
      appSettings: defaultSettings,
      apiKeyTests: {},
    );

    when(() => mockSettingsBloc.state).thenReturn(settingsState);
    when(() => mockThemeBloc.state).thenReturn(
      AppThemeState.initial(defaultSettings),
    );

    // Build a small comparison result
    testResult = ComparisonResult(
      {'key1': 'Hello', 'key2': 'World'},
      {'key1': 'Hola', 'key3': 'Nuevo'},
      IMap({
        'key1': const ComparisonStatusDetail.modified(0.5),
        'key2': const ComparisonStatusDetail.removed(),
        'key3': const ComparisonStatusDetail.added(),
      }),
    );
  });

  testWidgets(
    'ComparisonResultDialog renders diff viewer with correct data',
    (WidgetTester tester) async {
      // Initialize locale for slang translations
      LocaleSettings.setLocale(AppLocale.en);

      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      await tester.pumpWidget(
        TranslationProvider(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SettingsBloc>.value(value: mockSettingsBloc),
              BlocProvider<ThemeBloc>.value(value: mockThemeBloc),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: ComparisonResultDialog(result: testResult),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify it renders without exception
      expect(find.byType(ComparisonResultDialog), findsOneWidget);

      // Verify key UI elements are present - the diff viewer header
      expect(find.textContaining('BASE'), findsWidgets);
      expect(find.textContaining('TARGET'), findsWidgets);
    },
  );
}
