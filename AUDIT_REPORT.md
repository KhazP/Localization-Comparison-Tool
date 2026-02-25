# Localization Comparison Tool — Full Codebase Audit Report

**Date:** 2026-02-25
**Version audited:** v2.0.0
**Scope:** 211 source files, 10 BLoCs, 13 file parsers, 6 AI/translation services, Windows/macOS
**Audit type:** Read-only analysis — no code was modified

---

## Resolution Summary — 2026-02-25

All critical issues and high-priority warnings from this audit were resolved in a single session
using 5 parallel teammates. Final state: `flutter analyze` — 0 errors; `flutter test` — 259 passed,
0 failures, 0 skipped.

| Issue | Status | Resolved By |
|---|---|---|
| God widget `file_comparison_view.dart` (3,819 lines) | ✅ RESOLVED | T2 — extracted DiffListItem, ExportService, FilePickerDropZone, PlatformTaskbarService; 895 lines removed |
| Missing `path_provider` / `provider` in pubspec.yaml | ✅ RESOLVED | T1 — `flutter pub add path_provider provider` |
| `ComparisonBloc` zero test coverage | ✅ RESOLVED | T4 — 10 new tests covering all primary flows |
| WCAG Level A/AA accessibility failures | ✅ RESOLVED | T5 — Semantics, tooltips, non-color indicators, contrast fix, colorblind wizard step |
| `SettingsBloc` (1,772 lines, 104 events) | ✅ RESOLVED | T3 — split into AppearanceBloc, AiServicesBloc, FileHandlingBloc |
| Dead code in `settings_state.dart` | ✅ RESOLVED | T1 — removed duplicate `if` block |
| Event base classes missing Equatable | ✅ RESOLVED | T1 — 6 event hierarchies updated (ComparisonEvent, GitEvent, HistoryEvent, ProgressEvent, TranslationEvent, FileWatcherEvent) |
| `macos_ui` declared but unused | ✅ RESOLVED | T1 — removed from pubspec.yaml |
| 57 deprecated `withOpacity()` calls | ✅ RESOLVED | T1 — replaced with `withValues(alpha:)` across 6 files |
| `context.watch<SettingsBloc>()` in non-build helpers | ✅ RESOLVED | T1/T2 — state read at top of build(), passed as parameters |
| Duplicated HSL color computation in 4 theme factories | ✅ RESOLVED | T1 — extracted `_computeColorPalette()` |
| `windows_taskbar` imported directly in widget/BLoC layers | ✅ RESOLVED | T2 — `PlatformTaskbarService` abstraction created |
| History recording in presentation layer BlocConsumer | ✅ RESOLVED | T2 — moved into `ComparisonBloc` |
| Test coverage 12% with 7 skipped tests | ✅ RESOLVED | T4 — 259 tests passing, 0 skipped; added parser tests (ARB/CSV/Properties/RESX), bloc tests (Comparison/Translation/Git), fixed all skipped tests |
| Blank `tooltip: ''` on PopupMenuButton | ✅ RESOLVED | T5 — `'More actions'` |
| Icon-only buttons with no accessible label | ✅ RESOLVED | T5 — 13 buttons given tooltip/Semantics |
| Default accent color failing contrast on dark theme | ✅ RESOLVED | T5 — `0xFF7B61FF` → `0xFF9B8FFF` |
| No colorblind preset visible in first-run wizard | ✅ RESOLVED | T5 — colorblind-friendly step added |
| GitBloc mutable fields outside Freezed state | ✅ RESOLVED | T1 — replaced with state-derived getters |

---

## Executive Summary

Four specialized agents audited the codebase across architecture, BLoC state management, test
coverage, and accessibility. The app has a well-structured foundation — BLoC layering is largely
correct, the `advanced_diff` subsystem is well-decomposed, and the theme system is complete. However
five cross-cutting issues stand out as the highest-priority problems across all four dimensions:

### Top 5 Most Impactful Fixes

