import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// A widget for managing feature flag overrides.
class FeatureFlagsSection extends StatelessWidget {
  final bool isDark;
  final bool isAmoled;
  final Map<String, bool> featureFlagOverrides;

  const FeatureFlagsSection({
    super.key,
    required this.isDark,
    required this.isAmoled,
    required this.featureFlagOverrides,
  });

  // Define all available feature flags
  static const List<_FeatureFlagDef> _availableFlags = [
    _FeatureFlagDef(
      key: 'experimental_ai_batch',
      name: 'Experimental AI Batch',
      description: 'Enable batch AI translation for multiple rows',
    ),
    _FeatureFlagDef(
      key: 'new_diff_algorithm',
      name: 'New Diff Algorithm',
      description: 'Use improved diffing algorithm for comparisons',
    ),
    _FeatureFlagDef(
      key: 'enhanced_search',
      name: 'Enhanced Search',
      description: 'Enable fuzzy search in translation files',
    ),
    _FeatureFlagDef(
      key: 'auto_save',
      name: 'Auto Save',
      description: 'Automatically save changes after edits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionTile(
      leading: Icon(LucideIcons.toggleRight, color: colorScheme.primary),
      title: const Text('Feature Flags'),
      subtitle: const Text('Override experimental features'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Local Overrides',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppThemeV2.darkTextSecondary
                      : AppThemeV2.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Toggle feature flags locally for testing. These overrides persist across app restarts.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              ..._availableFlags.map((flag) => _buildFlagToggle(context, flag)),
              const Divider(),
              TextButton.icon(
                icon: const Icon(LucideIcons.rotateCcw),
                label: const Text('Reset All Flags'),
                onPressed: () {
                  context
                      .read<SettingsBloc>()
                      .add(const ClearFeatureFlagOverrides());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlagToggle(BuildContext context, _FeatureFlagDef flag) {
    final currentValue = featureFlagOverrides[flag.key];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flag.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  flag.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppThemeV2.darkTextSecondary
                            : AppThemeV2.lightTextSecondary,
                      ),
                ),
              ],
            ),
          ),
          DropdownButton<bool?>(
            value: currentValue,
            hint: const Text('Default'),
            items: const [
              DropdownMenuItem(value: null, child: Text('Default')),
              DropdownMenuItem(value: true, child: Text('ON')),
              DropdownMenuItem(value: false, child: Text('OFF')),
            ],
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                    UpdateFeatureFlagOverride(flag.key, value),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureFlagDef {
  final String key;
  final String name;
  final String description;

  const _FeatureFlagDef({
    required this.key,
    required this.name,
    required this.description,
  });
}
