# Localization Comparison Tool

A Flutter-based desktop application for comparing localization files, tracking changes, and assisting with the translation process.

## Features

*   **Modern UI System:** Light/dark themes, tabbed navigation for Basic, Advanced, History, Git, and Settings views. Mockups provided by user are guiding UI development.
*   **Real-Time Comparison Engine:** Supports various file formats (XLIFF, TMX, CSV, JSON, YAML, Properties, RESX, XML, TXT, DOCX) with diff highlighting in the Basic View. Utilizes Isolates for parsing. `.lang` files are parsed as plain text, where each line is treated as both a key and a value (similar to `.txt` files). `.txt` and `.docx` files are treated as list-of-phrases, where each line is a key.
*   **Translation History & Diff Tracking:** Stores past comparison sessions in Hive. A History View displays these sessions in a sortable and filterable table, with options to clear history (with confirmation) and reload a past comparison into the Basic view.
*   **Application Settings:** User-configurable settings (Default File Formats, Ignore Patterns, Ignore Case) are implemented with persistence in Hive. UI is available in the Settings tab.
*   **AI-Assisted Translation:** Integrated Gemini 3 Flash (via `google_generative_ai`) for intelligent translations, rephrasing, and suggestions.
*   **Git Integration (Stubbed):** Core BLoC and Service (libgit2dart stub) structures are in place.

## Database Schema

The application uses Hive for local data storage.

### `ComparisonSession` (Box: `comparison_history_box`)

| Field             | Type        | Hive Index | Description                                          |
| ----------------- | ----------- | ---------- | ---------------------------------------------------- |
| `id`              | `String`    | 0          | Unique identifier for the session (UUID v4).         |
| `timestamp`       | `DateTime`  | 1          | When the comparison was performed.                   |
| `file1Path`       | `String`    | 2          | Absolute path to the first file compared.            |
| `file2Path`       | `String`    | 3          | Absolute path to the second file compared.           |
| `stringsAdded`    | `int`       | 4          | Number of strings present in file 2 but not file 1.  |
| `stringsRemoved`  | `int`       | 5          | Number of strings present in file 1 but not file 2.  |
| `stringsModified` | `int`       | 6          | Number of strings with the same key but different values. |
| `stringsIdentical`| `int`       | 7          | Number of strings with the same key and value.       |

### `AppSettings` (Box: `app_settings_box`)

| Field                 | Type           | Hive Index | Description                                       |
| --------------------- | -------------- | ---------- | ------------------------------------------------- |
| `defaultSourceFormat` | `String`       | 0          | Default format for source localization files.     |
| `defaultTargetFormat` | `String`       | 1          | Default format for target localization files.     |
| `ignorePatterns`      | `List<String>` | 2          | List of regex patterns to ignore during comparison. |
| `ignoreCase`          | `bool`         | 3          | Whether to ignore case during comparison.         |
| `appLanguage`         | `String`       | 4          | Selected application language.                    |
| `defaultViewOnStartup`| `String`       | 5          | Which view to show when the app starts.         |
| `autoCheckForUpdates` | `bool`         | 6          | Whether to automatically check for updates.       |
| `appThemeMode`        | `String`       | 7          | Selected application theme (System, Light, Dark, Amoled). |
| `accentColorValue`    | `int`          | 8          | Integer value of the selected accent color.       |
| `ignoreWhitespace`    | `bool`         | 9          | Whether to ignore whitespace during comparison.   |
| `diffAddedColor`      | `int`          | 10         | Integer value of the diff "Added" color.          |
| `diffRemovedColor`    | `int`          | 11         | Integer value of the diff "Removed" color.        |
| `diffModifiedColor`   | `int`          | 12         | Integer value of the diff "Modified" color.       |
| `defaultSourceEncoding` | `String`     | 13         | Default encoding for source files (e.g., 'UTF-8'). |
| `defaultTargetEncoding` | `String`     | 14         | Default encoding for target files (e.g., 'UTF-8'). |
| `autoDetectEncoding`  | `bool`         | 15         | Whether to auto-detect file encoding.             |
| `csvDelimiter`        | `String`       | 16         | Delimiter used for parsing CSV files.             |
| `handleByteOrderMark` | `bool`         | 17         | Whether to handle Byte Order Mark (BOM).          |
| `autoReloadOnChange`  | `bool`         | 18         | Auto-reload files in view if they change on disk. |
| `defaultExportDirectory`| `String`     | 19         | Default directory for exporting comparison results. |

## Completed Milestones

- **Robust Theming System**:
  - Light/Dark/Amoled themes that react instantly to user changes.
  - Dynamic accent color applied throughout the application.
  - Diff colors ("Added," "Removed," "Modified") are user-configurable and reflected in all comparison views.
- **Advanced Settings UI**:
  - Modern two-panel layout for settings.
  - Fully functional controls for General, Comparison Engine, and Appearance settings.
  - All settings are persisted locally using Hive.
- **Enhanced Comparison Engine**:
  - Core diffing logic refactored into a separate, testable `DiffCalculator` class.
  - Test suite now directly validates the production diffing logic.
  - Fixed a critical bug where "removed" strings were not correctly identified.
  - Full support for `ignoreCase`, `ignoreWhitespace`, and `ignorePatterns` options.
- **Stable Core Infrastructure**:
  - Navigation, state management (BLoC), and persistence (Hive) are stable.
  - All major views (`Basic`, `Advanced`, `History`, `Settings`) correctly apply themes, including Amoled.
- **File Handling Settings**:
  - Implemented a new "File Handling" section in the settings view.
  - Users can configure default source/target encodings, auto-detection, and CSV parsing options.
  - File system settings like auto-reloading and default export directory are now available.
  - All file handling settings are persisted locally.
- **Full Integration of File Settings & Bug Fixes**:
  - Connected all "File Handling" settings (e.g., encoding, CSV delimiter) to the core comparison engine, making them fully functional.
  - Refactored the file parsing logic to correctly use the new settings.
  - Resolved a critical crash caused by passing a non-transferable `HiveObject` to a background isolate, making the comparison process more robust.
- **Flexible Directory Comparison**:
  - Implemented a "Files" tab to compare entire directories.
  - The system automatically detects identically named files in the source and target directories.
  - A robust manual pairing system allows users to match source and target files with different names via a simple dialog.
  - The UI clearly separates paired files from unmatched source and target files.
  - A "Compare" function runs a diff on all paired files and displays added, removed, and modified stats for each pair directly in the UI.
  - A "View" button opens a popup dialog showing a detailed list of added, removed, and modified keys for each specific file pair.

## Development Roadmap

### 🚧 Up Next
- **Settings View - Remaining Sections**:
  - Implement "AI Services" (API key management).
  - Implement "Version Control" settings.
  - Implement "About" page content.
  - Add "Reset to Default" functionality for all categories.

### 🌱 Future Goals
- **Advanced Directory Comparison View**: Integrate a powerful, side-by-side diff viewer for directory comparison results, similar to the existing "Advanced" view for single files.
- **Translation Cache**: Implement Hive persistence for `TranslationCache`.
- **AI Translation Service**: Full implementation of `GeminiTranslationService` with caching, streaming, and retry logic.
- **Git Integration**: Implement `LibGit2DartService` using `libgit2dart` for actual Git operations. Build UI for repository selection, branch listing, and displaying branch comparison results.
- **UI & UX Polish**:
  - Refine file previews and progress reporting.
  - Enhance error handling and result exporting.

---
*This document will be updated as the project progresses.*
