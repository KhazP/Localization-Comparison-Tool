import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// A dismissable warning banner shown when a project uses AI settings
/// that are currently unavailable (e.g., no API key configured).
class ProjectConflictBanner extends StatefulWidget {
  const ProjectConflictBanner({super.key});

  @override
  State<ProjectConflictBanner> createState() => _ProjectConflictBannerState();
}

class _ProjectConflictBannerState extends State<ProjectConflictBanner> {
  final Set<String> _dismissedConflicts = {};

  @override
  Widget build(BuildContext context) {
    final projectState = context.watch<ProjectBloc>().state;
    final settingsState = context.watch<SettingsBloc>().state;

    // Only show when a project is loaded
    if (projectState.status != ProjectStatus.loaded ||
        settingsState.status != SettingsStatus.loaded) {
      return const SizedBox.shrink();
    }

    final project = projectState.currentProject;
    if (project == null) return const SizedBox.shrink();

    final projectSettings = project.settings;
    final globalSettings = settingsState.appSettings;

    // Check for conflicts
    final conflicts = <_ConflictInfo>[];

    // Check if project uses a specific AI service but the API key is missing
    final projectService = projectSettings.aiTranslationService;
    if (projectService != null) {
      final serviceKey = _getRequiredApiKeyForService(projectService);
      if (serviceKey != null && !_hasApiKey(globalSettings, serviceKey)) {
        final conflictId = 'ai_service_$projectService';
        if (!_dismissedConflicts.contains(conflictId)) {
          conflicts.add(_ConflictInfo(
            id: conflictId,
            title: 'Missing API key for $projectService',
            message:
                'This project uses $projectService but no API key is configured. '
                'Add your API key in Settings > AI Services, or the app will use the global default.',
            icon: Icons.key_off_rounded,
          ));
        }
      }
    }

    // Check if project uses a specific AI model but the provider isn't configured
    final projectModel = projectSettings.defaultAiModel;
    if (projectModel != null && projectService == null) {
      final conflictId = 'ai_model_$projectModel';
      if (!_dismissedConflicts.contains(conflictId)) {
        // Model specified but service will inherit from global
        // This is usually fine, so skip this warning
      }
    }

    if (conflicts.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
          conflicts.map((conflict) => _buildBanner(context, conflict)).toList(),
    );
  }

  Widget _buildBanner(BuildContext context, _ConflictInfo conflict) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // AMOLED detection
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final backgroundColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark
            ? Colors.orange.shade900.withAlpha(60)
            : Colors.orange.shade50);
    final borderColor =
        isDark ? Colors.orange.shade700 : Colors.orange.shade200;
    final iconColor = isDark ? Colors.orange.shade300 : Colors.orange.shade700;
    final textColor = isDark ? Colors.orange.shade200 : Colors.orange.shade900;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(conflict.icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conflict.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  conflict.message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: textColor.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _dismissedConflicts.add(conflict.id);
              });
            },
            icon: Icon(Icons.close_rounded, size: 18, color: textColor),
            tooltip: 'Dismiss',
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  /// Gets the API key field name required for a specific AI service.
  String? _getRequiredApiKeyForService(String service) {
    final serviceLower = service.toLowerCase();
    if (serviceLower.contains('openai') || serviceLower.contains('gpt')) {
      return 'openaiApiKey';
    }
    if (serviceLower.contains('google') || serviceLower.contains('gemini')) {
      return 'googleApiKey';
    }
    if (serviceLower.contains('anthropic') || serviceLower.contains('claude')) {
      return 'anthropicApiKey';
    }
    if (serviceLower.contains('deepl')) {
      return 'deeplApiKey';
    }
    if (serviceLower.contains('azure')) {
      return 'azureApiKey';
    }
    return null;
  }

  /// Checks if a specific API key is configured.
  bool _hasApiKey(dynamic settings, String keyName) {
    // The app settings should have these fields
    try {
      switch (keyName) {
        case 'openaiApiKey':
          return (settings.openaiApiKey as String?)?.isNotEmpty == true;
        case 'googleApiKey':
          return (settings.googleApiKey as String?)?.isNotEmpty == true;
        case 'anthropicApiKey':
          return (settings.anthropicApiKey as String?)?.isNotEmpty == true;
        case 'deeplApiKey':
          return (settings.deeplApiKey as String?)?.isNotEmpty == true;
        case 'azureApiKey':
          return (settings.azureApiKey as String?)?.isNotEmpty == true;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }
}

class _ConflictInfo {
  final String id;
  final String title;
  final String message;
  final IconData icon;

  const _ConflictInfo({
    required this.id,
    required this.title,
    required this.message,
    required this.icon,
  });
}
