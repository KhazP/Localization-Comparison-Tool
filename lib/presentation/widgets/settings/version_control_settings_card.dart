import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

class VersionControlSettingsCard extends StatelessWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const VersionControlSettingsCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SettingsCardContainer(
          title: 'Version History',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                'Track changes over time with Git.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ),
            SettingsRow(
              label: 'Enable Git',
              description: 'Enable version control features',
              control: Switch(
                value: settings.enableGitIntegration,
                onChanged: (val) => bloc.add(UpdateEnableGitIntegration(val)),
                activeColor: colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Auto-Commit',
              description: 'Commit changes on save',
              control: Switch(
                value: settings.autoCommitOnSave,
                onChanged: (val) => bloc.add(UpdateAutoCommitOnSave(val)),
                activeColor: colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        
        SettingsCardContainer(
          title: 'Git User',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildTextFieldRow(context, 'Name', settings.gitUserName, (val) {
              bloc.add(UpdateGitUserName(val));
            }),
            _buildTextFieldRow(context, 'Email', settings.gitUserEmail, (val) {
              bloc.add(UpdateGitUserEmail(val));
            }, showDivider: false),
          ],
        ),

        SettingsCardContainer(
          title: 'Git Defaults',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            SettingsRow(
              label: 'Default Branch',
              description: 'Branch to use for new comparisons',
              control: SizedBox(
                width: 150,
                child: TextField(
                  controller: TextEditingController(text: settings.defaultBranch),
                  onChanged: (val) => bloc.add(UpdateDefaultBranch(val)),
                  decoration: const InputDecoration(
                    hintText: 'main',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            SettingsRow(
              label: 'Default Remote',
              description: 'Remote to use for push/pull operations',
              control: SizedBox(
                width: 150,
                child: TextField(
                  controller: TextEditingController(text: settings.defaultRemote),
                  onChanged: (val) => bloc.add(UpdateDefaultRemote(val)),
                  decoration: const InputDecoration(
                    hintText: 'origin',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),

        SettingsCardContainer(
          title: 'Commit Templates',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLines: 2,
                    controller: TextEditingController(text: settings.commitMessageTemplate),
                    onChanged: (val) => bloc.add(UpdateCommitMessageTemplate(val)),
                    decoration: InputDecoration(
                      labelText: 'Commit Message Template',
                      hintText: 'Update localization: {files}',
                      helperText: 'Variables: {date}, {files}, {added}, {removed}, {modified}',
                      helperMaxLines: 2,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Presets',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildPresetChip(context, 'Simple', 'Update localization: {files}'),
                      _buildPresetChip(context, 'Detailed', '[{date}] Localization update\n\nModified: {modified}\nAdded: {added}\nRemoved: {removed}'),
                      _buildPresetChip(context, 'Conventional', 'chore(i18n): update translations\n\nFiles: {files}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        SettingsCardContainer(
          title: 'SSH Configuration',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: settings.sshKeyPath),
                          onChanged: (val) => bloc.add(UpdateSshKeyPath(val)),
                          decoration: InputDecoration(
                            labelText: 'SSH Key Path',
                            hintText: Platform.isWindows ? r'C:\Users\....\.ssh\id_rsa' : '~/.ssh/id_rsa',
                            helperText: 'Path to your private SSH key for Git operations',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.folder_open),
                        tooltip: 'Browse...',
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            dialogTitle: 'Select SSH Private Key',
                            type: FileType.any,
                          );
                          if (result != null && result.files.isNotEmpty) {
                            final path = result.files.first.path;
                            if (path != null) bloc.add(UpdateSshKeyPath(path));
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.content_copy, size: 18),
                        label: const Text('Copy Public Key'),
                        onPressed: settings.sshKeyPath.isEmpty ? null : () async {
                          final pubKeyPath = '${settings.sshKeyPath}.pub';
                          try {
                            final file = File(pubKeyPath);
                            if (await file.exists()) {
                              final content = await file.readAsString();
                              await Clipboard.setData(ClipboardData(text: content.trim()));
                              if (context.mounted) ToastService.showSuccess(context, 'Public key copied to clipboard!');
                            } else {
                              if (context.mounted) ToastService.showError(context, 'Public key not found: $pubKeyPath');
                            }
                          } catch (e) {
                            if (context.mounted) ToastService.showError(context, 'Error reading public key: $e');
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Copies {key}.pub to clipboard',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isDark ? Colors.grey[500] : Colors.grey[600],
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

  Widget _buildTextFieldRow(BuildContext context, String label, String value, ValueChanged<String> onChanged, {bool showDivider = true}) {
    return SettingsRow(
      label: label,
      control: SizedBox(
        width: 200,
        child: TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      isDark: isDark,
      isAmoled: isAmoled,
      showDivider: showDivider,
    );
  }

  Widget _buildPresetChip(BuildContext context, String label, String template) {
    return ActionChip(
      label: Text(label),
      onPressed: () => context.read<SettingsBloc>().add(UpdateCommitMessageTemplate(template)),
      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
      side: BorderSide.none,
    );
  }
}
