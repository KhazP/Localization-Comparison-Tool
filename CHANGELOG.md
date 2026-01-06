## [2.0.0] - 2026-01-07

### 🎨 Major UI/UX Overhaul

#### Advanced Diff View
- **Side-by-side diff viewer** with synchronized scrolling
- **Character-level diff highlighting** showing exact changes within lines
- **Filter badges** for Added/Removed/Modified with click-to-toggle
- **Minimap overview bar** for quick navigation in large diffs
- **Reviewed row visual feedback** — dimmed styling for reviewed entries

#### Git Comparison
- **Enhanced visual hierarchy** with branch/repo icons on selectors
- **Prominent file status indicators** with color-coded strips
- **Consistent styling** matching the Directory Comparison view

#### Settings & Polish
- **Collapsible sections** for dense settings areas
- **Contextual tooltips** explaining settings like Auto-Backup and Protocol Handler
- **Status indicators** showing last backup time and registration status
- **Section header icons** for faster scanning

#### Empty States
- **Rich empty states** for all comparison pages with helpful guidance
- **Recent comparisons** section on empty views
- **File type chips** showing supported formats
- **Gradient icon styling** with dynamic accent colors

#### History View
- **Distinct icons** for Git vs Directory comparisons
- **Relative timestamps** ("2 hours ago" format)
- **Enhanced metadata display** with repository names and branches

### 🖥️ Windows Integration

- **Updated branding** — "Localization Comparison Tool" by Alp Yalay
- **New app icon** — modern side-by-side comparison design
- **Windows metadata** — proper file properties and Task Manager display

### 🔧 Technical Improvements

- **Unified terminology** — consistent "Source/Target" naming throughout
- **Search bar repositioning** — moved to left sidebar for discoverability
- **Visual noise reduction** — subtle status bars instead of loud badges
- **Micro-interactions** — hover states and subtle animations

### 🐛 Bug Fixes

- Fixed history not displaying after Git/Directory comparisons
- Fixed Git history navigation from Recent section
- Fixed overflow issues in Advanced Diff grid columns
- Resolved comparison details modal scannability issues

---

## [1.0.0] - 2025-06-26

### 🚀 Initial Flutter Release

Complete rewrite from Python/Flet to Flutter for native desktop performance.

#### Core Features
- **10x performance improvement** over Python version
- **Native Windows compilation** with AOT
- **Material Design 3** interface
- **Light/Dark/AMOLED themes** with custom accent colors

#### Comparison Engine
- File comparison with Added/Removed/Modified detection
- Directory comparison with smart file matching
- Similarity analysis for modified strings
- Real-time search and filtering

#### File Format Support
- JSON, ARB, XML, XLIFF, TMX, CSV, YAML, Properties, RESX

#### Productivity Features
- Drag & drop file support
- Auto-reload file watching
- Comparison history with session tracking
- CSV export for documentation

#### Desktop Integration
- Single instance enforcement
- Window position/size persistence
- Custom title bar
- Mica/Acrylic effects (Windows 11)

---

[2.0.0]: https://github.com/KhazP/Localization-Comparison-Tool/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/KhazP/Localization-Comparison-Tool/releases/tag/v1.0.0
