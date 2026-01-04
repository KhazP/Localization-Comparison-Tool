import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'dart:developer' as developer;

class GlobalTranslationMemoryCard extends StatefulWidget {
  final AppSettings settings;
  final TranslationMemoryService? translationMemoryService;
  final Future<TranslationMemoryStats>? translationMemoryStatsFuture;
  final VoidCallback onRefreshStats;
  final bool isDark;
  final bool isAmoled;

  const GlobalTranslationMemoryCard({
    super.key,
    required this.settings,
    this.translationMemoryService,
    this.translationMemoryStatsFuture,
    required this.onRefreshStats,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  State<GlobalTranslationMemoryCard> createState() =>
      _GlobalTranslationMemoryCardState();
}

class _GlobalTranslationMemoryCardState
    extends State<GlobalTranslationMemoryCard> {
  bool _busy = false;

  Future<void> _runAction(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  String _formatMemorySize(int bytes) {
    if (bytes <= 0) return '0 KB';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }

  Future<void> _import(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    await _runAction(() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['tmx', 'csv'],
      );
      if (result == null || result.files.single.path == null) return;
      final file = File(result.files.single.path!);
      final imported = await service.importFromFile(file);
      widget.onRefreshStats();
      if (!mounted) return;
      final message = imported > 0
          ? 'Imported $imported items into memory.'
          : 'No items were added.';
      ToastService.showInfo(context, message);
    });
  }

  Future<void> _exportTmx(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    await _runAction(() async {
      final stats = await service.getStats();
      if (stats.entryCount == 0) {
        if (mounted) {
          ToastService.showWarning(context, 'Nothing to export yet.');
        }
        return;
      }
      final outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Export TMX',
        fileName: 'translation_memory.tmx',
        type: FileType.custom,
        allowedExtensions: ['tmx'],
      );
      if (outputPath == null) return;
      await service.exportToTmx(File(outputPath));
      if (mounted) {
        ToastService.showSuccessWithAction(
          context,
          'TMX saved',
          actionLabel: 'Open',
          onAction: () => OpenFile.open(outputPath),
        );
      }
    });
  }

  Future<void> _exportCsv(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    await _runAction(() async {
      final stats = await service.getStats();
      if (stats.entryCount == 0) {
        if (mounted) {
          ToastService.showWarning(context, 'Nothing to export yet.');
        }
        return;
      }
      final outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Export CSV',
        fileName: 'translation_memory.csv',
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (outputPath == null) return;
      await service.exportToCsv(File(outputPath));
      if (mounted) {
        ToastService.showSuccessWithAction(
          context,
          'CSV saved',
          actionLabel: 'Open',
          onAction: () => OpenFile.open(outputPath),
        );
      }
    });
  }

  Future<void> _clear(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    final confirm = await DialogService.showConfirmation(
      context: context,
      title: 'Clear translation memory?',
      content:
          'This removes all saved translation pairs on this device. This action cannot be undone.',
      confirmText: 'Clear Memory',
      isDestructive: true,
      icon: LucideIcons.trash2,
    );

    if (confirm != true) return;

    await _runAction(() async {
      try {
        await service.clearMemory();
        widget.onRefreshStats();
        if (mounted) {
          ToastService.showSuccess(context, 'Translation memory cleared.');
        }
      } catch (e, s) {
        developer.log('Failed to clear translation memory.',
            name: 'translation_memory.clear', error: e, stackTrace: s);
        if (mounted) ToastService.showError(context, 'Could not clear memory.');
      }
    });
  }

  Widget _buildStatItem(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: widget.isDark
                    ? AppThemeV2.darkTextMuted
                    : AppThemeV2.lightTextMuted,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();

    return SettingsCardContainer(
      title: 'Global Translation Memory',
      isDark: widget.isDark,
      isAmoled: widget.isAmoled,
      children: [
        SettingsRow(
          label: 'Auto-learn',
          description: 'Save translations to local memory for future reuse',
          control: Switch(
            value: widget.settings.enableTranslationMemory,
            onChanged: (val) => bloc.add(UpdateEnableTranslationMemory(val)),
          ),
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
        ),
        SettingsRow(
          label: 'Confidence Threshold',
          description:
              'Minimum score to auto-apply (${(widget.settings.translationConfidenceThreshold * 100).toInt()}%)',
          control: SizedBox(
            width: 150,
            child: Slider(
              value: widget.settings.translationConfidenceThreshold,
              onChanged: (val) =>
                  bloc.add(UpdateTranslationConfidenceThreshold(val)),
            ),
          ),
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
        ),
        FutureBuilder<TranslationMemoryStats>(
          future: widget.translationMemoryStatsFuture,
          builder: (context, snapshot) {
            final stats = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildStatItem('Entries',
                          stats?.entryCount.toString() ?? '...', context),
                      const SizedBox(width: 24),
                      _buildStatItem(
                          'Size',
                          stats != null
                              ? 'Memory Size: ${_formatMemorySize(stats.storageBytes)}'
                              : '...',
                          context),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton.icon(
                        onPressed: _busy ? null : () => _import(context),
                        icon: const Icon(LucideIcons.download, size: 18),
                        label: const Text('Import'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _busy ? null : () => _exportTmx(context),
                        icon: const Icon(LucideIcons.upload, size: 18),
                        label: const Text('Export TMX'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _busy ? null : () => _exportCsv(context),
                        icon: const Icon(LucideIcons.table, size: 18),
                        label: const Text('Export CSV'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _busy ? null : () => _clear(context),
                        icon: Icon(LucideIcons.trash2,
                            size: 18, color: AppThemeV2.error),
                        label: Text('Clear Memory',
                            style: TextStyle(color: AppThemeV2.error)),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color:
                                    AppThemeV2.error.withValues(alpha: 0.5))),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
