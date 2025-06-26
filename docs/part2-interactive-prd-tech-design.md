<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# Product Requirements Document (PRD) - MVP

**Localization Comparison Tool**

---

## 1. Introduction \& Goals

**Product Name:** Localization Comparison Tool

**Purpose:** Rebuild the existing Python/Flet-based localization comparison tool using Flutter to address technical debt, enable feature expansion, and deliver a modern user experience for developers and translators managing multilingual projects.

**MVP Goals:**

- Achieve 3x faster file parsing performance compared to legacy implementation
- Implement comprehensive file format support including XLIFF, TMX, CSV, and industry-standard formats[^1][^6][^7]
- Deliver modern UI with Git integration capabilities
- Establish sustainable architecture for future feature expansion

---

## 2. Target Audience

**Primary Users:**

- **Localization Engineers:** Technical professionals managing multilingual software projects requiring precise diff tracking
- **Translators/Localizers:** Translation professionals working with various file formats who need visual comparison tools
- **Open-Source Maintainers:** Solo developers handling localization across community-driven projects

---

## 3. User Stories

**Primary Journey:**
*"As a localization engineer, I need to compare translation files across CSV, LANG, XML, XLIFF, and other industry formats between development branches, so I can identify missing translations before release."*

**Supporting Story:**
*"As a translator, I want to see visual diffs with machine translation suggestions, so I can quickly fill gaps in localized content across multiple file formats."*

---

## 4. Features \& Requirements

### Core Features (Priority Order)

**1. Modern UI System**

- Dark/light theme with system adaptation
- **Basic Tab:** String display with color coding (green=added, red=removed)
- **Advanced Tab:** Side-by-side comparison view
- Adaptive layout for desktop environments

**2. Translation History \& Diff Tracking**

- Session-based comparison history with detailed change logs
- Version delta visualization with color-coded modifications
- Export capabilities for documentation purposes

**3. Real-Time Comparison Engine**

- Asynchronous file processing with progress indicators
- Support for comprehensive file formats: XLIFF, TMX, CSV, LANG, XML, JSON, YAML, Properties, RESX[^1][^6][^7]
- Directory-level recursive comparison capabilities

**4. AI-Assisted Translation**

- Integration with Google Translate API (user-provided keys)
- On-demand translation suggestions for missing strings
- Local caching of frequent translations for performance

**5. Git Integration**

- Basic branch comparison functionality
- Commit-based version snapshots for change tracking
- Repository-aware file detection and processing

---

## 5. Out of Scope for MVP

- Mobile/Web browser support
- Collaborative editing features
- Advanced permission/user management systems
- Legacy Python code migration tools
- Cross-platform deployment (macOS/Linux delayed to future versions)

---

## 6. Success Metrics

**Adoption Metrics:**

- ≥1 active monthly user maintaining consistent translation workflow
- ≥3 downloads per month indicating market validation

**Performance Benchmarks:**

- <2s response time for 10k-string files
- 100% functional parity with legacy comparison logic
- Zero data loss during file processing operations

---

# Technical Design Document - MVP

**Localization Comparison Tool**

---

## 1. System Overview

**Architecture:** Clean Architecture with separation of concerns using Flutter's recommended patterns

**Platform:** Windows desktop primary (MSIX packaging), with future Linux/macOS compatibility considerations

**Core Principle:** Maintainable, testable codebase addressing previous technical debt issues

---

## 2. Tech Stack

### Frontend Framework

```dart
Flutter 3.19+ • Desktop-optimized UI components
Window Manager • Native desktop integration
```


### State Management \& Core Logic

```dart
BLoC Pattern • Isolates for file processing
RxDart • Reactive programming support
```


### File Format Support

```dart
XLIFF Parser • TMX handling • CSV processing
XML/JSON/YAML • Properties files • RESX support
```


### External Integrations

```dart
libgit2dart • Git operations
Google Translate API • ML Kit integration
Hive • Local caching and storage
```


---

## 3. Architecture \& Data Flow

### Component Structure

```
┌─ Presentation Layer (UI Components)
│  ├─ Basic Comparison View
│  ├─ Advanced Side-by-Side View
│  └─ Settings & History Management
│
├─ Business Logic Layer (BLoC)
│  ├─ Comparison State Management
│  ├─ File Processing Coordination
│  └─ Git Integration Logic
│
└─ Data Layer
   ├─ File Format Parsers (15+ formats)
   ├─ Git Repository Interface
   └─ Translation API Services
```


### Data Flow Process

1. **Input Detection:** File system watcher monitors changes, format detector routes files
2. **Processing Pipeline:** Isolate pool handles parallel parsing, diff engine calculates changes
3. **State Updates:** BLoC pattern manages UI state transitions
4. **Output Rendering:** Results cached using Hive, UI updates reactively

---

## 4. Feature Implementation Details

### File Format Support Implementation[^1][^6][^7]

