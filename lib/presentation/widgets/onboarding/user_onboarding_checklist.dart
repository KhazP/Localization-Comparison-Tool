import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

/// Onboarding step definitions
enum OnboardingStep {
  importFiles(LucideIcons.upload),
  runComparison(LucideIcons.play),
  reviewMissing(LucideIcons.alertTriangle),
  useFilters(LucideIcons.filter),
  searchResults(LucideIcons.search),
  advancedView(LucideIcons.maximize),
  editCell(LucideIcons.edit3),
  exportResults(LucideIcons.download);

  final IconData icon;

  const OnboardingStep(this.icon);

  static OnboardingStep? fromIndex(int index) {
    if (index < 0 || index >= OnboardingStep.values.length) return null;
    return OnboardingStep.values[index];
  }

  String getTitle(BuildContext context) {
    switch (this) {
      case OnboardingStep.importFiles:
        return context.t.onboarding.steps.importFiles.title;
      case OnboardingStep.runComparison:
        return context.t.onboarding.steps.runComparison.title;
      case OnboardingStep.reviewMissing:
        return context.t.onboarding.steps.reviewMissing.title;
      case OnboardingStep.useFilters:
        return context.t.onboarding.steps.useFilters.title;
      case OnboardingStep.searchResults:
        return context.t.onboarding.steps.searchResults.title;
      case OnboardingStep.advancedView:
        return context.t.onboarding.steps.advancedView.title;
      case OnboardingStep.editCell:
        return context.t.onboarding.steps.editCell.title;
      case OnboardingStep.exportResults:
        return context.t.onboarding.steps.exportResults.title;
    }
  }

  String getDescription(BuildContext context) {
    switch (this) {
      case OnboardingStep.importFiles:
        return context.t.onboarding.steps.importFiles.description;
      case OnboardingStep.runComparison:
        return context.t.onboarding.steps.runComparison.description;
      case OnboardingStep.reviewMissing:
        return context.t.onboarding.steps.reviewMissing.description;
      case OnboardingStep.useFilters:
        return context.t.onboarding.steps.useFilters.description;
      case OnboardingStep.searchResults:
        return context.t.onboarding.steps.searchResults.description;
      case OnboardingStep.advancedView:
        return context.t.onboarding.steps.advancedView.description;
      case OnboardingStep.editCell:
        return context.t.onboarding.steps.editCell.description;
      case OnboardingStep.exportResults:
        return context.t.onboarding.steps.exportResults.description;
    }
  }
}

class UserOnboardingChecklist extends StatelessWidget {
  final VoidCallback onLoadSampleData;

  const UserOnboardingChecklist({
    super.key,
    required this.onLoadSampleData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state.status != SettingsStatus.loaded)
          return const SizedBox.shrink();
        final settings = state.appSettings;
        if (settings.isOnboardingCompleted) return const SizedBox.shrink();

        final currentStep = settings.onboardingStep;
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Positioned(
          bottom: 24,
          right: 24,
          child: Material(
            elevation: 12,
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 300,
              constraints: const BoxConstraints(maxHeight: 420),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        Icon(LucideIcons.rocket,
                            color: theme.colorScheme.primary, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.t.onboarding.gettingStarted,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                context.t.onboarding.stepProgress(
                                    current: currentStep + 1,
                                    total: OnboardingStep.values.length),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(LucideIcons.x,
                              size: 18,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5)),
                          onPressed: () {
                            context
                                .read<SettingsBloc>()
                                .add(const UpdateIsOnboardingCompleted(true));
                          },
                          tooltip: context.t.onboarding.skipTutorial,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(minWidth: 32, minHeight: 32),
                        ),
                      ],
                    ),
                  ),
                  // Progress bar
                  LinearProgressIndicator(
                    value: (currentStep + 1) / OnboardingStep.values.length,
                    backgroundColor:
                        theme.colorScheme.primary.withValues(alpha: 0.1),
                    valueColor:
                        AlwaysStoppedAnimation(theme.colorScheme.primary),
                    minHeight: 3,
                  ),
                  // Steps list
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: OnboardingStep.values.map((step) {
                          return _buildStep(
                            context,
                            step: step,
                            currentIndex: currentStep,
                            onLoadSampleData: step == OnboardingStep.importFiles
                                ? onLoadSampleData
                                : null,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required OnboardingStep step,
    required int currentIndex,
    VoidCallback? onLoadSampleData,
  }) {
    final isCompleted = step.index < currentIndex;
    final isCurrent = step.index == currentIndex;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isCurrent
            ? theme.colorScheme.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isCurrent
            ? Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        children: [
          // Step indicator
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? theme.colorScheme.primary
                  : isCurrent
                      ? theme.colorScheme.primaryContainer
                      : theme.disabledColor.withValues(alpha: 0.15),
              border: isCurrent
                  ? Border.all(color: theme.colorScheme.primary, width: 2)
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? Icon(LucideIcons.check,
                      size: 14, color: theme.colorScheme.onPrimary)
                  : Icon(step.icon,
                      size: 14,
                      color: isCurrent
                          ? theme.colorScheme.primary
                          : theme.disabledColor),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.getTitle(context),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                    color: isCompleted || isCurrent
                        ? theme.colorScheme.onSurface
                        : theme.disabledColor,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (isCurrent) ...[
                  const SizedBox(height: 2),
                  Text(
                    step.getDescription(context),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  if (onLoadSampleData != null) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 28,
                      child: TextButton.icon(
                        onPressed: onLoadSampleData,
                        icon: const Icon(LucideIcons.downloadCloud, size: 14),
                        label: Text(context.t.onboarding.loadSampleData,
                            style: const TextStyle(fontSize: 12)),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
