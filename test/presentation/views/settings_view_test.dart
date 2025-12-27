import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
// SettingsEvent should be exported by settings_bloc.dart
// import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_event.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/presentation/views/settings_view.dart';
import 'package:mocktail/mocktail.dart'; // mocktail for general mocking if needed elsewhere
import 'package:bloc_test/bloc_test.dart'; // bloc_test for MockBloc and whenListen

// Default API key tests map for SettingsState
Map<ApiProvider, ApiKeyTestResult> get defaultApiKeyTests => {
  ApiProvider.googleTranslate: const ApiKeyTestResult.idle(),
  ApiProvider.deepl: const ApiKeyTestResult.idle(),
  ApiProvider.gemini: const ApiKeyTestResult.idle(),
  ApiProvider.openAi: const ApiKeyTestResult.idle(),
};

// Mock SettingsBloc
class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {}

// Fake SettingsEvent for mocktail
// SettingsEvent itself is an abstract class, so we can extend it if it's exported by settings_bloc.dart
// Or, if there's a concrete base event class we can use, that would be even better.
// For now, assuming SettingsEvent is accessible via settings_bloc.dart
class FakeSettingsEvent extends Fake implements SettingsEvent {}

// Helper to find category navigation tile
Finder findSettingsCategoryTile(String title) {
  // Assuming the navigation rail uses InkWell -> Container -> Row -> Text for category names.
  return find.descendant(of: find.byType(InkWell), matching: find.text(title));
}

