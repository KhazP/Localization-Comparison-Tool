# Settings UI/UX Improvement Plan

This document contains detailed improvement plans for each Settings page identified from screenshot analysis. Each section is self-contained for implementation.

---

## Table of Contents

1. [General Settings Improvements](#1-general-settings-improvements)
2. [Comparison Engine Enhancements](#2-comparison-engine-enhancements)
3. [Appearance Settings Polish](#3-appearance-settings-polish)
4. [File Handling Additions](#4-file-handling-additions)
5. [AI Services Improvements](#5-ai-services-improvements)
6. [Version Control Enhancements](#6-version-control-enhancements)
7. [About Page Enhancements](#7-about-page-enhancements)
8. [Cross-Cutting Improvements](#8-cross-cutting-improvements)

---

## 1. General Settings Improvements

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/settings_view.dart` → `_buildGeneralSettings`  
**Current State:** Language, Default View, Auto-Check Updates, Reset All Settings

### 1.1 Add More Language Options

**Problem:** Only 3 languages available (English, Spanish, French). Limited internationalization.

**Requirements:**
1. Add more commonly used languages (German, Italian, Portuguese, Turkish, Japanese, Chinese, Korean)
2. Add language auto-detection option
3. Show native language names (e.g., "Deutsch" instead of "German")

**Technical Implementation:**

```dart
final List<String> _appLanguages = [
  'Auto-Detect',
  'English (US)',
  'Español (ES)',
  'Français (FR)',
  'Deutsch (DE)',
  'Italiano (IT)',
  'Português (BR)',
  'Türkçe (TR)',
  '日本語 (JP)',
  '中文 (ZH)',
  '한국어 (KR)',
];
```

### 1.2 Add Startup Options

**Priority:** 🟢 LOW

**Requirements:**
1. "Check for updates on startup" toggle (already exists ✓)
2. Add "Start minimized to tray" toggle
3. Add "Open last project on startup" toggle
4. Add "Remember window size and position" toggle

**Technical Implementation:**

```dart
_buildSettingRow(
  context: context,
  label: 'Remember Window Position',
  description: 'Restore window size and position on startup',
  control: Switch(
    value: settings.rememberWindowPosition,
    onChanged: (val) => context.read<SettingsBloc>().add(UpdateRememberWindowPosition(val)),
  ),
  isDark: isDark,
),
_buildSettingRow(
  context: context,
  label: 'Open Last Project',
  description: 'Automatically load the last comparison on startup',
  control: Switch(
    value: settings.openLastProjectOnStartup,
    onChanged: (val) => context.read<SettingsBloc>().add(UpdateOpenLastProjectOnStartup(val)),
  ),
  isDark: isDark,
),
```

### 1.3 Add Keyboard Shortcuts Section

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Display list of keyboard shortcuts
2. Allow customization of key bindings
3. "Reset to defaults" option

**Technical Implementation:**

```dart
_buildSettingsCard(
  context: context,
  title: 'Keyboard Shortcuts',
  isDark: isDark,
  children: [
    _buildShortcutRow(context, 'Open File', 'Ctrl+O', isDark),
    _buildShortcutRow(context, 'Save', 'Ctrl+S', isDark),
    _buildShortcutRow(context, 'Compare', 'Ctrl+Shift+C', isDark),
    _buildShortcutRow(context, 'Export', 'Ctrl+E', isDark),
    _buildShortcutRow(context, 'Settings', 'Ctrl+,', isDark),
    Padding(
      padding: const EdgeInsets.all(16),
      child: OutlinedButton(
        onPressed: () => _showShortcutsDialog(context),
        child: const Text('Customize Shortcuts'),
      ),
    ),
  ],
),
```

---

## 2. Comparison Engine Enhancements

**Priority:** 🔴 HIGH  
**Location:** `lib/presentation/views/settings_view.dart` → `_buildComparisonSettings`  
**Current State:** Ignore Case, Ignore Whitespace, Ignore Patterns (regex)

### 2.1 Add Similarity Threshold Setting

**Problem:** No control over similarity threshold for detecting modified strings.

**Requirements:**
1. Slider for similarity threshold (0.5 to 1.0)
2. Preview showing how threshold affects detection
3. Default: 0.85 (85% similarity)

**Technical Implementation:**

```dart
_buildSettingRow(
  context: context,
  label: 'Similarity Threshold',
  description: 'Minimum similarity for "Modified" detection (${(settings.similarityThreshold * 100).round()}%)',
  control: SizedBox(
    width: 200,
    child: Slider(
      value: settings.similarityThreshold,
      min: 0.5,
      max: 1.0,
      divisions: 10,
      label: '${(settings.similarityThreshold * 100).round()}%',
      onChanged: (val) => context.read<SettingsBloc>().add(UpdateSimilarityThreshold(val)),
    ),
  ),
  isDark: isDark,
),
```

### 2.2 Add Comparison Mode Selection

**Priority:** 🔴 HIGH

**Requirements:**
1. "Key-based" mode (current default) - matches by key name
2. "Order-based" mode - matches by position in file
3. "Smart" mode - attempts to match moved keys

**Technical Implementation:**

```dart
final List<String> _comparisonModes = ['Key-based', 'Order-based', 'Smart Match'];

_buildSettingRow(
  context: context,
  label: 'Comparison Mode',
  description: 'How to match entries between files',
  control: _buildDropdown(context, settings.comparisonMode, _comparisonModes, (val) {
    if (val != null) context.read<SettingsBloc>().add(UpdateComparisonMode(val));
  }, isDark),
  isDark: isDark,
),
```

### 2.3 Add Pattern Presets

**Priority:** 🟡 MEDIUM

**Problem:** Users must manually enter regex patterns. No common presets available.

**Requirements:**
1. Add preset buttons for common patterns:
   - "Comments" → `^//.*`, `^#.*`
   - "Temp Keys" → `^temp_.*`, `^test_.*`
   - "Placeholders" → `^TODO_.*`, `^PLACEHOLDER_.*`
2. Quick add common patterns with one click

**Technical Implementation:**

```dart
Widget _buildPatternPresets(BuildContext context) {
  final presets = {
    'Comments': ['^//.*', '^#.*'],
    'Temp Keys': ['^temp_.*', '^test_.*'],
    'Placeholders': ['^TODO_.*', '^PLACEHOLDER.*'],
    'Dev Only': ['^DEBUG_.*', '^DEV_.*'],
  };
  
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: presets.entries.map((entry) => 
      OutlinedButton.icon(
        icon: const Icon(Icons.add, size: 16),
        label: Text(entry.key),
        onPressed: () {
          for (final pattern in entry.value) {
            context.read<SettingsBloc>().add(AddIgnorePattern(pattern));
          }
        },
      ),
    ).toList(),
  );
}
```

### 2.4 Pattern Validation & Testing

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Validate regex patterns before adding
2. Show error message for invalid patterns
3. Add "Test Pattern" button with sample input

**Technical Implementation:**

```dart
void _showAddPatternDialog(BuildContext context, bool isDark) {
  String? errorMessage;
  
  showDialog(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Add Ignore Pattern'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _newPatternController,
              decoration: InputDecoration(
                hintText: 'e.g., ^temp_.*',
                labelText: 'Pattern (regex)',
                errorText: errorMessage,
              ),
              onChanged: (value) {
                try {
                  RegExp(value);
                  setState(() => errorMessage = null);
                } catch (e) {
                  setState(() => errorMessage = 'Invalid regex pattern');
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Test String',
                hintText: 'Enter a key to test against pattern',
              ),
              onChanged: (testStr) {
                // Show match result
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(
            onPressed: errorMessage == null ? () => _submitPattern() : null,
            child: const Text('Add'),
          ),
        ],
      ),
    ),
  );
}
```

---

## 3. Appearance Settings Polish

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/settings_view.dart` → `_buildAppearanceSettings`  
**Current State:** Theme, Font Size, Accent Color, Diff Colors with Presets, Live Preview

### 3.1 Add More Theme Presets

**Priority:** 🟢 LOW

**Requirements:**
1. Add "Nord" theme preset (popular among developers)
2. Add "Solarized" theme preset
3. Add "Monokai" theme preset
4. Show color swatches in preset buttons

**Technical Implementation:**

```dart
final Map<String, _ThemePreset> _themePresets = {
  'Default': const _ThemePreset(
    added: Color(0xFF4CAF50),
    removed: Color(0xFFF44336),
    modified: Color(0xFFFFC107),
  ),
  'Colorblind-Friendly': const _ThemePreset(
    added: Color(0xFF0077BB),
    removed: Color(0xFFEE7733),
    modified: Color(0xFF009988),
  ),
  'High Contrast': const _ThemePreset(
    added: Colors.greenAccent,
    removed: Colors.redAccent,
    modified: Colors.yellowAccent,
  ),
  'Nord': const _ThemePreset(
    added: Color(0xFFA3BE8C),  // Nord green
    removed: Color(0xFFBF616A), // Nord red
    modified: Color(0xFFEBCB8B), // Nord yellow
  ),
  'Solarized': const _ThemePreset(
    added: Color(0xFF859900),  // Solarized green
    removed: Color(0xFFDC322F), // Solarized red
    modified: Color(0xFFB58900), // Solarized yellow
  ),
};
```

### 3.2 Add Line Height Control

**Priority:** 🟢 LOW

**Requirements:**
1. Slider for line height (1.0 to 2.0)
2. Preview updates in real-time
3. Default: 1.5

**Technical Implementation:**

```dart
_buildSettingRow(
  context: context,
  label: 'Line Height',
  description: 'Adjust spacing between lines',
  control: SizedBox(
    width: 200,
    child: Slider(
      value: settings.lineHeight,
      min: 1.0,
      max: 2.0,
      divisions: 10,
      label: '${settings.lineHeight.toStringAsFixed(1)}',
      onChanged: (value) => context.read<SettingsBloc>().add(UpdateLineHeight(value)),
    ),
  ),
  isDark: isDark,
),
```

### 3.3 Add Font Family Selection

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Dropdown to select font family for diff view
2. Options: System Default, JetBrains Mono, Fira Code, Source Code Pro, Cascadia Code
3. Preview in live preview panel

**Technical Implementation:**

```dart
final List<String> _fontFamilies = [
  'System Default',
  'JetBrains Mono',
  'Fira Code',
  'Source Code Pro',
  'Cascadia Code',
  'Roboto Mono',
];

_buildSettingRow(
  context: context,
  label: 'Diff Font Family',
  description: 'Font for comparison view',
  control: _buildDropdown(context, settings.diffFontFamily, _fontFamilies, (val) {
    if (val != null) context.read<SettingsBloc>().add(UpdateDiffFontFamily(val));
  }, isDark),
  isDark: isDark,
),
```

### 3.4 Add "Identical" Entry Color

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Add color picker for "Identical" entries
2. Allow customizing opacity of identical entries
3. Default: subtle gray

**Technical Implementation:**

```dart
_buildColorRow(
  context,
  'Identical',
  Color(settings.identicalColorValue),
  (color) => context.read<SettingsBloc>().add(UpdateIdenticalColor(color.toARGB32())),
  isDark,
),
```

---

## 4. File Handling Additions

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/settings_view.dart` → `_buildFileHandlingSettings`  
**Current State:** Source/Target Format, Source/Target Encoding, Auto-Detect

### 4.1 Add Default Export Settings

**Priority:** 🔴 HIGH

**Requirements:**
1. Default export format (CSV, JSON, Excel)
2. Default export directory
3. Include UTF-8 BOM toggle for CSV exports
4. Auto-open folder after export toggle

**Technical Implementation:**

```dart
_buildSettingsCard(
  context: context,
  title: 'Export Settings',
  isDark: isDark,
  children: [
    _buildSettingRow(
      context: context,
      label: 'Default Export Format',
      control: _buildDropdown(context, settings.defaultExportFormat, ['CSV', 'JSON', 'Excel'], (val) {
        if (val != null) context.read<SettingsBloc>().add(UpdateDefaultExportFormat(val));
      }, isDark),
      isDark: isDark,
    ),
    _buildSettingRow(
      context: context,
      label: 'Include UTF-8 BOM',
      description: 'Required for Excel compatibility',
      control: Switch(
        value: settings.includeUtf8Bom,
        onChanged: (val) => context.read<SettingsBloc>().add(UpdateIncludeUtf8Bom(val)),
      ),
      isDark: isDark,
    ),
    _buildSettingRow(
      context: context,
      label: 'Open Folder After Export',
      control: Switch(
        value: settings.openFolderAfterExport,
        onChanged: (val) => context.read<SettingsBloc>().add(UpdateOpenFolderAfterExport(val)),
      ),
      isDark: isDark,
    ),
  ],
),
```

### 4.2 Add Backup Settings

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Auto-backup before overwriting files toggle
2. Backup directory path
3. Number of backups to keep

**Technical Implementation:**

```dart
_buildSettingsCard(
  context: context,
  title: 'Backup',
  isDark: isDark,
  children: [
    _buildSettingRow(
      context: context,
      label: 'Auto-Backup',
      description: 'Create backup before overwriting files',
      control: Switch(
        value: settings.autoBackup,
        onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoBackup(val)),
      ),
      isDark: isDark,
    ),
    _buildSettingRow(
      context: context,
      label: 'Backups to Keep',
      description: 'Number of backup copies to retain',
      control: SizedBox(
        width: 100,
        child: Slider(
          value: settings.backupsToKeep.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: settings.backupsToKeep.toString(),
          onChanged: (val) => context.read<SettingsBloc>().add(UpdateBackupsToKeep(val.round())),
        ),
      ),
      isDark: isDark,
    ),
  ],
),
```

### 4.3 Add File Association Settings

**Priority:** 🟢 LOW

**Requirements:**
1. Register as handler for .lang, .json, .xml files
2. Add to right-click context menu (Windows)
3. Show current registration status

---

## 5. AI Services Improvements

**Priority:** 🔴 HIGH  
**Location:** `lib/presentation/views/settings_view.dart` → `_buildAiServicesSettings`  
**Current State:** LLM Models, API Keys, Translation Context, Confidence Threshold

### 5.1 Add API Key Validation

**Priority:** 🔴 HIGH

**Requirements:**
1. "Test Connection" button for each API key
2. Show success/error status after testing
3. Display API usage/quota if available

**Technical Implementation:**

```dart
Widget _buildApiKeyRowWithTest(
  BuildContext context,
  String label,
  String value,
  ValueChanged<String> onChanged,
  VoidCallback onTest,
  bool isDark,
) {
  return Column(
    children: [
      _buildSettingRow(
        context: context,
        label: label,
        control: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: TextEditingController(text: value),
                obscureText: true,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Enter API key',
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: value.isNotEmpty ? onTest : null,
              child: const Text('Test'),
            ),
          ],
        ),
        isDark: isDark,
      ),
    ],
  );
}
```

### 5.2 Add Model-Specific Settings

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Temperature slider (0.0 - 1.0)
2. Max tokens setting
3. Custom system prompt per model

**Technical Implementation:**

```dart
_buildSettingsCard(
  context: context,
  title: 'Model Parameters',
  isDark: isDark,
  children: [
    _buildSettingRow(
      context: context,
      label: 'Temperature',
      description: 'Creativity vs consistency (${settings.aiTemperature.toStringAsFixed(1)})',
      control: SizedBox(
        width: 150,
        child: Slider(
          value: settings.aiTemperature,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          onChanged: (val) => context.read<SettingsBloc>().add(UpdateAiTemperature(val)),
        ),
      ),
      isDark: isDark,
    ),
    _buildSettingRow(
      context: context,
      label: 'Max Tokens',
      description: 'Maximum response length',
      control: _buildDropdown(context, settings.maxTokens.toString(), 
        ['256', '512', '1024', '2048', '4096'], (val) {
        if (val != null) context.read<SettingsBloc>().add(UpdateMaxTokens(int.parse(val)));
      }, isDark),
      isDark: isDark,
    ),
  ],
),
```

### 5.3 Add Translation Memory

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Enable/disable translation memory
2. Clear translation memory button
3. Show memory size/entry count
4. Import/export translation memory

---

## 6. Version Control Enhancements

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/settings_view.dart` → `_buildVersionControlSettings`  
**Current State:** Enable Git, Auto-Commit, Git User (Name, Email)

### 6.1 Add Default Branch Setting

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Default branch name input (main/master/develop)
2. Default remote name (origin)

**Technical Implementation:**

```dart
_buildSettingRow(
  context: context,
  label: 'Default Branch',
  description: 'Branch to use for new comparisons',
  control: SizedBox(
    width: 150,
    child: TextField(
      controller: TextEditingController(text: settings.defaultBranch),
      onChanged: (val) => context.read<SettingsBloc>().add(UpdateDefaultBranch(val)),
      decoration: const InputDecoration(
        hintText: 'main',
        isDense: true,
      ),
    ),
  ),
  isDark: isDark,
),
```

### 6.2 Add Commit Message Templates

**Priority:** 🟢 LOW

**Requirements:**
1. Default commit message template
2. Variables support: `{date}`, `{files}`, `{changes}`
3. Presets for common formats

**Technical Implementation:**

```dart
_buildSettingsCard(
  context: context,
  title: 'Commit Templates',
  isDark: isDark,
  children: [
    Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        maxLines: 2,
        controller: TextEditingController(text: settings.commitMessageTemplate),
        onChanged: (val) => context.read<SettingsBloc>().add(UpdateCommitMessageTemplate(val)),
        decoration: InputDecoration(
          labelText: 'Commit Message Template',
          hintText: 'Update localization: {files}',
          helperText: 'Variables: {date}, {files}, {added}, {removed}, {modified}',
        ),
      ),
    ),
  ],
),
```

### 6.3 Add SSH Key Configuration

**Priority:** 🟢 LOW

**Requirements:**
1. SSH key path configuration
2. Generate SSH key button
3. Copy public key to clipboard

---

## 7. About Page Enhancements

**Priority:** 🟢 LOW  
**Location:** `lib/presentation/views/settings_view.dart` → `_buildAboutSettings`  
**Current State:** Version, Build, Platform, GitHub links, Licenses

### 7.1 Add Update Information

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Show current version vs latest version
2. "Check for Updates Now" button
3. Changelog viewer
4. Auto-download update toggle

### 7.2 Add System Information

**Priority:** 🟢 LOW

**Requirements:**
1. Show Flutter version
2. Show Dart version
3. Show available disk space
4. Show memory usage

### 7.3 Add Telemetry Settings

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Anonymous usage statistics toggle
2. Crash reporting toggle
3. Privacy policy link

---

## 8. Cross-Cutting Improvements

### 8.1 Settings Search

**Priority:** 🔴 HIGH

**Requirements:**
1. Add search field at top of settings navigation
2. Highlight matching settings
3. Jump to setting on selection

**Technical Implementation:**

```dart
TextField(
  decoration: InputDecoration(
    hintText: 'Search settings...',
    prefixIcon: const Icon(Icons.search, size: 20),
    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  ),
  onChanged: (query) => setState(() => _searchQuery = query),
),
```

### 8.2 Import/Export Settings

**Priority:** 🟡 MEDIUM

**Requirements:**
1. Export all settings to JSON file
2. Import settings from JSON file
3. Share settings between machines

**Technical Implementation:**

```dart
_buildSettingsCard(
  context: context,
  title: 'Settings Management',
  isDark: isDark,
  children: [
    Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.upload, size: 18),
              label: const Text('Export Settings'),
              onPressed: () => _exportSettings(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Import Settings'),
              onPressed: () => _importSettings(context),
            ),
          ),
        ],
      ),
    ),
  ],
),
```

### 8.3 Settings Profiles

**Priority:** 🟢 LOW

**Requirements:**
1. Save current settings as named profile
2. Switch between profiles
3. Share profiles

---

## Summary Table

| # | Feature | Priority | Complexity | Category |
|---|---------|----------|------------|----------|
| 1.1 | More Language Options | 🟡 MEDIUM | Low | General |
| 1.2 | Startup Options | 🟢 LOW | Low | General |
| 1.3 | Keyboard Shortcuts | 🟡 MEDIUM | Medium | General |
| 2.1 | Similarity Threshold | 🔴 HIGH | Low | Comparison |
| 2.2 | Comparison Mode | 🔴 HIGH | Medium | Comparison |
| 2.3 | Pattern Presets | 🟡 MEDIUM | Low | Comparison |
| 2.4 | Pattern Validation | 🟡 MEDIUM | Low | Comparison |
| 3.1 | More Theme Presets | 🟢 LOW | Low | Appearance |
| 3.2 | Line Height Control | 🟢 LOW | Low | Appearance |
| 3.3 | Font Family Selection | 🟡 MEDIUM | Low | Appearance |
| 3.4 | Identical Entry Color | 🟡 MEDIUM | Low | Appearance |
| 4.1 | Export Settings | 🔴 HIGH | Medium | File Handling |
| 4.2 | Backup Settings | 🟡 MEDIUM | Medium | File Handling |
| 4.3 | File Associations | 🟢 LOW | High | File Handling |
| 5.1 | API Key Validation | 🔴 HIGH | Medium | AI Services |
| 5.2 | Model Parameters | 🟡 MEDIUM | Low | AI Services |
| 5.3 | Translation Memory | 🟡 MEDIUM | High | AI Services |
| 6.1 | Default Branch | 🟡 MEDIUM | Low | Version Control |
| 6.2 | Commit Templates | 🟢 LOW | Low | Version Control |
| 6.3 | SSH Configuration | 🟢 LOW | Medium | Version Control |
| 7.1 | Update Information | 🟡 MEDIUM | Medium | About |
| 7.2 | System Information | 🟢 LOW | Low | About |
| 7.3 | Telemetry Settings | 🟡 MEDIUM | Low | About |
| 8.1 | Settings Search | 🔴 HIGH | Medium | Cross-Cutting |
| 8.2 | Import/Export Settings | 🟡 MEDIUM | Medium | Cross-Cutting |
| 8.3 | Settings Profiles | 🟢 LOW | High | Cross-Cutting |

---

## Recommended Implementation Order

### Phase 1: High Priority (Core Features)
1. ✅ 2.1 Similarity Threshold
2. ✅ 2.2 Comparison Mode Selection
3. ✅ 4.1 Default Export Settings
4. ✅ 5.1 API Key Validation
5. ✅ 8.1 Settings Search

### Phase 2: Medium Priority (Enhanced UX)
6. 1.1 More Language Options
7. 1.3 Keyboard Shortcuts
8. 2.3 Pattern Presets
9. 2.4 Pattern Validation
10. 3.3 Font Family Selection
11. 3.4 Identical Entry Color
12. 4.2 Backup Settings
13. 5.2 Model Parameters
14. 6.1 Default Branch
15. 7.1 Update Information
16. 7.3 Telemetry Settings
17. 8.2 Import/Export Settings

### Phase 3: Low Priority (Nice to Have)
18. 1.2 Startup Options
19. 3.1 More Theme Presets
20. 3.2 Line Height Control
21. 6.2 Commit Templates
22. 6.3 SSH Configuration
23. 7.2 System Information
24. 8.3 Settings Profiles
25. 4.3 File Associations (platform-specific, complex)
26. 5.3 Translation Memory (requires database work)
