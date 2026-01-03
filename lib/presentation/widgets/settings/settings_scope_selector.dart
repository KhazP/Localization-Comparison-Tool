import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_scope.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';

/// Selector widget for switching between global and project settings scope.
///
/// Appears at the top of the Settings view when a project is open.
/// Allows users to choose whether to edit global defaults or project overrides.
class SettingsScopeSelector extends StatelessWidget {
  const SettingsScopeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) =>
          previous.scope != current.scope ||
          previous.hasProject != current.hasProject ||
          previous.currentProjectName != current.currentProjectName,
      builder: (context, state) {
        // Show prompt if no project is loaded
        if (!state.hasProject) {
          return const NoProjectScopePrompt();
        }

        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark
                ? colorScheme.surfaceContainerHighest.withOpacity(0.5)
                : colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 18,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Settings Scope',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildScopeSelector(context, state, colorScheme, isDark),
              const SizedBox(height: 8),
              _buildScopeDescription(context, state, colorScheme),
              if (state.hasProject &&
                  state.isProjectScope &&
                  (state.projectSettings?.hasOverrides ?? false)) ...[
                const SizedBox(height: 12),
                _buildResetProjectButton(context, theme, colorScheme),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildResetProjectButton(
      BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return Center(
      child: TextButton.icon(
        onPressed: () async {
          final confirm = await DialogService.showConfirmation(
            context: context,
            title: 'Reset Project Settings?',
            content:
                'This will clear all overrides for this project and revert to global defaults. This action cannot be undone.',
            confirmText: 'Reset',
            isDestructive: true,
          );

          if (confirm == true && context.mounted) {
            context.read<SettingsBloc>().add(const ResetAllProjectSettings());
          }
        },
        icon: Icon(
          Icons.restart_alt_rounded,
          size: 16,
          color: colorScheme.error,
        ),
        label: Text(
          'Reset Project to Global Defaults',
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.error,
          ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.error,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildScopeSelector(
    BuildContext context,
    SettingsState state,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.black.withOpacity(0.2)
            : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _ScopeButton(
              icon: Icons.public_rounded,
              label: 'Global Defaults',
              isSelected: state.scope == SettingsScope.global,
              onTap: () {
                context.read<SettingsBloc>().add(
                      const SwitchSettingsScope(SettingsScope.global),
                    );
              },
            ),
          ),
          Expanded(
            child: _ScopeButton(
              icon: Icons.folder_rounded,
              label: state.currentProjectName ?? 'Project',
              isSelected: state.scope == SettingsScope.project,
              onTap: () {
                context.read<SettingsBloc>().add(
                      const SwitchSettingsScope(SettingsScope.project),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScopeDescription(
    BuildContext context,
    SettingsState state,
    ColorScheme colorScheme,
  ) {
    final isProjectScope = state.scope == SettingsScope.project;
    final description = isProjectScope
        ? 'Changes apply only to "${state.currentProjectName}". Other settings inherit from global defaults.'
        : 'Changes apply to all projects unless overridden.';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 14,
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScopeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ScopeButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onSurface.withOpacity(0.7),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface.withOpacity(0.7),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows a disabled scope selector with a prompt to create a project.
class NoProjectScopePrompt extends StatelessWidget {
  const NoProjectScopePrompt({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surfaceContainerHighest.withOpacity(0.3)
            : colorScheme.surfaceContainerLow.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.15),
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Create a project to customize settings for specific folders',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
