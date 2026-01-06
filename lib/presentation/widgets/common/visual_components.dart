import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// A wrapper widget that provides hover effects for cards
/// Features: elevation lift, border color change, subtle scaling
class HoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? borderColor;
  final Color? hoverBorderColor;
  final double borderWidth;
  final bool enableScale;
  final double scaleAmount;
  final Duration animationDuration;
  final bool isAmoled;
  final bool isDark;

  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.borderColor,
    this.hoverBorderColor,
    this.borderWidth = 1.0,
    this.enableScale = true,
    this.scaleAmount = 1.01,
    this.animationDuration = const Duration(milliseconds: 150),
    this.isAmoled = false,
    this.isDark = true,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  Color get _defaultBackground {
    if (widget.isAmoled) return AppThemeV2.amoledCard;
    return widget.isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard;
  }

  Color get _defaultHoverBackground {
    if (widget.isAmoled) return AppThemeV2.amoledCardHover;
    return widget.isDark ? AppThemeV2.darkCardHover : AppThemeV2.lightCardHover;
  }

  Color get _defaultBorder {
    if (widget.isAmoled) return AppThemeV2.amoledBorder;
    return widget.isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder;
  }

  Color get _defaultHoverBorder {
    // Use a slightly brighter border on hover
    if (widget.isAmoled) return AppThemeV2.amoledBorder.withAlpha(180);
    return widget.isDark
        ? AppThemeV2.darkBorder.withAlpha(180)
        : AppThemeV2.lightBorder.withAlpha(180);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveHoverBorder =
        widget.hoverBorderColor ?? colorScheme.primary.withAlpha(100);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress,
        child: AnimatedScale(
          scale: _isHovered && widget.enableScale ? widget.scaleAmount : 1.0,
          duration: widget.animationDuration,
          child: AnimatedContainer(
            duration: widget.animationDuration,
            curve: Curves.easeOut,
            margin: widget.margin,
            padding: widget.padding,
            decoration: BoxDecoration(
              color: _isHovered
                  ? (widget.hoverBackgroundColor ?? _defaultHoverBackground)
                  : (widget.backgroundColor ?? _defaultBackground),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? effectiveHoverBorder
                    : (widget.borderColor ?? _defaultBorder),
                width: widget.borderWidth,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withAlpha(15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// A widget for staggered list loading animations
class AnimatedListLoader extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;
  final Curve curve;
  final double slideOffset;
  final Axis slideDirection;

  const AnimatedListLoader({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 50),
    this.itemDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutCubic,
    this.slideOffset = 20.0,
    this.slideDirection = Axis.vertical,
  });

  @override
  State<AnimatedListLoader> createState() => _AnimatedListLoaderState();
}

class _AnimatedListLoaderState extends State<AnimatedListLoader>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _controllers = List.generate(
      widget.children.length,
      (index) => AnimationController(
        vsync: this,
        duration: widget.itemDuration,
      ),
    );

    _fadeAnimations = _controllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: widget.curve,
            ))
        .toList();

    _slideAnimations = _controllers.map((controller) {
      final beginOffset = widget.slideDirection == Axis.vertical
          ? Offset(0, widget.slideOffset / 100)
          : Offset(widget.slideOffset / 100, 0);

      return Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ));
    }).toList();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.itemDelay * i, () {
        if (mounted && i < _controllers.length) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(widget.children.length, (index) {
        return FadeTransition(
          opacity: _fadeAnimations[index],
          child: SlideTransition(
            position: _slideAnimations[index],
            child: widget.children[index],
          ),
        );
      }),
    );
  }
}

