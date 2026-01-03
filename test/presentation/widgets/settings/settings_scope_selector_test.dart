import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_scope.dart';
import 'package:localizer_app_main/data/models/project_settings.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_scope_selector.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

void main() {
  late MockSettingsBloc mockSettingsBloc;

  setUp(() {
    mockSettingsBloc = MockSettingsBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<SettingsBloc>.value(
          value: mockSettingsBloc,
          child: const SettingsScopeSelector(),
        ),
      ),
    );
  }

  group('SettingsScopeSelector Reset Button', () {
    testWidgets('Reset button is hidden when no project is loaded',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        SettingsState.initial().copyWith(
          projectSettings: null,
          scope: SettingsScope.global,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Reset Project to Global Defaults'), findsNothing);
      expect(find.byType(NoProjectScopePrompt), findsOneWidget);
      expect(
          find.text(
              'Create a project to customize settings for specific folders'),
          findsOneWidget);
    });

    testWidgets('Reset button is hidden when in global scope', (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        SettingsState.initial().copyWith(
          projectSettings:
              const ProjectSettings(systemTranslationContext: 'test'),
          scope: SettingsScope.global,
          currentProjectName: 'Test Project',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Reset Project to Global Defaults'), findsNothing);
    });

    testWidgets('Reset button is hidden when project has no overrides',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        SettingsState.initial().copyWith(
          projectSettings: const ProjectSettings(),
          scope: SettingsScope.project,
          currentProjectName: 'Test Project',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Reset Project to Global Defaults'), findsNothing);
    });

    testWidgets(
        'Reset button is visible when overrides exist and scope is project',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        SettingsState.initial().copyWith(
          projectSettings:
              const ProjectSettings(systemTranslationContext: 'override'),
          scope: SettingsScope.project,
          currentProjectName: 'Test Project',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Reset Project to Global Defaults'), findsOneWidget);
    });

    testWidgets('Clicking reset button shows confirmation dialog',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        SettingsState.initial().copyWith(
          projectSettings:
              const ProjectSettings(systemTranslationContext: 'override'),
          scope: SettingsScope.project,
          currentProjectName: 'Test Project',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Reset Project to Global Defaults'));
      await tester.pumpAndSettle();

      expect(find.text('Reset Project Settings?'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('Confirming dialog triggers ResetAllProjectSettings event',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        SettingsState.initial().copyWith(
          projectSettings:
              const ProjectSettings(systemTranslationContext: 'override'),
          scope: SettingsScope.project,
          currentProjectName: 'Test Project',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      // Open dialog
      await tester.tap(find.text('Reset Project to Global Defaults'));
      await tester.pumpAndSettle();

      // Click Reset in dialog
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      verify(() => mockSettingsBloc.add(const ResetAllProjectSettings()))
          .called(1);
    });

    testWidgets('Cancelling dialog does not trigger event', (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        SettingsState.initial().copyWith(
          projectSettings:
              const ProjectSettings(systemTranslationContext: 'override'),
          scope: SettingsScope.project,
          currentProjectName: 'Test Project',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      // Open dialog
      await tester.tap(find.text('Reset Project to Global Defaults'));
      await tester.pumpAndSettle();

      // Click Cancel in dialog
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => mockSettingsBloc.add(const ResetAllProjectSettings()));
    });
  });
}
