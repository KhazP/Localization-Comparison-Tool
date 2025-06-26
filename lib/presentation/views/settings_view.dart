import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart'; // Needed for AppSettings type
import 'package:localizer_app_main/presentation/themes/app_theme.dart'; // Import AppTheme to access static colors
import 'package:file_picker/file_picker.dart';

// Enum for settings categories to make it type-safe
enum SettingsCategory {
  general,
  comparisonEngine,
  appearance,
  fileHandling,
  aiServices,
  versionControl,
  about,
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SettingsCategory _selectedCategory = SettingsCategory.general;

  // Local state for UI elements that don't directly map to AppSettings fields
  // or are temporary, like the text controller for adding a new pattern.
  final TextEditingController _newPatternController = TextEditingController();

  // File formats list for dropdowns - can be expanded or moved to a config file
  final List<String> _fileFormats = [
    'json', 'xml', 'yaml', 'yml', 'csv', 'arb', 'xliff', 'properties', 'resx', 'lang', 'txt', 'docx'
  ];

  // Dark theme specific UI Styling Constants (will be used if not light theme)
  static const Color darkNavBackgroundColor = Color(0xFF1E1E2D);
  static const Color darkContentBackgroundColor = Color(0xFF161622);
  static const Color darkCardBackgroundColor = Color(0xFF2A2D3E);
  static const Color darkTextColor = Colors.white;
  static Color darkMutedTextColor = Colors.grey[400]!;
  static Color darkBorderColor = Colors.grey[700]!;
  static const Color darkSelectedNavItemColor = Color(0xFF2A2D3E);
  static const Color darkSelectedNavItemIndicatorColor = Color(0xFF3A3D4E);

  // Placeholder data for General Settings dropdowns
  final List<String> _appLanguages = ['English (US)', 'Spanish (ES)', 'French (FR)'];
  final List<String> _defaultViews = ['Basic Comparison', 'History View', 'Files', 'Last Used View'];
  final List<String> _encodings = ['UTF-8', 'UTF-16', 'UTF-16BE', 'UTF-16LE', 'ASCII', 'ISO-8859-1'];


  // Placeholder data for Appearance Settings
  final List<String> _themeModes = ['System', 'Light', 'Dark', 'Amoled'];

  @override
  void dispose() {
    _newPatternController.dispose();
    super.dispose();
  }

  // Helper to show tooltip
  Widget _buildTooltip(BuildContext context, String message, {Widget? child}) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';

    final Color tooltipBgColor = isLight 
        ? AppTheme.lightSettingsNavBackground.withOpacity(0.95) 
        : (isAmoled ? const Color(0xFF1A1A1A).withOpacity(0.95) : darkNavBackgroundColor.withOpacity(0.95)); // Darker grey for Amoled tooltip
    final Color tooltipTextColor = isLight 
        ? AppTheme.lightSettingsTextColor.withOpacity(0.9) 
        : (isAmoled ? Colors.grey[300]! : darkTextColor.withOpacity(0.9));
    final Color tooltipBorderColor = isLight 
        ? AppTheme.lightSettingsBorderColor.withOpacity(0.5) 
        : (isAmoled ? Colors.grey[700]!.withOpacity(0.5) : darkBorderColor.withOpacity(0.5));
    final Color iconMutedColor = isLight 
        ? AppTheme.lightSettingsMutedTextColor 
        : (isAmoled ? Colors.grey[500]! : darkMutedTextColor);