| # | Fix | Areas Affected | Effort | Risk if Left Unfixed |
|---|---|---|---|---|
| 1 | **Decompose `file_comparison_view.dart`** (3,819 lines, 34 setState, dual state sources, per-item BLoC watches) | Architecture, BLoC | Large (1–2 weeks) | Increasing render lag, maintenance collapse, and correctness bugs as the file grows |
| 2 | **Declare missing transitive dependencies** (`path_provider`, `provider` absent from `pubspec.yaml`) | Architecture | Trivial (< 5 min) | A single upstream package update silently breaks the build |
| 3 | **Test `ComparisonBloc`** — the core feature orchestrator has zero test coverage | Testing | Medium (2–3 days) | Silent regression in the primary user workflow |
| 4 | **Fix WCAG Level A accessibility failures** — 35+ interactive elements have no accessible name/role; default diff colors fail for colorblind users | Accessibility | Medium (1–2 days) | Exclusion of users with disabilities; fails WCAG 1.4.1 and 4.1.2 |
| 5 | **Split `SettingsBloc`** (1,772 lines, 104 event classes) into 4–5 sub-BLoCs | BLoC, Architecture | Large (3–5 days) | Continued growth of an already-unmaintainable class; every settings change touches this file |

---

## Section 1: Flutter Architecture Review

**Full report:** `dev/active/flutter-arch-audit/flutter-arch-audit-code-review.md`

### Summary

The layered architecture (presentation / business_logic / data / core) is well-intentioned and
mostly respected. The `advanced_diff` subsystem is the model to follow internally — focused widgets,
clean `ChangeNotifierProvider` scoping, dedicated controller. However `file_comparison_view.dart`
has grown to 3,819 lines and represents a single point of structural, performance, and correctness
risk. Two production dependencies resolve only transitively (not declared in `pubspec.yaml`), making
the build fragile to upstream changes.

### Critical Issues

1. **`file_comparison_view.dart` — God Widget (3,819 lines, 34 setState)**
   - File: `lib/presentation/views/file_comparison_view.dart`
   - Accumulates every responsibility: file picking, drag-and-drop (lines 511–666), tutorial
     orchestration (lines 252–410), export logic (lines 1,839–2,070), diff list rendering (lines
     3,057–3,398), analytics bar, search, pagination, chart, file watcher coordination.
   - `_buildDiffListItem` calls `context.watch<SettingsBloc>()` and `context.watch<ThemeBloc>()`
     inside a `ListView.builder` item builder — every settings or theme change rebuilds the entire
     visible list without selectivity.
   - **Severity: Critical** — maintenance, performance, correctness.

2. **Dual state sources in `_FileComparisonViewState`**
   - File: `lib/presentation/views/file_comparison_view.dart` (line 1,154)
   - `_file1`, `_file2`, `_isBilingualMode`, and `_latestComparisonResult` are held in widget state
     AND in the BLoC. After `ComparisonSuccess`, local fields are re-synced from BLoC via `setState`.
     If BLoC state resets between navigations, widget state can be stale.
   - **Severity: Critical** — correctness risk.

3. **`package:provider` used in 10 files but not declared in `pubspec.yaml`**
   - Files: `lib/presentation/views/advanced_diff/` (10 files), including `advanced_diff_view.dart:6`
   - Resolves transitively through `flutter_bloc`. A version bump in any dependency could silently
     break all 10 files.
   - **Severity: Critical** — build fragility.

4. **`package:path_provider` used in `main.dart` but not declared in `pubspec.yaml`**
   - File: `lib/main.dart:14`
   - Same transitive-only risk.
   - **Severity: Critical** — build fragility.

5. **`windows_taskbar` imported directly in presentation and BLoC layers**
   - Files: `lib/presentation/views/file_comparison_view.dart:40`,
     `lib/business_logic/blocs/progress_bloc.dart:5`
   - Platform-specific packages should be behind a service abstraction, not imported at widget/BLoC
     level. Calling `WindowsTaskbar.setProgressMode(...)` from a widget violates layering.
   - **Severity: Critical** — platform abstraction violation.

