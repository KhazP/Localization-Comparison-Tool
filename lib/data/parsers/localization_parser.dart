import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';

abstract class LocalizationParser {
  Future<Map<String, String>> parse(File file, AppSettings settings);
  List<String> getSupportedExtensions();
} 