    return Tooltip(
      message: message,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      preferBelow: false,
      textStyle: TextStyle(color: tooltipTextColor),
      decoration: BoxDecoration(
        color: tooltipBgColor, 
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: tooltipBorderColor)
      ),
      child: child ?? Icon(Icons.info_outline, size: 16, color: iconMutedColor),
    );
  }

  Widget _buildColorPickerButton(BuildContext context, Color currentColor, ValueChanged<Color> onColorSelected) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';

    final Color currentBorderColor = isLight ? AppTheme.lightSettingsBorderColor : (isAmoled ? Colors.grey[850]! : darkBorderColor);
    
    return InkWell(
      onTap: () => _showColorPicker(context, currentColor, onColorSelected),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: currentColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: currentBorderColor.withOpacity(0.5)),
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context, Color initialColor, ValueChanged<Color> onColorSelected) {
    Color pickerColor = initialColor;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) => pickerColor = color,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Done'),
            onPressed: () {
              onColorSelected(pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build the content for the selected category
  Widget _buildSettingsContent(BuildContext context, SettingsCategory category, AppSettings settings) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';

    final Color currentBorderColor = isLight ? AppTheme.lightSettingsBorderColor : (isAmoled ? Colors.grey[850]! : darkBorderColor);
    final Color currentMutedTextColor = isLight ? AppTheme.lightSettingsMutedTextColor : (isAmoled ? Colors.grey[500]! : darkMutedTextColor);

    Widget resetCategoryButton = Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: ElevatedButton(
        onPressed: () => _showResetCategoryDialog(context, category),
        child: Text('Reset ${_getCategoryTitle(category)} to Default'),
      ),
    );

    List<Widget> settingsWidgets;

    switch (category) {
      case SettingsCategory.general:
        settingsWidgets = [
          _buildSettingCard(
            context,
            title: 'Application Configuration',
              children: [
              _buildSettingItemRow(
                context,
                label: 'Application Language',
                control: _buildStyledDropdown(
                  context,
                  settings.appLanguage,
                  _appLanguages, 
                  (val) {
                    if (val != null) {
                      context.read<SettingsBloc>().add(UpdateAppLanguage(val));
                    }
                  }
                ),
              ),
              Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
              _buildSettingItemRow(
                context,
                label: 'Default View on Startup',
                control: _buildStyledDropdown(
                  context,
                  settings.defaultViewOnStartup,
                  _defaultViews, 
                  (val) {
                     if (val != null) {
                      context.read<SettingsBloc>().add(UpdateDefaultViewOnStartup(val));
                    }
                  }
                ),
              ),
              Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
              _buildSettingItemRow(
                context,
                label: 'Auto-Check for Updates',
                control: Switch(
                  value: settings.autoCheckForUpdates,
                  onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoCheckForUpdates(val)),
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveTrackColor: currentMutedTextColor.withOpacity(0.3),
                  activeTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) return Theme.of(context).colorScheme.primary;
                      return Colors.grey[400];
                  }),
                ),
                tooltip: 'Automatically check for new application versions on startup.',
              ),
            ],
          ),
          _buildSettingCard(
            context,
            title: 'Danger Zone',
            children: [
                ElevatedButton.icon(
                icon: const Icon(Icons.restart_alt, color: Colors.white, size: 20),
                label: const Text('Reset All Settings to Factory Defaults', style: TextStyle(color: Colors.white, fontSize: 14)),
                  onPressed: () => _showResetAllSettingsDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F), // More specific red from image
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    elevation: 0,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'This action cannot be undone. All your custom settings will be lost.',
                  style: TextStyle(color: currentMutedTextColor, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ];
        break;
      case SettingsCategory.comparisonEngine:
        settingsWidgets = [
          _buildSettingCard(
            context,
            title: 'Comparison Behavior',
            children: [
              _buildSettingItemRow(
                context,
                label: 'Ignore Case During Comparison',
                control: Switch( 
                    key: const Key('settings_ignoreCase_switch'),
                    value: settings.ignoreCase,
                    onChanged: (val) => context.read<SettingsBloc>().add(UpdateIgnoreCase(val)),
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveTrackColor: currentMutedTextColor.withOpacity(0.3),
                    activeTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                     thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) return Theme.of(context).colorScheme.primary;
                      return Colors.grey[400];
                  }),
                ),
                tooltip: 'If enabled, differences in capitalization will be ignored. Treats \'Key\' and \'key\' as the same.'
              ),
              Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
               _buildSettingItemRow(
                context,
                label: 'Ignore Whitespace Differences',
                control: Switch( 
                    key: const Key('settings_ignoreWhitespace_switch'),
                    value: settings.ignoreWhitespace,
                    onChanged: (val) => context.read<SettingsBloc>().add(UpdateIgnoreWhitespace(val)),
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveTrackColor: currentMutedTextColor.withOpacity(0.3),
                    activeTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                     thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) return Theme.of(context).colorScheme.primary;
                      return Colors.grey[400];
                  }),
                ),
                tooltip: 'If enabled, differences in whitespace (e.g., leading/trailing spaces) will be ignored.'
              ),
            ]
          ),
          _buildSettingCard(
            context,
            title: 'Ignore Key Patterns (Regular Expressions)',
            children: [
              _buildIgnorePatternsList(context, settings.ignorePatterns, isLight),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                key: const Key('settings_addPattern_button'),
                icon: Icon(Icons.add, color: isLight ? AppTheme.lightSettingsTextColor : darkTextColor, size: 20),
                label: Text('Add Pattern', style: TextStyle(color: isLight ? AppTheme.lightSettingsTextColor : darkTextColor, fontSize: 14)),
                onPressed: () => _showAddPatternDialog(context, isLight),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(isLight ? 0.2 : 0.7),
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  elevation: 0,
                ),
              ),
            ]
          ),
        ];
        break;
      case SettingsCategory.appearance:
        final Color currentAccentPreviewBg = isLight ? AppTheme.lightSettingsBorderColor : darkBorderColor;
        settingsWidgets = [
          _buildSettingCard(
            context,
            title: 'Theme & Colors',
            children: [
              _buildSettingItemRow(
                context,
                label: 'Application Theme',
                control: _buildStyledDropdown(
                  context,
                  settings.appThemeMode,
                  _themeModes,
                  (val) {
                    if (val != null) {
                      context.read<SettingsBloc>().add(UpdateAppThemeMode(val));
                    }
                  }
                ),
                tooltip: 'Select the overall theme for the application.'
              ),
              Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
              _buildSettingItemRow(
                context,
                label: 'Accent Color',
                control: Row(
                  children: [
                    Container(
                      width: 24, height: 24, 
                      decoration: BoxDecoration(
                        color: Color(settings.accentColorValue),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: currentAccentPreviewBg.withOpacity(0.8))
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        _showAccentColorPickerDialog(context, Color(settings.accentColorValue), isLight);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        foregroundColor: isLight ? AppTheme.lightSettingsTextColor : darkTextColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))
                      ),
                      child: const Text('Change...', style: TextStyle(fontSize: 13)),
                    )
                  ],
                ),
                tooltip: 'Choose the primary accent color for UI elements.'
              ),
            ]
          ),
          _buildSettingCard(
            context,
            title: 'Font & Display',
            children: [
              _buildSettingItemRow(
                context,
                label: 'Diff "Added" Color',
                control: _buildColorPickerButton(context, Color(settings.diffAddedColor), (color) {
                  context.read<SettingsBloc>().add(UpdateDiffAddedColor(color.value));
                }),
              ),
              Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
              _buildSettingItemRow(
                context,
                label: 'Diff "Removed" Color',
                control: _buildColorPickerButton(context, Color(settings.diffRemovedColor), (color) {
                  context.read<SettingsBloc>().add(UpdateDiffRemovedColor(color.value));
                }),
              ),
              Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
              _buildSettingItemRow(
                context,
                label: 'Diff "Modified" Color',
                control: _buildColorPickerButton(context, Color(settings.diffModifiedColor), (color) {
                  context.read<SettingsBloc>().add(UpdateDiffModifiedColor(color.value));
                }),
              ),
            ],
          ),
        ];
        break;
      case SettingsCategory.fileHandling:
        settingsWidgets = _buildFileHandlingSettings(context, settings);
        break;
      case SettingsCategory.aiServices:
        settingsWidgets = [_buildSettingCard(context,title: 'AI Services', children: [Text('AI Services Settings (Placeholder)', style: TextStyle(color: isLight ? AppTheme.lightSettingsTextColor : darkTextColor))])];
        resetCategoryButton = const SizedBox.shrink();
        break;
      case SettingsCategory.versionControl:
        settingsWidgets = [_buildSettingCard(context,title: 'Version Control', children: [Text('Version Control (Git) Settings (Placeholder)', style: TextStyle(color: isLight ? AppTheme.lightSettingsTextColor : darkTextColor))])];
        resetCategoryButton = const SizedBox.shrink();
        break;
      case SettingsCategory.about:
        settingsWidgets = _buildAboutContent(context, isLight);
        resetCategoryButton = const SizedBox.shrink();
        break;
      default:
        final Color currentTextColor = isLight ? AppTheme.lightSettingsTextColor : darkTextColor;
        settingsWidgets = [const Text('Select a category')];
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 32), // -32 for padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes button to bottom
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getCategoryTitle(category),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold, 
                        color: isLight 
                            ? AppTheme.lightSettingsTextColor 
                            : (isAmoled ? Colors.grey[300]! : Theme.of(context).textTheme.headlineSmall?.color)
                      ),
                    ),
                    const Divider(height: 20, thickness: 1),
                    ...settingsWidgets,
                  ],
                ),
                resetCategoryButton,
              ],
            ),
          ),
        );
      }
    );
  }

  List<Widget> _buildFileHandlingSettings(BuildContext context, AppSettings settings) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';
    final Color currentBorderColor = isLight ? AppTheme.lightSettingsBorderColor : (isAmoled ? Colors.grey[850]! : darkBorderColor);
    final Color currentMutedTextColor = isLight ? AppTheme.lightSettingsMutedTextColor : (isAmoled ? Colors.grey[500]! : darkMutedTextColor);
    
    return [
      _buildSettingCard(
        context,
        title: 'File Formats',
        children: [
          _buildSettingItemRow(
            context,
            label: 'Default Source Format',
            control: _buildStyledDropdown(context, settings.defaultSourceFormat, _fileFormats, (val) {
              if (val != null) {
                context.read<SettingsBloc>().add(UpdateDefaultSourceFormat(val));
              }
            }),
            tooltip: 'Default file format for source localization files.',
          ),
          Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
          _buildSettingItemRow(
            context,
            label: 'Default Target Format',
            control: _buildStyledDropdown(context, settings.defaultTargetFormat, _fileFormats, (val) {
              if (val != null) {
                context.read<SettingsBloc>().add(UpdateDefaultTargetFormat(val));
              }
            }),
            tooltip: 'Default file format for target localization files.',
          ),
        ],
      ),
      _buildSettingCard(
        context,
        title: 'Encoding',
        children: [
          _buildSettingItemRow(
            context,
            label: 'Default Source Encoding',
            control: _buildStyledDropdown(context, settings.defaultSourceEncoding, _encodings, (val) {
              if (val != null) {
                context.read<SettingsBloc>().add(UpdateDefaultSourceEncoding(val));
              }
            }),
          ),
          Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
          _buildSettingItemRow(
            context,
            label: 'Default Target Encoding',
            control: _buildStyledDropdown(context, settings.defaultTargetEncoding, _encodings, (val) {
              if (val != null) {
                context.read<SettingsBloc>().add(UpdateDefaultTargetEncoding(val));
              }
            }),
          ),
          Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
          _buildSettingItemRow(
            context,
            label: 'Auto-Detect Encoding',
            control: Switch(
              value: settings.autoDetectEncoding,
              onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoDetectEncoding(val)),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Attempt to automatically detect file encoding. Fallback to default if detection fails.',
          ),
        ],
      ),
      _buildSettingCard(
        context,
        title: 'Parsing',
        children: [
          _buildSettingItemRow(
            context,
            label: 'CSV Delimiter',
            control: _CsvDelimiterInput(initialValue: settings.csvDelimiter),
          ),
          Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
          _buildSettingItemRow(
            context,
            label: 'Handle Byte Order Mark (BOM)',
            control: Switch(
              value: settings.handleByteOrderMark,
              onChanged: (val) => context.read<SettingsBloc>().add(UpdateHandleByteOrderMark(val)),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Recognize and handle the BOM in files like UTF-8, which can affect parsing.',
          ),
        ],
      ),
      _buildSettingCard(
        context,
        title: 'File System',
        children: [
          _buildSettingItemRow(
            context,
            label: 'Auto-reload on change',
            control: Switch(
              value: settings.autoReloadOnChange,
              onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoReloadOnChange(val)),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Automatically reload files in the comparison view if they are modified on disk.',
          ),
          Divider(color: currentBorderColor.withOpacity(0.5), height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                const Text('Default Export Directory', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    settings.defaultExportDirectory.isEmpty
                        ? 'Not Set'
                        : settings.defaultExportDirectory,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: settings.defaultExportDirectory.isEmpty
                          ? currentMutedTextColor
                          : (isLight
                              ? AppTheme.lightSettingsTextColor
                              : darkTextColor),
                      fontStyle: settings.defaultExportDirectory.isEmpty
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onPressed: () async {
                    String? result = await FilePicker.platform.getDirectoryPath();
                    if (result != null) {
                      context
                          .read<SettingsBloc>()
                          .add(UpdateDefaultExportDirectory(result));
                    }
                  },
                  child: const Text('Choose...'),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  String _getCategoryTitle(SettingsCategory category) {
    switch (category) {
      case SettingsCategory.general: return 'General Settings';
      case SettingsCategory.comparisonEngine: return 'Comparison Engine';
      case SettingsCategory.appearance: return 'Appearance';
      case SettingsCategory.fileHandling: return 'File Handling';
      case SettingsCategory.aiServices: return 'AI Services';
      case SettingsCategory.versionControl: return 'Version Control (Git)';
      case SettingsCategory.about: return 'About';
      default: return 'Settings';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';

    final Color currentContentBg = isLight 
        ? AppTheme.lightSettingsContentBackground 
        : (isAmoled ? Colors.black : darkContentBackgroundColor);

    return Scaffold(
      // AppBar can be added if needed, or if this view is part of a larger Scaffold with a TabBar
      // appBar: AppBar(title: Text(_getCategoryTitle(_selectedCategory))),
      body: Row(
        children: <Widget>[
          _buildLeftNavigationPanel(context, isLight), // Pass context and isLight
          Expanded(
            // Wrap the content area with BlocBuilder
            child: Container( // Add container to set content background color
              color: currentContentBg,
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  if (state.status == SettingsStatus.loading || state.status == SettingsStatus.initial) {
                    return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
                  }
                  if (state.status == SettingsStatus.error) {
                    return Center(child: Text('Error loading settings: ${state.errorMessage}', style: const TextStyle(color: Colors.redAccent)));
                  }
                  // Assuming state.status == SettingsStatus.loaded
                  final AppSettings settings = state.appSettings;
                  return _buildSettingsContent(context, _selectedCategory, settings);
                },
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildLeftNavigationPanel(BuildContext context, bool isLight) { // Accept context and isLight
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';

    final Color navBg = isLight 
        ? AppTheme.lightSettingsNavBackground 
        : (isAmoled ? Colors.black : darkNavBackgroundColor);
    final Color headerIconColor = Theme.of(context).colorScheme.primary;
    final Color headerTextColor = isLight 
        ? AppTheme.lightSettingsTextColor 
        : (isAmoled ? Colors.grey[300]! : darkTextColor);
    final Color dividerColor = isLight 
        ? AppTheme.lightSettingsBorderColor.withOpacity(0.3) 
        : (isAmoled ? Colors.grey[850]!.withOpacity(0.5) : darkBorderColor.withOpacity(0.3));
    final Color currentMutedTextColor = isLight 
        ? AppTheme.lightSettingsMutedTextColor 
        : (isAmoled ? Colors.grey[500]! : darkMutedTextColor);
    final Color currentTextColor = isLight 
        ? AppTheme.lightSettingsTextColor 
        : (isAmoled ? Colors.grey[300]! : darkTextColor);
    final Color selectedIndicator = isLight 
        ? Theme.of(context).colorScheme.primary.withOpacity(0.15) 
        : (isAmoled ? Theme.of(context).colorScheme.primary.withOpacity(0.25) : darkSelectedNavItemIndicatorColor);
    final Color hoverColor = Theme.of(context).colorScheme.primary.withOpacity(isAmoled ? 0.15 : 0.1);

    return Material(
      color: navBg,
      elevation: 2.0, 
      shadowColor: Colors.black.withOpacity(isLight ? 0.1 : 0.5),
      child: SizedBox(
        width: 230, // Adjusted width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  Icon(Icons.settings_suggest_outlined, color: headerIconColor, size: 26),
                  const SizedBox(width: 12),
                  Text('Settings', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: headerTextColor, 
                    fontWeight: FontWeight.bold
                  )),
                ],
              ),
            ),
            Divider(color: dividerColor, height: 1, indent: 16, endIndent: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16.0), // Add padding at the top of the list
                itemCount: SettingsCategory.values.length,
                itemBuilder: (context, index) {
                  final category = SettingsCategory.values[index];
                  final bool isSelected = _selectedCategory == category;
                  final Color itemIconColor = isSelected 
                      ? Theme.of(context).colorScheme.primary 
                      : (isAmoled ? Colors.grey[600]! : currentMutedTextColor);
                  final Color itemTextColor = isSelected 
                      ? (isLight ? Theme.of(context).colorScheme.primary : (isAmoled ? Theme.of(context).colorScheme.primary : currentTextColor)) 
                      : (isAmoled ? Colors.grey[400]! : currentMutedTextColor);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.0), // Reduced vertical padding
                    child: InkWell(
                      onTap: () => setState(() => _selectedCategory = category),
                      borderRadius: BorderRadius.circular(8.0),
                      hoverColor: hoverColor,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? selectedIndicator : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Icon(_getCategoryIcon(category), color: itemIconColor, size: 20),
                            const SizedBox(width: 16),
                            Text(
                              _getCategoryNavLabel(category), 
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: itemTextColor, 
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(SettingsCategory category) {
    // Using selected flag for future different selected icons if needed
    switch (category) {
      case SettingsCategory.general:
        return Icons.tune_outlined;
      case SettingsCategory.comparisonEngine:
        return Icons.compare_arrows_rounded;
      case SettingsCategory.appearance:
        return Icons.palette_outlined;
      case SettingsCategory.fileHandling:
        return Icons.snippet_folder_outlined;
      case SettingsCategory.aiServices:
        return Icons.psychology_outlined;
      case SettingsCategory.versionControl:
        return Icons.lan_outlined; // Git icon like 'hub' or a custom one
      case SettingsCategory.about:
        return Icons.info_outline_rounded;
      default:
        return Icons.settings_outlined;
    }
  }

  Widget _buildDropdown(BuildContext context, String label,
      String? currentValue, ValueChanged<String?> onChanged, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: currentValue,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          ),
        ),
      ],
    );
  }

  Widget _buildIgnorePatternsList(BuildContext context, List<String> patterns, bool isLight) {
    final Color currentTextColor = isLight ? AppTheme.lightSettingsTextColor : darkTextColor;
    if (patterns.isEmpty) {
      return const Center(child: Text('No ignore patterns set.', style: TextStyle(fontStyle: FontStyle.italic)));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // To be used within another ListView
      itemCount: patterns.length,
      itemBuilder: (context, index) {
        final pattern = patterns[index];
        return Card(
          key: Key('ignorePattern_card_$pattern'), // Key for the card
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            key: Key('ignorePattern_tile_$pattern'), // Key for the ListTile
            title: Text(pattern),
            trailing: IconButton(
              key: Key('ignorePattern_delete_$pattern'), // Key for the delete button
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
              onPressed: () {
                context.read<SettingsBloc>().add(RemoveIgnorePattern(pattern));
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddPatternDialog(BuildContext blocContext, bool isLight) async {
    // Passed blocContext to ensure we use the correct context for BLoC access
    _newPatternController.clear();
    final Color dialogBgColor = isLight ? AppTheme.lightSettingsContentBackground : darkCardBackgroundColor; 
    final Color dialogTextColor = isLight ? AppTheme.lightSettingsTextColor : darkTextColor;
    final Color dialogMutedTextColor = isLight ? AppTheme.lightSettingsMutedTextColor : darkMutedTextColor;

    return showDialog<void>(
      context: blocContext, // Use the context passed to the method
      builder: (BuildContext dialogContext) { // Different context for dialog
        return AlertDialog(
          title: const Text('Add Ignore Pattern'),
          content: TextField(
            key: const Key('addPattern_textField'), // Key for the TextField
            controller: _newPatternController,
            decoration: InputDecoration(
              hintText: 'Enter regex pattern',
              hintStyle: TextStyle(color: dialogMutedTextColor),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isLight ? AppTheme.lightSettingsBorderColor : darkBorderColor)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              key: const Key('addPattern_cancelButton'), // Key for Cancel button
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              key: const Key('addPattern_addButton'),
              onPressed: () {
                if (_newPatternController.text.isNotEmpty) {
                  blocContext // Use blocContext here for BLoC
                      .read<SettingsBloc>()
                      .add(AddIgnorePattern(_newPatternController.text));
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
              ), // Key for Add button
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingCard(BuildContext context, {required String title, required List<Widget> children}) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';

    final Color cardBg = isLight 
        ? AppTheme.lightSettingsCardBackground 
        : (isAmoled ? Colors.black : darkCardBackgroundColor);
    final Color titleColor = isLight 
        ? AppTheme.lightSettingsTextColor 
        : (isAmoled ? Colors.grey[300]! : darkTextColor);
    final BorderSide cardBorder = isLight 
        ? BorderSide(color: AppTheme.lightSettingsBorderColor.withOpacity(0.7)) 
        : (isAmoled ? BorderSide(color: Colors.grey[850]!) : BorderSide.none);

    return Card(
      color: cardBg,
      elevation: isLight ? 0.5 : (isAmoled ? 0.2 : 0),
      margin: const EdgeInsets.only(bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: cardBorder,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: titleColor, 
              fontWeight: FontWeight.w600
            )), // Bolder title
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItemRow(BuildContext context, {required String label, required Widget control, String? tooltip}) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final Color labelColor = isLight ? AppTheme.lightSettingsTextColor.withOpacity(0.85) : darkTextColor.withOpacity(0.85);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: labelColor
          )),
          Row(
            children: [
              control,
              if (tooltip != null) const SizedBox(width: 10),
              if (tooltip != null) _buildTooltip(context, tooltip),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStyledDropdown(BuildContext context, String? currentValue, List<String> items, ValueChanged<String?> onChanged) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';

    final Color dropdownBg = isLight ? AppTheme.lightSettingsNavBackground.withOpacity(0.7) : darkNavBackgroundColor; // Or lightSettingsCardBackground
    final Color dropdownBorderColor = isLight ? AppTheme.lightSettingsBorderColor.withOpacity(0.7) : darkBorderColor.withOpacity(0.7);
    final Color dropdownTextColor = isLight ? AppTheme.lightSettingsTextColor.withOpacity(0.9) : darkTextColor.withOpacity(0.9);
    final Color dropdownIconColor = Theme.of(context).colorScheme.primary; // Use accent from theme

    return Container(
      width: 200, // Give dropdown a fixed width as in image
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: dropdownBg,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: dropdownBorderColor)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: dropdownTextColor)),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true, // Make dropdown take the width of container
          style: TextStyle(color: dropdownTextColor, fontSize: 14),
          dropdownColor: dropdownBg, // Match the nav background
          iconEnabledColor: dropdownIconColor,
        ),
      ),
    );
  }

  String _getCategoryNavLabel(SettingsCategory category) {
    // Short, concise labels for navigation panel
    switch (category) {
      case SettingsCategory.general: return 'General';
      case SettingsCategory.comparisonEngine: return 'Comparison';
      case SettingsCategory.appearance: return 'Appearance';
      case SettingsCategory.fileHandling: return 'File';
      case SettingsCategory.aiServices: return 'AI';
      case SettingsCategory.versionControl: return 'Version';
      case SettingsCategory.about: return 'About';
      default: return 'Settings';
    }
  }

  // Method to show the Accent Color Picker Dialog
  Future<void> _showAccentColorPickerDialog(BuildContext context, Color currentColor, bool isLight) async {
    Color pickedColor = currentColor;
    final Color dialogBg = isLight ? AppTheme.lightSettingsContentBackground : darkCardBackgroundColor;
    final Color titleTextColor = isLight ? AppTheme.lightSettingsTextColor : darkTextColor;
    final Color pickerDialogMutedTextColor = isLight ? AppTheme.lightSettingsMutedTextColor : darkMutedTextColor;
    final Color pickerDialogTextColor = isLight ? AppTheme.lightSettingsTextColor : darkTextColor;

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Pick Accent Color', style: TextStyle(color: titleTextColor)),
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // It's good practice to give some padding around the color picker if it doesn't have its own internal padding
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Theme( // Theme the color picker for light/dark mode text primarily
                    data: Theme.of(context).copyWith(
                       textTheme: Theme.of(context).textTheme.copyWith(
                        bodyMedium: TextStyle(color: pickerDialogTextColor), 
                        titleMedium: TextStyle(color: pickerDialogTextColor), 
                      ),
                       inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                        labelStyle: TextStyle(color: pickerDialogMutedTextColor),
                        hintStyle: TextStyle(color: pickerDialogMutedTextColor),
                        helperStyle: TextStyle(color: pickerDialogMutedTextColor),
                        prefixStyle: TextStyle(color: pickerDialogTextColor),
                        suffixStyle: TextStyle(color: pickerDialogTextColor),
                        counterStyle: TextStyle(color: pickerDialogMutedTextColor),
                        fillColor: isLight ? Colors.grey[200] : Colors.grey[700],
                        iconColor: pickerDialogMutedTextColor,
                        // Might need more specific theming for text fields inside color picker if they are not inheriting
                      ),
                    ),
                    child: ColorPicker(
                      pickerColor: currentColor,
                      onColorChanged: (Color color) => pickedColor = color,
                      colorPickerWidth: 300.0,
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: false, // Usually accent colors don't need alpha
                      displayThumbColor: true,
                      paletteType: PaletteType.hsl,
                      labelTypes: const [ColorLabelType.hsl, ColorLabelType.rgb, ColorLabelType.hex],
                      pickerAreaBorderRadius: BorderRadius.circular(8.0),
                      hexInputBar: true,
                      // Ensure text inside the picker is readable for light/dark
                      // The Theme wrapper above should help.
                    ),
                  )
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: pickerDialogMutedTextColor)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              // Style should be fine from theme
              child: const Text('Select'), // Text color from button theme
              onPressed: () {
                context.read<SettingsBloc>().add(UpdateAccentColor(pickedColor.value));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show confirmation dialog for resetting a specific category
  Future<void> _showResetCategoryDialog(BuildContext originalContext, SettingsCategory category) async {
    final bool isLight = Theme.of(originalContext).brightness == Brightness.light;
    final settingsState = originalContext.read<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';
    
    final Color dialogBg = isLight ? AppTheme.lightSettingsContentBackground : (isAmoled ? Colors.black : darkCardBackgroundColor);
    final Color titleTextColor = isLight ? AppTheme.lightSettingsTextColor : (isAmoled ? Colors.grey[300]! : darkTextColor);
    final Color contentTextColor = isLight ? AppTheme.lightSettingsMutedTextColor : (isAmoled ? Colors.grey[400]! : darkMutedTextColor);

    return showDialog<void>(
      context: originalContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text('Reset ${_getCategoryTitle(category)}?', style: TextStyle(color: titleTextColor)),
          content: Text(
            'This will reset all ${_getCategoryTitle(category).toLowerCase()} settings to their default values. This action cannot be undone.',
            style: TextStyle(color: contentTextColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: contentTextColor)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(originalContext).colorScheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
              ),
              child: const Text('Reset'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _resetCategory(originalContext, category);
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show confirmation dialog for resetting all settings
  Future<void> _showResetAllSettingsDialog(BuildContext originalContext) async {
    final bool isLight = Theme.of(originalContext).brightness == Brightness.light;
    final settingsState = originalContext.read<SettingsBloc>().state;
    final String currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final bool isAmoled = !isLight && currentThemeMode == 'amoled';
    
    final Color dialogBg = isLight ? AppTheme.lightSettingsContentBackground : (isAmoled ? Colors.black : darkCardBackgroundColor);
    final Color titleTextColor = isLight ? AppTheme.lightSettingsTextColor : (isAmoled ? Colors.grey[300]! : darkTextColor);
    final Color contentTextColor = isLight ? AppTheme.lightSettingsMutedTextColor : (isAmoled ? Colors.grey[400]! : darkMutedTextColor);

    return showDialog<void>(
      context: originalContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text('Reset All Settings?', style: TextStyle(color: titleTextColor, fontWeight: FontWeight.bold)),
          content: Text(
            'This will reset ALL application settings to their factory defaults. This includes themes, colors, file formats, comparison settings, and all other preferences.\n\nThis action cannot be undone.',
            style: TextStyle(color: contentTextColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: contentTextColor)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
              ),
              child: const Text('Reset All', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                originalContext.read<SettingsBloc>().add(ResetAllSettings());
                ScaffoldMessenger.of(originalContext).showSnackBar(
                  const SnackBar(content: Text('All settings have been reset to defaults')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Helper method to trigger the appropriate reset event
  void _resetCategory(BuildContext context, SettingsCategory category) {
    switch (category) {
      case SettingsCategory.general:
        context.read<SettingsBloc>().add(ResetGeneralSettings());
        break;
      case SettingsCategory.comparisonEngine:
        context.read<SettingsBloc>().add(ResetComparisonSettings());
        break;
      case SettingsCategory.appearance:
        context.read<SettingsBloc>().add(ResetAppearanceSettings());
        break;
      case SettingsCategory.fileHandling:
        context.read<SettingsBloc>().add(ResetFileHandlingSettings());
        break;
      default:
        return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_getCategoryTitle(category)} settings have been reset to defaults')),
    );
  }

  // Method to build About page content
  List<Widget> _buildAboutContent(BuildContext context, bool isLight) {
    final Color currentTextColor = isLight ? AppTheme.lightSettingsTextColor : darkTextColor;
    final Color currentMutedTextColor = isLight ? AppTheme.lightSettingsMutedTextColor : darkMutedTextColor;
    
    return [
      _buildSettingCard(
        context,
        title: 'Application Information',
        children: [
          _buildAboutInfoRow('Application Name', 'Localization Comparison Tool', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutInfoRow('Version', '1.0.0+1', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutInfoRow('Build Number', '1', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutInfoRow('Release Date', 'December 2024', currentTextColor, currentMutedTextColor),
        ],
      ),
      _buildSettingCard(
        context,
        title: 'Developer Information',
        children: [
          _buildAboutInfoRow('Developer', 'Localization Tools Team', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutInfoRow('Copyright', '© 2024 All Rights Reserved', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutLinkRow(context, 'Website', 'https://github.com/yourorg/localizer-app', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutLinkRow(context, 'Support', 'mailto:support@yourorg.com', currentTextColor, currentMutedTextColor),
        ],
      ),
      _buildSettingCard(
        context,
        title: 'System Information',
        children: [
          _buildAboutInfoRow('Flutter Version', 'Flutter 3.19+', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutInfoRow('Dart Version', 'Dart 3.0+', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutInfoRow('Platform', _getPlatformInfo(), currentTextColor, currentMutedTextColor),
        ],
      ),
      _buildSettingCard(
        context,
        title: 'Legal & Licenses',
        children: [
          _buildAboutLinkRow(context, 'License', 'MIT License', currentTextColor, currentMutedTextColor),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutActionRow(context, 'Open Source Licenses', 'View third-party licenses', currentTextColor, () {
            _showLicensesDialog(context, isLight);
          }),
          Divider(color: currentMutedTextColor.withOpacity(0.3), height: 1),
          _buildAboutLinkRow(context, 'Privacy Policy', 'https://yourorg.com/privacy', currentTextColor, currentMutedTextColor),
        ],
      ),
      _buildSettingCard(
        context,
        title: 'Actions',
        children: [
          _buildAboutActionButton(context, 'Check for Updates', Icons.system_update, currentTextColor, () {
            _checkForUpdates(context);
          }),
          const SizedBox(height: 12),
          _buildAboutActionButton(context, 'Send Feedback', Icons.feedback, currentTextColor, () {
            _sendFeedback(context);
          }),
          const SizedBox(height: 12),
          _buildAboutActionButton(context, 'Rate this App', Icons.star_rate, currentTextColor, () {
            _rateApp(context);
          }),
        ],
      ),
    ];
  }

  Widget _buildAboutInfoRow(String label, String value, Color labelColor, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: labelColor, fontSize: 14)),
          Text(value, style: TextStyle(color: valueColor, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAboutLinkRow(BuildContext context, String label, String url, Color labelColor, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: labelColor, fontSize: 14)),
          InkWell(
            onTap: () => _launchUrl(url),
            child: Text(
              url.startsWith('http') ? 'Visit Website' : url,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutActionRow(BuildContext context, String label, String description, Color labelColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: labelColor, fontSize: 14)),
                Text(description, style: TextStyle(color: labelColor.withOpacity(0.7), fontSize: 12)),
              ],
            ),
            Icon(Icons.chevron_right, color: labelColor.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutActionButton(BuildContext context, String label, IconData icon, Color textColor, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  String _getPlatformInfo() {
    // This would normally use Platform.operatingSystem but keeping it simple
    return 'Windows Desktop';
  }

  void _launchUrl(String url) {
    // In a real implementation, would use url_launcher package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Would open: $url')),
    );
  }

  void _checkForUpdates(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checking for updates... (Not implemented)')),
    );
  }

  void _sendFeedback(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening feedback form... (Not implemented)')),
    );
  }

  void _rateApp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening app store rating... (Not implemented)')),
    );
  }

  void _showLicensesDialog(BuildContext context, bool isLight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Open Source Licenses'),
        content: const SingleChildScrollView(
          child: Text(
            'This application uses the following open source packages:\n\n'
            '• Flutter SDK (BSD License)\n'
            '• flutter_bloc (MIT License)\n'
            '• hive (Apache License 2.0)\n'
            '• file_picker (MIT License)\n'
            '• flutter_colorpicker (MIT License)\n'
            '• csv (BSD License)\n'
            '• yaml (MIT License)\n'
            '• xml (MIT License)\n'
            '• http (BSD License)\n'
            '• path (BSD License)\n'
            '• uuid (MIT License)\n'
            '• intl (BSD License)\n'
            '\nFor full license texts, please visit the respective package repositories.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

}

class _CsvDelimiterInput extends StatefulWidget {
  const _CsvDelimiterInput({required this.initialValue});

  final String initialValue;

  @override
  State<_CsvDelimiterInput> createState() => _CsvDelimiterInputState();
}

class _CsvDelimiterInputState extends State<_CsvDelimiterInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _CsvDelimiterInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the setting is changed externally (e.g., by resetting to default),
    // update the text field to reflect the new state.
    if (widget.initialValue != oldWidget.initialValue && widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        onSubmitted: (val) {
          if (val.isNotEmpty) {
            context.read<SettingsBloc>().add(UpdateCsvDelimiter(val));
          } else {
            // If user clears the field and submits, revert to what's in state
            // to prevent submitting an empty value.
            _controller.text = context.read<SettingsBloc>().state.appSettings.csvDelimiter;
          }
        },
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
} 