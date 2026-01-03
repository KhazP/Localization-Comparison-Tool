import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/services/windows_integration_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SystemIntegrationsCard extends StatefulWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const SystemIntegrationsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  State<SystemIntegrationsCard> createState() => _SystemIntegrationsCardState();
}

class _SystemIntegrationsCardState extends State<SystemIntegrationsCard> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return _buildWindowsIntegrations(context);
    } else if (Platform.isMacOS) {
      return _buildMacOSIntegrations(context);
    } else {
      return _buildUnsupportedPlatform(context);
    }
  }

  Widget _buildUnsupportedPlatform(BuildContext context) {
    return SettingsCardContainer(
      title: 'Platform Notice',
      isDark: widget.isDark,
      isAmoled: widget.isAmoled,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(LucideIcons.info,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'System integrations are not available for this platform.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWindowsIntegrations(BuildContext context) {
    final settings = widget.settings;
    final isWindows = Platform.isWindows;

    return Column(
      children: [
        SettingsCardContainer(
          title: 'Visual Effects',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: 'Use Mica Effect',
              description:
                  'Enable Windows 11 Mica transparency (requires restart)',
              control: Switch(
                value: settings.useMicaEffect,
                onChanged: isWindows
                    ? (val) => context
                        .read<SettingsBloc>()
                        .add(UpdateUseMicaEffect(val))
                    : null,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Explorer Integration',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add "Open with Localizer" to the Windows Explorer right-click menu for folders.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .addToContextMenu();
                                  if (context.mounted) {
                                    if (success) {
                                      ToastService.showSuccess(
                                          context, 'Context menu added!');
                                    } else {
                                      ToastService.showError(context,
                                          'Failed to add context menu');
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.plus, size: 18),
                          label: const Text('Add to Context Menu'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .removeFromContextMenu();
                                  if (context.mounted) {
                                    if (success) {
                                      ToastService.showSuccess(
                                          context, 'Context menu removed!');
                                    } else {
                                      ToastService.showError(context,
                                          'Failed to remove context menu');
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.minus, size: 18),
                          label: const Text('Remove'),
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
          title: 'File Associations',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Register file types to open with Localizer when double-clicked in Explorer.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            // Per-extension toggles
            ...WindowsIntegrationService.supportedExtensions.entries
                .map((entry) {
              final ext = entry.key;
              final description = entry.value;
              final isRegistered = isWindows &&
                  WindowsIntegrationService.isFileExtensionRegistered(ext);

              return SettingsRow(
                label: ext,
                description: description,
                control: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isRegistered ? Colors.green : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isRegistered ? 'Registered' : 'Not Registered',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: widget.isDark
                                ? AppThemeV2.darkTextMuted
                                : AppThemeV2.lightTextMuted,
                          ),
                    ),
                    const SizedBox(width: 12),
                    Switch(
                      value: isRegistered,
                      onChanged: isWindows
                          ? (val) async {
                              final success = val
                                  ? await WindowsIntegrationService
                                      .registerFileExtension(ext)
                                  : await WindowsIntegrationService
                                      .unregisterFileExtension(ext);
                              if (context.mounted) {
                                if (success) {
                                  ToastService.showSuccess(
                                      context,
                                      val
                                          ? '$ext registered!'
                                          : '$ext unregistered!');
                                } else {
                                  ToastService.showError(context,
                                      'Failed to ${val ? 'register' : 'unregister'} $ext');
                                }
                                // Trigger rebuild to update status
                                setState(() {});
                              }
                            }
                          : null,
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                isDark: widget.isDark,
                isAmoled: widget.isAmoled,
                showDivider: ext !=
                    WindowsIntegrationService.supportedExtensions.keys.last,
              );
            }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: isWindows
                          ? () async {
                              final results = await WindowsIntegrationService
                                  .registerAllExtensions();
                              final successCount =
                                  results.values.where((v) => v).length;
                              if (context.mounted) {
                                final message =
                                    'Registered $successCount of ${results.length} file types';
                                if (successCount == results.length) {
                                  ToastService.showSuccess(context, message);
                                } else {
                                  ToastService.showWarning(context, message);
                                }
                                setState(() {});
                              }
                            }
                          : null,
                      icon: const Icon(LucideIcons.checkCircle, size: 18),
                      label: const Text('Register All'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isWindows
                          ? () async {
                              final results = await WindowsIntegrationService
                                  .unregisterAllExtensions();
                              final successCount =
                                  results.values.where((v) => v).length;
                              if (context.mounted) {
                                final message =
                                    'Unregistered $successCount of ${results.length} file types';
                                if (successCount == results.length) {
                                  ToastService.showSuccess(context, message);
                                } else {
                                  ToastService.showWarning(context, message);
                                }
                                setState(() {});
                              }
                            }
                          : null,
                      icon: const Icon(LucideIcons.minusCircle, size: 18),
                      label: const Text('Unregister All'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Protocol Handler',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register localizer:// URLs to open this application.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .registerProtocolHandler();
                                  if (context.mounted) {
                                    if (success) {
                                      ToastService.showSuccess(context,
                                          'Protocol handler registered!');
                                    } else {
                                      ToastService.showError(
                                          context, 'Failed to register');
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.globe, size: 18),
                          label: const Text('Register Protocol'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .unregisterProtocolHandler();
                                  if (context.mounted) {
                                    if (success) {
                                      ToastService.showSuccess(
                                          context, 'Protocol handler removed!');
                                    } else {
                                      ToastService.showError(
                                          context, 'Failed to remove');
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.unlink, size: 18),
                          label: const Text('Unregister'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacOSIntegrations(BuildContext context) {
    final settings = widget.settings;
    final isMacOS = Platform.isMacOS;

    // Available window materials
    const materials = [
      ('sidebar', 'Sidebar'),
      ('menu', 'Menu'),
      ('popover', 'Popover'),
      ('titlebar', 'Titlebar'),
      ('underPageBackground', 'Page Background'),
      ('contentBackground', 'Content'),
    ];

    return Column(
      children: [
        SettingsCardContainer(
          title: 'Visual Effects',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: 'Window Material',
              description: 'Select the macOS vibrancy material style',
              control: DropdownButton<String>(
                value: settings.macosWindowMaterial,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(8),
                onChanged: isMacOS
                    ? (val) {
                        if (val != null) {
                          context
                              .read<SettingsBloc>()
                              .add(UpdateMacosWindowMaterial(val));
                        }
                      }
                    : null,
                items: materials.map((m) {
                  return DropdownMenuItem(
                    value: m.$1,
                    child: Text(m.$2),
                  );
                }).toList(),
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Dock Integration',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: 'Show Untranslated Count',
              description:
                  'Display untranslated string count on the dock icon badge',
              control: Switch(
                value: settings.showDockBadge,
                onChanged: isMacOS
                    ? (val) => context
                        .read<SettingsBloc>()
                        .add(UpdateShowDockBadge(val))
                    : null,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
              showDivider: false,
            ),
          ],
        ),
      ],
    );
  }
}
