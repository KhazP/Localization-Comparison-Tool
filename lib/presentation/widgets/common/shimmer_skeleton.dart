import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// Reusable shimmer skeleton widget using the shimmer package.
/// Wraps content in a shimmer effect for loading states.
class ShimmerSkeleton extends StatelessWidget {
  /// The child widget to apply the shimmer effect to.
  final Widget child;
  
  /// Base color for the shimmer effect.
  final Color? baseColor;
  
  /// Highlight color for the shimmer effect.
  final Color? highlightColor;
  
  /// Whether the shimmer is enabled (animating).
  final bool enabled;

  const ShimmerSkeleton({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final base = baseColor ??
        (isAmoled
            ? AppThemeV2.amoledCard
            : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard));
    final highlight = highlightColor ??
        (isAmoled
            ? AppThemeV2.amoledCardHover
            : (isDark ? AppThemeV2.darkCardHover : AppThemeV2.lightCardHover));

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      enabled: enabled,
      child: child,
    );
  }
}

/// A simple rectangular skeleton box for use inside shimmer effects.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius,
  });

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
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
    );
  }
}

/// A shimmer skeleton row for project stats loading.
class ProjectStatsSkeleton extends StatelessWidget {
  const ProjectStatsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerSkeleton(
      child: Row(
        children: [
          SkeletonBox(width: 12, height: 12, borderRadius: BorderRadius.circular(2)),
          const SizedBox(width: 4),
          SkeletonBox(width: 100, height: 14, borderRadius: BorderRadius.circular(4)),
        ],
      ),
    );
  }
}
