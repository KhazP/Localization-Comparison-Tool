import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AppearanceSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const AppearanceSettingsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  static const List<String> themeModes = ['System', 'Light', 'Dark', 'Amoled'];
  static const List<String> fontFamilies = [
    'System Default',
    'JetBrains Mono',
    'Fira Code',
    'Source Code Pro',
    'Cascadia Code',
    'Roboto Mono',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsCardContainer(
          title: context.t.settings.appearance.title,
          isDark: isDark,
          isAmoled: isAmoled,
          onReset: () {
            final defaults = AppSettings.defaultSettings();
            context.read<SettingsBloc>()
              ..add(UpdateAppThemeMode(defaults.appThemeMode))
              ..add(UpdateDiffFontSize(defaults.diffFontSize))
              ..add(UpdateDiffFontFamily(defaults.diffFontFamily))
              ..add(UpdateAccentColor(defaults.accentColorValue));
          },
          children: [
            SettingsRow(
              label: context.t.settings.appearance.theme,
              description: context.t.settings.appearance.themeDescription,
              control: SettingsDropdown(
                value: settings.appThemeMode,
                items: themeModes,
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateAppThemeMode(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
                itemLabelBuilder: (val) {
                  switch (val) {
                    case 'System':
                      return context.t.settings.appearance.themeSystem;
                    case 'Light':
                      return context.t.settings.appearance.themeLight;
                    case 'Dark':
                      return context.t.settings.appearance.themeDark;
                    case 'Amoled':
                      return context.t.settings.appearance.themeAmoled;
                    default:
                      return val;
                  }
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: context.t.settings.appearance.diffFontSize,
              description:
                  context.t.settings.appearance.diffFontSizeDescription,
              control: SizedBox(
                width: 200,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Slider(
                        value: settings.diffFontSize,
                        min: 10,
                        max: 18,
                        divisions: 8,
                        label: '${settings.diffFontSize.round()}px',
                        onChanged: (value) => context
                            .read<SettingsBloc>()
                            .add(UpdateDiffFontSize(value)),
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${settings.diffFontSize.round()}px',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: context.t.settings.appearance.diffFontFamily,
              description:
                  context.t.settings.appearance.diffFontFamilyDescription,
              control: SettingsDropdown(
                value: settings.diffFontFamily.isEmpty
                    ? 'System Default'
                    : settings.diffFontFamily,
                items: fontFamilies,
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateDiffFontFamily(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
                itemLabelBuilder: (val) {
                  if (val == 'System Default') {
                    return context.t.settings.appearance.systemDefault;
                  }
                  return val;
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: context.t.settings.appearance.accentColor,
              control: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Color(settings.accentColorValue),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: SettingsThemeHelper(
                                isDark: isDark, isAmoled: isAmoled)
                            .borderColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => AppearanceSettingsCard.showColorPicker(
                      context,
                      Color(settings.accentColorValue),
                      (color) => context
                          .read<SettingsBloc>()
                          .add(UpdateAccentColor(color.value)),
                      title: context.t.settings.appearance.pickAccentColor,
                    ),
                    child: Text(context.t.common.change),
                  ),
                ],
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        DiffColorsSettingsCard(
          settings: settings,
          isDark: isDark,
          isAmoled: isAmoled,
        ),
        LifePreviewPanel(
          settings: settings,
          isDark: isDark,
          isAmoled: isAmoled,
        ),
      ],
    );
  }

  static void showColorPicker(
    BuildContext context,
    Color initialColor,
    ValueChanged<Color> onColorSelected, {
    required String title,
  }) {
    Color pickerColor = initialColor;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(
            children: [
              Icon(
                LucideIcons.palette,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(title),
            ],
          ),
          content: SizedBox(
            width: 380,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withAlpha(10)
                        : Colors.black.withAlpha(10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              context.t.common.original,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: isDark
                                    ? AppThemeV2.darkTextMuted
                                    : AppThemeV2.lightTextMuted,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: initialColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isDark
                                      ? AppThemeV2.darkBorder
                                      : AppThemeV2.lightBorder,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(
                          LucideIcons.arrowRight,
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "New",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: pickerColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (color) =>
                      setState(() => pickerColor = color),
                  enableAlpha: false,
                  displayThumbColor: true,
                  hexInputBar: true,
                  labelTypes: const [],
                  pickerAreaHeightPercent: 0.7,
                  portraitOnly: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.t.common.cancel),
            ),
            FilledButton(
              onPressed: () {
                onColorSelected(pickerColor);
                Navigator.of(dialogContext).pop();
              },
              child: Text(context.t.common.apply),
            ),
          ],
        ),
      ),
    );
  }
}

class DiffColorsSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const DiffColorsSettingsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsCardContainer(
      title: context.t.settings.appearance.diffColors,
      isDark: isDark,
      isAmoled: isAmoled,
      onReset: () {
        context.read<SettingsBloc>().add(ResetDiffColors());
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Text(
            context.t.settings.appearance.presetsTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: _buildPresetButtons(context),
        ),
        Divider(
          color: SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled)
              .borderColor,
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        _buildColorRow(
            context, context.t.diff.added, Color(settings.diffAddedColor),
            (color) {
          context.read<SettingsBloc>().add(UpdateDiffAddedColor(color.value));
        }),
        _buildColorRow(
            context, context.t.diff.removed, Color(settings.diffRemovedColor),
            (color) {
          context.read<SettingsBloc>().add(UpdateDiffRemovedColor(color.value));
        }),
        _buildColorRow(
            context, context.t.diff.modified, Color(settings.diffModifiedColor),
            (color) {
          context
              .read<SettingsBloc>()
              .add(UpdateDiffModifiedColor(color.value));
        }),
        _buildColorRow(context, context.t.settings.appearance.identical,
            Color(settings.diffIdenticalColor), (color) {
          context
              .read<SettingsBloc>()
              .add(UpdateDiffIdenticalColor(color.value));
        }, showDivider: false),
      ],
    );
  }

  Widget _buildPresetButtons(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _themePresets.entries.map((entry) {
        String label = entry.key;
        switch (entry.key) {
          case 'Default':
            label = context.t.settings.appearance.presets.presetDefault;
            break;
          case 'Colorblind-Friendly':
            label = context.t.settings.appearance.presets.presetColorblind;
            break;
          case 'High Contrast':
            label = context.t.settings.appearance.presets.presetHighContrast;
            break;
          case 'Nord':
            label = context.t.settings.appearance.presets.presetNord;
            break;
          case 'Solarized':
            label = context.t.settings.appearance.presets.presetSolarized;
            break;
          case 'Monokai':
            label = context.t.settings.appearance.presets.presetMonokai;
            break;
        }

        return ActionChip(
          label: Text(label),
          onPressed: () {
            context.read<SettingsBloc>().add(ApplyThemePreset(
                  added: entry.value.added.value,
                  removed: entry.value.removed.value,
                  modified: entry.value.modified.value,
                ));
          },
          labelStyle: const TextStyle(fontSize: 12),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        );
      }).toList(),
    );
  }

  Widget _buildColorRow(
    BuildContext context,
    String label,
    Color color,
    ValueChanged<Color> onChanged, {
    bool showDivider = true,
  }) {
    return SettingsRow(
      label: label,
      isDark: isDark,
      isAmoled: isAmoled,
      showDivider: showDivider,
      control: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled)
                    .borderColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () => AppearanceSettingsCard.showColorPicker(
              context,
              color,
              onChanged,
              title: context.t.settings.appearance.pickColorFor(label: label),
            ),
            child: Text(context.t.common.change),
          ),
        ],
      ),
    );
  }

  static const Map<String, _ThemePreset> _themePresets = {
    'Default': _ThemePreset(
      added: Color(0xFF4CAF50),
      removed: Color(0xFFF44336),
      modified: Color(0xFFFFC107),
    ),
    'Colorblind-Friendly': _ThemePreset(
      added: Color(0xFF0077BB),
      removed: Color(0xFFEE7733),
      modified: Color(0xFF009988),
    ),
    'High Contrast': _ThemePreset(
      added: Colors.greenAccent,
      removed: Colors.redAccent,
      modified: Colors.yellowAccent,
    ),
    'Nord': _ThemePreset(
      added: Color(0xFFA3BE8C),
      removed: Color(0xFFBF616A),
      modified: Color(0xFFEBCB8B),
    ),
    'Solarized': _ThemePreset(
      added: Color(0xFF859900),
      removed: Color(0xFFDC322F),
      modified: Color(0xFFB58900),
    ),
    'Monokai': _ThemePreset(
      added: Color(0xFFA6E22E),
      removed: Color(0xFFF92672),
      modified: Color(0xFFFD971F),
    ),
  };
}

