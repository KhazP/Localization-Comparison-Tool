# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter-based desktop application called "Localization Comparison Tool" for comparing localization files, tracking changes, and assisting with translation processes. The app uses BLoC pattern for state management and Hive for local data persistence.

## Technology Stack

- **Framework**: Flutter (SDK >=3.0.0 <4.0.0)
- **State Management**: BLoC pattern with flutter_bloc
- **Local Database**: Hive with Flutter integration
- **Architecture**: Clean Architecture with separation of concerns

## Development Commands

### Basic Commands
```bash
# Run the application
flutter run

# Build the application
flutter build windows

# Run tests
flutter test

# Analyze code
flutter analyze

# Get dependencies
flutter pub get

# Clean build artifacts
flutter clean
```

### Code Generation
```bash
# Generate Hive type adapters and other code
flutter packages pub run build_runner build

# Watch for changes and regenerate
flutter packages pub run build_runner watch

# Clean generated files
flutter packages pub run build_runner clean
```

### Linting
The project uses `flutter_lints` package with standard Flutter linting rules defined in `analysis_options.yaml`.

## Architecture Overview

### Directory Structure
```
lib/
├── business_logic/blocs/     # BLoC state management
├── core/services/           # Core business services
├── data/                    # Data layer
│   ├── cache/              # Translation cache
│   ├── models/             # Hive models with generated adapters
│   ├── parsers/            # File format parsers
│   ├── repositories/       # Data repositories
│   └── services/           # External service integrations
├── presentation/           # UI layer
│   ├── themes/            # App theming
│   └── views/             # Screen widgets
└── main.dart              # App entry point
```

### Key Components

**BLoCs (Business Logic Components)**:
- `ComparisonBloc`: Handles file comparison operations
- `SettingsBloc`: Manages app settings with Hive persistence
- `HistoryBloc`: Manages comparison history
- `ThemeBloc`: Handles theme switching
- `ProgressBloc`: Reports progress during operations
- `TranslationBloc`: AI translation features (stubbed)
- `GitBloc`: Git integration features (stubbed)

**Parsers**: Support for multiple localization formats:
- XLIFF, TMX, CSV, JSON, YAML, Properties, RESX, XML
- Plain text (.txt) and DOCX files
- `.lang` files (treated as XML/Android strings.xml)

**Models**: Hive-based data models with type adapters:
- `ComparisonSession`: Stores comparison history
- `AppSettings`: User preferences and settings

### Data Persistence

**Hive Boxes**:
- `comparison_history_box`: Stores `ComparisonSession` objects
- `app_settings_box`: Stores `AppSettings` object

**Important**: The app temporarily deletes the settings box on startup to handle breaking changes in the AppSettings model. This is a temporary measure and should be replaced with proper migration in production.

### UI Architecture

The app uses a tabbed interface with:
- **Basic**: File comparison with diff highlighting
- **History**: Past comparison sessions
- **Files**: File management (placeholder)
- **Settings**: User preferences

Theme system supports Light/Dark/Amoled modes with dynamic accent colors.

## Development Guidelines

### Working with BLoCs
- Always inject required dependencies through constructors
- Use repository pattern for data access
- Follow the established event/state pattern

### Adding New File Parsers
1. Create parser class implementing `LocalizationParser`
2. Register in `FileParserFactory`
3. Add corresponding file extension handling

### Hive Model Updates
- Run `flutter packages pub run build_runner build` after model changes
- Consider migration strategy for breaking changes in production

### Performance Considerations
- Large datasets (1000+ keys) may cause performance issues in `AdvancedDiffView`
- Consider using Isolates for heavy processing
- DataTable virtualization may be needed for large result sets

## Common Issues

### File Picker Not Opening
Run `flutter clean && flutter pub get` if file picker fails to open.

### Hive Box Corruption
The app currently deletes the settings box on startup to handle model changes. Implement proper migration for production builds.

### Testing
- Use `bloc_test` for BLoC testing
- Use `mocktail` for mocking dependencies
- Test files should follow the same architecture patterns

## Features Status

**Implemented**:
- File comparison with multiple format support
- History tracking with Hive persistence
- Settings management
- Theme switching
- Basic UI components

**Stubbed/Partial**:
- AI Translation (Google Translate integration)
- Git integration (libgit2dart)
- Translation cache persistence