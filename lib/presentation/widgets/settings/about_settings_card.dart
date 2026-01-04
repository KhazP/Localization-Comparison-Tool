import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/update_checker_service.dart';
import 'package:localizer_app_main/data/services/system_info_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/app_command_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AboutSettingsCard extends StatefulWidget {
  final AppSettings settings;
  final PackageInfo? packageInfo;
  final UpdateCheckResult? updateCheckResult;
  final bool isCheckingForUpdates;
  final SystemInfo? systemInfo;
  final bool isDark;
  final bool isAmoled;

  // Callbacks
  final VoidCallback onCheckForUpdates;
  final VoidCallback onShowChangelog;
  final Function(String) onLaunchUrl;
  final VoidCallback onRefreshSystemInfo;
  final VoidCallback onExportSettings;
  final VoidCallback onImportSettings;
  final VoidCallback onResetAllSettings;
  final VoidCallback onShowLicenses;

  const AboutSettingsCard({
    super.key,
    required this.settings,
    this.packageInfo,
    this.updateCheckResult,
    required this.isCheckingForUpdates,
    this.systemInfo,
    required this.isDark,
    required this.isAmoled,
    required this.onCheckForUpdates,
    required this.onShowChangelog,
    required this.onLaunchUrl,
    required this.onRefreshSystemInfo,
    required this.onExportSettings,
    required this.onImportSettings,
    required this.onResetAllSettings,
    required this.onShowLicenses,
  });

  @override
  State<AboutSettingsCard> createState() => _AboutSettingsCardState();
}

class _AboutSettingsCardState extends State<AboutSettingsCard> {
  int _versionTapCount = 0;
  DateTime? _lastTapTime;

  void _handleVersionTap(BuildContext context) {
    if (widget.settings.showDeveloperOptions) return;

    final now = DateTime.now();
    if (_lastTapTime == null ||
        now.difference(_lastTapTime!) > const Duration(seconds: 1)) {
      _versionTapCount = 0;
    }

    _versionTapCount++;
    _lastTapTime = now;

    if (_versionTapCount >= 2 && _versionTapCount < 7) {
      final stepsRemaining = 7 - _versionTapCount;
      ToastService.showInfo(
        context,
        'You are $stepsRemaining steps away from being a developer.',
        duration: const Duration(milliseconds: 1500),
      );
    }

    if (_versionTapCount >= 7) {
      _versionTapCount = 0;
      context.read<SettingsBloc>().add(const UpdateShowDeveloperOptions(true));
      ToastService.showSuccess(context, 'You are now a developer!');
    }
  }

