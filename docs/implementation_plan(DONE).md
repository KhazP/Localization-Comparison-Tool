# Localization Comparison Tool - UI/UX Improvement Plan

This document contains detailed implementation plans for each UI/UX improvement identified from the screenshot analysis. Each section is self-contained so it can be copied into a new chat for implementation.

---

## Table of Contents

1. [Search/Filter in Comparison View](#1-searchfilter-in-comparison-view)
2. [Character-Level Diff Highlighting](#2-character-level-diff-highlighting)
3. [Remove DEBUG Ribbon](#3-remove-debug-ribbon)
4. [Summary Statistics with Charts](#4-summary-statistics-with-charts)
5. [Hide/Collapse Identical Entries](#5-hidecollapse-identical-entries)
6. [Line Numbers in Comparison View](#6-line-numbers-in-comparison-view)
7. [File Watching Toggle Clarity](#7-file-watching-toggle-clarity)
8. [Interactive File Format Badges](#8-interactive-file-format-badges)
9. [Enhanced Empty State](#9-enhanced-empty-state)
10. [Batch Export for Directory Comparison](#10-batch-export-for-directory-comparison)
11. [Settings Live Preview](#11-settings-live-preview)
12. [Accessibility Theme Presets](#12-accessibility-theme-presets)
13. [Font Size Control](#13-font-size-control)
14. [Advanced View Multi-Select Filters](#14-advanced-view-multi-select-filters)
15. [Directory Comparison Summary](#15-directory-comparison-summary)

---

## 1. Search/Filter in Comparison View

**Priority:** 🔴 HIGH  
**Location:** `lib/presentation/views/basic_comparison_view.dart`  
**Complexity:** Medium

### Problem
When comparing large localization files with hundreds or thousands of entries, users cannot quickly find specific keys or values. They must scroll through the entire list manually.

### Requirements
1. Add a search text field above the comparison results list
2. Search should filter results in real-time as the user types
3. Search should match against:
   - String key/name (e.g., `tooltips.equipped`)
   - Source value content
   - Target value content
4. Highlight matching text within results
5. Show count of matching results (e.g., "Showing 23 of 536 entries")
6. Add a clear button to reset the search

### Technical Implementation

```dart
// Add to the state class
final TextEditingController _searchController = TextEditingController();
String _searchQuery = '';

// Filter function
List<ComparisonEntry> get filteredEntries {
  if (_searchQuery.isEmpty) return allEntries;
  return allEntries.where((entry) {
    final query = _searchQuery.toLowerCase();
    return entry.key.toLowerCase().contains(query) ||
           entry.sourceValue.toLowerCase().contains(query) ||
           entry.targetValue.toLowerCase().contains(query);
  }).toList();
}

// Search field widget
TextField(
  controller: _searchController,
  decoration: InputDecoration(
    hintText: 'Search keys or values...',
    prefixIcon: Icon(Icons.search),
    suffixIcon: _searchQuery.isNotEmpty
        ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              setState(() => _searchQuery = '');
            },
          )
        : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  onChanged: (value) => setState(() => _searchQuery = value),
)
```

### UI Placement
- Position the search field in the stats bar area, between the Total count and the icon buttons
- Use a compact design that doesn't take too much vertical space
- Consider using a debounce of 300ms to avoid excessive filtering on large datasets

### Verification
1. Load a comparison with 500+ entries
2. Type a partial key name and verify results filter in real-time
3. Verify the count updates correctly
4. Test clearing the search resets to full list
5. Test search is case-insensitive

---

## 2. Character-Level Diff Highlighting

**Priority:** 🔴 HIGH  
**Location:** `lib/presentation/views/advanced_diff_view.dart`, `lib/presentation/widgets/`  
**Complexity:** High

### Problem
When strings are marked as "Modified", users cannot see exactly WHAT changed within the string. They must visually compare the old and new values character by character.

### Requirements
1. For modified entries, highlight the exact characters that changed
2. Use distinct colors: red background for deleted characters, green for added
3. Apply to both "Old Value (Source)" and "New Value (Target)" columns
4. Should work with the Levenshtein/similarity algorithm already in use

### Technical Implementation

```dart
import 'package:diff_match_patch/diff_match_patch.dart';

class DiffHighlighter {
  static List<TextSpan> highlightDiff(String oldText, String newText, {bool isSource = true}) {
    final dmp = DiffMatchPatch();
    final diffs = dmp.diff_main(oldText, newText);
    dmp.diff_cleanupSemantic(diffs);

    List<TextSpan> spans = [];
    for (final diff in diffs) {
      TextStyle? style;
      if (diff.operation == DIFF_DELETE && isSource) {
        style = TextStyle(
          backgroundColor: Colors.red.withOpacity(0.3),
          decoration: TextDecoration.lineThrough,
        );
      } else if (diff.operation == DIFF_INSERT && !isSource) {
        style = TextStyle(
          backgroundColor: Colors.green.withOpacity(0.3),
        );
      } else if (diff.operation == DIFF_EQUAL) {
        style = null; // Default style
      } else {
        continue; // Skip insertions when showing source, deletions when showing target
      }

      if (style != null || diff.operation == DIFF_EQUAL) {
        spans.add(TextSpan(text: diff.text, style: style));
      }
    }
    return spans;
  }
}

// Usage in the table cell
RichText(
  text: TextSpan(
    children: DiffHighlighter.highlightDiff(
      oldValue,
      newValue,
      isSource: true,
    ),
    style: DefaultTextStyle.of(context).style,
  ),
)
```

### Dependencies
Add to `pubspec.yaml`:
```yaml
dependencies:
  diff_match_patch: ^0.4.1
```

### Verification
1. Compare two files with modified strings
2. Verify deleted portions show with red strikethrough in source column
3. Verify added portions show with green highlight in target column
4. Test with various modification types: word changes, character insertions, deletions

---

## 3. Remove DEBUG Ribbon

**Priority:** 🔴 HIGH  
**Location:** `lib/main.dart` or `lib/presentation/app.dart`  
**Complexity:** Low

### Problem
The red "DEBUG" ribbon appears in the top-right corner of the app, which should not be visible in production builds.

### Requirements
1. Remove the debug banner for release builds
2. Keep it for debug builds during development

### Technical Implementation

```dart
// In MaterialApp or your App widget
MaterialApp(
  debugShowCheckedModeBanner: false, // Add this line
  // ... rest of your configuration
)
```

Alternatively, for conditional display:
```dart
MaterialApp(
  debugShowCheckedModeBanner: kDebugMode, // Shows only in debug mode
  // ... rest of your configuration
)
```

### Verification
1. Run `flutter run -d windows --release` and verify no debug banner
2. Run `flutter run -d windows` and verify banner appears (if using conditional approach)

---

## 4. Summary Statistics with Charts

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/basic_comparison_view.dart`  
**Complexity:** Medium

### Problem
The stats bar shows "Total: 536 +263 -262 ~0" but this is hard to quickly parse visually. A chart would make proportions immediately clear.

### Requirements
1. Add a mini donut chart or horizontal bar chart next to the stats
2. Color segments should match the diff colors (green=added, red=removed, yellow=modified)
3. Chart should be compact (roughly 40x40 pixels for donut, or horizontal strip)
4. Optionally show percentage on hover

### Technical Implementation

```dart
// Using fl_chart package for a mini pie chart
import 'package:fl_chart/fl_chart.dart';

Widget buildStatsChart(int added, int removed, int modified) {
  final total = added + removed + modified;
  if (total == 0) return SizedBox.shrink();

  return SizedBox(
    width: 36,
    height: 36,
    child: PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: added.toDouble(),
            color: Colors.green,
            radius: 12,
            showTitle: false,
          ),
          PieChartSectionData(
            value: removed.toDouble(),
            color: Colors.red,
            radius: 12,
            showTitle: false,
          ),
          PieChartSectionData(
            value: modified.toDouble(),
            color: Colors.amber,
            radius: 12,
            showTitle: false,
          ),
        ],
        sectionsSpace: 1,
        centerSpaceRadius: 8,
      ),
    ),
  );
}
```

### Alternative: Horizontal Bar
```dart
Widget buildStatsBar(int added, int removed, int modified) {
  final total = added + removed + modified;
  if (total == 0) return SizedBox.shrink();

  return Container(
    width: 100,
    height: 8,
    child: Row(
      children: [
        Expanded(
          flex: added,
          child: Container(color: Colors.green),
        ),
        Expanded(
          flex: removed,
          child: Container(color: Colors.red),
        ),
        Expanded(
          flex: modified,
          child: Container(color: Colors.amber),
        ),
      ],
    ),
  );
}
```

### Dependencies
```yaml
dependencies:
  fl_chart: ^0.68.0  # Or use the simpler bar approach with no deps
```

### Verification
1. Load comparison with varied stats (e.g., 263 added, 262 removed, 5 modified)
2. Verify chart segments are proportional
3. Verify colors match the existing diff color scheme from settings

---

## 5. Hide/Collapse Identical Entries

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/basic_comparison_view.dart`  
**Complexity:** Low-Medium

### Problem
When comparing files, IDENTICAL entries take up the same screen space as changed entries, making it harder to focus on actual differences.

### Requirements
1. Add a toggle button to show/hide identical entries
2. Default state: show all entries (current behavior)
3. When hidden, show a collapsed summary: "42 identical entries hidden"
4. Remember preference in settings

### Technical Implementation

```dart
// Add to state
bool _showIdentical = true;

// Filter entries
List<ComparisonEntry> get displayedEntries {
  if (_showIdentical) return allEntries;
  return allEntries.where((e) => e.status != DiffStatus.identical).toList();
}

// Toggle button in toolbar
IconButton(
  icon: Icon(_showIdentical ? Icons.visibility : Icons.visibility_off),
  tooltip: _showIdentical ? 'Hide identical entries' : 'Show identical entries',
  onPressed: () => setState(() => _showIdentical = !_showIdentical),
),

// Show summary when hidden
if (!_showIdentical)
  Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    color: Theme.of(context).colorScheme.surfaceVariant,
    child: Text(
      '${identicalCount} identical entries hidden',
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  ),
```

### Verification
1. Load comparison with both identical and changed entries
2. Click toggle and verify identical entries are hidden
3. Verify the hidden count is correct
4. Toggle back and verify all entries reappear

---

## 6. Line Numbers in Comparison View

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/basic_comparison_view.dart`  
**Complexity:** Low

### Problem
Without line numbers, users cannot easily reference or communicate about specific entries when discussing changes.

### Requirements
1. Add line numbers to the left of each comparison entry
2. Numbers should be zero-padded for alignment (001, 002, ... 999)
3. Use subtle styling so they don't distract from content
4. Line numbers should persist even when filtered

### Technical Implementation

```dart
// In the ListView.builder
ListView.builder(
  itemCount: entries.length,
  itemBuilder: (context, index) {
    final lineNumber = (index + 1).toString().padLeft(3, '0');
    return Row(
      children: [
        Container(
          width: 48,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            lineNumber,
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(child: buildEntryWidget(entries[index])),
      ],
    );
  },
)
```

### Verification
1. Load a comparison and verify line numbers appear
2. Verify numbers are properly aligned and readable
3. Apply a filter and verify line numbers update correctly

---

## 7. File Watching Toggle Clarity

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/basic_comparison_view.dart`  
**Complexity:** Low

### Problem
The "OFF" badge next to the eye icon doesn't clearly communicate what feature it controls (file watching).

### Requirements
1. Replace icon-only design with a labeled toggle or tooltip
2. When OFF: Show "File Watching: OFF" or use tooltip
3. When ON: Show pulsing indicator to show it's actively monitoring
4. Add tooltip explaining the feature

### Technical Implementation

```dart
// Option 1: Chip with label
InputChip(
  avatar: Icon(
    _fileWatchingEnabled ? Icons.visibility : Icons.visibility_off,
    size: 18,
  ),
  label: Text(_fileWatchingEnabled ? 'Watching' : 'Watch Off'),
  selected: _fileWatchingEnabled,
  onSelected: (value) => _toggleFileWatching(value),
  tooltip: 'Automatically recompare when files change on disk',
)

// Option 2: Icon with enhanced tooltip
Tooltip(
  message: 'File Watching: ${_fileWatchingEnabled ? "ON" : "OFF"}\n'
           'Automatically recompares when source files are modified.',
  child: IconButton(
    icon: Badge(
      label: Text(_fileWatchingEnabled ? 'ON' : 'OFF'),
      child: Icon(Icons.visibility),
    ),
    onPressed: _toggleFileWatching,
  ),
)
```

### Verification
1. Hover over the toggle and verify tooltip explains the feature
2. Toggle on/off and verify the label updates
3. Modify a source file while watching is ON and verify recompare triggers

---

## 8. Interactive File Format Badges

**Priority:** 🟢 LOW  
**Location:** `lib/presentation/views/home_view.dart` (empty state)  
**Complexity:** Low

### Problem
The file format badges (.lang, .json, .xml, etc.) in the empty state are purely decorative.

### Requirements
1. Make badges clickable/tappable
2. Clicking a badge shows a tooltip or dialog with:
   - Full format name (e.g., ".json → JSON Localization")
   - What features are supported for that format
   - Example snippet of the format

### Technical Implementation

```dart
Map<String, FormatInfo> formatDetails = {
  '.json': FormatInfo(
    name: 'JSON Localization',
    description: 'Standard JSON key-value pairs',
    features: ['Nested keys', 'Array values', 'Unicode support'],
    example: '{\n  "greeting": "Hello",\n  "farewell": "Goodbye"\n}',
  ),
  '.xml': FormatInfo(
    name: 'Android XML Strings',
    description: 'Android strings.xml format',
    features: ['String arrays', 'Plurals', 'HTML formatting'],
    example: '<string name="hello">Hello</string>',
  ),
  // ... other formats
};

Widget buildFormatBadge(String format) {
  return Tooltip(
    richMessage: TextSpan(
      children: [
        TextSpan(text: '${formatDetails[format]!.name}\n', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: formatDetails[format]!.description),
      ],
    ),
    child: ActionChip(
      label: Text(format),
      onPressed: () => showFormatDetailsDialog(context, format),
    ),
  );
}
```

### Verification
1. Hover over a badge and verify tooltip appears
2. Click badge and verify details dialog opens
3. Verify all supported formats have info populated

---

## 9. Enhanced Empty State

**Priority:** 🟢 LOW  
**Location:** `lib/presentation/views/home_view.dart`  
**Complexity:** Medium

### Problem
The empty state is functional but could be more engaging and useful.

### Requirements
1. Add "Recent Files" section showing last 5 comparisons (if any)
2. Add subtle animation to the arrows icon
3. Consider adding a "Quick Tutorial" or "Getting Started" link

### Technical Implementation

```dart
// Animated icon using AnimatedRotation or custom animation
AnimatedContainer(
  duration: Duration(seconds: 2),
  curve: Curves.easeInOut,
  child: Icon(Icons.compare_arrows, size: 64, color: theme.primary),
)

// Recent files section
if (recentComparisons.isNotEmpty) ...[
  Divider(),
  Text('Recent Comparisons'),
  ...recentComparisons.take(5).map((recent) => ListTile(
    leading: Icon(Icons.history),
    title: Text('${recent.sourceName} ↔ ${recent.targetName}'),
    subtitle: Text(timeAgo(recent.timestamp)),
    onTap: () => loadComparison(recent),
  )),
]
```

### Verification
1. Launch app with no history - verify enhanced empty state
2. Perform a comparison, restart app, verify it appears in Recent
3. Click a recent item and verify it loads correctly

---

## 10. Batch Export for Directory Comparison

**Priority:** 🔴 HIGH  
**Location:** `lib/presentation/views/files_view.dart`  
**Complexity:** Medium

### Problem
Users can compare entire directories but cannot export all results at once. They must click "View" on each file pair individually to export.

### Requirements
1. Add "Export All" button in the Files view
2. Export should create a single CSV with pages or ZIP with all comparison results
3. Include summary sheet with totals per file
4. Show progress indicator for large exports

### Technical Implementation

```dart
// Export all button
ElevatedButton.icon(
  icon: Icon(Icons.download),
  label: Text('Export All Results'),
  onPressed: _pairedFiles.isEmpty ? null : () => _exportAllResults(),
)

Future<void> _exportAllResults() async {
  final directory = await getApplicationDocumentsDirectory();
  final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  final exportDir = Directory('${directory.path}/exports/$timestamp');
  await exportDir.create(recursive: true);

  for (int i = 0; i < _pairedFiles.length; i++) {
    final pair = _pairedFiles[i];
    // Show progress
    _updateProgress(i + 1, _pairedFiles.length);

    // Export each comparison
    final csvContent = await generateCsvForPair(pair);
    final file = File('${exportDir.path}/${pair.baseName}_comparison.csv');
    await file.writeAsString(csvContent);
  }

  // Generate summary
  await generateSummaryFile(exportDir);

  // Show completion dialog with path
  showExportCompleteDialog(exportDir.path);
}
```

### Verification
1. Compare a directory with multiple file pairs
2. Click "Export All"
3. Verify progress indicator shows
4. Verify output folder contains all CSV files plus summary
5. Open CSVs and verify data integrity

---

## 11. Settings Live Preview

**Priority:** 🟢 LOW  
**Location:** `lib/presentation/views/settings_view.dart`  
**Complexity:** Medium

### Problem
When customizing diff colors or themes, users cannot see how changes will look until they navigate back to a comparison.

### Requirements
1. Add a mini preview panel in the Appearance settings
2. Preview shows sample diff entries with current colors
3. Updates in real-time as user changes settings

### Technical Implementation

```dart
Widget buildPreviewPanel() {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preview', style: theme.textTheme.labelLarge),
          SizedBox(height: 8),
          _PreviewEntry(status: 'ADDED', color: addedColor, text: 'New string'),
          _PreviewEntry(status: 'REMOVED', color: removedColor, text: 'Deleted string'),
          _PreviewEntry(status: 'MODIFIED', color: modifiedColor, text: 'Changed string'),
        ],
      ),
    ),
  );
}
```

### Verification
1. Open Settings > Appearance
2. Change the "Added" color
3. Verify preview updates immediately
4. Navigate to a comparison and verify color matches preview

---

## 12. Accessibility Theme Presets

**Priority:** 🟢 LOW  
**Location:** `lib/presentation/views/settings_view.dart`  
**Complexity:** Low

### Problem
Users with color blindness may have difficulty distinguishing between added/removed/modified colors.

### Requirements
1. Add preset buttons: "Default", "Colorblind-Friendly", "High Contrast"
2. Colorblind preset uses distinguishable colors for deuteranopia/protanopia
3. High Contrast uses maximum contrast colors

### Technical Implementation

```dart
final themePresets = {
  'Default': ThemePreset(
    added: Colors.green,
    removed: Colors.red,
    modified: Colors.amber,
  ),
  'Colorblind-Friendly': ThemePreset(
    added: Color(0xFF0077BB),    // Blue
    removed: Color(0xFFEE7733),  // Orange
    modified: Color(0xFF009988), // Teal
  ),
  'High Contrast': ThemePreset(
    added: Colors.greenAccent,
    removed: Colors.redAccent,
    modified: Colors.yellowAccent,
  ),
};

Widget buildPresetButtons() {
  return Wrap(
    spacing: 8,
    children: themePresets.entries.map((entry) =>
      OutlinedButton(
        onPressed: () => applyPreset(entry.value),
        child: Text(entry.key),
      )
    ).toList(),
  );
}
```

### Verification
1. Open Settings > Appearance
2. Click "Colorblind-Friendly" preset
3. Verify colors change to the preset values
4. Navigate to comparison and verify accessibility

---

## 13. Font Size Control

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/settings_view.dart`  
**Complexity:** Low

### Problem
Fixed font size may be too small for some users or too large for others, especially when working with long string values.

### Requirements
1. Add font size slider in Appearance settings
2. Range: 10px to 18px, default 14px
3. Apply to comparison view text
4. Persist preference

### Technical Implementation

```dart
// In settings
Slider(
  value: _diffFontSize,
  min: 10,
  max: 18,
  divisions: 8,
  label: '${_diffFontSize.round()}px',
  onChanged: (value) {
    setState(() => _diffFontSize = value);
    settingsBloc.updateDiffFontSize(value);
  },
)

// In comparison view, read from settings
Text(
  entryValue,
  style: TextStyle(fontSize: settings.diffFontSize),
)
```

### Verification
1. Open Settings > Appearance
2. Adjust font size slider
3. Navigate to comparison view
4. Verify text size updates
5. Restart app and verify size persists

---

## 14. Advanced View Multi-Select Filters

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/advanced_diff_view.dart`  
**Complexity:** Low

### Problem
Filter chips appear to be single-select (clicking "Added" deselects "Removed"). Users may want to see Added AND Modified together.

### Requirements
1. Allow multiple filter chips to be selected simultaneously
2. "All" button to show all entries
3. "Clear" button to deselect all filters
4. Results show union of selected filters

### Technical Implementation

```dart
// State: Set instead of single value
Set<DiffStatus> _selectedFilters = {DiffStatus.values.toSet()}; // All by default

// Modified filter chip
FilterChip(
  label: Text('Added'),
  selected: _selectedFilters.contains(DiffStatus.added),
  onSelected: (selected) {
    setState(() {
      if (selected) {
        _selectedFilters.add(DiffStatus.added);
      } else {
        _selectedFilters.remove(DiffStatus.added);
      }
    });
  },
)

// Filter logic
List<ComparisonEntry> get filteredEntries {
  if (_selectedFilters.isEmpty) return [];
  return allEntries.where((e) => _selectedFilters.contains(e.status)).toList();
}
```

### Verification
1. Open Advanced Comparison view
2. Click "Added" - verify only added entries shown
3. Click "Modified" (while Added still selected) - verify both types shown
4. Click "All" - verify all entries shown

---

## 15. Directory Comparison Summary

**Priority:** 🟡 MEDIUM  
**Location:** `lib/presentation/views/files_view.dart`  
**Complexity:** Low

### Problem
After discovering file pairs, there's no aggregate summary showing total changes across all files.

### Requirements
1. Add summary bar above the paired files list
2. Show: "8 file pairs: 707 Added, 706 Removed, 0 Modified total"
3. Include total unique vs duplicate key detection if applicable

### Technical Implementation

```dart
Widget buildSummaryBar() {
  final totalAdded = _pairedFiles.fold(0, (sum, f) => sum + f.addedCount);
  final totalRemoved = _pairedFiles.fold(0, (sum, f) => sum + f.removedCount);
  final totalModified = _pairedFiles.fold(0, (sum, f) => sum + f.modifiedCount);

  return Container(
    padding: EdgeInsets.all(12),
    color: Theme.of(context).colorScheme.surfaceVariant,
    child: Row(
      children: [
        Text(
          '${_pairedFiles.length} file pairs',
          style: theme.textTheme.titleMedium,
        ),
        Spacer(),
        _StatBadge(label: 'A', value: totalAdded, color: Colors.green),
        SizedBox(width: 8),
        _StatBadge(label: 'R', value: totalRemoved, color: Colors.red),
        SizedBox(width: 8),
        _StatBadge(label: 'M', value: totalModified, color: Colors.amber),
      ],
    ),
  );
}
```

### Verification
1. Compare directories with multiple file pairs
2. Verify summary bar shows correct totals
3. Compare totals manually against individual file stats to confirm accuracy

---

## Summary

| # | Feature | Priority | Complexity |
|---|---------|----------|------------|
| 1 | Search/Filter | 🔴 HIGH | Medium |
| 2 | Character-Level Diff | 🔴 HIGH | High |
| 3 | Remove DEBUG Ribbon | 🔴 HIGH | Low |
| 4 | Stats Charts | 🟡 MEDIUM | Medium |
| 5 | Hide Identical | 🟡 MEDIUM | Low-Medium |
| 6 | Line Numbers | 🟡 MEDIUM | Low |
| 7 | File Watching Clarity | 🟡 MEDIUM | Low |
| 8 | Interactive Format Badges | 🟢 LOW | Low |
| 9 | Enhanced Empty State | 🟢 LOW | Medium |
| 10 | Batch Export | 🔴 HIGH | Medium |
| 11 | Settings Live Preview | 🟢 LOW | Medium |
| 12 | Accessibility Presets | 🟢 LOW | Low |
| 13 | Font Size Control | 🟡 MEDIUM | Low |
| 14 | Multi-Select Filters | 🟡 MEDIUM | Low |
| 15 | Directory Summary | 🟡 MEDIUM | Low |
