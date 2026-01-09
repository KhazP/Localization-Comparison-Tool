import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_constants.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/core/services/project_sharing_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:file_picker/file_picker.dart';

import 'package:open_file_plus/open_file_plus.dart';

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
    final projectState = context.watch<ProjectBloc>().state;
    final isProjectLoaded = projectState.status == ProjectStatus.loaded;

    return Column(
      children: [
        if (isProjectLoaded)
          SettingsCardContainer(
            title: context.t.settings.projectSettings,
            isDark: isDark,
            isAmoled: isAmoled,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.t.projects.exportProject,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            context.t.projects.exportDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.6),
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    FilledButton.icon(
                      onPressed: () => _handleExport(context, projectState),
                      icon: const Icon(LucideIcons.package),
                      label: Text(context.t.common.export),
                    ),
                  ],
                ),
              ),
            ],
          ),
        SettingsCardContainer(
          title: context.t.settings.general.application,
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: context.t.settings.general.language,
              description: context.t.settings.general.languageDescription,
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
                itemLabelBuilder: (val) {
                  if (val == 'Auto-Detect') {
                    return context.t.settings.general.languageAuto;
                  }
                  return val;
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: context.t.settings.general.defaultView,
              description: context.t.settings.general.defaultViewDescription,
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
                itemLabelBuilder: (val) {
                  switch (val) {
                    case 'Basic Comparison':
                      return context.t.settings.general.viewBasic;
                    case 'History View':
                      return context.t.settings.general.viewHistory;
                    case 'Quality Dashboard':
                      return context.t.settings.general.viewDashboard;
                    case 'Files':
                      return context.t.settings.general.viewDirectory;
                    case 'Last Used View':
                      return context.t.settings.general.viewLastUsed;
                    default:
                      return val;
                  }
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: context.t.settings.general.autoCheckUpdates,
              description:
                  context.t.settings.general.autoCheckUpdatesDescription,
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
          title: context.t.settings.general.startupOptions,
          isDark: isDark,
          isAmoled: isAmoled,
          onReset: () {
            context.read<SettingsBloc>().add(ResetStartupOptions());
          },
          children: [
            SettingsRow(
              label: context.t.settings.general.rememberWindowPosition,
              description:
                  context.t.settings.general.rememberWindowPositionDescription,
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
              label: context.t.settings.general.openLastProject,
              description:
                  context.t.settings.general.openLastProjectDescription,
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
              label: context.t.settings.general.startMinimized,
              description: context.t.settings.general.startMinimizedDescription,
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

  Future<void> _handleExport(
      BuildContext context, ProjectState projectState) async {
    final project = projectState.currentProject;
    if (project == null) return;

    // Select destination
    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: context.t.projects.exportProject,
      fileName: '${project.name.replaceAll(' ', '_')}_export.zip',
      allowedExtensions: ['zip'],
      type: FileType.custom,
    );

    if (outputPath == null) return;

    var finalPath = outputPath;
    if (!finalPath.toLowerCase().endsWith('.zip')) {
      finalPath += '.zip';
    }

    // Get History for this project
    // We assume the history is loaded in HistoryBloc.
    // Ideally we should filter by projectId.
    final historyState = context.read<HistoryBloc>().state;
    var projectHistory =
        <dynamic>[]; // Using dynamic to avoid deep coupling, or better:
    // Actually we need the list.
    if (historyState is HistoryLoaded) {
      projectHistory =
          historyState.history.where((s) => s.projectId == project.id).toList();
    }

    try {
      ToastService.showInfo(context, context.t.projects.exporting);

      final sharingService = ProjectSharingService();
      await sharingService.exportProject(
        project: project,
        destinationZipPath: finalPath,
        projectHistory: projectHistory as dynamic, // Dart inference helper
      );

      if (context.mounted) {
        ToastService.showSuccessWithAction(
          context,
          context.t.projects.exportSuccess,
          actionLabel: context.t.common.open,
          onAction: () => OpenFile.open(finalPath),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ToastService.showError(
            context, context.t.projects.exportError(error: e));
      }
    }
  }
}
