import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/update_checker_service.dart';
import 'package:localizer_app_main/data/services/system_info_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:intl/intl.dart';

class AboutSettingsCard extends StatelessWidget {
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
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildInfoRow(context, 'Version', packageInfo?.version ?? 'Loading...'),
            _buildInfoRow(context, 'Build', packageInfo?.buildNumber ?? 'Loading...'),
            _buildInfoRow(context, 'Platform', Platform.operatingSystem, showDivider: false), // Simplified platform info
          ],
        ),

        SettingsCardContainer(
          title: 'Update Information',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Current Version',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(packageInfo?.version ?? 'Loading...', style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted)),
                  if (updateCheckResult?.updateAvailable == true) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppThemeV2.success.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppThemeV2.success.withAlpha(100)),
                      ),
                      child: Text('Update Available!', style: theme.textTheme.labelSmall?.copyWith(color: AppThemeV2.success, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ],
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            if (updateCheckResult != null)
              SettingsRow(
                label: 'Latest Version',
                control: Text(
                  updateCheckResult!.latestVersion,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: updateCheckResult!.updateAvailable ? AppThemeV2.success : (isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted),
                    fontWeight: updateCheckResult!.updateAvailable ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                isDark: isDark,
                isAmoled: isAmoled,
              ),
            SettingsRow(
              label: 'Last Checked',
              control: Text(_formatLastChecked(settings.lastUpdateCheckTime), style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted)),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: isCheckingForUpdates ? null : onCheckForUpdates,
                      icon: isCheckingForUpdates
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.refresh_rounded, size: 18),
                      label: Text(isCheckingForUpdates ? 'Checking...' : 'Check for Updates'),
                    ),
                  ),
                  if (updateCheckResult?.changelog?.isNotEmpty == true) ...[
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: onShowChangelog,
                      icon: const Icon(Icons.notes_rounded, size: 18),
                      label: const Text("What's New"),
                    ),
                  ],
                  if (updateCheckResult?.updateAvailable == true && updateCheckResult?.downloadUrl != null) ...[
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () => onLaunchUrl(updateCheckResult!.downloadUrl!),
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Download'),
                      style: FilledButton.styleFrom(backgroundColor: AppThemeV2.success),
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
                value: settings.autoCheckForUpdates,
                onChanged: (val) => bloc.add(UpdateAutoCheckForUpdates(val)),
                activeColor: theme.colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),

        SettingsCardContainer(
          title: 'System Information',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildInfoRow(context, 'Dart Version', systemInfo?.dartVersion ?? 'Loading...'),
            _buildInfoRow(context, 'Available Disk Space', systemInfo?.availableDiskSpace ?? 'Loading...'),
            SettingsRow(
              label: 'Memory Usage',
              control: Text(
                systemInfo != null ? '${systemInfo!.memoryUsage} / ${systemInfo!.totalMemory}' : 'Loading...',
                style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: OutlinedButton.icon(
                onPressed: onRefreshSystemInfo,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Refresh'),
              ),
            ),
          ],
        ),

        SettingsCardContainer(
          title: 'Privacy & Telemetry',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Anonymous Usage Statistics',
              description: 'Help improve the app by sending anonymous usage data',
              control: Switch(
                value: settings.enableAnonymousUsageStatistics,
                onChanged: (val) => bloc.add(UpdateEnableAnonymousUsageStatistics(val)),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Crash Reporting',
              description: 'Automatically send crash reports to help fix issues',
              control: Switch(
                value: settings.enableCrashReporting,
                onChanged: (val) => bloc.add(UpdateEnableCrashReporting(val)),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildLinkRow(context, 'Privacy Policy', Icons.privacy_tip_rounded, 
                () => onLaunchUrl('https://github.com/KhazP/LocalizerAppMain/blob/main/PRIVACY.md'), 
                showDivider: false),
          ],
        ),

        SettingsCardContainer(
          title: 'Settings Management',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export your settings to a file to back them up or share with other machines.',
                    style: theme.textTheme.bodySmall?.copyWith(color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.upload_rounded, size: 18),
                          label: const Text('Export'),
                          onPressed: onExportSettings,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Import'),
                          onPressed: onImportSettings,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.refresh_rounded, size: 18),
                          label: const Text('Reset All'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppThemeV2.error,
                            side: BorderSide(color: AppThemeV2.error.withAlpha(100)),
                          ),
                          onPressed: onResetAllSettings,
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
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildLinkRow(context, 'GitHub Repository', Icons.code_rounded, 
                () => onLaunchUrl('https://github.com/KhazP/LocalizerAppMain')),
            _buildLinkRow(context, 'Report Issue', Icons.bug_report_rounded, 
                () => onLaunchUrl('https://github.com/KhazP/LocalizerAppMain/issues')),
            _buildLinkRow(context, 'Licenses', Icons.article_rounded, onShowLicenses, showDivider: false),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {bool showDivider = true}) {
    return SettingsRow(
      label: label,
      control: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            ),
      ),
      isDark: isDark,
      isAmoled: isAmoled,
      showDivider: showDivider,
    );
  }

  Widget _buildLinkRow(BuildContext context, String label, IconData icon, VoidCallback onTap, {bool showDivider = true}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
                Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: isAmoled ? AppThemeV2.amoledBorder : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder),
            height: 1, indent: 16, endIndent: 16,
          ),
      ],
    );
  }
}
