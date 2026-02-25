import 'package:equatable/equatable.dart';

abstract class FileHandlingEvent extends Equatable {
  const FileHandlingEvent();

  @override
  List<Object?> get props => [];
}

class LoadFileHandlingSettings extends FileHandlingEvent {}

class UpdateDefaultSourceEncoding extends FileHandlingEvent {
  final String encoding;
  const UpdateDefaultSourceEncoding(this.encoding);
  @override
  List<Object> get props => [encoding];
}

class UpdateDefaultTargetEncoding extends FileHandlingEvent {
  final String encoding;
  const UpdateDefaultTargetEncoding(this.encoding);
  @override
  List<Object> get props => [encoding];
}

class UpdateAutoDetectEncoding extends FileHandlingEvent {
  final bool autoDetect;
  const UpdateAutoDetectEncoding(this.autoDetect);
  @override
  List<Object> get props => [autoDetect];
}

class UpdateCsvDelimiter extends FileHandlingEvent {
  final String delimiter;
  const UpdateCsvDelimiter(this.delimiter);
  @override
  List<Object> get props => [delimiter];
}

class UpdateHandleByteOrderMark extends FileHandlingEvent {
  final bool handle;
  const UpdateHandleByteOrderMark(this.handle);
  @override
  List<Object> get props => [handle];
}

class UpdateAutoReloadOnChange extends FileHandlingEvent {
  final bool enabled;
  const UpdateAutoReloadOnChange(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateDefaultExportDirectory extends FileHandlingEvent {
  final String directory;
  const UpdateDefaultExportDirectory(this.directory);
  @override
  List<Object> get props => [directory];
}

class UpdateDefaultExportFormat extends FileHandlingEvent {
  final String format;
  const UpdateDefaultExportFormat(this.format);
  @override
  List<Object> get props => [format];
}

class UpdateIncludeUtf8Bom extends FileHandlingEvent {
  final bool enable;
  const UpdateIncludeUtf8Bom(this.enable);
  @override
  List<Object> get props => [enable];
}

class UpdateOpenFolderAfterExport extends FileHandlingEvent {
  final bool enable;
  const UpdateOpenFolderAfterExport(this.enable);
  @override
  List<Object> get props => [enable];
}

class UpdateAutoBackup extends FileHandlingEvent {
  final bool enable;
  const UpdateAutoBackup(this.enable);
  @override
  List<Object> get props => [enable];
}

class UpdateBackupDirectory extends FileHandlingEvent {
  final String directory;
  const UpdateBackupDirectory(this.directory);
  @override
  List<Object> get props => [directory];
}

class UpdateBackupsToKeep extends FileHandlingEvent {
  final int count;
  const UpdateBackupsToKeep(this.count);
  @override
  List<Object> get props => [count];
}

class ResetFileHandlingSettings extends FileHandlingEvent {}
