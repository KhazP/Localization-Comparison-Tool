import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/update_checker_service.dart';
import 'package:localizer_app_main/data/services/system_info_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
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
        context.t.settings.about.developerSteps(count: stepsRemaining),
        duration: const Duration(milliseconds: 1500),
      );
    }

    if (_versionTapCount >= 7) {
      _versionTapCount = 0;
      context.read<SettingsBloc>().add(const UpdateShowDeveloperOptions(true));
      ToastService.showSuccess(
          context, context.t.settings.about.developerActivated);
    }
  }

  String _formatLastChecked(BuildContext context, String? timestamp) {
    if (timestamp == null || timestamp.isEmpty)
      return context.t.settings.about.neverChecked;
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      if (difference.inMinutes < 1) return context.t.history.timeAgo.justNow;
      if (difference.inHours < 1)
        return context.t.history.timeAgo
            .minutesAgo(count: difference.inMinutes);
      if (difference.inDays < 1)
        return context.t.history.timeAgo.hoursAgo(count: difference.inHours);
      if (difference.inDays < 7)
        return context.t.history.timeAgo.daysAgo(count: difference.inDays);
      return DateFormat('MMM d, yyyy').format(dateTime);
    } catch (e) {
      return context.t.common.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<SettingsBloc>();

    return Column(
      children: [
        SettingsCardContainer(
          title: context.t.settings.about.applicationInfo,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            GestureDetector(
              onTap: () => _handleVersionTap(context),
              behavior: HitTestBehavior.opaque,
              child: _buildInfoRow(context, context.t.settings.about.version,
                  widget.packageInfo?.version ?? context.t.common.loading),
            ),
            GestureDetector(
              onTap: () => _handleVersionTap(context),
              behavior: HitTestBehavior.opaque,
              child: _buildInfoRow(
                  context,
                  context.t.settings.about.buildNumber,
                  widget.packageInfo?.buildNumber ?? context.t.common.loading),
            ),
            _buildInfoRow(context, context.t.settings.about.platform,
                Platform.operatingSystem,
                showDivider: false), // Simplified platform info
          ],
        ),
        SettingsCardContainer(
          title: context.t.settings.about.updateInformation,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: context.t.settings.about.currentVersion,
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.packageInfo?.version ?? context.t.common.loading,
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
                      child: Text(context.t.settings.about.updateAvailableBadge,
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
                label: context.t.settings.about.latestVersion,
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
              label: context.t.settings.about.lastChecked,
              control: Text(
                  _formatLastChecked(
                      context, widget.settings.lastUpdateCheckTime),
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
                          ? context.t.settings.about.checkingForUpdates
                          : context.t.settings.about.checkForUpdates),
                    ),
                  ),
                  if (widget.updateCheckResult?.changelog?.isNotEmpty ==
                      true) ...[
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: widget.onShowChangelog,
                      icon: const Icon(LucideIcons.fileText, size: 18),
                      label: Text(context.t.settings.about.whatsNew),
                    ),
                  ],
                  if (widget.updateCheckResult?.updateAvailable == true &&
                      widget.updateCheckResult?.downloadUrl != null) ...[
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () => widget
                          .onLaunchUrl(widget.updateCheckResult!.downloadUrl!),
                      icon: const Icon(LucideIcons.download, size: 18),
                      label: Text(context.t.common.download),
                      style: FilledButton.styleFrom(
                          backgroundColor: AppThemeV2.success),
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            SettingsRow(
              label: context.t.settings.general.autoCheckUpdates,
              description:
                  context.t.settings.general.autoCheckUpdatesDescription,
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
          title: context.t.settings.about.systemInformation,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            _buildInfoRow(context, context.t.settings.about.dartVersion,
                widget.systemInfo?.dartVersion ?? context.t.common.loading),
            _buildInfoRow(
                context,
                context.t.settings.about.diskSpace,
                widget.systemInfo?.availableDiskSpace ??
                    context.t.common.loading),
            SettingsRow(
              label: context.t.settings.about.memoryUsage,
              control: Text(
                widget.systemInfo != null
                    ? '${widget.systemInfo!.memoryUsage} / ${widget.systemInfo!.totalMemory}'
                    : context.t.common.loading,
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
                label: Text(context.t.common.refresh),
              ),
            ),
          ],
        ),
        SettingsCardContainer(
          title: context.t.settings.about.privacyTitle,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: context.t.settings.about.usageStats,
              description: context.t.settings.about.requiresFirebase,
              control: Tooltip(
                message: context.t.settings.about.featureUnavailable,
                child: Switch(
                  value: false, // Force disabled state
                  onChanged: null, // Disable interaction
                ),
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            SettingsRow(
              label: context.t.settings.about.crashReporting,
              description: context.t.settings.about.requiresFirebase,
              control: Tooltip(
                message: context.t.settings.about.featureUnavailable,
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
                context.t.settings.about.privacyPolicy,
                LucideIcons.shieldAlert,
                () => widget.onLaunchUrl(
                    'https://github.com/KhazP/LocalizerAppMain/blob/main/PRIVACY.md'),
                showDivider: false),
          ],
        ),
        SettingsCardContainer(
          title: context.t.settings.about.settingsManagement,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.settings.about.settingsManagementDescription,
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
                          label: Text(context.t.common.export),
                          onPressed: widget.onExportSettings,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(LucideIcons.download, size: 18),
                          label: Text(context.t.common.import),
                          onPressed: widget.onImportSettings,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(LucideIcons.refreshCcw, size: 18),
                          label: Text(context.t.settings.about.resetAll),
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
          title: context.t.settings.about.links,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            _buildLinkRow(
                context,
                context.t.settings.about.githubRepo,
                LucideIcons.github,
                () => widget
                    .onLaunchUrl('https://github.com/KhazP/LocalizerAppMain')),
            _buildLinkRow(
                context,
                context.t.menu.reportIssue,
                LucideIcons.bug,
                () => widget.onLaunchUrl(
                    'https://github.com/KhazP/LocalizerAppMain/issues')),
            _buildLinkRow(context, context.t.settings.about.license,
                LucideIcons.fileText, widget.onShowLicenses,
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
