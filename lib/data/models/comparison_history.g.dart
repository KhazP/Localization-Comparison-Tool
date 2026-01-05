// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comparison_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComparisonSessionAdapter extends TypeAdapter<ComparisonSession> {
  @override
  final int typeId = 0;

  @override
  ComparisonSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComparisonSession(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      file1Path: fields[2] as String,
      file2Path: fields[3] as String,
      stringsAdded: fields[4] as int,
      stringsRemoved: fields[5] as int,
      stringsModified: fields[6] as int,
      stringsIdentical: fields[7] as int,
      sourceKeyCount: fields[8] as int?,
      translatedKeyCount: fields[9] as int?,
      sourceWordCount: fields[10] as int?,
      translatedWordCount: fields[11] as int?,
      projectId: fields[12] as String?,
      type: fields[13] as ComparisonType?,
      gitRepoPath: fields[14] as String?,
      gitBranch1: fields[15] as String?,
      gitBranch2: fields[16] as String?,
      gitCommit1: fields[17] as String?,
      gitCommit2: fields[18] as String?,
      fileCount: fields[19] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ComparisonSession obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.file1Path)
      ..writeByte(3)
      ..write(obj.file2Path)
      ..writeByte(4)
      ..write(obj.stringsAdded)
      ..writeByte(5)
      ..write(obj.stringsRemoved)
      ..writeByte(6)
      ..write(obj.stringsModified)
      ..writeByte(7)
      ..write(obj.stringsIdentical)
      ..writeByte(8)
      ..write(obj.sourceKeyCount)
      ..writeByte(9)
      ..write(obj.translatedKeyCount)
      ..writeByte(10)
      ..write(obj.sourceWordCount)
      ..writeByte(11)
      ..write(obj.translatedWordCount)
      ..writeByte(12)
      ..write(obj.projectId)
      ..writeByte(13)
      ..write(obj.type)
      ..writeByte(14)
      ..write(obj.gitRepoPath)
      ..writeByte(15)
      ..write(obj.gitBranch1)
      ..writeByte(16)
      ..write(obj.gitBranch2)
      ..writeByte(17)
      ..write(obj.gitCommit1)
      ..writeByte(18)
      ..write(obj.gitCommit2)
      ..writeByte(19)
      ..write(obj.fileCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComparisonSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ComparisonTypeAdapter extends TypeAdapter<ComparisonType> {
  @override
  final int typeId = 1;

  @override
  ComparisonType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ComparisonType.file;
      case 1:
        return ComparisonType.directory;
      case 2:
        return ComparisonType.git;
      default:
        return ComparisonType.file;
    }
  }

  @override
  void write(BinaryWriter writer, ComparisonType obj) {
    switch (obj) {
      case ComparisonType.file:
        writer.writeByte(0);
        break;
      case ComparisonType.directory:
        writer.writeByte(1);
        break;
      case ComparisonType.git:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComparisonTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