class _ThemePreset {
  final Color added;
  final Color removed;
  final Color modified;

  const _ThemePreset({
    required this.added,
    required this.removed,
    required this.modified,
  });
}

class LifePreviewPanel extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const LifePreviewPanel({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  Widget build(BuildContext context) {
    String fontFamily = settings.diffFontFamily.isEmpty
        ? 'System Default'
        : settings.diffFontFamily;
    final String actualFontFamily = fontFamily == 'System Default'
        ? 'Consolas, Monaco, monospace'
        : fontFamily;
    final double fontSize = settings.diffFontSize;
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Icon(
                  LucideIcons.eye,
                  size: 16,
                  color: theme.textMutedColor,
                ),
                const SizedBox(width: 8),
                Text(
                  context.t.settings.appearance.livePreview,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.textSecondaryColor,
                      ),
                ),
              ],
            ),
          ),
          Divider(color: theme.borderColor, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _AnimatedPreviewEntry(
                  lineNumber: 42,
                  status: context.t.diff.added.toUpperCase(),
                  color: Color(settings.diffAddedColor),
                  keyName: context.t.settings.appearance.preview.step3Title,
                  value: context.t.settings.appearance.preview.connectAccount,
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
                const SizedBox(height: 8),
                _AnimatedPreviewEntry(
                  lineNumber: 58,
                  status: context.t.diff.removed.toUpperCase(),
                  color: Color(settings.diffRemovedColor),
                  keyName: context.t.settings.appearance.preview.loginHint,
                  value: context.t.settings.appearance.preview.enterCredentials,
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
                const SizedBox(height: 8),
                _AnimatedPreviewEntry(
                  lineNumber: 73,
                  status: context.t.diff.modified.toUpperCase(),
                  color: Color(settings.diffModifiedColor),
                  keyName: context.t.settings.appearance.preview.ctaButton,
                  value:
                      '${context.t.settings.appearance.preview.buyNow} → ${context.t.settings.appearance.preview.completePurchase}',
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
                const SizedBox(height: 8),
                _AnimatedPreviewEntry(
                  lineNumber: 89,
                  status: context.t.settings.appearance.identical.toUpperCase(),
                  color: Color(settings.diffIdenticalColor),
                  keyName: context.t.settings.appearance.preview.appNameKey,
                  value: context.t.settings.appearance.preview.appNameValue,
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedPreviewEntry extends StatelessWidget {
  final int lineNumber;
  final String status;
  final Color color;
  final String keyName;
  final String value;
  final bool isDark;
  final bool isAmoled;
  final String fontFamily;
  final double fontSize;

  const _AnimatedPreviewEntry({
    required this.lineNumber,
    required this.status,
    required this.color,
    required this.keyName,
    required this.value,
    required this.isDark,
    required this.isAmoled,
    required this.fontFamily,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 250);
    const curve = Curves.easeOutCubic;

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: color),
      duration: duration,
      curve: curve,
      builder: (context, animatedColor, child) {
        final effectiveColor = animatedColor ?? color;
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(end: fontSize),
          duration: duration,
          curve: curve,
          builder: (context, animatedFontSize, _) {
            return AnimatedContainer(
              duration: duration,
              curve: curve,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: effectiveColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: effectiveColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    alignment: Alignment.center,
                    child: Text(
                      '$lineNumber',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppThemeV2.darkTextMuted
                                : AppThemeV2.lightTextMuted,
                            fontFamily: fontFamily,
                            fontSize: 11,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedContainer(
                    duration: duration,
                    curve: curve,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: effectiveColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontFamily: fontFamily,
                              fontSize: animatedFontSize,
                            ),
                        children: [
                          TextSpan(
                            text: keyName,
                            style: TextStyle(
                              color: effectiveColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ': ',
                            style: TextStyle(
                              color: isDark
                                  ? AppThemeV2.darkTextMuted
                                  : AppThemeV2.lightTextMuted,
                            ),
                          ),
                          TextSpan(
                            text: value,
                            style: TextStyle(
                              color: isDark
                                  ? AppThemeV2.darkTextSecondary
                                  : AppThemeV2.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
