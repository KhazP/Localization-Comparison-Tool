import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/services/windows_integration_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
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
      title: context.t.settings.integrations.platformNotice,
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
                  context.t.settings.integrations.platformNoticeDescription,
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
          title: context.t.settings.integrations.visualEffects,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: context.t.settings.appearance.useMicaEffect,
              description: context.t.settings.appearance.micaDescription,
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
          title: context.t.settings.integrations.explorerIntegration,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context
                        .t.settings.integrations.explorerIntegrationDescription,
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
                                          context,
                                          context.t.settings.integrations
                                              .contextMenuAdded);
                                    } else {
                                      ToastService.showError(
                                          context,
                                          context.t.settings.integrations
                                              .contextMenuAddError);
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.plus, size: 18),
                          label: Text(
                              context.t.settings.integrations.addToContextMenu),
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
                                          context,
                                          context.t.settings.integrations
                                              .contextMenuRemoved);
                                    } else {
                                      ToastService.showError(
                                          context,
                                          context.t.settings.integrations
                                              .contextMenuRemoveError);
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.minus, size: 18),
                          label: Text(context.t.common.remove),
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
          title: context.t.settings.integrations.fileAssociations,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                context.t.settings.integrations.fileAssociationsDescription,
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
                      isRegistered
                          ? context.t.settings.integrations.registered
                          : context.t.settings.integrations.notRegistered,
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
                                          ? context.t.settings.integrations
                                              .extRegistered(ext: ext)
                                          : context.t.settings.integrations
                                              .extUnregistered(ext: ext));
                                } else {
                                  ToastService.showError(
                                      context,
                                      context.t.settings.integrations.extError(
                                          action:
                                              val ? 'register' : 'unregister',
                                          ext: ext));
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
                                final message = context.t.settings.integrations
                                    .registerAllResult(
                                        success: successCount,
                                        total: results.length);
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
                      label: Text(context.t.settings.integrations.registerAll),
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
                                final message = context.t.settings.integrations
                                    .unregisterAllResult(
                                        success: successCount,
                                        total: results.length);
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
                      label:
                          Text(context.t.settings.integrations.unregisterAll),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SettingsCardContainer(
          title: context.t.settings.integrations.protocolHandler,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.settings.integrations.protocolHandlerDescription,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                  ),
                  const SizedBox(height: 12),
                  // Status indicator
                  Builder(
                    builder: (context) {
                      final isRegistered = isWindows &&
                          WindowsIntegrationService
                              .isProtocolHandlerRegistered();
                      return Row(
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
                            isRegistered
                                ? context
                                    .t.settings.integrations.protocolRegistered
                                : context.t.settings.integrations
                                    .protocolNotRegistered,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isRegistered
                                          ? Colors.green
                                          : (widget.isDark
                                              ? AppThemeV2.darkTextMuted
                                              : AppThemeV2.lightTextMuted),
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      );
                    },
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
                                      ToastService.showSuccess(
                                          context,
                                          context.t.settings.integrations
                                              .protocolRegisteredSuccess);
                                      setState(() {});
                                    } else {
                                      ToastService.showError(
                                          context,
                                          context.t.settings.integrations
                                              .protocolRegisterError);
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.globe, size: 18),
                          label: Text(
                              context.t.settings.integrations.registerProtocol),
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
                                          context,
                                          context.t.settings.integrations
                                              .protocolRemovedSuccess);
                                      setState(() {});
                                    } else {
                                      ToastService.showError(
                                          context,
                                          context.t.settings.integrations
                                              .protocolRemoveError);
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(LucideIcons.unlink, size: 18),
                          label:
                              Text(context.t.settings.integrations.unregister),
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
    final materials = [
      ('sidebar', context.t.settings.integrations.materials.sidebar),
      ('menu', context.t.settings.integrations.materials.menu),
      ('popover', context.t.settings.integrations.materials.popover),
      ('titlebar', context.t.settings.integrations.materials.titlebar),
      (
        'underPageBackground',
        context.t.settings.integrations.materials.underPageBackground
      ),
      (
        'contentBackground',
        context.t.settings.integrations.materials.contentBackground
      ),
    ];

    return Column(
      children: [
        SettingsCardContainer(
          title: context.t.settings.integrations.visualEffects,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: context.t.settings.integrations.windowMaterial,
              description:
                  context.t.settings.integrations.windowMaterialDescription,
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
          title: context.t.settings.integrations.dockIntegration,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: context.t.settings.integrations.showDockBadge,
              description:
                  context.t.settings.integrations.showDockBadgeDescription,
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
