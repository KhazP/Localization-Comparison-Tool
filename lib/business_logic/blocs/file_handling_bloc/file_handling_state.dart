import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

enum FileHandlingStatus { initial, loading, loaded, error }

class FileHandlingState extends Equatable {
  final String defaultSourceEncoding;
  final String defaultTargetEncoding;
  final bool autoDetectEncoding;
  final String csvDelimiter;
  final bool handleByteOrderMark;
  final bool autoReloadOnChange;
  final String defaultExportDirectory;
  final String defaultExportFormat;
  final bool includeUtf8Bom;
  final bool openFolderAfterExport;
  final bool autoBackup;
  final String backupDirectory;
  final int backupsToKeep;
  final FileHandlingStatus status;
  final String? errorMessage;

  const FileHandlingState({
    required this.defaultSourceEncoding,
    required this.defaultTargetEncoding,
    required this.autoDetectEncoding,
    required this.csvDelimiter,
    required this.handleByteOrderMark,
    required this.autoReloadOnChange,
    required this.defaultExportDirectory,
    required this.defaultExportFormat,
    required this.includeUtf8Bom,
    required this.openFolderAfterExport,
    required this.autoBackup,
    required this.backupDirectory,
    required this.backupsToKeep,
    this.status = FileHandlingStatus.initial,
    this.errorMessage,
  });

  factory FileHandlingState.initial() {
    final defaults = AppSettings.defaultSettings();
    return FileHandlingState(
      defaultSourceEncoding: defaults.defaultSourceEncoding,
      defaultTargetEncoding: defaults.defaultTargetEncoding,
      autoDetectEncoding: defaults.autoDetectEncoding,
      csvDelimiter: defaults.csvDelimiter,
      handleByteOrderMark: defaults.handleByteOrderMark,
      autoReloadOnChange: defaults.autoReloadOnChange,
      defaultExportDirectory: defaults.defaultExportDirectory,
      defaultExportFormat: defaults.defaultExportFormat,
      includeUtf8Bom: defaults.includeUtf8Bom,
      openFolderAfterExport: defaults.openFolderAfterExport,
      autoBackup: defaults.autoBackup,
      backupDirectory: defaults.backupDirectory,
      backupsToKeep: defaults.backupsToKeep,
    );
  }

  FileHandlingState copyWith({
    String? defaultSourceEncoding,
    String? defaultTargetEncoding,
    bool? autoDetectEncoding,
    String? csvDelimiter,
    bool? handleByteOrderMark,
    bool? autoReloadOnChange,
    String? defaultExportDirectory,
    String? defaultExportFormat,
    bool? includeUtf8Bom,
    bool? openFolderAfterExport,
    bool? autoBackup,
    String? backupDirectory,
    int? backupsToKeep,
    FileHandlingStatus? status,
    String? errorMessage,
  }) {
    return FileHandlingState(
      defaultSourceEncoding:
          defaultSourceEncoding ?? this.defaultSourceEncoding,
      defaultTargetEncoding:
          defaultTargetEncoding ?? this.defaultTargetEncoding,
      autoDetectEncoding: autoDetectEncoding ?? this.autoDetectEncoding,
      csvDelimiter: csvDelimiter ?? this.csvDelimiter,
      handleByteOrderMark: handleByteOrderMark ?? this.handleByteOrderMark,
      autoReloadOnChange: autoReloadOnChange ?? this.autoReloadOnChange,
      defaultExportDirectory:
          defaultExportDirectory ?? this.defaultExportDirectory,
      defaultExportFormat: defaultExportFormat ?? this.defaultExportFormat,
      includeUtf8Bom: includeUtf8Bom ?? this.includeUtf8Bom,
      openFolderAfterExport:
          openFolderAfterExport ?? this.openFolderAfterExport,
      autoBackup: autoBackup ?? this.autoBackup,
      backupDirectory: backupDirectory ?? this.backupDirectory,
      backupsToKeep: backupsToKeep ?? this.backupsToKeep,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        defaultSourceEncoding,
        defaultTargetEncoding,
        autoDetectEncoding,
        csvDelimiter,
        handleByteOrderMark,
        autoReloadOnChange,
        defaultExportDirectory,
        defaultExportFormat,
        includeUtf8Bom,
        openFolderAfterExport,
        autoBackup,
        backupDirectory,
        backupsToKeep,
        status,
        errorMessage,
      ];
}
