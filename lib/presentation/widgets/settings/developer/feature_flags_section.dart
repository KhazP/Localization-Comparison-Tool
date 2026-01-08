import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/i18n/translations.g.dart';
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

  // Define all available feature flags keys
  static const List<String> _availableFlagKeys = [
    'experimental_ai_batch',
    'new_diff_algorithm',
    'enhanced_search',
    'auto_save',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionTile(
      leading: Icon(LucideIcons.toggleRight, color: colorScheme.primary),
      title: Text(context.t.settings.developer.featureFlags.title),
      subtitle: Text(context.t.settings.developer.featureFlags.subtitle),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.settings.developer.featureFlags.overrides,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppThemeV2.darkTextSecondary
                      : AppThemeV2.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.t.settings.developer.featureFlags.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              ..._availableFlagKeys
                  .map((key) => _buildFlagToggle(context, key)),
              const Divider(),
              TextButton.icon(
                icon: const Icon(LucideIcons.rotateCcw),
                label: Text(context.t.settings.developer.featureFlags.reset),
                onPressed: null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlagToggle(BuildContext context, String flagKey) {
    final currentValue = featureFlagOverrides[flagKey];
    final flagInfo = _getFlagInfo(context, flagKey);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flagInfo.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  flagInfo.description,
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
            hint: Text(context.t.settings.developer.featureFlags.defaultVal),
            items: [
              DropdownMenuItem(
                  value: null,
                  child: Text(
                      context.t.settings.developer.featureFlags.defaultVal)),
              DropdownMenuItem(
                  value: true,
                  child: Text(context.t.settings.developer.featureFlags.on)),
              DropdownMenuItem(
                  value: false,
                  child: Text(context.t.settings.developer.featureFlags.off)),
            ],
            onChanged: null,
          ),
        ],
      ),
    );
  }

  ({String name, String description}) _getFlagInfo(
      BuildContext context, String key) {
    final flags = context.t.settings.developer.featureFlags.flags;
    switch (key) {
      case 'experimental_ai_batch':
        return (
          name: flags.experimental_ai_batch.name,
          description: flags.experimental_ai_batch.description
        );
      case 'new_diff_algorithm':
        return (
          name: flags.new_diff_algorithm.name,
          description: flags.new_diff_algorithm.description
        );
      case 'enhanced_search':
        return (
          name: flags.enhanced_search.name,
          description: flags.enhanced_search.description
        );
      case 'auto_save':
        return (
          name: flags.auto_save.name,
          description: flags.auto_save.description
        );
      default:
        return (name: key, description: '');
    }
  }
}

// Removed _FeatureFlagDef class as it is no longer used
