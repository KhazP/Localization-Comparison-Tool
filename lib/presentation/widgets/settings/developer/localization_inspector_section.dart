import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// A widget that allows toggling localization key visibility for debugging.
class LocalizationInspectorSection extends StatelessWidget {
  final bool isDark;
  final bool isAmoled;
  final bool showLocalizationKeys;

  const LocalizationInspectorSection({
    super.key,
    required this.isDark,
    required this.isAmoled,
    required this.showLocalizationKeys,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionTile(
      leading: Icon(LucideIcons.languages, color: colorScheme.primary),
      title: const Text('Localization Inspector'),
      subtitle: const Text('Debug translation strings'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Show Localization Keys',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppThemeV2.darkTextSecondary
                      : AppThemeV2.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'When enabled, all translated text will show their localization keys instead of the translated value. Useful for verifying which key is used where.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Show Keys Instead of Values'),
                subtitle: Text(
                    showLocalizationKeys ? 'Keys visible' : 'Normal display'),
                value: showLocalizationKeys,
                onChanged: (value) {
                  context
                      .read<SettingsBloc>()
                      .add(UpdateShowLocalizationKeys(value));
                },
                activeColor: colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                'Note: This feature requires app localization to use a wrapper that respects this setting.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: isDark
                          ? AppThemeV2.darkTextSecondary
                          : AppThemeV2.lightTextSecondary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
