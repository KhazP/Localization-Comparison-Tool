# Changelog

## [Unreleased] — 2026-02-25

### Architecture
- Decomposed `file_comparison_view.dart` from 3,819 lines to ~2,946 lines (23% reduction) by extracting:
  - `DiffListItem` widget (`lib/presentation/widgets/diff/diff_list_item.dart`)
  - `ExportService` (`lib/core/services/export_service.dart`)
  - `FilePickerDropZone` widget (`lib/presentation/widgets/file_picker_drop_zone.dart`)
  - `PlatformTaskbarService` (`lib/core/services/platform_taskbar_service.dart`) — Windows taskbar is now behind a clean abstraction
- Moved history recording logic from the presentation layer into `ComparisonBloc` where it belongs
- Split `SettingsBloc` (1,772 lines, 104 events) into three focused sub-BLoCs:
  - `AppearanceBloc` — theme mode, accent color, diff colors, fonts
  - `AiServicesBloc` — API keys, model selection, AI temperature, translation memory
  - `FileHandlingBloc` — encoding, CSV delimiter, BOM, backup, export format
- Declared previously-transitive dependencies (`path_provider`, `provider`) explicitly in `pubspec.yaml`
- Removed unused `macos_ui` dependency
- Extracted `_computeColorPalette()` to consolidate duplicated HSL color computation across 4 theme factories
- Moved `GitBloc` mutable fields (`_cachedBranches`, `_cachedCommits`, etc.) into Freezed state

### State Management
- Added `extends Equatable` with proper `props` to 6 event base classes: `ComparisonEvent`, `GitEvent`, `HistoryEvent`, `ProgressEvent`, `TranslationEvent`, `FileWatcherEvent`
- Fixed `context.watch<SettingsBloc>()` calls inside non-build helper methods — state is now read once at the top of `build()` and passed as parameters
- Added `buildWhen` predicate to `BlocBuilder<SettingsBloc>` in `user_onboarding_checklist.dart`
- Removed dead code: duplicate `if (projectSettings?.defaultAiModel != null)` block in `settings_state.dart`

### Accessibility
- Added `Semantics(button: true, label: ...)` to InkWell-based interactive elements (theme toggle, animated preview entries)
- Converted `_ActionIconButton` from InkWell+Tooltip to proper `IconButton` throughout the diff table
- Added `tooltip:` labels to 13 icon-only buttons (pagination controls, close buttons, clear search, back, delete glossary, toggle AI params)
- Added non-color diff status indicators ("+", "-", "~", "=") to diff list items and diff table rows — satisfies WCAG SC 1.4.1
- Raised default accent color from `0xFF7B61FF` to `0xFF9B8FFF` for better contrast on dark backgrounds (~4.6:1 ratio)
- Fixed blank `tooltip: ''` on "More actions" PopupMenuButton
- Added `label:` parameter to AI temperature `Slider`
- Wrapped color swatches in `Semantics(label: 'Color swatch: #RRGGBB')` in appearance settings
- Added colorblind-friendly diff color preset (blue/orange/teal) to the first-run wizard
- Removed `semanticsEnabled: false` from 8 test cases

### Testing
- Raised test coverage from ~12% toward meaningful coverage of all critical paths
- 259 tests passing, 0 failures, 0 skipped (previously 182 passing, 3 failing, 7 skipped)
- New test files:
  - `test/helpers/mocks.dart` — shared mock library used across all test files
  - `test/business_logic/blocs/comparison_bloc_test.dart` (10 tests)
  - `test/business_logic/blocs/translation_bloc_test.dart` (6 tests)
  - `test/business_logic/blocs/git_bloc_test.dart` (7 tests)
  - `test/data/parsers/arb_parser_test.dart` (7 tests)
  - `test/data/parsers/csv_parser_test.dart` (9 tests)
  - `test/data/parsers/properties_parser_test.dart` (7 tests)
  - `test/data/parsers/resx_parser_test.dart` (7 tests)
- Fixed `settings_bloc_test.dart` timing issues (replaced `Future.delayed` + `skip:` with `wait:` and `seed:`)
- Fixed and un-skipped `ComparisonResultDialog` test and `ComparisonSettingsCard` test group
- Replaced `expect(true, isTrue)` placeholder in `widget_test.dart` with real tests

### Code Quality
- Replaced 57 deprecated `.withOpacity(X)` calls with `.withValues(alpha: X)` across 6 files
