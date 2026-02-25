/// Shared mock library for all test files.
///
/// Import this file to get access to all mock classes used across the test suite.
/// Uses the `mocktail` package for mock generation.
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/translation_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/repositories/warning_suppressions_repository.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

// ── Repository Mocks ──────────────────────────────────────────────────────────
class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockHistoryRepository extends Mock implements HistoryRepository {}

class MockWarningSuppressionsRepository extends Mock
    implements WarningSuppressionsRepository {}

// ── Service Mocks ─────────────────────────────────────────────────────────────
class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockApiKeyValidationService extends Mock
    implements ApiKeyValidationService {}

class MockComparisonEngine extends Mock implements ComparisonEngine {}

class MockGitService extends Mock implements GitService {}

class MockTranslationService extends Mock implements TranslationService {}

class MockTranslationCache extends Mock implements TranslationCache {}

class MockTranslationMemoryService extends Mock
    implements TranslationMemoryService {}

// ── BLoC Mocks (for widget tests) ────────────────────────────────────────────
class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockComparisonBloc extends MockBloc<ComparisonEvent, ComparisonState>
    implements ComparisonBloc {}

class MockTranslationBloc extends MockBloc<TranslationEvent, TranslationState>
    implements TranslationBloc {}

class MockGitBloc extends MockBloc<GitEvent, GitState> implements GitBloc {}

class MockProjectBloc extends MockBloc<ProjectEvent, ProjectState>
    implements ProjectBloc {}

// ── Fake Values (for registerFallbackValue) ──────────────────────────────────
class FakeSettingsEvent extends Fake implements SettingsEvent {}

class FakeComparisonEvent extends Fake implements ComparisonEvent {}

class FakeProjectEvent extends Fake implements ProjectEvent {}

class FakeGitEvent extends Fake implements GitEvent {}

class FakeTranslationEvent extends Fake implements TranslationEvent {}
