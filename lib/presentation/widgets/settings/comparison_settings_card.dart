import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_constants.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';

/// Comparison Engine Settings card widget
class ComparisonSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;
  final VoidCallback onShowAddPatternDialog;

  const ComparisonSettingsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
    required this.onShowAddPatternDialog,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return Column(
      children: [
        SettingsCardContainer(
          title: 'Comparison Behavior',
          isDark: isDark,
          isAmoled: isAmoled,
          onReset: () {
            context.read<SettingsBloc>().add(ResetComparisonSettings());
          },
          children: [
            SettingsRow(
              label: 'Ignore Case',
              description: 'Treat "Key" and "key" as the same',
              control: Switch(
                key: const Key('settings_ignoreCase_switch'),
                value: settings.ignoreCase,
                onChanged: (val) =>
                    context.read<SettingsBloc>().add(UpdateIgnoreCase(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Ignore Whitespace',
              description: 'Ignore leading/trailing spaces',
              control: Switch(
                key: const Key('settings_ignoreWhitespace_switch'),
                value: settings.ignoreWhitespace,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateIgnoreWhitespace(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Similarity Threshold',
              description:
                  'Minimum similarity for "Modified" detection (${(settings.similarityThreshold * 100).round()}%)',
              control: SizedBox(
                width: 200,
                child: Slider(
                  value: settings.similarityThreshold,
                  min: 0.5,
                  max: 1.0,
                  divisions: 10,
                  label: '${(settings.similarityThreshold * 100).round()}%',
                  onChanged: (val) => context
                      .read<SettingsBloc>()
                      .add(UpdateSimilarityThreshold(val)),
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Comparison Mode',
              description: 'How to match entries between files',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SettingsDropdown(
                    value: settings.comparisonMode,
                    items: SettingsConstants.comparisonModes,
                    onChanged: (val) {
                      if (val != null) {
                        context
                            .read<SettingsBloc>()
                            .add(UpdateComparisonMode(val));
                      }
                    },
                    isDark: isDark,
                    isAmoled: isAmoled,
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    richMessage: const TextSpan(
                      children: [
                        TextSpan(
                            text: 'Key-based: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Matches by key name (default).\n\n'),
                        TextSpan(
                            text: 'Order-based: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Matches by position in file.\n\n'),
                        TextSpan(
                            text: 'Smart Match: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Detects moved/renamed keys.'),
                      ],
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
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
          title: 'Ignore Patterns',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            if (settings.ignorePatterns.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'No ignore patterns set.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: theme.textMutedColor,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              )
            else
              ...settings.ignorePatterns
                  .map((pattern) => _buildPatternItem(context, pattern)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildPatternPresets(context),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                key: const Key('settings_addPattern_button'),
                onPressed: onShowAddPatternDialog,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Pattern'),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPatternItem(BuildContext context, String pattern) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return Padding(
      key: Key('ignorePattern_tile_$pattern'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.code_rounded,
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
            icon: Icon(Icons.delete_outline_rounded,
                size: 18, color: AppThemeV2.error, semanticLabel: 'Delete $pattern'),
            onPressed: () =>
                context.read<SettingsBloc>().add(RemoveIgnorePattern(pattern)),
            tooltip: 'Remove pattern',
          ),
        ],
      ),
    );
  }

  Widget _buildPatternPresets(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SettingsConstants.patternPresets.entries
          .map(
            (entry) => OutlinedButton.icon(
              icon: const Icon(Icons.add, size: 16, semanticLabel: 'Add ignore pattern'),
              label: Text(entry.key),
              onPressed: () {
                for (final pattern in entry.value) {
                  context.read<SettingsBloc>().add(AddIgnorePattern(pattern));
                }
              },
            ),
          )
          .toList(),
    );
  }
}