void main() {
  late MockSettingsBloc mockSettingsBloc;
  late AppSettings initialAppSettings;

  // Register fallback for SettingsEvent
  setUpAll(() {
    registerFallbackValue(FakeSettingsEvent());
  });

  setUp(() {
    mockSettingsBloc = MockSettingsBloc();
    initialAppSettings = AppSettings.defaultSettings();
    
    // Default stub for any add/remove event if not specifically overridden in a test
    // This should now work because FakeSettingsEvent is registered.
    when(() => mockSettingsBloc.add(any())).thenReturn(null);

    whenListen(
      mockSettingsBloc,
      Stream.fromIterable([SettingsState(status: SettingsStatus.loaded, appSettings: initialAppSettings, apiKeyTests: defaultApiKeyTests)]),
      initialState: SettingsState(status: SettingsStatus.loaded, appSettings: initialAppSettings, apiKeyTests: defaultApiKeyTests),
    );
  });

  // tearDown is not strictly necessary for MockBloc as it handles its own cleanup if any.
  // However, if other resources were allocated in setUp, they should be cleaned here.

  Future<void> pumpSettingsView(WidgetTester tester, {SettingsBloc? settingsBloc}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SettingsBloc>.value(
          value: settingsBloc ?? mockSettingsBloc,
          child: const SettingsView(),
        ),
      ),
    );
    await tester.pumpAndSettle(); // Ensure initial frame is settled
  }

  // Helper to navigate to a settings category
  Future<void> navigateToCategory(WidgetTester tester, String categoryNavLabel) async {
    final categoryFinder = findSettingsCategoryTile(categoryNavLabel);
    expect(categoryFinder, findsOneWidget, reason: 'Failed to find navigation tile for $categoryNavLabel');
    await tester.tap(categoryFinder);
    await tester.pumpAndSettle(); // Let the UI update to the new category
  }

  group('SettingsView - Comparison Engine Settings UI Tests', () {
    testWidgets('Initial state of Comparison Engine settings is displayed correctly', (WidgetTester tester) async {
      initialAppSettings = initialAppSettings.copyWith(
        ignoreCase: true,
        ignoreWhitespace: false,
        ignorePatterns: ['^test_', r'_temp$'],
      );

      final specificTestSettingsBloc = MockSettingsBloc();
      // No need for when(() => specificTestSettingsBloc.add(any())) here if covered by global setUp
      whenListen(
        specificTestSettingsBloc,
        Stream.fromIterable([SettingsState(status: SettingsStatus.loaded, appSettings: initialAppSettings, apiKeyTests: defaultApiKeyTests)]),
        initialState: SettingsState(status: SettingsStatus.loaded, appSettings: initialAppSettings, apiKeyTests: defaultApiKeyTests),
      );

      await pumpSettingsView(tester, settingsBloc: specificTestSettingsBloc);
      await navigateToCategory(tester, 'Comparison');

      final ignoreCaseSwitch = tester.widget<Switch>(find.byKey(const Key('settings_ignoreCase_switch')));
      expect(ignoreCaseSwitch.value, isTrue, reason: 'Ignore Case switch should be ON');

      final ignoreWhitespaceSwitch = tester.widget<Switch>(find.byKey(const Key('settings_ignoreWhitespace_switch')));
      expect(ignoreWhitespaceSwitch.value, isFalse, reason: 'Ignore Whitespace switch should be OFF');

      expect(find.byKey(const Key('ignorePattern_tile_^test_')), findsOneWidget);
      expect(find.byKey(const Key(r'ignorePattern_tile__temp$')), findsOneWidget);
      expect(find.byKey(const Key('settings_addPattern_button')), findsOneWidget);
    });

    testWidgets('Initial state shows "No ignore patterns set." when list is empty', (WidgetTester tester) async {
      initialAppSettings = initialAppSettings.copyWith(ignorePatterns: []);
      final specificTestSettingsBloc = MockSettingsBloc();
      // No need for when(() => specificTestSettingsBloc.add(any())) here
      whenListen(
        specificTestSettingsBloc,
        Stream.fromIterable([SettingsState(status: SettingsStatus.loaded, appSettings: initialAppSettings, apiKeyTests: defaultApiKeyTests)]),
        initialState: SettingsState(status: SettingsStatus.loaded, appSettings: initialAppSettings, apiKeyTests: defaultApiKeyTests),
      );
      await pumpSettingsView(tester, settingsBloc: specificTestSettingsBloc);
      await navigateToCategory(tester, 'Comparison');
      expect(find.text('No ignore patterns set.'), findsOneWidget);
    });

    testWidgets('Tapping Ignore Case switch calls UpdateIgnoreCase event', (WidgetTester tester) async {
      AppSettings currentSettings = AppSettings.defaultSettings().copyWith(ignoreCase: false);
      final testBloc = MockSettingsBloc();
      // Specific event stubbing is good
      when(() => testBloc.add(const UpdateIgnoreCase(true))).thenReturn(null);
      whenListen(
        testBloc,
        Stream.fromIterable([SettingsState(status: SettingsStatus.loaded, appSettings: currentSettings, apiKeyTests: defaultApiKeyTests)]),
        initialState: SettingsState(status: SettingsStatus.loaded, appSettings: currentSettings, apiKeyTests: defaultApiKeyTests),
      );
      
      await pumpSettingsView(tester, settingsBloc: testBloc);
      await navigateToCategory(tester, 'Comparison');
      
      await tester.tap(find.byKey(const Key('settings_ignoreCase_switch'))); 
      await tester.pumpAndSettle();

      verify(() => testBloc.add(const UpdateIgnoreCase(true))).called(1);
    });

    testWidgets('Tapping Ignore Whitespace switch calls UpdateIgnoreWhitespace event', (WidgetTester tester) async {
      AppSettings currentSettings = AppSettings.defaultSettings().copyWith(ignoreWhitespace: false);
      final testBloc = MockSettingsBloc();
      when(() => testBloc.add(const UpdateIgnoreWhitespace(true))).thenReturn(null);
      whenListen(
        testBloc,
        Stream.fromIterable([SettingsState(status: SettingsStatus.loaded, appSettings: currentSettings, apiKeyTests: defaultApiKeyTests)]),
        initialState: SettingsState(status: SettingsStatus.loaded, appSettings: currentSettings, apiKeyTests: defaultApiKeyTests),
      );

      await pumpSettingsView(tester, settingsBloc: testBloc);
      await navigateToCategory(tester, 'Comparison');
      
      await tester.tap(find.byKey(const Key('settings_ignoreWhitespace_switch'))); 
      await tester.pumpAndSettle();

      verify(() => testBloc.add(const UpdateIgnoreWhitespace(true))).called(1);
    });

    testWidgets('Adding an ignore pattern calls AddIgnorePattern event and pattern appears', (WidgetTester tester) async {
      const String newPattern = 'new_pattern_.*';
      AppSettings settingsBeforeAdd = AppSettings.defaultSettings().copyWith(ignorePatterns: []);
      AppSettings settingsAfterAdd = settingsBeforeAdd.copyWith(ignorePatterns: [newPattern]);
      final testBloc = MockSettingsBloc();
      final controller = StreamController<SettingsState>();

      when(() => testBloc.add(AddIgnorePattern(newPattern))).thenReturn(null); // Still useful to verify the event is added

      whenListen(
        testBloc,
        controller.stream,
        initialState: SettingsState(status: SettingsStatus.loaded, appSettings: settingsBeforeAdd, apiKeyTests: defaultApiKeyTests),
      );

      await pumpSettingsView(tester, settingsBloc: testBloc);
      await navigateToCategory(tester, 'Comparison');

      // Ensure it starts without the pattern
      expect(find.byKey(Key('ignorePattern_tile_$newPattern')), findsNothing); 

      await tester.ensureVisible(
        find.byKey(const Key('settings_addPattern_button')),
      );
      await tester.tap(find.byKey(const Key('settings_addPattern_button')));
      await tester.pumpAndSettle(); // Dialog opens

      await tester.enterText(find.byKey(const Key('addPattern_textField')), newPattern);
      await tester.pump();

      controller.add(
        SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settingsAfterAdd,
          apiKeyTests: defaultApiKeyTests,
        ),
      );

      await tester.tap(find.byKey(const Key('addPattern_addButton')));
      // Crucial: After adding, the BLoC should have emitted settingsAfterAdd, so we need to pump for the UI to catch up.
      // The whenListen stream will provide this new state upon the next bloc build trigger (which tap/event should cause).
      await tester.pumpAndSettle(); 

      verify(() => testBloc.add(AddIgnorePattern(newPattern))).called(1);
      expect(find.byKey(Key('ignorePattern_tile_$newPattern')), findsOneWidget);

      await controller.close();
    });

    testWidgets('Removing an ignore pattern calls RemoveIgnorePattern event and pattern disappears', (WidgetTester tester) async {
      const String patternToRemove = 'pattern_to_remove';
      const String otherPattern = 'another_pattern';
      AppSettings settingsWithPattern = AppSettings.defaultSettings().copyWith(ignorePatterns: [patternToRemove, otherPattern]);
      AppSettings settingsWithoutPattern = AppSettings.defaultSettings().copyWith(ignorePatterns: [otherPattern]);
      final testBloc = MockSettingsBloc();
      final controller = StreamController<SettingsState>();

      // Stub the event addition (optional but good for verification clarity)
      when(() => testBloc.add(RemoveIgnorePattern(patternToRemove))).thenReturn(null);

      whenListen(
        testBloc,
        controller.stream,
        initialState: SettingsState(status: SettingsStatus.loaded, appSettings: settingsWithPattern, apiKeyTests: defaultApiKeyTests), // Start with the pattern present
      );

      await pumpSettingsView(tester, settingsBloc: testBloc);
      await navigateToCategory(tester, 'Comparison');

      // Verify pattern is initially present
      expect(find.byKey(Key('ignorePattern_tile_$patternToRemove')), findsOneWidget);
      expect(find.byKey(Key('ignorePattern_tile_$otherPattern')), findsOneWidget);

      await tester.ensureVisible(
        find.byKey(Key('ignorePattern_delete_$patternToRemove')),
      );
      await tester.tap(find.byKey(Key('ignorePattern_delete_$patternToRemove')));
      // After tap, the BLoC should process RemoveIgnorePattern.
      // The whenListen stream will then emit settingsWithoutPattern.
      // pumpAndSettle allows the UI to rebuild with the new state.
      controller.add(
        SettingsState(
          status: SettingsStatus.loaded,
          appSettings: settingsWithoutPattern,
          apiKeyTests: defaultApiKeyTests,
        ),
      );
      await tester.pumpAndSettle(); 

      verify(() => testBloc.add(RemoveIgnorePattern(patternToRemove))).called(1);
      expect(find.byKey(Key('ignorePattern_tile_$patternToRemove')), findsNothing); // Should now be gone
      expect(find.byKey(Key('ignorePattern_tile_$otherPattern')), findsOneWidget); // Other pattern should remain

      await controller.close();
    });

    testWidgets('Cancelling add pattern dialog does not call AddIgnorePattern event', (WidgetTester tester) async {
      AppSettings currentSettings = AppSettings.defaultSettings().copyWith(ignorePatterns: []);
      final testBloc = MockSettingsBloc(); 
      // General when(() => testBloc.add(any())) from setUp should cover this
      whenListen(
        testBloc,
        Stream.fromIterable([SettingsState(status: SettingsStatus.loaded, appSettings: currentSettings, apiKeyTests: defaultApiKeyTests)]),
        initialState: SettingsState(status: SettingsStatus.loaded, appSettings: currentSettings, apiKeyTests: defaultApiKeyTests),
      );

      await pumpSettingsView(tester, settingsBloc: testBloc);
      await navigateToCategory(tester, 'Comparison');

      await tester.ensureVisible(
        find.byKey(const Key('settings_addPattern_button')),
      );
      await tester.tap(find.byKey(const Key('settings_addPattern_button')));
      await tester.pumpAndSettle(); // Dialog opens

      expect(find.byKey(const Key('addPattern_textField')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('addPattern_textField')), 'some_text');
      await tester.pump();

      await tester.tap(find.byKey(const Key('addPattern_cancelButton')));
      await tester.pumpAndSettle(); // Dialog closes

      verifyNever(() => testBloc.add(any(that: isA<AddIgnorePattern>())));
      expect(find.text('No ignore patterns set.'), findsOneWidget); // List should still be empty
    });

  });
} 