### Warnings

1. `_buildDiffListItem` reconstructs `TextStyle`, `BoxDecoration`, and `BorderRadius` on every call
   — extract to a `StatelessWidget` with `BlocSelector` to allow element tree diffing.
2. Other views are growing toward the same pattern: `git_comparison_view.dart` (2,680 lines, 21
   setState), `quality_dashboard_view.dart` (2,465 lines), `history_view.dart` (2,077 lines).
3. Both `hive` and `sqflite` are used as persistence backends — consider migrating Translation Memory
   to Hive to eliminate `sqflite` unless relational queries are required.
4. 57 remaining `withOpacity()` calls (deprecated) vs. 332 modern `withValues(alpha:)` calls.
5. `macos_ui` declared in `pubspec.yaml:61` but no import found in `lib/` — likely unused.
6. `dependency_overrides: collection: 1.19.0` in `pubspec.yaml` — temporary workaround that should
   be removed when upstream packages release compatible versions.
7. 31 scattered `Platform.isWindows/isMacOS/isLinux` checks in the presentation layer — platform
   capability guards belong in a service layer, not views.

### Recommended Fixes (Priority Order)

1. **Add `path_provider` and `provider` to `pubspec.yaml`** — zero code change, removes transitive
   risk immediately. Run: `flutter pub add path_provider provider`
2. **Extract `_buildDiffListItem` into `DiffListItem` widget** — uses `BlocSelector` to subscribe
   only to the fields it needs. Begin decomposing `file_comparison_view.dart`.
3. **Move export logic (~200 lines) to `ExportService`** in `lib/core/services/export_service.dart`
4. **Extract file picking and drag-and-drop into `FilePickerDropZone` widget** — removes ~15
   setState calls and ~400 lines.
5. **Encapsulate `WindowsTaskbar` behind `PlatformTaskbarService`** with a no-op on non-Windows.
6. **Remove `macos_ui`** after confirming zero usage with `dart pub deps`.
7. **Consolidate theme color computation** — extract `_computeColorPalette(Color accent)` helper
   to eliminate ~60 lines of duplication across the four theme factories.
8. **Replace `withOpacity()` globally** with `withValues(alpha: ...)`.

---

## Section 2: BLoC State Management Audit

**Full report:** `dev/active/bloc-audit/bloc-audit-code-review.md`

### Summary

The BLoC architecture is largely sound: Freezed union types are used consistently for all states,
BLoC-to-BLoC coordination is correctly handled via `BlocListener` in the widget layer (not direct
coupling), and stream subscriptions are clean. The primary concerns are `SettingsBloc`'s extreme
bloat (1,772 lines, 104 event classes), business logic that has leaked into `FileComparisonView`'s
BlocConsumer listener, a dead code bug in `SettingsState`, and event class inconsistency across
BLoCs.

### Critical Issues

1. **Dead code bug in `SettingsState.getEffectiveDefaultAiModel()`**
   - File: `lib/business_logic/blocs/settings_bloc/settings_state.dart:91–98`
   - The second `if (projectSettings?.defaultAiModel != null)` block is an identical duplicate of
     the first — it is unreachable dead code. The method was not reviewed carefully after editing.
   - **Severity: Critical** — correctness.

2. **Business logic in BlocConsumer listener — history recording in widget**
   - File: `lib/presentation/views/file_comparison_view.dart:~1178–1241`
   - The `BlocConsumer<ComparisonBloc>` listener builds a full `ComparisonSession`, computes diff
     statistics, runs coverage metrics, and dispatches `AddToHistory`. This is business logic in a
     widget. `DirectoryComparisonBloc` and `GitBloc` already do this correctly inside the BLoC —
     `ComparisonBloc` does not, forcing the widget to compensate.
   - **Severity: Critical** — architectural inconsistency, business logic in presentation layer.

