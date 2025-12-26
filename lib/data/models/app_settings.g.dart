// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 2;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      defaultSourceFormat: fields[0] == null ? 'json' : fields[0] as String,
      defaultTargetFormat: fields[1] == null ? 'json' : fields[1] as String,
      ignorePatterns: fields[2] == null
          ? ['^//.*', '^#.*']
          : (fields[2] as List).cast<String>(),
      ignoreCase: fields[3] == null ? true : fields[3] as bool,
      ignoreWhitespace: fields[4] == null ? false : fields[4] as bool,
      appLanguage: fields[5] == null ? 'English (US)' : fields[5] as String,
      defaultViewOnStartup:
          fields[6] == null ? 'Basic Comparison' : fields[6] as String,
      autoCheckForUpdates: fields[7] == null ? true : fields[7] as bool,
      appThemeMode: fields[8] == null ? 'System' : fields[8] as String,
      accentColorValue: fields[9] == null ? 4286276095 : fields[9] as int,
      diffAddedColor: fields[10] == null ? 4283215696 : fields[10] as int,
      diffRemovedColor: fields[11] == null ? 4294198070 : fields[11] as int,
      diffModifiedColor: fields[12] == null ? 4294951175 : fields[12] as int,
      diffFontSize: fields[37] == null ? 14.0 : fields[37] as double,
      defaultSourceEncoding:
          fields[13] == null ? 'UTF-8' : fields[13] as String,
      defaultTargetEncoding:
          fields[14] == null ? 'UTF-8' : fields[14] as String,
      autoDetectEncoding: fields[15] == null ? true : fields[15] as bool,
      csvDelimiter: fields[16] == null ? ',' : fields[16] as String,
      handleByteOrderMark: fields[17] == null ? true : fields[17] as bool,
      autoReloadOnChange: fields[18] == null ? true : fields[18] as bool,
      defaultExportDirectory: fields[19] == null ? '' : fields[19] as String,
      aiTranslationService:
          fields[20] == null ? 'Google Translate' : fields[20] as String,
      googleTranslateApiKey: fields[21] == null ? '' : fields[21] as String,
      deeplApiKey: fields[22] == null ? '' : fields[22] as String,
      enableAiTranslation: fields[23] == null ? false : fields[23] as bool,
      translationConfidenceThreshold:
          fields[24] == null ? 0.8 : fields[24] as double,
      geminiApiKey: fields[30] == null ? '' : fields[30] as String,
      openaiApiKey: fields[31] == null ? '' : fields[31] as String,
      defaultAiModel: fields[32] == null ? '' : fields[32] as String,
      systemTranslationContext: fields[33] == null ? '' : fields[33] as String,
      contextStringsCount: fields[34] == null ? 2 : fields[34] as int,
      includeContextStrings: fields[35] == null ? false : fields[35] as bool,
      defaultGitRepositoryPath: fields[25] == null ? '' : fields[25] as String,
      autoCommitOnSave: fields[26] == null ? false : fields[26] as bool,
      gitUserName: fields[27] == null ? '' : fields[27] as String,
      gitUserEmail: fields[28] == null ? '' : fields[28] as String,
      enableGitIntegration: fields[29] == null ? false : fields[29] as bool,
      showIdenticalEntries: fields[36] == null ? true : fields[36] as bool,
      startMinimizedToTray: fields[38] == null ? false : fields[38] as bool,
      openLastProjectOnStartup: fields[39] == null ? false : fields[39] as bool,
      rememberWindowPosition: fields[40] == null ? false : fields[40] as bool,
      lastWindowX: fields[41] as double?,
      lastWindowY: fields[42] as double?,
      lastWindowWidth: fields[43] as double?,
      lastWindowHeight: fields[44] as double?,
      similarityThreshold: fields[45] == null ? 0.85 : fields[45] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(46)
      ..writeByte(0)
      ..write(obj.defaultSourceFormat)
      ..writeByte(1)
      ..write(obj.defaultTargetFormat)
      ..writeByte(2)
      ..write(obj.ignorePatterns)
      ..writeByte(3)
      ..write(obj.ignoreCase)
      ..writeByte(4)
      ..write(obj.ignoreWhitespace)
      ..writeByte(5)
      ..write(obj.appLanguage)
      ..writeByte(6)
      ..write(obj.defaultViewOnStartup)
      ..writeByte(7)
      ..write(obj.autoCheckForUpdates)
      ..writeByte(8)
      ..write(obj.appThemeMode)
      ..writeByte(9)
      ..write(obj.accentColorValue)
      ..writeByte(10)
      ..write(obj.diffAddedColor)
      ..writeByte(11)
      ..write(obj.diffRemovedColor)
      ..writeByte(12)
      ..write(obj.diffModifiedColor)
      ..writeByte(37)
      ..write(obj.diffFontSize)
      ..writeByte(13)
      ..write(obj.defaultSourceEncoding)
      ..writeByte(14)
      ..write(obj.defaultTargetEncoding)
      ..writeByte(15)
      ..write(obj.autoDetectEncoding)
      ..writeByte(16)
      ..write(obj.csvDelimiter)
      ..writeByte(17)
      ..write(obj.handleByteOrderMark)
      ..writeByte(18)
      ..write(obj.autoReloadOnChange)
      ..writeByte(19)
      ..write(obj.defaultExportDirectory)
      ..writeByte(20)
      ..write(obj.aiTranslationService)
      ..writeByte(21)
      ..write(obj.googleTranslateApiKey)
      ..writeByte(22)
      ..write(obj.deeplApiKey)
      ..writeByte(23)
      ..write(obj.enableAiTranslation)
      ..writeByte(24)
      ..write(obj.translationConfidenceThreshold)
      ..writeByte(30)
      ..write(obj.geminiApiKey)
      ..writeByte(31)
      ..write(obj.openaiApiKey)
      ..writeByte(32)
      ..write(obj.defaultAiModel)
      ..writeByte(33)
      ..write(obj.systemTranslationContext)
      ..writeByte(34)
      ..write(obj.contextStringsCount)
      ..writeByte(35)
      ..write(obj.includeContextStrings)
      ..writeByte(25)
      ..write(obj.defaultGitRepositoryPath)
      ..writeByte(26)
      ..write(obj.autoCommitOnSave)
      ..writeByte(27)
      ..write(obj.gitUserName)
      ..writeByte(28)
      ..write(obj.gitUserEmail)
      ..writeByte(29)
      ..write(obj.enableGitIntegration)
      ..writeByte(36)
      ..write(obj.showIdenticalEntries)
      ..writeByte(38)
      ..write(obj.startMinimizedToTray)
      ..writeByte(39)
      ..write(obj.openLastProjectOnStartup)
      ..writeByte(40)
      ..write(obj.rememberWindowPosition)
      ..writeByte(41)
      ..write(obj.lastWindowX)
      ..writeByte(42)
      ..write(obj.lastWindowY)
      ..writeByte(43)
      ..write(obj.lastWindowWidth)
      ..writeByte(44)
      ..write(obj.lastWindowHeight)
      ..writeByte(45)
      ..write(obj.similarityThreshold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