```dart
abstract class LocalizationParser {
  Future<Map<String, String>> parse(File file);
  List<String> getSupportedExtensions();
}

class XLIFFParser extends LocalizationParser {
  // Industry-standard XLIFF 2.0 support
}

class TMXParser extends LocalizationParser {
  // Translation Memory eXchange format
}
```


### Git Integration Architecture

```dart
Future<ComparisonResult> compareBranches(
  String repoPath, 
  String baseBranch, 
  String targetBranch
) async {
  final git = Git(Directory(repoPath));
  final diff = await git.diff(base: baseBranch, target: targetBranch);
  return _processGitDiff(diff);
}
```


### Error Handling Strategy[^4][^8][^10]

- **Network Failures:** "Translation service unavailable - using cached results"
- **File Format Errors:** "Unsupported format detected in [filename] - attempting generic parsing"
- **Git Repository Issues:** "Repository access denied - check permissions and try again"
- **Memory Constraints:** "Large file detected - processing in chunks for optimal performance"

---

## 5. UI/UX Implementation

### Basic Comparison View

- **Added Strings:** Green highlighting with + indicator
- **Removed Strings:** Red highlighting with - indicator
- **Modified Strings:** Yellow highlighting with edit indicator
- **Statistics Panel:** Count summaries and completion percentages


### Advanced Side-by-Side View

- **Split Panel Layout:** Source and target files in parallel columns
- **Synchronized Scrolling:** Coordinated navigation between panels
- **Inline Diff Highlighting:** Character-level change detection
- **Search \& Filter:** Real-time filtering by status or content

---

## 6. Data Handling \& Security

### Privacy Considerations

- **Analytics:** Opt-in telemetry with explicit user consent (default: disabled)
- **Translation Data:** User-provided API keys, no server-side storage of content
- **File Processing:** Local-only operations, no cloud data transmission except for translation API calls
- **Git Integration:** Read-only repository access, no modification capabilities


### Caching Strategy

```dart
class TranslationCache {
  static const Duration _cacheDuration = Duration(days: 7);
  
  Future<String?> getCachedTranslation(String source, String targetLang) {
    // Hive-based local storage with expiration
  }
}
```


---

## 7. Development Timeline

### Phase 1: Core Infrastructure (Weeks 1-3)

- Flutter project setup with clean architecture
- Basic file format parsers (CSV, JSON, XML)
- BLoC state management implementation
- Unit test framework establishment


### Phase 2: Comparison Engine (Weeks 4-6)

- Diff algorithm implementation
- UI component development (basic view)
- Translation history functionality
- Integration testing


### Phase 3: Advanced Features (Weeks 7-9)

- Git integration implementation
- AI translation service integration
- Advanced side-by-side UI
- Performance optimization


### Phase 4: Polish \& Deployment (Weeks 10-12)

- Error handling refinement
- MSIX packaging for Windows
- Documentation and user guides
- Beta testing and feedback integration

---

## 8. Risk Mitigation

### Technical Risks

| Risk | Probability | Impact | Mitigation |
| :-- | :-- | :-- | :-- |
| Flutter desktop plugin instability | Medium | High | Lock core dependencies, maintain fork readiness |
| Large file performance issues | High | Medium | Implement isolate-based processing early |
| Format parser complexity | Medium | Medium | Prototype with existing file samples |

### Performance Considerations

- **Memory Management:** Streaming parsers for large files (>50MB)
- **CPU Optimization:** Isolate pools for parallel processing
- **Storage Efficiency:** Compressed caching with intelligent cleanup

---

## 9. Testing Strategy

### Automated Testing

- **Unit Tests:** 80%+ coverage for core business logic
- **Integration Tests:** File format compatibility validation
- **Performance Tests:** Large file handling benchmarks
- **UI Tests:** Golden file testing for visual consistency


### Manual Testing Scenarios

- Multi-format file compatibility validation
- Git repository integration across different project structures
- Translation API error handling and fallback behavior
- UI responsiveness across different screen resolutions

---

**This technical design provides a robust foundation for the MVP while maintaining flexibility for future enhancements including cross-platform support and advanced collaboration features.**

<div style="text-align: center">⁂</div>

[^1]: README.md

[^2]: https://learn.microsoft.com/en-us/globalization/localization/localization-file-formats

[^3]: https://blog.wtigga.com/localization-files/

[^4]: https://localizely.com/blog/error-messages/

[^5]: https://itnext.io/resolving-network-related-errors-for-git-57922c0be63b

[^6]: https://poeditor.com/localization/files

[^7]: https://www.transifex.com/blog/2016/common-localization-file-formats

[^8]: https://fastercapital.com/content/Best-Practices-for-UI-Error-Handling.html

[^9]: https://wordslaboratory.com/blog/key-translation-file-formats-you-need-to-know/

[^10]: https://techcommunity.microsoft.com/discussions/appsonazure/best-practices-for-api-error-handling-a-comprehensive-guide/4088121

