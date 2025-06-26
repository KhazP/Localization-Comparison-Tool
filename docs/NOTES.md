<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# NOTES.md

## Project Overview

**Product Name:** Localization Comparison Tool
**Core Purpose:** Rebuild the existing Python/Flet-based localization comparison tool using Flutter to address technical debt, enable feature expansion, and deliver a modern user experience for developers and translators managing multilingual projects.
**MVP Goal:** Achieve 3x faster file parsing performance compared to legacy implementation, implement comprehensive file format support including XLIFF, TMX, CSV, and industry-standard formats, and deliver modern UI with Git integration capabilities.
**Target Audience:** Localization Engineers, Translators/Localizers, and Open-Source Maintainers managing multilingual software projects.

## Technical Specifications

**Platform:** Windows desktop primary (MSIX packaging), with future Linux/macOS compatibility considerations
**Tech Stack (Frontend):** Flutter 3.19+, Window Manager, Native desktop integration
**Tech Stack (Backend/Core):** BLoC Pattern, Isolates for file processing, RxDart for reactive programming
**Key Libraries/APIs:** libgit2dart (Git operations), Google Translate API, Hive (local caching), ML Kit integration
**Architecture Overview:** Clean Architecture with layered separation - Presentation Layer (UI Components), Business Logic Layer (BLoC), Data Layer (File Format Parsers, Git Interface, Translation Services)
**Data Handling Notes:** Analytics opt-in (default disabled), user-provided API keys, local-only operations except for translation API calls, Hive-based caching with 7-day expiration
**Error Handling Approach:** Graceful handling with user-friendly messages, fallback mechanisms for network failures, chunked processing for large files

## Core MVP Features \& Implementation Plan

### Feature: Modern UI System

**Description:** Dark/light theme with system adaptation, Basic Tab (string display with color coding: green=added, red=removed), Advanced Tab (side-by-side comparison view), adaptive layout for desktop environments
**Key Acceptance Criteria:** Theme switching functionality, color-coded diff display, responsive desktop layout
**Technical Implementation Notes:** Flutter themes system, custom color schemes, tabbed navigation with state management via BLoC
**Agent Implementation Steps:**

1. Create `lib/presentation/themes/` directory with theme definitions
2. Implement `ThemeBloc` for theme state management
3. Create `BasicComparisonView` and `AdvancedComparisonView` widgets
4. Implement tabbed navigation in main app structure
5. Add color-coding logic for diff visualization

### Feature: Translation History \& Diff Tracking

**Description:** Session-based comparison history with detailed change logs, version delta visualization with color-coded modifications, export capabilities for documentation
**Key Acceptance Criteria:** Persistent history storage, visual diff representation, export functionality
**Technical Implementation Notes:** Hive database for local storage, diff algorithm implementation, export to common formats
**Agent Implementation Steps:**

1. Create `lib/data/models/comparison_history.dart` model
2. Implement `HistoryRepository` using Hive for persistence
3. Create `HistoryBloc` for state management
4. Implement diff algorithm in `lib/core/services/diff_service.dart`
5. Add export functionality to clipboard and file formats

### Feature: Real-Time Comparison Engine

**Description:** Asynchronous file processing with progress indicators, support for XLIFF, TMX, CSV, LANG, XML, JSON, YAML, Properties, RESX formats, directory-level recursive comparison
**Key Acceptance Criteria:** <2s response time for 10k-string files, support for 15+ file formats, progress tracking
**Technical Implementation Notes:** Isolate-based parallel processing, format-specific parsers, progress streaming
**Agent Implementation Steps:**

1. Create `lib/data/parsers/` directory with individual format parsers
2. Implement `FileParserFactory` for format detection and routing
3. Create `ComparisonEngine` using Isolates for parallel processing
4. Implement `ProgressBloc` for real-time progress tracking
5. Add recursive directory scanning functionality

### Feature: AI-Assisted Translation

**Description:** Integration with Google Translate API using user-provided keys, on-demand translation suggestions for missing strings, local caching of frequent translations
**Key Acceptance Criteria:** API key configuration, translation suggestions display, caching mechanism
**Technical Implementation Notes:** Google Translate API integration, Hive-based translation cache, API key secure storage
**Agent Implementation Steps:**

