import 'dart:io';
import 'package:equatable/equatable.dart';

class FilePair extends Equatable {
  final File sourceFile;
  final File targetFile;

  const FilePair({required this.sourceFile, required this.targetFile});

  @override
  List<Object> get props => [sourceFile.path, targetFile.path];
} 