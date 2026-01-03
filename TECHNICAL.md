# Technical Decisions

## Product Scope
- Desktop Flutter app for localization file comparison and analysis.

## Platforms
- Windows is primary. macOS and Linux are supported targets.

## Stack
- Flutter 3.19+ with Dart 3.
- Material 3 UI.

## Architecture
- Keep the existing layered structure:
  - `lib/presentation` for UI.
  - `lib/business_logic/blocs` for BLoC state management.
  - `lib/data` for models and data access.
  - `lib/core/services` for shared services.
- Use BLoC via `flutter_bloc` for app state; keep UI-only state local.
- Use `get_it` as the service locator for dependency injection.

## Persistence
- Use Hive for local storage.
- Use `hive_generator` and `build_runner` for model code generation.

## File Handling
- `file_picker` for file dialogs.
- `desktop_drop` and `cross_file` for drag and drop.
- `watcher` for file system watching.
- `path` for extension handling.
- Desktop integrations via `window_manager`, `tray_manager`, and platform
  packages already in the repo.

## Parsing and Formats
- Use existing format packages: `yaml`, `xml`, `csv`, and `docx_to_text`.
- Keep parsers in the data layer with clear interfaces to add new formats.

## Diff and Comparison
- Use `string_similarity` for similarity scoring.
- Use `diff_match_patch` for character-level diffs.
- Keep diff logic in business logic, UI reads results only.

## Git Integration
- Use `libgit2dart` for Git features.
- Windows context menus and file associations use `win32_registry`.
- Fail gracefully when Git is unavailable.

## AI and Translation
- Use `http` for API calls.
- Store API keys with `flutter_secure_storage`.
- Keep provider-specific logic isolated. Do not send data without explicit
  user action and clear UI controls.

## Theming and Typography
- Accent color: #4ADE80.
- Typography: Open Sans via `google_fonts` (already in dependencies).
- Support light and dark themes with accessible contrast.

## Testing and Quality
- Use `flutter_test`, `bloc_test`, and `mocktail`.
- Prefer fakes and stubs over mocks.
- Run `flutter test`, `flutter analyze`, and formatting checks before release.

## Code Generation
- Use `build_runner` for generated code and keep outputs consistent.
- Use Freezed for immutable model and state classes where Hive annotations are
  not required.

## Logging and Errors
- Avoid `print`. Use structured logging (such as `dart:developer` log) or add
  `package:logging` if needed.
- Show friendly, non-technical error messages in the UI.

## Release Practices
- Use release builds for distribution.
- Ensure debug-only UI is off in release builds.
- Maintain development vs production separation for network features.
