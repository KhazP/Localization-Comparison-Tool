import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/app_command_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/presentation/widgets/settings/developer/storage_inspector_section.dart';
import 'package:localizer_app_main/presentation/widgets/settings/developer/device_info_section.dart';
import 'package:localizer_app_main/presentation/widgets/settings/developer/theme_playground_section.dart';
import 'package:localizer_app_main/presentation/widgets/settings/developer/localization_inspector_section.dart';

class DeveloperSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const DeveloperSettingsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsCardContainer(
      title: 'Developer Options',
      isDark: isDark,
      isAmoled: isAmoled,
      headerIcon: LucideIcons.code,
      children: [
        _SectionHeader(title: 'Debugging Tools', isDark: isDark),
        SettingsRow(
          label: 'Performance Overlay',
          description: 'Show Flutter performance overlay',
          control: Switch(
            value: settings.showPerformanceOverlay,
            onChanged: (value) => context
                .read<SettingsBloc>()
                .add(UpdateShowPerformanceOverlay(value)),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          isDark: isDark,
          isAmoled: isAmoled,
        ),
        SettingsRow(
          label: 'Semantics Debugger',
          description: 'Visualize semantics tree',
          control: Switch(
            value: settings.showSemanticsDebugger,
            onChanged: (value) => context
                .read<SettingsBloc>()
                .add(UpdateShowSemanticsDebugger(value)),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          isDark: isDark,
          isAmoled: isAmoled,
        ),
        SettingsRow(
          label: 'Material Grid',
          description: 'Overlay material layout grid',
          control: Switch(
            value: settings.debugShowMaterialGrid,
            onChanged: (value) => context
                .read<SettingsBloc>()
                .add(UpdateDebugShowMaterialGrid(value)),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          isDark: isDark,
          isAmoled: isAmoled,
        ),
        SettingsRow(
          label: 'Raster Cache Images',
          description: 'Checkerboard raster cache images',
          control: Switch(
            value: settings.checkerboardRasterCacheImages,
            onChanged: (value) => context
                .read<SettingsBloc>()
                .add(UpdateCheckerboardRasterCacheImages(value)),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          isDark: isDark,
          isAmoled: isAmoled,
          showDivider: false,
        ),
        const SizedBox(height: 20),
        _SectionHeader(title: 'Actions', isDark: isDark),
        _ActionRow(
          label: 'Show App Logs',
          description: 'Open Talker debug console',
          icon: LucideIcons.fileText,
          isDark: isDark,
          isAmoled: isAmoled,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    TalkerScreen(talker: sl<TalkerService>().talker),
              ),
            );
          },
        ),
        _ActionRow(
          label: 'Restart Onboarding Tutorial',
          description: 'Reset flags and launch tutorial again',
          icon: LucideIcons.playCircle,
          isDark: isDark,
          isAmoled: isAmoled,
          onPressed: () {
            context
                .read<SettingsBloc>()
                .add(const UpdateIsOnboardingCompleted(false));
            context.read<SettingsBloc>().add(const UpdateOnboardingStep(0));
            sl<AppCommandService>()
                .emit(const AppCommand(AppCommandType.restartTutorial));
            ToastService.showInfo(
              context,
              'Tutorial restart requested.',
            );
          },
        ),
        _ActionRow(
          label: 'Throw Test Exception',
          description: 'Trigger a test exception for crash reporting',
          icon: LucideIcons.bug,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () {
            throw Exception(
              'Test Exception triggered from Developer Options',
            );
          },
        ),
        _ActionRow(
          label: 'Clear Translation Memory',
          description: 'Delete all cached translations',
          icon: LucideIcons.database,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () async {
            final confirmed = await _showConfirmationDialog(
              context,
              'Clear Translation Memory?',
              'This will delete all learned translations. This cannot be undone.',
            );
            if (confirmed) {
              await sl<TranslationMemoryService>().clearMemory();
              if (context.mounted) {
                ToastService.showSuccess(context, 'Translation memory cleared');
              }
            }
          },
        ),
        _ActionRow(
          label: 'Clear API Keys',
          description: 'Remove all stored API keys',
          icon: LucideIcons.key,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () async {
            final confirmed = await _showConfirmationDialog(
              context,
              'Clear API Keys?',
              'This will remove all API keys from secure storage.',
            );
            if (confirmed) {
              await sl<SecureStorageService>().clearAllKeys();
              if (context.mounted) {
                // Reload settings to reflect change (keys cleared)
                context.read<SettingsBloc>().add(LoadSettings());
                ToastService.showSuccess(context, 'API keys cleared');
              }
            }
          },
        ),
        _ActionRow(
          label: 'Hide Developer Options',
          description: 'Disable developer mode (requires 7 taps to re-enable)',
          icon: LucideIcons.eyeOff,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () {
            context
                .read<SettingsBloc>()
                .add(const UpdateShowDeveloperOptions(false));
            ToastService.showInfo(context, 'Developer options disabled');
          },
          showDivider: false,
        ),
        const SizedBox(height: 20),
        _SectionHeader(title: 'Danger Zone', isDark: isDark),
        _ActionRow(
          label: 'Factory Reset',
          description: 'Reset all settings and clear data',
          icon: LucideIcons.trash2,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () {
            _showFactoryResetDialog(context);
          },
          showDivider: false,
        ),
        const SizedBox(height: 20),
        _SectionHeader(title: 'Inspection Tools', isDark: isDark),
        StorageInspectorSection(isDark: isDark, isAmoled: isAmoled),
        DeviceInfoSection(isDark: isDark, isAmoled: isAmoled),
        ThemePlaygroundSection(isDark: isDark, isAmoled: isAmoled),
        LocalizationInspectorSection(
          isDark: isDark,
          isAmoled: isAmoled,
          showLocalizationKeys: settings.showLocalizationKeys,
        ),
      ],
    );
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String title, String content) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppThemeV2.error,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Confirm'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showFactoryResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Factory Reset'),
        content: const Text(
          'Are you sure you want to reset all settings? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppThemeV2.error,
            ),
            onPressed: () {
              context.read<SettingsBloc>().add(ResetAllSettings());
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const _SectionHeader({
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppThemeV2.darkTextSecondary
                  : AppThemeV2.lightTextSecondary,
            ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final String label;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;
  final bool isAmoled;
  final bool isDestructive;
  final bool showDivider;

  const _ActionRow({
    required this.label,
    required this.description,
    required this.icon,
    required this.onPressed,
    required this.isDark,
    required this.isAmoled,
    this.isDestructive = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: isDestructive ? AppThemeV2.error : colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: theme.textMutedColor,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  foregroundColor:
                      isDestructive ? AppThemeV2.error : colorScheme.primary,
                ),
                onPressed: onPressed,
                child: Text(isDestructive ? 'Execute' : 'Run'),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: theme.borderColor,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