1. Create `lib/data/services/translation_service.dart` for API integration
2. Implement secure API key storage using Flutter Secure Storage
3. Create `TranslationBloc` for managing translation state
4. Add caching layer using Hive with expiration logic
5. Implement translation suggestion UI components

### Feature: Git Integration

**Description:** Basic branch comparison functionality, commit-based version snapshots for change tracking, repository-aware file detection
**Key Acceptance Criteria:** Branch selection interface, commit comparison, repository validation
**Technical Implementation Notes:** libgit2dart for Git operations, repository path validation, branch listing and comparison
**Agent Implementation Steps:**

1. Create `lib/data/services/git_service.dart` using libgit2dart
2. Implement `GitBloc` for repository state management
3. Add repository selection and validation UI
4. Create branch comparison functionality
5. Implement commit-based file version retrieval

## UI/UX Concept

**Design Approach:** Modern desktop-first interface with dark mode default, side-by-side comparison in advanced tab, color-coded string display (green=added, red=removed) in basic tab, adaptive layout optimized for 1080p+ displays, intuitive navigation with minimal learning curve.

## Out of Scope for MVP

- Mobile/Web browser support
- Collaborative editing features
- Advanced permission/user management systems
- Legacy Python code migration tools
- Cross-platform deployment (macOS/Linux delayed to future versions)


## Key Agent Instructions

**Agent: Please generate the MVP codebase based on the details above.**

**Prioritize implementing the features exactly as specified in the 'Core MVP Features' section in the following order:**

1. Modern UI System (foundation for all other features)
2. Real-Time Comparison Engine (core functionality)
3. Translation History \& Diff Tracking (user workflow support)
4. AI-Assisted Translation (value-added feature)
5. Git Integration (advanced functionality)

**Strictly adhere to the 'Technical Specifications' regarding platform, stack, and architecture:**

- Use Flutter 3.19+ with Clean Architecture principles
- Implement BLoC pattern for state management
- Use Isolates for file processing operations
- Follow the layered architecture approach (Presentation → Business Logic → Data)

**Directory Structure Requirements:**

```
lib/
├── presentation/          # UI components, themes, pages
├── business_logic/        # BLoC classes, state management
├── data/                 # Repositories, services, parsers
├── core/                 # Constants, utilities, base classes
└── main.dart             # Application entry point
```

**Refer to the PRD and Tech Design Doc content provided in this conversation for complete details if needed.**

**Create files and directory structures as logically required by the Tech Design Doc and implementation plan.**

**Add comprehensive comments to explain complex logic, especially for:**

- File parsing algorithms
- Diff calculation logic
- Git integration operations
- Translation caching mechanisms

**Ensure proper error handling throughout the application with user-friendly error messages as specified in the Technical Specifications.**

**Implement the application following Flutter best practices with:**

- Proper widget composition
- Efficient state management
- Performance optimization for large file handling
- Desktop-specific UI patterns and interactions

<div style="text-align: center">⁂</div>

[^1]: README.md

[^2]: https://community.openai.com/t/i-ve-built-an-mvp-for-a-product-matching-system-using-ai/1208365

[^3]: https://www.zartis.com/how-to-create-a-product-specification-document-for-mvp-development/

[^4]: https://sidsaladi.substack.com/p/new-feature-update-prds-on-product

[^5]: https://dev.to/freakynit/building-a-minimum-viable-product-mvp-1l58

[^6]: https://www.manageengine.com/academy/product-management-framework.html

[^7]: https://www.reforge.com/blog/evolving-product-requirement-documents

[^8]: https://productmanagementroadmap.com/prd-templates/

[^9]: https://www.reforge.com/blog/product-requirement-document-prd-templates

[^10]: https://www.figma.com/resource-library/product-development-process/

[^11]: https://ieeexplore.ieee.org/document/10740475/

[^12]: https://phrase.com/blog/posts/software-localization/

[^13]: https://americanchase.com/mvp-testing/