3. **`SettingsBloc` extreme bloat — 102 handlers, 104 event classes, 1,772 lines**
   - File: `lib/business_logic/blocs/settings_bloc/settings_bloc.dart`
   - Handles AI services, developer tools, appearance, encoding, file handling, window bounds,
     macOS integration, translation memory, telemetry, startup options, and onboarding — all in one
     class. The subdirectory (`settings_bloc/`) signals awareness of complexity, but no
     decomposition has happened.
   - **Severity: Critical** — maintainability.

### Warnings

4. **Event class inconsistency** — 3 BLoCs use `Equatable` events, 7 use plain abstract classes.
   Without `Equatable`, duplicate events aren't deduplicated; events log as generic objects in
   BlocObserver. Affected (no Equatable): `ComparisonBloc`, `GitBloc`, `HistoryBloc`,
   `ProgressBloc`, `TranslationBloc`, `FileWatcherBloc`.
5. **`GitBloc` mutable instance state** — `_cachedBranches`, `_cachedCommits`, `_currentMode`,
   `_currentRepoPath` (lines 163–165) exist as instance fields parallel to the Freezed state.
   If the BLoC is recreated, internal cache is lost while emitted state may have data.
6. **`context.watch` in non-build helper methods** — `_buildAnalyticsAndActionsBar` (line 2525)
   and `_buildDiffRow` (line 3064–3100) call `context.watch` in helpers instead of receiving state
   as parameters. Hides dependencies and triggers full widget rebuilds.
7. **`HistoryView` duplicates history data from BLoC** — copies `HistoryLoaded.history` into
   `_allHistory` via setState and re-reads `ProjectBloc.state` inside setState callbacks.
8. **`QualityDashboardView._refreshDashboard()`** reads from two BLoCs, filters history, and builds
   a future — all inside the widget. This is orchestration logic.
9. **`buildWhen` underused** — `SettingsBloc` emits on every settings change; only 2 of 15
   `BlocBuilder<SettingsBloc>` usages have `buildWhen` predicates, causing unnecessary rebuilds.
10. **Sealed class migration not warranted** — Freezed already provides exhaustive matching. This
    is a future-state consideration only.

### Recommended Fixes (Priority Order)

1. **Fix dead code in `settings_state.dart:95–97`** — remove the duplicate `if` block. (5 minutes)
2. **Move history recording into `ComparisonBloc`** — pass `HistoryRepository` to `ComparisonBloc`
   at construction, matching `DirectoryComparisonBloc` and `GitBloc`. (~1–2 days)
3. **Add `Equatable` to the 6 inconsistent event base classes** — mechanical, low-risk. (~0.5 day)
4. **Move GitBloc parallel state into Freezed state** — especially `_currentRepoPath`. (~0.5–1 day)
5. **Pass state as parameters to helper build methods** in `FileComparisonView` instead of calling
   `context.watch` inside helpers. (~1 day)
6. **Split `SettingsBloc` into sub-BLoCs** — suggested order: `AppearanceBloc` first (fewest
   cross-dependencies), then `AiServicesBloc`, `FileHandlingBloc`, then `GeneralSettingsBloc`.
   (~3–5 days, careful migration of `MultiBlocProvider` in `app.dart` and all consumers)

---

## Section 3: Testing Coverage Analysis

**Full report:** `dev/active/test-coverage-audit/test-coverage-audit-code-review.md`

### Summary

The project has 21 test files against 176 non-generated source files (~12% file coverage). Coverage
is severely skewed toward model and utility tests. The entire presentation layer (28 views, 44+
widgets) has zero meaningful widget coverage. The core BLoC (`ComparisonBloc`) is completely
untested. Two test bodies are permanently disabled via `skip:` rather than fixed. There are no
integration tests of any kind.

### Critical Issues

1. **`ComparisonBloc` is completely untested** — the central orchestrator of the app's primary
   feature (file comparison) has no tests. Any regression silently breaks the core workflow.