/// A prominent pill-shaped status badge for file status indicators
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final bool compact;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.compact = false,
  });

  /// Factory constructor for common status types
  factory StatusBadge.added({bool compact = false}) {
    return StatusBadge(
      label: compact ? 'A' : 'ADDED',
      color: AppThemeV2.added,
      icon: compact ? null : Icons.add_rounded,
      compact: compact,
    );
  }

  factory StatusBadge.removed({bool compact = false}) {
    return StatusBadge(
      label: compact ? 'D' : 'DELETED',
      color: AppThemeV2.removed,
      icon: compact ? null : Icons.remove_rounded,
      compact: compact,
    );
  }

  factory StatusBadge.modified({bool compact = false}) {
    return StatusBadge(
      label: compact ? 'M' : 'MODIFIED',
      color: AppThemeV2.modified,
      icon: compact ? null : Icons.edit_rounded,
      compact: compact,
    );
  }

  factory StatusBadge.renamed({bool compact = false}) {
    return StatusBadge(
      label: compact ? 'R' : 'RENAMED',
      color: AppThemeV2.info,
      icon: compact ? null : Icons.drive_file_rename_outline_rounded,
      compact: compact,
    );
  }

  factory StatusBadge.copied({bool compact = false}) {
    return StatusBadge(
      label: compact ? 'C' : 'COPIED',
      color: AppThemeV2.info,
      icon: compact ? null : Icons.copy_rounded,
      compact: compact,
    );
  }

  /// Create from git status string
  factory StatusBadge.fromGitStatus(String status, {bool compact = false}) {
    switch (status.toUpperCase()) {
      case 'A':
      case 'ADDED':
        return StatusBadge.added(compact: compact);
      case 'D':
      case 'DELETED':
        return StatusBadge.removed(compact: compact);
      case 'M':
      case 'MODIFIED':
        return StatusBadge.modified(compact: compact);
      case 'R':
      case 'RENAMED':
        return StatusBadge.renamed(compact: compact);
      case 'C':
      case 'COPIED':
        return StatusBadge.copied(compact: compact);
      default:
        return StatusBadge(
          label: compact ? status[0].toUpperCase() : status.toUpperCase(),
          color: AppThemeV2.info,
          compact: compact,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 10,
        vertical: compact ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(compact ? 4 : 20),
        border: Border.all(
          color: color.withAlpha(80),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null && !compact) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: compact ? 0 : 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// File type icon helper
class FileTypeIcon extends StatelessWidget {
  final String filePath;
  final double size;
  final Color? color;

  const FileTypeIcon({
    super.key,
    required this.filePath,
    this.size = 16,
    this.color,
  });

  static IconData getIconForExtension(String extension) {
    switch (extension.toLowerCase()) {
      // Localization files
      case 'json':
        return Icons.data_object_rounded;
      case 'xml':
      case 'resx':
      case 'xliff':
      case 'xlf':
        return Icons.code_rounded;
      case 'yaml':
      case 'yml':
        return Icons.settings_applications_rounded;
      case 'arb':
        return Icons.translate_rounded;
      case 'po':
      case 'pot':
      case 'mo':
        return Icons.g_translate_rounded;
      case 'strings':
      case 'stringsdict':
        return Icons.apple_rounded;
      case 'properties':
        return Icons.settings_rounded;
      // Common code files
      case 'dart':
        return Icons.flutter_dash_rounded;
      case 'js':
      case 'jsx':
      case 'ts':
      case 'tsx':
        return Icons.javascript_rounded;
      case 'py':
        return Icons.terminal_rounded;
      case 'java':
      case 'kt':
        return Icons.android_rounded;
      case 'swift':
        return Icons.apple_rounded;
      case 'cs':
        return Icons.window_rounded;
      case 'html':
      case 'htm':
        return Icons.html_rounded;
      case 'css':
      case 'scss':
      case 'sass':
        return Icons.css_rounded;
      case 'md':
      case 'markdown':
        return Icons.description_rounded;
      case 'txt':
        return Icons.text_snippet_rounded;
      // Config files
      case 'toml':
      case 'ini':
      case 'cfg':
      case 'conf':
        return Icons.tune_rounded;
      // Images
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'svg':
      case 'webp':
        return Icons.image_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final extension = filePath.split('.').last;
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return Icon(
      getIconForExtension(extension),
      size: size,
      color: effectiveColor,
    );
  }
}
