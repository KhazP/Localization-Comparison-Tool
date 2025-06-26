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
      defaultSourceFormat: fields[0] as String,
      defaultTargetFormat: fields[1] as String,
      ignorePatterns: (fields[2] as List).cast<String>(),
      ignoreCase: fields[3] as bool,
      ignoreWhitespace: fields[4] as bool,
      appLanguage: fields[5] as String,
      defaultViewOnStartup: fields[6] as String,
      autoCheckForUpdates: fields[7] as bool,
      appThemeMode: fields[8] as String,
      accentColorValue: fields[9] as int,
      diffAddedColor: fields[10] as int,
      diffRemovedColor: fields[11] as int,
      diffModifiedColor: fields[12] as int,
      defaultSourceEncoding: fields[13] as String,
      defaultTargetEncoding: fields[14] as String,
      autoDetectEncoding: fields[15] as bool,
      csvDelimiter: fields[16] as String,
      handleByteOrderMark: fields[17] as bool,
      autoReloadOnChange: fields[18] as bool,
      defaultExportDirectory: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(20)
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
      ..write(obj.defaultExportDirectory);
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
