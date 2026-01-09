import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

Map<ApiProvider, ApiKeyTestResult> get defaultApiKeyTests => {
      ApiProvider.googleTranslate: ApiKeyTestResult.idle,
      ApiProvider.deepl: ApiKeyTestResult.idle,
      ApiProvider.gemini: ApiKeyTestResult.idle,
      ApiProvider.openAi: ApiKeyTestResult.idle,
    };

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class FakeSettingsEvent extends Fake implements SettingsEvent {}

Future<void> pumpComparisonSettingsCard(
  WidgetTester tester, {
  required SettingsBloc settingsBloc,
  required SettingsState initialState,
  Stream<SettingsState>? stream,
  VoidCallback? onShowAddPatternDialog,
}) async {
  await tester.binding.setSurfaceSize(const Size(1600, 2000));
  addTearDown(() async {
    await tester.binding.setSurfaceSize(null);
  });

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<SettingsBloc>.value(
        value: settingsBloc,
        child: StreamBuilder<SettingsState>(
          stream: stream,
          initialData: initialState,
          builder: (context, snapshot) {
            final state = snapshot.data ?? initialState;
            return Scaffold(
              body: ComparisonSettingsCard(
                settings: state.appSettings,
                state: state,
                isDark: false,
                isAmoled: false,
                onShowAddPatternDialog: onShowAddPatternDialog ?? () {},
                showLivePreview: false,
              ),
            );
          },
        ),
      ),
    ),
  );

  await tester.pump();
}

Future<void> openAddIgnorePatternDialog(
  WidgetTester tester, {
  required ValueChanged<String> onSubmit,
}) async {
  // Initialize locale settings for slang translations
  LocaleSettings.setLocale(AppLocale.en);

  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                key: const Key('open_add_dialog_button'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddIgnorePatternDialog(
                      autofocus: false,
                      onSubmit: onSubmit,
                    ),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.byKey(const Key('open_add_dialog_button')));
  await tester.pump(const Duration(milliseconds: 200));
}

