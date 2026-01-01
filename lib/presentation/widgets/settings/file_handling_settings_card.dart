import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_constants.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';

class FileHandlingSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const FileHandlingSettingsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  Future<void> _pickBackupDirectory(BuildContext context) async {
    final selected = await FilePicker.platform.getDirectoryPath();
    if (selected == null) return;
    
    if (context.mounted) {
      context.read<SettingsBloc>().add(UpdateBackupDirectory(selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsCardContainer(
          title: 'File Formats',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Source Format',
              control: SettingsDropdown(
                value: settings.defaultSourceFormat,
                items: ['Auto', ...SettingsConstants.fileFormats],
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateDefaultSourceFormat(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Target Format',
              control: SettingsDropdown(
                value: settings.defaultTargetFormat,
                items: ['Auto', ...SettingsConstants.fileFormats],
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateDefaultTargetFormat(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Encoding',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Source Encoding',
              control: SettingsDropdown(
                value: settings.defaultSourceEncoding,
                items: SettingsConstants.encodings,
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateDefaultSourceEncoding(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Target Encoding',
              control: SettingsDropdown(
                value: settings.defaultTargetEncoding,
                items: SettingsConstants.encodings,
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateDefaultTargetEncoding(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Auto-Detect',
              description: 'Automatically detect file encoding',
              control: Switch(
                value: settings.autoDetectEncoding,
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoDetectEncoding(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'Export Settings',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Default Export Format',
              control: SettingsDropdown(
                value: settings.defaultExportFormat,
                items: const ['CSV', 'JSON', 'Excel'],
                onChanged: (val) {
                  if (val != null) {
                    context.read<SettingsBloc>().add(UpdateDefaultExportFormat(val));
                  }
                },
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Include UTF-8 BOM',
              description: 'Required for Excel compatibility',
              control: Switch(
                value: settings.includeUtf8Bom,
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateIncludeUtf8Bom(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Open Folder After Export',
              control: Switch(
                value: settings.openFolderAfterExport,
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateOpenFolderAfterExport(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        SettingsCardContainer(
          title: 'File Safety',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                'Automatic local copies for disaster recovery.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled).textMutedColor,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ),
            SettingsRow(
              label: 'Auto-Backup',
              description: 'Create backup before overwriting files',
              control: Switch(
                value: settings.autoBackup,
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoBackup(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Backup Folder',
              description: 'Leave empty to use the same folder',
              control: SizedBox(
                width: 320,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: settings.backupDirectory),
                        onChanged: (value) => context.read<SettingsBloc>().add(UpdateBackupDirectory(value)),
                        decoration: InputDecoration(
                          hintText: 'Use original file folder',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () => _pickBackupDirectory(context),
                      icon: const Icon(Icons.folder_open_rounded, size: 18),
                      label: const Text('Browse'),
                    ),
                  ],
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Backups to Keep',
              description: 'Number of backup copies to retain',
              control: SizedBox(
                width: 150,
                child: Slider(
                  value: settings.backupsToKeep.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: settings.backupsToKeep.toString(),
                  onChanged: (val) => context.read<SettingsBloc>().add(UpdateBackupsToKeep(val.round())),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
      ],
    );
  }
}
