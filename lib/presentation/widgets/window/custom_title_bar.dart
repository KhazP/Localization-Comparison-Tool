import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';

/// A custom title bar widget that replaces the native window title bar.
/// 
/// This provides:
/// - Consistent look across Windows and macOS
/// - App branding with logo and title
/// - Window controls (minimize, maximize, close)
/// - Drag-to-move functionality
class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  static const double height = 32.0;

  @override
  Widget build(BuildContext context) {
    // Only show on desktop platforms
    if (!Platform.isWindows && !Platform.isMacOS && !Platform.isLinux) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<ThemeBloc, AppThemeState>(
      builder: (context, themeState) {
        final accentColor = themeState.accentColor;
        final isDark = ThemeData.estimateBrightnessForColor(accentColor) == Brightness.dark;
        final foregroundColor = isDark ? Colors.white : Colors.black;

        return Container(
          height: height,
          color: accentColor,
          child: Row(
            children: [
              // App Icon and Title (left side)
              Expanded(
                child: MoveWindow(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        // App Icon
                        Icon(
                          Icons.translate,
                          size: 18,
                          color: foregroundColor,
                          semanticLabel: 'Localizer App Icon',
                        ),
                        const SizedBox(width: 8),
                        // App Title
                        Text(
                          'Localizer',
                          style: TextStyle(
                            color: foregroundColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Window Buttons (right side)
              _WindowButtons(
                buttonColor: foregroundColor,
                hoverColor: foregroundColor.withOpacity(0.1),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Window control buttons (minimize, maximize, close).
class _WindowButtons extends StatelessWidget {
  final Color buttonColor;
  final Color hoverColor;

  const _WindowButtons({
    required this.buttonColor,
    required this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColors = WindowButtonColors(
      iconNormal: buttonColor,
      mouseOver: hoverColor,
      mouseDown: hoverColor,
      iconMouseOver: buttonColor,
      iconMouseDown: buttonColor,
    );

    final closeButtonColors = WindowButtonColors(
      iconNormal: buttonColor,
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconMouseOver: Colors.white,
      iconMouseDown: Colors.white,
    );

    return Row(
      children: [
        MinimizeWindowButton(
          colors: buttonColors,
          animate: true,
        ),
        MaximizeWindowButton(
          colors: buttonColors,
          animate: true,
        ),
        CloseWindowButton(
          colors: closeButtonColors,
          animate: true,
        ),
      ],
    );
  }
}
