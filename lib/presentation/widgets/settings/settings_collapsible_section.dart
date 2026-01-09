import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// A collapsible section widget for grouping dense settings
/// Uses smooth animations and themed styling
class SettingsCollapsibleSection extends StatefulWidget {
  final String title;
  final IconData? icon;
  final List<Widget> children;
  final bool initiallyExpanded;
  final bool isDark;
  final bool isAmoled;
  final String? subtitle;
  final Widget? trailing;
  final Color? iconColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool showBorder;

  const SettingsCollapsibleSection({
    super.key,
    required this.title,
    required this.children,
    this.icon,
    this.initiallyExpanded = false,
    this.isDark = true,
    this.isAmoled = false,
    this.subtitle,
    this.trailing,
    this.iconColor,
    this.contentPadding,
    this.showBorder = true,
  });

  @override
  State<SettingsCollapsibleSection> createState() =>
      _SettingsCollapsibleSectionState();
}

class _SettingsCollapsibleSectionState extends State<SettingsCollapsibleSection>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOut);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _heightFactor = _controller.drive(_easeInTween);

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Color get _borderColor {
    if (widget.isAmoled) return AppThemeV2.amoledBorder;
    return widget.isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder;
  }

  Color get _surfaceColor {
    if (widget.isAmoled) return AppThemeV2.amoledSurface;
    return widget.isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface;
  }

  Color get _textMuted {
    return widget.isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final headerContent = InkWell(
      onTap: _handleTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            if (widget.icon != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      (widget.iconColor ?? colorScheme.primary).withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  size: 18,
                  color: widget.iconColor ?? colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _isExpanded ? colorScheme.primary : null,
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (widget.trailing != null) ...[
              widget.trailing!,
              const SizedBox(width: 8),
            ],
            RotationTransition(
              turns: _iconTurns,
              child: Icon(
                LucideIcons.chevronDown,
                size: 20,
                color: _isExpanded ? colorScheme.primary : _textMuted,
              ),
            ),
          ],
        ),
      ),
    );

    final content = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(height: 1, color: _borderColor),
          Padding(
            padding: widget.contentPadding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children,
            ),
          ),
        ],
      ),
    );

    if (!widget.showBorder) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          headerContent,
          content,
        ],
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isExpanded ? colorScheme.primary.withAlpha(50) : _borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          headerContent,
          content,
        ],
      ),
    );
  }
}

/// A simpler inline collapsible section without card styling
class InlineCollapsibleSection extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final bool isDark;
  final bool isAmoled;

  const InlineCollapsibleSection({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.isDark = true,
    this.isAmoled = false,
  });

  @override
  State<InlineCollapsibleSection> createState() =>
      _InlineCollapsibleSectionState();
}

class _InlineCollapsibleSectionState extends State<InlineCollapsibleSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  Color get _textMuted {
    return widget.isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _isExpanded ? colorScheme.primary : _textMuted,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    LucideIcons.chevronDown,
                    size: 16,
                    color: _isExpanded ? colorScheme.primary : _textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.children,
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
