import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';

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
      message: 'Create a project to save custom settings for a folder',
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

  Widget _buildProjectOpen(BuildContext context, ProjectState state, ColorScheme colorScheme) {
    return Tooltip(
      message: 'Project: ${state.projectName}\nClick to see options',
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
                state.projectName ?? 'Project',
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
                'Location',
                state.currentProject!.rootPath,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                Icons.calendar_today_outlined,
                'Created',
                _formatDate(state.currentProject!.createdAt),
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
            label: const Text('Switch Project'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ProjectBloc>().add(const CloseProject());
            },
            icon: const Icon(Icons.close, size: 18),
            label: const Text('Close Project'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
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
