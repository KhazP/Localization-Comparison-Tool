import 'package:bloc/bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';

import 'file_handling_event.dart';
import 'file_handling_state.dart';

export 'file_handling_event.dart';
export 'file_handling_state.dart';

class FileHandlingBloc extends Bloc<FileHandlingEvent, FileHandlingState> {
  final SettingsRepository _settingsRepository;

  FileHandlingBloc({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(FileHandlingState.initial()) {
    on<LoadFileHandlingSettings>(_onLoadFileHandlingSettings);
    on<UpdateDefaultSourceEncoding>(_onUpdateDefaultSourceEncoding);
    on<UpdateDefaultTargetEncoding>(_onUpdateDefaultTargetEncoding);
    on<UpdateAutoDetectEncoding>(_onUpdateAutoDetectEncoding);
    on<UpdateCsvDelimiter>(_onUpdateCsvDelimiter);
    on<UpdateHandleByteOrderMark>(_onUpdateHandleByteOrderMark);
    on<UpdateAutoReloadOnChange>(_onUpdateAutoReloadOnChange);
    on<UpdateDefaultExportDirectory>(_onUpdateDefaultExportDirectory);
    on<UpdateDefaultExportFormat>(_onUpdateDefaultExportFormat);
    on<UpdateIncludeUtf8Bom>(_onUpdateIncludeUtf8Bom);
    on<UpdateOpenFolderAfterExport>(_onUpdateOpenFolderAfterExport);
    on<UpdateAutoBackup>(_onUpdateAutoBackup);
    on<UpdateBackupDirectory>(_onUpdateBackupDirectory);
    on<UpdateBackupsToKeep>(_onUpdateBackupsToKeep);
    on<ResetFileHandlingSettings>(_onResetFileHandlingSettings);
  }

  Future<void> _saveSettings(AppSettings Function(AppSettings) updater) async {
    final settings = await _settingsRepository.loadSettings();
    final newSettings = updater(settings);
    await _settingsRepository.saveSettings(newSettings);
  }

  Future<void> _onLoadFileHandlingSettings(
    LoadFileHandlingSettings event,
    Emitter<FileHandlingState> emit,
  ) async {
    emit(state.copyWith(status: FileHandlingStatus.loading));
    try {
      final settings = await _settingsRepository.loadSettings();
      emit(FileHandlingState(
        defaultSourceEncoding: settings.defaultSourceEncoding,
        defaultTargetEncoding: settings.defaultTargetEncoding,
        autoDetectEncoding: settings.autoDetectEncoding,
        csvDelimiter: settings.csvDelimiter,
        handleByteOrderMark: settings.handleByteOrderMark,
        autoReloadOnChange: settings.autoReloadOnChange,
        defaultExportDirectory: settings.defaultExportDirectory,
        defaultExportFormat: settings.defaultExportFormat,
        includeUtf8Bom: settings.includeUtf8Bom,
        openFolderAfterExport: settings.openFolderAfterExport,
        autoBackup: settings.autoBackup,
        backupDirectory: settings.backupDirectory,
        backupsToKeep: settings.backupsToKeep,
        status: FileHandlingStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FileHandlingStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateDefaultSourceEncoding(
    UpdateDefaultSourceEncoding event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(defaultSourceEncoding: event.encoding));
    emit(state.copyWith(defaultSourceEncoding: event.encoding));
  }

  Future<void> _onUpdateDefaultTargetEncoding(
    UpdateDefaultTargetEncoding event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(defaultTargetEncoding: event.encoding));
    emit(state.copyWith(defaultTargetEncoding: event.encoding));
  }

  Future<void> _onUpdateAutoDetectEncoding(
    UpdateAutoDetectEncoding event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(autoDetectEncoding: event.autoDetect));
    emit(state.copyWith(autoDetectEncoding: event.autoDetect));
  }

  Future<void> _onUpdateCsvDelimiter(
    UpdateCsvDelimiter event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(csvDelimiter: event.delimiter));
    emit(state.copyWith(csvDelimiter: event.delimiter));
  }

  Future<void> _onUpdateHandleByteOrderMark(
    UpdateHandleByteOrderMark event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(handleByteOrderMark: event.handle));
    emit(state.copyWith(handleByteOrderMark: event.handle));
  }

  Future<void> _onUpdateAutoReloadOnChange(
    UpdateAutoReloadOnChange event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(autoReloadOnChange: event.enabled));
    emit(state.copyWith(autoReloadOnChange: event.enabled));
  }

  Future<void> _onUpdateDefaultExportDirectory(
    UpdateDefaultExportDirectory event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(defaultExportDirectory: event.directory));
    emit(state.copyWith(defaultExportDirectory: event.directory));
  }

  Future<void> _onUpdateDefaultExportFormat(
    UpdateDefaultExportFormat event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(defaultExportFormat: event.format));
    emit(state.copyWith(defaultExportFormat: event.format));
  }

  Future<void> _onUpdateIncludeUtf8Bom(
    UpdateIncludeUtf8Bom event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(includeUtf8Bom: event.enable));
    emit(state.copyWith(includeUtf8Bom: event.enable));
  }

  Future<void> _onUpdateOpenFolderAfterExport(
    UpdateOpenFolderAfterExport event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(openFolderAfterExport: event.enable));
    emit(state.copyWith(openFolderAfterExport: event.enable));
  }

  Future<void> _onUpdateAutoBackup(
    UpdateAutoBackup event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(autoBackup: event.enable));
    emit(state.copyWith(autoBackup: event.enable));
  }

  Future<void> _onUpdateBackupDirectory(
    UpdateBackupDirectory event,
    Emitter<FileHandlingState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(backupDirectory: event.directory.trim()));
    emit(state.copyWith(backupDirectory: event.directory.trim()));
  }

  Future<void> _onUpdateBackupsToKeep(
    UpdateBackupsToKeep event,
    Emitter<FileHandlingState> emit,
  ) async {
    final clampedCount = event.count.clamp(1, 10);
    await _saveSettings((s) => s.copyWith(backupsToKeep: clampedCount));
    emit(state.copyWith(backupsToKeep: clampedCount));
  }

  Future<void> _onResetFileHandlingSettings(
    ResetFileHandlingSettings event,
    Emitter<FileHandlingState> emit,
  ) async {
    final defaults = AppSettings.defaultSettings();
    await _saveSettings((s) => s.copyWith(
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
        ));
    emit(FileHandlingState(
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
      status: FileHandlingStatus.loaded,
    ));
  }
}
