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
import 'package:localizer_app_main/i18n/strings.g.dart';
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
      title: context.t.settings.developer.title,
      isDark: isDark,
      isAmoled: isAmoled,
      headerIcon: LucideIcons.code,
      children: [
        _SectionHeader(
            title: context.t.settings.developer.debuggingTools, isDark: isDark),
        SettingsRow(
          label: context.t.settings.developer.showPerformanceOverlay,
          description:
              context.t.settings.developer.performanceOverlayDescription,
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
          label: context.t.settings.developer.semanticsDebugger,
          description:
              context.t.settings.developer.semanticsDebuggerDescription,
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
          label: context.t.settings.developer.materialGrid,
          description: context.t.settings.developer.materialGridDescription,
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
          label: context.t.settings.developer.rasterCache,
          description: context.t.settings.developer.rasterCacheDescription,
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
        _SectionHeader(
            title: context.t.settings.developer.actions, isDark: isDark),
        _ActionRow(
          label: context.t.settings.developer.showLogs,
          description: context.t.settings.developer.showLogsDescription,
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
          label: context.t.settings.developer.restartTutorial,
          description: context.t.settings.developer.restartTutorialDescription,
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
              context.t.settings.developer.restartRequested,
            );
          },
        ),
        _ActionRow(
          label: context.t.settings.developer.throwException,
          description: context.t.settings.developer.throwExceptionDescription,
          icon: LucideIcons.bug,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () {
            throw Exception(
              context.t.settings.developer.testExceptionMessage,
            );
          },
        ),
        _ActionRow(
          label: context.t.settings.developer.clearTM,
          description: context.t.settings.developer.clearTMDescription,
          icon: LucideIcons.database,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () async {
            final confirmed = await _showConfirmationDialog(
              context,
              context.t.settings.developer.clearTMConfirmation,
              context.t.settings.developer.clearTMWarning,
            );
            if (confirmed) {
              await sl<TranslationMemoryService>().clearMemory();
              if (context.mounted) {
                ToastService.showSuccess(
                    context, context.t.settings.developer.tmCleared);
              }
            }
          },
        ),
        _ActionRow(
          label: context.t.settings.developer.clearApiKeys,
          description: context.t.settings.developer.clearApiKeysDescription,
          icon: LucideIcons.key,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () async {
            final confirmed = await _showConfirmationDialog(
              context,
              context.t.settings.developer.clearApiKeysConfirmation,
              context.t.settings.developer.clearApiKeysWarning,
            );
            if (confirmed) {
              await sl<SecureStorageService>().clearAllKeys();
              if (context.mounted) {
                // Reload settings to reflect change (keys cleared)
                context.read<SettingsBloc>().add(LoadSettings());
                ToastService.showSuccess(
                    context, context.t.settings.developer.apiKeysCleared);
              }
            }
          },
        ),
        _ActionRow(
          label: context.t.settings.developer.hideOptions,
          description: context.t.settings.developer.hideOptionsDescription,
          icon: LucideIcons.eyeOff,
          isDark: isDark,
          isAmoled: isAmoled,
          isDestructive: true,
          onPressed: () {
            context
                .read<SettingsBloc>()
                .add(const UpdateShowDeveloperOptions(false));
            ToastService.showInfo(
                context, context.t.settings.developer.optionsDisabled);
          },
          showDivider: false,
        ),
        const SizedBox(height: 20),
        _SectionHeader(
            title: context.t.settings.developer.dangerZone, isDark: isDark),
        _ActionRow(
          label: context.t.settings.developer.factoryReset,
          description: context.t.settings.developer.factoryResetDescription,
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
        _SectionHeader(
            title: context.t.settings.developer.inspectionTools,
            isDark: isDark),
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
                child: Text(context.t.common.cancel),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppThemeV2.error,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(context.t.common.confirm),
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
        title: Text(context.t.settings.developer.factoryReset),
        content: Text(
          context.t.settings.developer.factoryResetWarning,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.t.common.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppThemeV2.error,
            ),
            onPressed: () {
              context.read<SettingsBloc>().add(ResetAllSettings());
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.t.common.reset),
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
                child: Text(isDestructive
                    ? context.t.common.execute
                    : context.t.common.run),
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
