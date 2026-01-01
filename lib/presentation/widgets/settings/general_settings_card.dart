import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_constants.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';

/// General Settings card widget
class GeneralSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const GeneralSettingsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsCardContainer(
          title: 'Application',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Language',
              description: 'Application interface language',
              control: SettingsDropdown(
                value: settings.appLanguage,
                items: SettingsConstants.appLanguages,
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateAppLanguage(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Default View',
              description: 'View to show on startup',
              control: SettingsDropdown(
                value: settings.defaultViewOnStartup,
                items: SettingsConstants.defaultViews,
                onChanged: (val) {
                  if (val != null) {
                    context
                        .read<SettingsBloc>()
                        .add(UpdateDefaultViewOnStartup(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Auto-Check Updates',
              description: 'Check for updates on startup',
              control: Switch(
                value: settings.autoCheckForUpdates,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateAutoCheckForUpdates(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Startup Options',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Remember Window Position',
              description: 'Restore window size and position on startup',
              control: Switch(
                value: settings.rememberWindowPosition,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateRememberWindowPosition(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Open Last Project',
              description: 'Automatically load the last comparison on startup',
              control: Switch(
                value: settings.openLastProjectOnStartup,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateOpenLastProjectOnStartup(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Start Minimized to Tray',
              description: 'Minimize window to system tray on startup',
              control: Switch(
                value: settings.startMinimizedToTray,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateStartMinimizedToTray(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
      ],
    );
  }
}
