import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';

/// Animated icon widget for empty states with floating/pulsing animation.
/// Uses the theme's primary (accent) color for the gradient.
class AnimatedEmptyStateIcon extends StatefulWidget {
  final IconData icon;
  final double size;

  const AnimatedEmptyStateIcon({
    super.key,
    required this.icon,
    this.size = 48,
  });

  @override
  State<AnimatedEmptyStateIcon> createState() => _AnimatedEmptyStateIconState();
}

class _AnimatedEmptyStateIconState extends State<AnimatedEmptyStateIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatAnimation;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    // Smooth floating up and down
    _floatAnimation = Tween<double>(begin: 0, end: -12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // Pulsing background glow
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // Very subtle rotation for more "life"
    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing background glow
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(
                            alpha: 0.2 * (2 - _pulseAnimation.value)),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
              // Floating and rotating icon
              Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Icon(
                    widget.icon,
                    size: widget.size,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Container widget for consistent empty state layout.
class EmptyStateContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Widget>? chips;
  final Widget? bottomSection;

  const EmptyStateContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.chips,
    this.bottomSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Icon with gradient background
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: AnimatedEmptyStateIcon(icon: icon),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textSecondary,
                  height: 1.5,
                ),
              ),
              if (chips != null && chips!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: chips!,
                ),
              ],
              if (bottomSection != null) ...[
                const SizedBox(height: 32),
                bottomSection!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Builds context info chips for empty states.
class ContextChip extends StatelessWidget {
  final String label;
  final String? tooltip;

  const ContextChip({
    super.key,
    required this.label,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.primary,
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        preferBelow: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.help,
          child: chip,
        ),
      );
    }

    return chip;
  }
}

/// Recent comparisons list widget filtered by comparison type.
class RecentComparisonsList extends StatelessWidget {
  final ComparisonType filterType;
  final void Function(ComparisonSession session) onTap;
  final int maxItems;

  const RecentComparisonsList({
    super.key,
    required this.filterType,
    required this.onTap,
    this.maxItems = 5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, historyState) {
        if (historyState is HistoryLoaded) {
          final filteredHistory = historyState.history
              .where((s) => s.type == filterType)
              .take(maxItems)
              .toList();

          if (filteredHistory.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: theme.dividerColor.withValues(alpha: 0.5)),
              const SizedBox(height: 12),
              Text(
                'Recent Comparisons',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...filteredHistory.map((session) => _buildItem(
                    context,
                    session,
                    theme,
                    textSecondary,
                  )),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildItem(
    BuildContext context,
    ComparisonSession session,
    ThemeData theme,
    Color textSecondary,
  ) {
    final title = _getTitle(session);
    final subtitle = _timeAgo(session.timestamp);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        _getIcon(),
        color: theme.colorScheme.primary.withValues(alpha: 0.7),
      ),
      title: Text(
        title,
        style:
            theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(color: textSecondary),
      ),
      onTap: () => onTap(session),
    );
  }

  String _getTitle(ComparisonSession session) {
    switch (filterType) {
      case ComparisonType.git:
        final repoName =
            session.gitRepoPath?.split(Platform.pathSeparator).last ??
                'Unknown';
        if (session.gitBranch1 != null && session.gitBranch2 != null) {
          return '$repoName: ${session.gitBranch1} → ${session.gitBranch2}';
        }
        return repoName;
      case ComparisonType.directory:
        final source = session.file1Path.split(Platform.pathSeparator).last;
        final target = session.file2Path.split(Platform.pathSeparator).last;
        return '$source ↔ $target';
      case ComparisonType.file:
        final source = session.file1Path.split(Platform.pathSeparator).last;
        final target = session.file2Path.split(Platform.pathSeparator).last;
        final isBilingual = session.file1Path == session.file2Path;
        return isBilingual ? 'Bilingual: $source' : '$source ↔ $target';
    }
  }

  IconData _getIcon() {
    switch (filterType) {
      case ComparisonType.git:
        return LucideIcons.gitBranch;
      case ComparisonType.directory:
        return LucideIcons.folders;
      case ComparisonType.file:
        return LucideIcons.clock;
    }
  }

  String _timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
