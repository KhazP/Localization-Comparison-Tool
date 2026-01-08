import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

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
      title: Text(context.t.settings.developer.localizationInspector),
      subtitle:
          Text(context.t.settings.developer.localizationInspectorDescription),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.settings.developer.showLocalizationKeys,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppThemeV2.darkTextSecondary
                      : AppThemeV2.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.t.settings.developer.localizationKeysDescription,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: Text(context.t.settings.developer
                    .localizationInspectorSection.showKeys),
                subtitle: Text(showLocalizationKeys
                    ? context.t.settings.developer.localizationInspectorSection
                        .keysVisible
                    : context.t.settings.developer.localizationInspectorSection
                        .normalDisplay),
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
                context.t.settings.developer.localizationInspectorSection.note,
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