[^11]: https://www.semanticscholar.org/paper/7ea9f92d07efd2e32914286616e43de86af7dfd8

[^12]: https://www.semanticscholar.org/paper/edd093b4286daa1de9496cf3286dfe5ba811d710

[^13]: https://bmchealthservres.biomedcentral.com/articles/10.1186/s12913-022-08181-1

[^14]: https://www.semanticscholar.org/paper/20add4f6d3b93cc5206f4e4697c1809d785ffbb6

[^15]: https://www.blackkitetranslations.com/quote/file-formats.php

[^16]: https://lokalise.com

[^17]: https://ossisto.com/blog/software-localization-tools/

[^18]: https://docs.memoq.com/10-4/en/places/xliff-files.html

[^19]: https://www.cambridge.org/core/product/identifier/S0002731600062971/type/journal_article

[^20]: https://arxiv.org/pdf/2205.13945.pdf

[^21]: http://arxiv.org/pdf/2305.14611.pdf

[^22]: https://arxiv.org/html/2410.18967

[^23]: https://www.maxiomtech.com/ui-design-tools-comprehensive-comparison/

[^24]: https://www.kaarwan.com/blog/ui-ux-design/comparing-popular-ui-ux-design-tools-the-ultimate-guide?id=1406

[^25]: https://www.interaction-design.org/literature/article/10-great-sites-for-ui-design-patterns

[^26]: https://www.loginradius.com/blog/engineering/best-ui-ux-design-tools-2020/

[^27]: https://blog.logrocket.com/ux-design/filtering-ux-ui-design-patterns-best-practices/

[^28]: https://stackoverflow.com/questions/23784193/localization-tool-to-find-all-ui-strings

[^29]: http://ieeexplore.ieee.org/document/6827652/

[^30]: https://ieeexplore.ieee.org/document/8811953/

[^31]: https://dl.acm.org/doi/10.1145/3510003.3510071

[^32]: https://www.semanticscholar.org/paper/e81a0e50e2539e52bf26eaf144d417389f69720e

[^33]: https://stackoverflow.com/questions/30109787/internationalization-of-api-error-messages-on-front-end-or-back-end

[^34]: https://www.linkedin.com/posts/milan-jovanovic_what-are-the-best-practices-for-api-error-activity-7234084792818896897-4Uol

[^35]: https://stackoverflow.com/questions/50479561/how-to-fix-commit-to-git-failed-due-to-network

[^36]: https://link.springer.com/10.1007/978-3-031-59164-8_28

[^37]: https://dl.acm.org/doi/10.14778/3436905.3436913

[^38]: https://journals.aiac.org.au/index.php/IJCLTS/article/view/1648/1579

[^39]: http://www.jbe-platform.com/content/journals/10.1075/ts.3.05lew

[^40]: http://www.cttl.org/uploads/5/2/4/3/5243866/cttl20235.pdf

[^41]: https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-019-2982-3

[^42]: https://www.marstranslation.com/page/files-formats

[^43]: https://docs.weblate.org/en/latest/formats.html

[^44]: https://arxiv.org/pdf/2102.05216.pdf

[^45]: https://arxiv.org/abs/2212.03440

[^46]: https://arxiv.org/abs/2102.09039

[^47]: https://arxiv.org/pdf/2302.03739.pdf

[^48]: https://arxiv.org/html/2406.16177v1

[^49]: https://arxiv.org/html/2412.01268v1

[^50]: https://centus.com/blog/best-localization-platforms

[^51]: https://www.gridly.com/blog/game-ui-design-localization-best-practices/

[^52]: https://userpilot.com/blog/software-localization-tool/

[^53]: https://lingoport.com/blog/what-are-the-best-approaches-to-localize-ui-strings/

[^54]: https://discussions.unity.com/t/how-to-easily-localize-ui-strings-across-all-languages/913993

[^55]: https://xtm.cloud/blog/id-based-localization/

[^56]: https://www.youtube.com/watch?v=E-PR0d0Jb5A

[^57]: http://biorxiv.org/lookup/doi/10.1101/2022.11.24.517847

[^58]: https://amkcorp.in/index.php/books/essential-security-practices-for-fortifying-mobile-apps/

[^59]: https://ieeexplore.ieee.org/document/10048882/

[^60]: https://carijournals.org/journals/index.php/IJCE/article/view/2042

[^61]: https://ieeexplore.ieee.org/document/10211893/

[^62]: http://medrxiv.org/lookup/doi/10.1101/2025.04.15.25325584

[^63]: https://learn.microsoft.com/en-us/dotnet/standard/exceptions/best-practices-for-exceptions

[^64]: https://phrase.com/blog/posts/10-common-mistakes-in-software-localization/

[^65]: https://lokalise.com/blog/9-biggest-localization-issues-developers-face-and-how-to-solve-them/

