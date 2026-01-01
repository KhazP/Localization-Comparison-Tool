import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// Reusable shimmer skeleton loader for loading states
class ShimmerSkeleton extends StatefulWidget {
  final Widget child;

  const ShimmerSkeleton({super.key, required this.child});

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final baseColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final shimmerColor = isAmoled
        ? AppThemeV2.amoledCardHover
        : (isDark ? AppThemeV2.darkCardHover : AppThemeV2.lightCardHover);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                baseColor,
                shimmerColor,
                baseColor,
              ],
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

/// Skeleton placeholder for a history card
class HistoryCardSkeleton extends StatelessWidget {
  const HistoryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final cardColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final borderColor = isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);

    return ShimmerSkeleton(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: date and file type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SkeletonBox(width: 120, height: 14),
                const _SkeletonBox(width: 50, height: 20),
              ],
            ),
            const SizedBox(height: 12),
            // File path placeholder
            const _SkeletonBox(width: double.infinity, height: 16),
            const SizedBox(height: 8),
            const _SkeletonBox(width: 200, height: 16),
            const SizedBox(height: 12),
            // Stats row
            Row(
              children: [
                const _SkeletonBox(width: 40, height: 24),
                const SizedBox(width: 8),
                const _SkeletonBox(width: 40, height: 24),
                const SizedBox(width: 8),
                const _SkeletonBox(width: 40, height: 24),
                const Spacer(),
                const _SkeletonBox(width: 80, height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton placeholder for a settings section
class SettingsSectionSkeleton extends StatelessWidget {
  const SettingsSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final cardColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final borderColor = isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);

    return ShimmerSkeleton(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            const _SkeletonBox(width: 150, height: 18),
            const SizedBox(height: 16),
            // Toggle row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SkeletonBox(width: 180, height: 14),
                const _SkeletonBox(width: 50, height: 30),
              ],
            ),
            const SizedBox(height: 12),
            // Toggle row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SkeletonBox(width: 220, height: 14),
                const _SkeletonBox(width: 50, height: 30),
              ],
            ),
            const SizedBox(height: 12),
            // Input field
            const _SkeletonBox(width: double.infinity, height: 44),
          ],
        ),
      ),
    );
  }
}

/// Internal skeleton box placeholder
class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonBox({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark
        ? AppThemeV2.darkBorder.withAlpha(100)
        : AppThemeV2.lightBorder.withAlpha(150);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

/// Creates a list of skeleton history cards
class HistorySkeletonList extends StatelessWidget {
  final int itemCount;

  const HistorySkeletonList({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const HistoryCardSkeleton(),
    );
  }
}

/// Creates a list of skeleton settings sections
class SettingsSkeletonList extends StatelessWidget {
  final int itemCount;

  const SettingsSkeletonList({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const SettingsSectionSkeleton(),
    );
  }
}
