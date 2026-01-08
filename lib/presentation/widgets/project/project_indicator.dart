import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

import 'package:localizer_app_main/presentation/widgets/project/project_selection_dialog.dart';

/// A compact widget that shows the current project status.
///
/// Displays either:
/// - A button to create a project if none is open
/// - The current project name with options to close it
class ProjectIndicator extends StatelessWidget {
  const ProjectIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state.hasProject) {
          return _buildProjectOpen(context, state, colorScheme);
        } else {
          return _buildNoProject(context, colorScheme);
        }
      },
    );
  }

  Widget _buildNoProject(BuildContext context, ColorScheme colorScheme) {
    return Tooltip(
      message: context.t.projects.indicator.tooltipNoProject,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showNoProjectOptions(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.not_listed_location_outlined,
              size: 20,
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectOpen(
      BuildContext context, ProjectState state, ColorScheme colorScheme) {
    return Tooltip(
      message: context.t.projects.indicator.tooltipProject(
          name: state.projectName ?? context.t.historyView.project),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showProjectMenu(context, state),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.4),
              ),
            ),
            child: Icon(
              Icons.folder_special,
              size: 20,
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  void _showProjectMenu(BuildContext context, ProjectState state) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.folder_special, color: colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                state.projectName ?? context.t.historyView.project,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.currentProject != null) ...[
              _buildInfoRow(
                context,
                Icons.folder_outlined,
                context.t.projects.indicator.location,
                state.currentProject!.rootPath,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                Icons.calendar_today_outlined,
                context.t.projects.indicator.created,
                _formatDate(context, state.currentProject!.createdAt),
              ),
            ],
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _showNoProjectOptions(context);
            },
            icon: const Icon(Icons.swap_horiz, size: 18),
            label: Text(context.t.projects.indicator.switchProject),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ProjectBloc>().add(const CloseProject());
            },
            icon: const Icon(Icons.close, size: 18),
            label: Text(context.t.projects.closeProject),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.t.projects.indicator.done),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today'; // TODO: Add to translations if needed or use intl
    } else if (difference.inDays == 1) {
      return 'Yesterday'; // TODO: Add to translations if needed or use intl
    } else if (difference.inDays < 7) {
      return context.t.history.timeAgo.daysAgo(count: difference.inDays);
    } else {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  void _showNoProjectOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ProjectSelectionDialog(),
    );
  }
}
