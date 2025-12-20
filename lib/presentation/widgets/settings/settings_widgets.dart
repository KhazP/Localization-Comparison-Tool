import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';

/// A styled card container for settings sections
class SettingsCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final isAmoled = !isLight && currentThemeMode == 'amoled';

    final cardBgColor = isAmoled 
        ? const Color(0xFF0D0D0D)
        : (isLight ? Colors.white : const Color(0xFF2A2D3E));
    final borderColor = isAmoled
        ? Colors.grey[850]!
        : theme.dividerColor.withOpacity(0.5);
    final titleColor = isAmoled
        ? Colors.grey[300]!
        : theme.textTheme.titleMedium?.color;

    return Card(
      color: cardBgColor,
      elevation: isAmoled ? 0.0 : 1.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 16.0),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// A row for a single setting with label and control
class SettingItemRow extends StatelessWidget {
  final String label;
  final Widget control;
  final String? tooltip;

  const SettingItemRow({
    super.key,
    required this.label,
    required this.control,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelColor = theme.colorScheme.onSurface;
    final tooltipColor = theme.colorScheme.onSurface.withOpacity(0.5);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 14, color: labelColor),
                  ),
                ),
                if (tooltip != null) ...[
                  const SizedBox(width: 6),
                  Tooltip(
                    message: tooltip!,
                    child: Icon(Icons.info_outline, size: 16, color: tooltipColor),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          control,
        ],
      ),
    );
  }
}

/// A styled dropdown for settings
class SettingsDropdown extends StatelessWidget {
  final String? currentValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double width;

  const SettingsDropdown({
    super.key,
    required this.currentValue,
    required this.items,
    required this.onChanged,
    this.width = 180,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final settingsState = context.watch<SettingsBloc>().state;
    final currentThemeMode = settingsState.appSettings.appThemeMode.toLowerCase();
    final isAmoled = !isLight && currentThemeMode == 'amoled';

    final dropdownBg = isAmoled
        ? Colors.grey[900]!
        : (isLight ? Colors.grey[100]! : const Color(0xFF3A3D4E));
    final dropdownTextColor = isAmoled
        ? Colors.grey[300]!
        : theme.colorScheme.onSurface;
    final borderColor = isAmoled
        ? Colors.grey[700]!
        : theme.dividerColor;

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: dropdownBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderColor.withOpacity(0.5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(currentValue) ? currentValue : items.first,
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item, style: TextStyle(fontSize: 14, color: dropdownTextColor)),
          )).toList(),
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: dropdownBg,
          style: TextStyle(fontSize: 14, color: dropdownTextColor),
          icon: Icon(Icons.arrow_drop_down, color: dropdownTextColor.withOpacity(0.7)),
        ),
      ),
    );
  }
}

/// A styled switch for settings
class SettingsSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedColor = theme.colorScheme.onSurface.withOpacity(0.3);

    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: theme.colorScheme.primary,
      activeTrackColor: theme.colorScheme.primary.withOpacity(0.5),
      inactiveTrackColor: mutedColor,
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return theme.colorScheme.primary;
        }
        return Colors.grey[400];
      }),
    );
  }
}

/// An info banner for settings sections
class SettingsInfoBanner extends StatelessWidget {
  final String message;
  final IconData icon;

  const SettingsInfoBanner({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final mutedColor = theme.colorScheme.onSurface.withOpacity(0.7);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: mutedColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