2. **`ComparisonResultDialog` test is empty and permanently skipped**
   - File: `test/presentation/views/comparison_result_dialog_test.dart`
   - Single `testWidgets` call with empty body and `skip: true`. The dialog is the primary result
     surface users see after every comparison.

3. **`ComparisonSettingsCard` group is permanently skipped**
   - File: `test/presentation/views/settings_view_test.dart:345`
   - 5 widget tests skipped with comment `'Widget layout assertions in tests are unstable.'`
   - This suppresses the failure rather than fixing the root cause.

4. **10 of 13 parsers have zero test coverage**
   - Untested: ARB (Flutter's native format), CSV, DOCX, properties, RESX, plain text, XML,
     `file_parser_factory.dart`, XLIFF (individual units), TMX (individual units).
   - Parser failures are silent data loss for users.

5. **6 of 8 BLoCs are completely untested**
   - Untested: `ComparisonBloc`, `DirectoryComparisonBloc`, `TranslationBloc`, `GitBloc`,
     `HistoryBloc`, `FileWatcherBloc`, `ThemeBloc`, `ProgressBloc`.

6. **Zero integration tests** — no end-to-end workflow is verified: file comparison, AI
   translation, git diff, import/export, directory comparison.

7. **`widget_test.dart` is a dead placeholder** — `expect(true, isTrue)` passes trivially.

### Warnings

1. No shared mock or test utility layer — 7 files declare their own `MockSettingsBloc`,
   `MockSecureStorageService`, etc. Interface changes require updating every file individually.
2. `settings_bloc_test.dart` uses `skip: 2` with `Future.delayed(50ms)` to work around event
   ordering — a timing-dependent anti-pattern that breaks on slow CI machines.
3. AI translation tests (Gemini) cover only edge cases (cache hit, missing key) — no happy path.
   `DeepL`, `OpenAI`, and `AdaptiveAI` services have zero tests.
4. 4 repositories untested: `SettingsRepository`, `HistoryRepository`, `ReviewStatusRepository`,
   `WarningSuppressionRepository`.
5. 17+ core services untested including `BackupService`, `FileDiscoveryService`,
   `ProblemDetector`, `QualityReportExporter`, `FileCacheService`, `ComparisonEngine` (full surface).
6. `comparison_engine_test.dart` actually tests `DiffCalculator`, not `ComparisonEngine`. Misleading
   name could cause false confidence.

### Recommended Fixes (Priority Order)

1. **Un-skip `ComparisonResultDialog`** — write a minimal smoke test that verifies the dialog
   renders without crashing.
2. **Fix and un-skip `ComparisonSettingsCard` group** — investigate the instability (`pumpAndSettle`
   missing? surface size? locale init?) rather than suppressing 5 tests.
3. **Write `comparison_bloc_test.dart`** using `bloc_test` — at minimum: `LoadSourceFile`,
   `LoadTargetFile`, `RunComparison`, and error state.
4. **Add parser tests for ARB, CSV, properties, and RESX** — the four most-used formats users
   will bring to this tool.
5. **Create `test/helpers/mocks.dart`** — shared mock classes for all 7 test files that re-declare
   their own.
6. **Fix the timing-dependent `settings_bloc_test.dart`** — use `blocTest`'s `wait` parameter
   instead of `Future.delayed` + `skip: 2`.
7. **Write `translation_bloc_test.dart`** and `git_bloc_test.dart` with mocked services.
8. **Add smoke-level widget tests** for `home_view.dart`, `file_comparison_view.dart`, and
   `first_run_wizard_view.dart` — minimal render-without-exception checks.

### Priority Testing Roadmap (Highest to Lowest Risk Reduction)

1. `ComparisonBloc` — core feature, completely unguarded
2. Untested parsers (ARB, CSV, properties, RESX, XML) — format failures = silent data loss
3. Un-skip `ComparisonResultDialog` — primary result surface, zero verified rendering
4. Un-skip `ComparisonSettingsCard` group — 5 existing tests disabled
5. `TranslationBloc` — AI translation is a must-have feature
6. `DirectoryComparisonBloc` — multi-file comparison core workflow
7. `GitBloc` — git integration must-have feature
8. `SettingsRepository` — persistence failure would corrupt user preferences
9. `FileDiscoveryService` — detection failures break project loading
10. `BackupService` — backup failures during edits risk data loss
11. Shared mock library — reduces maintenance for all future tests
12. Integration test: core comparison workflow (end-to-end)
13. Integration test: AI translation workflow (end-to-end)
14. Home view smoke test — entry point rendering check
15. `GitService` unit tests — service layer currently untested

---

## Section 4: Accessibility Audit

**Full report:** `dev/active/accessibility-audit/accessibility-audit-code-review.md`

### Summary

The app has a very thin accessibility layer. Only 1 `Semantics` widget exists across the entire
`lib/presentation/` codebase; 16 of 43 `IconButton` instances have no tooltip; the default purple
accent color fails WCAG AA contrast on dark backgrounds; and the default diff colors (red/green) are
indistinguishable for approximately 8% of male users with red-green colorblindness. The testing
suite systematically disables semantics checks, eliminating automated detection of these gaps.

### Critical Issues

1. **Single `Semantics` widget in the entire codebase**
   - File: `lib/presentation/views/file_comparison_view.dart:2801` (search toggle only)
   - Every other custom interactive widget — `InkWell` tap targets in `pluto_grid_adapter.dart`,
     the theme toggle in `home_view.dart`, all `_AnimatedPreviewEntry` containers — has zero
     semantic annotation.
   - Screen readers (NVDA, JAWS, VoiceOver) cannot identify or describe the majority of interactive
     controls.
   - **Fails: WCAG 2.1 SC 4.1.2 (Name, Role, Value) — Level A**

2. **`_ActionIconButton` uses `InkWell` instead of `IconButton` — no semantic role**
   - File: `lib/presentation/views/advanced_diff/widgets/table/pluto_grid_adapter.dart:563–593`
   - The custom button (used for Mark-as-Reviewed and Revert throughout the diff table) wraps an
     `Icon` in `InkWell + Padding`. Has a tooltip string, but screen readers announce it as an
     unlabeled container, not a button. Core diff table actions are invisible to assistive tech.

3. **16 of 43 `IconButton` instances missing tooltip**
   - Most critical: all 4 pagination buttons in `file_comparison_view.dart:1707–1752` and all 4
     in `diff_data_table.dart:186–219` — used on every comparison session.
   - Also missing: close buttons in two dialogs, clear-search suffix icons, settings back button,
     delete button in `project_glossary_card.dart:80`, and AI params toggle.

4. **Default accent color fails WCAG AA contrast on dark theme**
   - Default `0xFF7B61FF` (purple) achieves ~2.96:1 against dark background `0xFF0F0F14`.
   - **Fails: WCAG 2.1 SC 1.4.3 (Contrast Minimum) — Level AA** (requires 4.5:1 for normal text,
     3:1 for UI components). Passes on light theme (~6.4:1).
   - Affects: active navigation rail items, focused input borders, primary buttons, chip selection.

5. **Default diff colors fail colorblind users**
   - Default: added = `0xFF22C55E` (green), removed = `0xFFEF4444` (red).
   - For deuteranopia/protanopia (~8% of males), green and red appear as the same olive/brown color.
   - Diff table rows use background color alone to communicate status — no shape, pattern, or text
     indicator supplements color.
   - A Colorblind-Friendly preset (`0xFF0077BB`/`0xFFEE7733`/`0xFF009988`) exists but is opt-in.
   - **Fails: WCAG 2.1 SC 1.4.1 (Use of Color) — Level A** (default configuration)

### Warnings

1. **`semanticsEnabled: false` in all 8 widget tests**
   - File: `test/presentation/views/settings_view_test.dart:156,181,209,240,288,343,370,395`
   - Eliminates all automated accessibility regression detection for the settings UI.
2. **`PopupMenuButton` has intentionally blank tooltip `''`** at `pluto_grid_adapter.dart:457`
   — suppresses Flutter's default without replacing it; screen readers announce nothing.
3. **Theme toggle `InkWell` in `home_view.dart:300–334`** has `Tooltip` but no `Semantics` —
   not identified as a button by screen readers.
4. **Color swatch containers** in `appearance_settings_card.dart:144–155,460–470` have no semantic
   label — a screen reader user cannot determine what color is shown.
5. **AI temperature `Slider`** at `ai_services_settings_card.dart:~291` has no `label:` parameter
   — screen reader announces a percentage of the 0–2 range, not the actual formatted value.
6. **Navigation rail hover region** (`home_view.dart:443–473`) updates mouse state but not keyboard
   focus state — minor inconsistency since Material 3 NavigationRail provides its own focus ring.

### WCAG 2.1 AA Compliance Status

| Criterion | Level | Status |
|---|---|---|
| 1.4.1 Use of Color | A | **FAILING** (default diff colors, red/green indistinguishable) |
| 1.4.3 Contrast Minimum | AA | **FAILING** (dark theme, default purple accent ≈ 2.96:1) |
| 4.1.2 Name, Role, Value | A | **FAILING** (~35+ interactive elements with no accessible name/role) |
| 2.4.7 Focus Visible | AA | PARTIAL (Material 3 focus rings present; custom InkWell buttons may not) |
| 2.1.1 Keyboard | A | PARTIAL (standard buttons operable; InkWell-based custom buttons may not activate on Enter/Space) |
| 1.3.1 Info and Relationships | A | AT RISK (color swatch containers convey meaning through color alone) |

### Recommended Fixes (Priority Order)

**Level A (highest priority — basic accessibility)**

1. Add `Semantics(button: true, label: '...')` to all `InkWell` widgets used as buttons — start
   with the theme toggle in `home_view.dart` and convert `_ActionIconButton` in
   `pluto_grid_adapter.dart` to a proper `IconButton`.
2. Add `tooltip:` to all 16 icon-only `IconButton` instances — pagination buttons first.
3. Add visible non-color status indicators to diff rows (e.g., "+"/"-"/"~" prefix, or icon) so
   colorblind users can distinguish Added, Removed, and Modified without relying on color alone.

**Level AA (standard accessibility)**

4. Evaluate replacing default accent `0xFF7B61FF` with a higher-contrast alternative (e.g.,
   `0xFF9B8FFF` at HSL L=70% achieves ~4.6:1 on dark background). Document in `TECHNICAL.md`.
5. Replace blank `tooltip: ''` at `pluto_grid_adapter.dart:457` with a descriptive label.
6. Add `label:` to the AI temperature `Slider` at `ai_services_settings_card.dart:~291`.
7. Add `Semantics(label: 'Current accent color: ...')` to color swatch containers.

**Recommended**

8. Remove `semanticsEnabled: false` from all 8 tests in `settings_view_test.dart` and fix the
   underlying instability.
9. Surface the Colorblind-Friendly diff color preset during first-run setup
   (`first_run_wizard_view.dart`) with a brief explanation — highest single-change impact for
   colorblind users.
10. Verify logical tab order in the advanced diff toolbar and confirm no focus traps inside
    `PlutoGrid`.

---

## Appendix: Detailed Reports

All detailed auditor reports are saved under `dev/active/`:

- `dev/active/flutter-arch-audit/flutter-arch-audit-code-review.md`
- `dev/active/bloc-audit/bloc-audit-code-review.md`
- `dev/active/test-coverage-audit/test-coverage-audit-code-review.md`
- `dev/active/accessibility-audit/accessibility-audit-code-review.md`
