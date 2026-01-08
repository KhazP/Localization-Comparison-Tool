import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_constants.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/presentation/widgets/settings/setting_override_indicator.dart';
import 'package:localizer_app_main/presentation/widgets/settings/live_logic_preview_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Comparison Engine Settings card widget
class ComparisonSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final SettingsState state; // Added state
  final bool isDark;
  final bool isAmoled;
  final VoidCallback onShowAddPatternDialog;
  final bool showLivePreview;

  const ComparisonSettingsCard({
    super.key,
    required this.settings,
    required this.state, // Added required state
    required this.isDark,
    required this.isAmoled,
    required this.onShowAddPatternDialog,
    this.showLivePreview = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);
    final bloc = context.read<SettingsBloc>();

    // Use effective values
    final ignoreCase = state.isProjectScope
        ? state.getEffectiveIgnoreCase()
        : settings.ignoreCase;
    final ignoreWhitespace = state.isProjectScope
        ? state.getEffectiveIgnoreWhitespace()
        : settings.ignoreWhitespace;
    final similarityThreshold = state.isProjectScope
        ? state.getEffectiveSimilarityThreshold()
        : settings.similarityThreshold;
    final ignorePatterns = state.isProjectScope
        ? state.getEffectiveIgnorePatterns()
        : settings.ignorePatterns;

    return Column(
      children: [
        SettingsCardContainer(
          title: context.t.settings.comparison.behavior,
          isDark: isDark,
          isAmoled: isAmoled,
          onReset: () {
            if (state.isProjectScope) {
              bloc.add(const ResetCategoryToGlobal('comparison'));
            } else {
              bloc.add(ResetComparisonSettings());
            }
          },
          trailing: _buildSectionResetButton(context, bloc),
          children: [
            _buildOverridableSettingsRow(
              context: context,
              bloc: bloc,
              label: context.t.settings.comparison.ignoreCase,
              description: context.t.settings.comparison.ignoreCaseDescription,
              settingKey: 'ignoreCase',
              control: Switch(
                key: const Key('settings_ignoreCase_switch'),
                value: ignoreCase,
                onChanged: (val) {
                  if (state.isProjectScope) {
                    bloc.add(UpdateProjectOverridableSetting(
                        settingKey: 'ignoreCase', value: val));
                  } else {
                    bloc.add(UpdateIgnoreCase(val));
                  }
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            _buildOverridableSettingsRow(
              context: context,
              bloc: bloc,
              label: context.t.settings.comparison.ignoreWhitespace,
              description:
                  context.t.settings.comparison.ignoreWhitespaceDescription,
              settingKey: 'ignoreWhitespace',
              control: Switch(
                key: const Key('settings_ignoreWhitespace_switch'),
                value: ignoreWhitespace,
                onChanged: (val) {
                  if (state.isProjectScope) {
                    bloc.add(UpdateProjectOverridableSetting(
                        settingKey: 'ignoreWhitespace', value: val));
                  } else {
                    bloc.add(UpdateIgnoreWhitespace(val));
                  }
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            _buildOverridableSettingsRow(
              context: context,
              bloc: bloc,
              label: context.t.settings.comparison.similarityThreshold,
              description:
                  '${context.t.settings.comparison.similarityThresholdDescription} (${(similarityThreshold * 100).round()}%)',
              settingKey: 'similarityThreshold',
              control: SizedBox(
                width: 200,
                child: Slider(
                  value: similarityThreshold,
                  min: 0.5,
                  max: 1.0,
                  divisions: 10,
                  label: '${(similarityThreshold * 100).round()}%',
                  onChanged: (val) {
                    if (state.isProjectScope) {
                      bloc.add(UpdateProjectOverridableSetting(
                          settingKey: 'similarityThreshold', value: val));
                    } else {
                      bloc.add(UpdateSimilarityThreshold(val));
                    }
                  },
                ),
              ),
            ),
            SettingsRow(
              label: context.t.settings.comparison.mode,
              description: context.t.settings.comparison.modeDescription,
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SettingsDropdown(
                    value: settings.comparisonMode,
                    items: SettingsConstants.comparisonModes,
                    onChanged: (val) {
                      if (val != null) {
                        bloc.add(UpdateComparisonMode(val));
                      }
                    },
                    isDark: isDark,
                    isAmoled: isAmoled,
                    itemLabelBuilder: (val) {
                      switch (val) {
                        case 'Key-based':
                          return context.t.settings.comparison.modeKey;
                        case 'Order-based':
                          return context.t.settings.comparison.modeOrder;
                        case 'Smart Match':
                          return context.t.settings.comparison.modeSmart;
                        default:
                          return val;
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    richMessage: TextSpan(
                      children: [
                        TextSpan(
                            text: '${context.t.settings.comparison.modeKey}: ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '${context.t.settings.comparison.modeKeyDescription}\n\n'),
                        TextSpan(
                            text:
                                '${context.t.settings.comparison.modeOrder}: ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '${context.t.settings.comparison.modeOrderDescription}\n\n'),
                        TextSpan(
                            text:
                                '${context.t.settings.comparison.modeSmart}: ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: context
                                .t.settings.comparison.modeSmartDescription),
                      ],
                    ),
                    child: Icon(
                      LucideIcons.info,
                      size: 18,
                      color: theme.textMutedColor,
                    ),
                  ),
                ],
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: context.t.settings.comparison.ignorePatterns,
          isDark: isDark,
          isAmoled: isAmoled,
          trailing: state.isProjectScope
              ? SettingOverrideIndicator(
                  isOverridden: state.isOverridden('ignorePatterns'),
                  onReset: state.isOverridden('ignorePatterns')
                      ? () =>
                          bloc.add(const ResetSettingToGlobal('ignorePatterns'))
                      : null,
                  compact: true,
                )
              : null,
          children: [
            if (ignorePatterns.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.t.settings.comparison.noIgnorePatterns,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: theme.textMutedColor,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              )
            else
              ...ignorePatterns.map(
                (pattern) =>
                    _buildPatternItem(context, pattern, ignorePatterns),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildPatternPresets(context, ignorePatterns),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                key: const Key('settings_addPattern_button'),
                onPressed: onShowAddPatternDialog,
                icon: const Icon(LucideIcons.plus, size: 18),
                label: Text(context.t.settings.comparison.addPattern),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40)),
              ),
            ),
          ],
        ),
        if (showLivePreview)
          LiveLogicPreviewCard(
            settings: settings,
            isDark: isDark,
            isAmoled: isAmoled,
          ),
      ],
    );
  }

  Widget _buildPatternItem(
    BuildContext context,
    String pattern,
    List<String> currentPatterns,
  ) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);
    final bloc = context.read<SettingsBloc>();

    return Padding(
      key: Key('ignorePattern_tile_$pattern'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            LucideIcons.code,
            size: 16,
            color: theme.textMutedColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              pattern,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ),
          IconButton(
            key: Key('ignorePattern_delete_$pattern'),
            icon: Icon(LucideIcons.trash2,
                size: 18,
                color: AppThemeV2.error,
                semanticLabel: '${context.t.common.delete} $pattern'),
            onPressed: () {
              if (state.isProjectScope) {
                final newPatterns = List<String>.from(currentPatterns)
                  ..remove(pattern);
                bloc.add(UpdateProjectOverridableSetting(
                    settingKey: 'ignorePatterns', value: newPatterns));
              } else {
                bloc.add(RemoveIgnorePattern(pattern));
              }
            },
            tooltip: context.t.common.remove,
          ),
        ],
      ),
    );
  }

  Widget _buildPatternPresets(
      BuildContext context, List<String> currentPatterns) {
    final bloc = context.read<SettingsBloc>();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SettingsConstants.patternPresets.entries
          .map(
            (entry) => OutlinedButton.icon(
              icon: Icon(LucideIcons.plus,
                  size: 16,
                  semanticLabel: context.t.settings.comparison.addPattern),
              label: Text(_getPatternPresetLabel(context, entry.key)),
              onPressed: () {
                if (state.isProjectScope) {
                  final newPatterns = List<String>.from(currentPatterns);
                  for (final pattern in entry.value) {
                    if (!newPatterns.contains(pattern)) {
                      newPatterns.add(pattern);
                    }
                  }
                  bloc.add(UpdateProjectOverridableSetting(
                      settingKey: 'ignorePatterns', value: newPatterns));
                } else {
                  for (final pattern in entry.value) {
                    bloc.add(AddIgnorePattern(pattern));
                  }
                }
              },
            ),
          )
          .toList(),
    );
  }

  String _getPatternPresetLabel(BuildContext context, String key) {
    switch (key) {
      case 'Comments':
        return context.t.settings.comparison.patternPresets.comments;
      case 'Temp Keys':
        return context.t.settings.comparison.patternPresets.tempKeys;
      case 'Placeholders':
        return context.t.settings.comparison.patternPresets.placeholders;
      case 'Dev Only':
        return context.t.settings.comparison.patternPresets.devOnly;
      default:
        return key;
    }
  }

  /// Builds a settings row that shows an override indicator when in project scope.
  Widget _buildOverridableSettingsRow({
    required BuildContext context,
    required SettingsBloc bloc,
    required String label,
    required String description,
    required String settingKey,
    required Widget control,
    bool showDivider = true,
  }) {
    final isProjectScope = state.isProjectScope;
    final isOverridden = state.isOverridden(settingKey);

    return SettingsRow(
      label: label,
      description: description,
      control: control,
      isDark: isDark,
      isAmoled: isAmoled,
      showDivider: showDivider,
      trailing: isProjectScope
          ? SettingOverrideIndicator(
              isOverridden: isOverridden,
              onReset: isOverridden
                  ? () => bloc.add(ResetSettingToGlobal(settingKey))
                  : null,
              compact: true,
            )
          : null,
    );
  }

  /// Builds a reset button for the section that appears when in project scope
  /// and there are any overrides in the Comparison category.
  Widget? _buildSectionResetButton(BuildContext context, SettingsBloc bloc) {
    if (!state.isProjectScope) return null;

    // Check if any comparison settings are overridden
    final hasOverrides = state.isOverridden('ignoreCase') ||
        state.isOverridden('ignoreWhitespace') ||
        state.isOverridden('similarityThreshold');

    if (!hasOverrides) return null;

    return Tooltip(
      message: context.t.settings.comparison.resetToGlobal,
      child: IconButton(
        icon: Icon(
          LucideIcons.refreshCcw,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        onPressed: () {
          bloc.add(const ResetCategoryToGlobal('comparison'));
        },
      ),
    );
  }
}
