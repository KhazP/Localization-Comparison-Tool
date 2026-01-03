import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:docx_to_text/docx_to_text.dart';

class DocxParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(
    File file,
    AppSettings settings, {
    ExtractionMode extractionMode = ExtractionMode.target,
    bool requireBilingual = false,
    ParseProgressCallback? onProgress,
  }) async {
    // Note: The AppSettings for encoding are not applicable here because
    // docx_to_text package works directly on the byte stream of the DOCX file.
    final Map<String, String> translations = {};
    try {
      final bytes = await file.readAsBytes();
      final text = docxToText(bytes);

      final lines = text.split('\n');
      for (final line in lines) {
        final trimmedLine = line.trim();
        if (trimmedLine.isNotEmpty) {
          // For DOCX, use each line of extracted text as both key and value
          translations[trimmedLine] = trimmedLine;
        }
      }
      if (translations.isEmpty && text.trim().isNotEmpty) {
        debugPrint(
            'Warning: Parsed .docx file ${file.path} but no non-empty lines found after text extraction.');
      }
    } catch (e) {
      debugPrint('Error parsing .docx file ${file.path}: $e');
      // Consider if specific error handling for docx_to_text is needed
      return {};
    }
    return translations;
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.docx'];
  }
}