  String _formatLastChecked(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return 'Never';
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      if (difference.inMinutes < 1) return 'Just now';
      if (difference.inHours < 1) return '${difference.inMinutes} minutes ago';
      if (difference.inDays < 1) return '${difference.inHours} hours ago';
      if (difference.inDays < 7) return '${difference.inDays} days ago';
      return DateFormat('MMM d, yyyy').format(dateTime);
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<SettingsBloc>();

    return Column(
      children: [
        SettingsCardContainer(
          title: 'Application Info',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            GestureDetector(
              onTap: () => _handleVersionTap(context),
              behavior: HitTestBehavior.opaque,
              child: _buildInfoRow(context, 'Version',
                  widget.packageInfo?.version ?? 'Loading...'),
            ),
            GestureDetector(
              onTap: () => _handleVersionTap(context),
              behavior: HitTestBehavior.opaque,
              child: _buildInfoRow(context, 'Build',
                  widget.packageInfo?.buildNumber ?? 'Loading...'),
            ),
            _buildInfoRow(context, 'Platform', Platform.operatingSystem,
                showDivider: false), // Simplified platform info
          ],
        ),
        SettingsCardContainer(
          title: 'Update Information',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: 'Current Version',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.packageInfo?.version ?? 'Loading...',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: widget.isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted)),
                  if (widget.updateCheckResult?.updateAvailable == true) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppThemeV2.success.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppThemeV2.success.withAlpha(100)),
                      ),
                      child: Text('Update Available!',
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: AppThemeV2.success,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ],
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            if (widget.updateCheckResult != null)
              SettingsRow(
                label: 'Latest Version',
                control: Text(
                  widget.updateCheckResult!.latestVersion,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: widget.updateCheckResult!.updateAvailable
                        ? AppThemeV2.success
                        : (widget.isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted),
                    fontWeight: widget.updateCheckResult!.updateAvailable
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                isDark: widget.isDark,
                isAmoled: widget.isAmoled,
              ),
            SettingsRow(
              label: 'Last Checked',
              control: Text(
                  _formatLastChecked(widget.settings.lastUpdateCheckTime),
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: widget.isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted)),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: widget.isCheckingForUpdates
                          ? null
                          : widget.onCheckForUpdates,
                      icon: widget.isCheckingForUpdates
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Icon(LucideIcons.refreshCcw, size: 18),
                      label: Text(widget.isCheckingForUpdates
                          ? 'Checking...'
                          : 'Check for Updates'),
                    ),
                  ),
                  if (widget.updateCheckResult?.changelog?.isNotEmpty ==
                      true) ...[
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: widget.onShowChangelog,
                      icon: const Icon(LucideIcons.fileText, size: 18),
                      label: const Text("What's New"),
                    ),
                  ],
                  if (widget.updateCheckResult?.updateAvailable == true &&
                      widget.updateCheckResult?.downloadUrl != null) ...[
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () => widget
                          .onLaunchUrl(widget.updateCheckResult!.downloadUrl!),
                      icon: const Icon(LucideIcons.download, size: 18),
                      label: const Text('Download'),
                      style: FilledButton.styleFrom(
                          backgroundColor: AppThemeV2.success),
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            SettingsRow(
              label: 'Auto-check for updates',
              description: 'Check for updates when the app starts',
              control: Switch(
                value: widget.settings.autoCheckForUpdates,
                onChanged: (val) => bloc.add(UpdateAutoCheckForUpdates(val)),
                activeColor: theme.colorScheme.primary,
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'System Information',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            _buildInfoRow(context, 'Dart Version',
                widget.systemInfo?.dartVersion ?? 'Loading...'),
            _buildInfoRow(context, 'Available Disk Space',
                widget.systemInfo?.availableDiskSpace ?? 'Loading...'),
            SettingsRow(
              label: 'Memory Usage',
              control: Text(
                widget.systemInfo != null
                    ? '${widget.systemInfo!.memoryUsage} / ${widget.systemInfo!.totalMemory}'
                    : 'Loading...',
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: widget.isDark
                        ? AppThemeV2.darkTextMuted
                        : AppThemeV2.lightTextMuted),
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
              showDivider: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: OutlinedButton.icon(
                onPressed: widget.onRefreshSystemInfo,
                icon: const Icon(LucideIcons.refreshCcw, size: 18),
                label: const Text('Refresh'),
              ),
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Privacy & Telemetry',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: 'Anonymous Usage Statistics',
              description: 'Requires Firebase configuration',
              control: Tooltip(
                message: 'Feature currently unavailable (Requires Firebase)',
                child: Switch(
                  value: false, // Force disabled state
                  onChanged: null, // Disable interaction
                ),
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            SettingsRow(
              label: 'Crash Reporting',
              description: 'Requires Firebase configuration',
              control: Tooltip(
                message: 'Feature currently unavailable (Requires Firebase)',
                child: Switch(
                  value: false, // Force disabled state
                  onChanged: null, // Disable interaction
                ),
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            _buildLinkRow(
                context,
                'Privacy Policy',
                LucideIcons.shieldAlert,
                () => widget.onLaunchUrl(
                    'https://github.com/KhazP/LocalizerAppMain/blob/main/PRIVACY.md'),
                showDivider: false),
          ],
        ),
        SettingsCardContainer(
          title: 'Settings Management',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export your settings to a file to back them up or share with other machines.',
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: widget.isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(LucideIcons.upload, size: 18),
                          label: const Text('Export'),
                          onPressed: widget.onExportSettings,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(LucideIcons.download, size: 18),
                          label: const Text('Import'),
                          onPressed: widget.onImportSettings,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(LucideIcons.refreshCcw, size: 18),
                          label: const Text('Reset All'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppThemeV2.error,
                            side: BorderSide(
                                color: AppThemeV2.error.withAlpha(100)),
                          ),
                          onPressed: widget.onResetAllSettings,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Links',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            _buildLinkRow(
                context,
                'GitHub Repository',
                LucideIcons.github,
                () => widget
                    .onLaunchUrl('https://github.com/KhazP/LocalizerAppMain')),
            _buildLinkRow(
                context,
                'Report Issue',
                LucideIcons.bug,
                () => widget.onLaunchUrl(
                    'https://github.com/KhazP/LocalizerAppMain/issues')),
            _buildLinkRow(context, 'Licenses', LucideIcons.fileText,
                widget.onShowLicenses,
                showDivider: false),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value,
      {bool showDivider = true}) {
    return SettingsRow(
      label: label,
      control: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: widget.isDark
                  ? AppThemeV2.darkTextMuted
                  : AppThemeV2.lightTextMuted,
            ),
      ),
      isDark: widget.isDark,
      isAmoled: widget.isAmoled,
      showDivider: showDivider,
    );
  }

  Widget _buildLinkRow(
      BuildContext context, String label, IconData icon, VoidCallback onTap,
      {bool showDivider = true}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon,
                    size: 20, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                    child: Text(label,
                        style: Theme.of(context).textTheme.bodyMedium)),
                Icon(LucideIcons.chevronRight,
                    size: 16,
                    color: widget.isDark
                        ? AppThemeV2.darkTextMuted
                        : AppThemeV2.lightTextMuted),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: widget.isAmoled
                ? AppThemeV2.amoledBorder
                : (widget.isDark
                    ? AppThemeV2.darkBorder
                    : AppThemeV2.lightBorder),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