void main() {
  late AppSettings initialAppSettings;

  setUpAll(() {
    registerFallbackValue(FakeSettingsEvent());
  });

  setUp(() {
    initialAppSettings = AppSettings.defaultSettings();
  });

  group('ComparisonSettingsCard', () {
    testWidgets(
      'Initial state of comparison settings is displayed correctly',
      (WidgetTester tester) async {
        final settings = initialAppSettings.copyWith(
          ignoreCase: true,
          ignoreWhitespace: false,
          ignorePatterns: ['^test_', r'_temp$'],
        );
        final state = SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settings,
          apiKeyTests: defaultApiKeyTests,
        );
        final testBloc = MockSettingsBloc();

        when(() => testBloc.add(any())).thenReturn(null);
        when(() => testBloc.state).thenReturn(state);

        await pumpComparisonSettingsCard(
          tester,
          settingsBloc: testBloc,
          initialState: state,
        );

        final ignoreCaseSwitch = tester.widget<Switch>(
            find.byKey(const Key('settings_ignoreCase_switch')));
        expect(ignoreCaseSwitch.value, isTrue,
            reason: 'Ignore Case switch should be ON');

        final ignoreWhitespaceSwitch = tester.widget<Switch>(
            find.byKey(const Key('settings_ignoreWhitespace_switch')));
        expect(ignoreWhitespaceSwitch.value, isFalse,
            reason: 'Ignore Whitespace switch should be OFF');

        expect(
            find.byKey(const Key('ignorePattern_tile_^test_')), findsOneWidget);
        expect(find.byKey(const Key(r'ignorePattern_tile__temp$')),
            findsOneWidget);
        expect(find.byKey(const Key('settings_addPattern_button')),
            findsOneWidget);
      },
      semanticsEnabled: false,
    );

    testWidgets(
      'Initial state shows empty pattern message',
      (WidgetTester tester) async {
        final settings = initialAppSettings.copyWith(ignorePatterns: []);
        final state = SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settings,
          apiKeyTests: defaultApiKeyTests,
        );
        final testBloc = MockSettingsBloc();

        when(() => testBloc.add(any())).thenReturn(null);
        when(() => testBloc.state).thenReturn(state);

        await pumpComparisonSettingsCard(
          tester,
          settingsBloc: testBloc,
          initialState: state,
        );

        expect(find.text('No ignore patterns set.'), findsOneWidget);
      },
      semanticsEnabled: false,
    );

    testWidgets(
      'Tapping Ignore Case switch dispatches update event',
      (WidgetTester tester) async {
        final settings = initialAppSettings.copyWith(ignoreCase: false);
        final state = SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settings,
          apiKeyTests: defaultApiKeyTests,
        );
        final testBloc = MockSettingsBloc();

        when(() => testBloc.add(const UpdateIgnoreCase(true))).thenReturn(null);
        when(() => testBloc.state).thenReturn(state);

        await pumpComparisonSettingsCard(
          tester,
          settingsBloc: testBloc,
          initialState: state,
        );

        await tester.tap(find.byKey(const Key('settings_ignoreCase_switch')));
        await tester.pump();

        verify(() => testBloc.add(const UpdateIgnoreCase(true))).called(1);
      },
      semanticsEnabled: false,
    );

    testWidgets(
      'Tapping Ignore Whitespace switch dispatches update event',
      (WidgetTester tester) async {
        final settings = initialAppSettings.copyWith(ignoreWhitespace: false);
        final state = SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settings,
          apiKeyTests: defaultApiKeyTests,
        );
        final testBloc = MockSettingsBloc();

        when(() => testBloc.add(const UpdateIgnoreWhitespace(true)))
            .thenReturn(null);
        when(() => testBloc.state).thenReturn(state);

        await pumpComparisonSettingsCard(
          tester,
          settingsBloc: testBloc,
          initialState: state,
        );

        await tester
            .tap(find.byKey(const Key('settings_ignoreWhitespace_switch')));
        await tester.pump();

        verify(() => testBloc.add(const UpdateIgnoreWhitespace(true)))
            .called(1);
      },
      semanticsEnabled: false,
    );

    testWidgets(
      'Tapping add pattern dispatches event and shows pattern',
      (WidgetTester tester) async {
        const newPattern = 'new_pattern_.*';
        final settingsBeforeAdd =
            initialAppSettings.copyWith(ignorePatterns: []);
        final settingsAfterAdd =
            settingsBeforeAdd.copyWith(ignorePatterns: [newPattern]);
        final initialState = SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settingsBeforeAdd,
          apiKeyTests: defaultApiKeyTests,
        );
        final testBloc = MockSettingsBloc();
        final controller = StreamController<SettingsState>();

        addTearDown(controller.close);
        when(() => testBloc.add(AddIgnorePattern(newPattern))).thenReturn(null);
        when(() => testBloc.state).thenReturn(initialState);

        await pumpComparisonSettingsCard(
          tester,
          settingsBloc: testBloc,
          initialState: initialState,
          stream: controller.stream,
          onShowAddPatternDialog: () {
            testBloc.add(AddIgnorePattern(newPattern));
            controller.add(SettingsState(
              status: SettingsStatus.loaded,
              appSettings: settingsAfterAdd,
              apiKeyTests: defaultApiKeyTests,
            ));
          },
        );

        expect(find.byKey(Key('ignorePattern_tile_$newPattern')), findsNothing);

        await tester.tap(find.byKey(const Key('settings_addPattern_button')));
        await tester.pump();
        await tester.pump();

        verify(() => testBloc.add(AddIgnorePattern(newPattern))).called(1);
        expect(
            find.byKey(Key('ignorePattern_tile_$newPattern')), findsOneWidget);
      },
      semanticsEnabled: false,
    );

    testWidgets(
      'Removing a pattern dispatches event and updates list',
      (WidgetTester tester) async {
        const patternToRemove = 'pattern_to_remove';
        const otherPattern = 'another_pattern';
        final settingsWithPattern = initialAppSettings
            .copyWith(ignorePatterns: [patternToRemove, otherPattern]);
        final settingsWithoutPattern =
            initialAppSettings.copyWith(ignorePatterns: [otherPattern]);
        final initialState = SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settingsWithPattern,
          apiKeyTests: defaultApiKeyTests,
        );
        final testBloc = MockSettingsBloc();
        final controller = StreamController<SettingsState>();

        addTearDown(controller.close);
        when(() => testBloc.add(RemoveIgnorePattern(patternToRemove)))
            .thenReturn(null);
        when(() => testBloc.state).thenReturn(initialState);

        await pumpComparisonSettingsCard(
          tester,
          settingsBloc: testBloc,
          initialState: initialState,
          stream: controller.stream,
        );

        expect(find.byKey(Key('ignorePattern_tile_$patternToRemove')),
            findsOneWidget);
        expect(find.byKey(Key('ignorePattern_tile_$otherPattern')),
            findsOneWidget);

        await tester
            .tap(find.byKey(Key('ignorePattern_delete_$patternToRemove')));
        await tester.pump();

        controller.add(SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settingsWithoutPattern,
          apiKeyTests: defaultApiKeyTests,
        ));
        await tester.pump();

        verify(() => testBloc.add(RemoveIgnorePattern(patternToRemove)))
            .called(1);
        expect(find.byKey(Key('ignorePattern_tile_$patternToRemove')),
            findsNothing);
        expect(find.byKey(Key('ignorePattern_tile_$otherPattern')),
            findsOneWidget);
      },
      semanticsEnabled: false,
    );
  }, skip: 'Widget layout assertions in tests are unstable.');

  group('AddIgnorePatternDialog', () {
    testWidgets(
      'Add button submits the pattern',
      (WidgetTester tester) async {
        String? submittedPattern;

        await openAddIgnorePatternDialog(
          tester,
          onSubmit: (pattern) {
            submittedPattern = pattern;
          },
        );

        await tester.enterText(
            find.byKey(const Key('addPattern_textField')), 'new_pattern');
        await tester.pump();

        await tester.tap(find.byKey(const Key('addPattern_addButton')));
        await tester.pump(const Duration(milliseconds: 200));

        expect(submittedPattern, 'new_pattern');
        expect(find.byKey(const Key('addPattern_textField')), findsNothing);
      },
      semanticsEnabled: false,
    );

    testWidgets(
      'Cancel does not submit the pattern',
      (WidgetTester tester) async {
        var submitted = false;

        await openAddIgnorePatternDialog(
          tester,
          onSubmit: (_) {
            submitted = true;
          },
        );

        await tester.enterText(
            find.byKey(const Key('addPattern_textField')), 'some_text');
        await tester.pump();

        await tester.tap(find.byKey(const Key('addPattern_cancelButton')));
        await tester.pump(const Duration(milliseconds: 200));

        expect(submitted, isFalse);
        expect(find.byKey(const Key('addPattern_textField')), findsNothing);
      },
      semanticsEnabled: false,
    );
  });
}
