import 'dart:io';

/// Utility class for safely opening file explorer/finder.
/// Validates paths to prevent command injection attacks.
class FileExplorerUtils {
  /// Characters that could be used for shell injection
  static const _dangerousChars = [
    ';',
    '|',
    '&',
    '\$',
    '`',
    '\n',
    '\r',
    '<',
    '>'
  ];

  /// Validates that a path is safe to use in system commands.
  /// Returns the canonicalized absolute path if valid.
  /// Throws ArgumentError if the path is invalid or potentially dangerous.
  static String validatePath(String path) {
    if (path.isEmpty) {
      throw ArgumentError('Path cannot be empty');
    }

    // Check for dangerous characters
    for (final char in _dangerousChars) {
      if (path.contains(char)) {
        throw ArgumentError('Path contains invalid character: $char');
      }
    }

    // Canonicalize and verify the path exists
    final directory = Directory(path);
    final file = File(path);

    if (directory.existsSync()) {
      return directory.absolute.path;
    } else if (file.existsSync()) {
      return file.parent.absolute.path;
    }

    throw ArgumentError('Path does not exist: $path');
  }

  /// Opens the system file explorer at the specified directory.
  /// Validates the path to prevent command injection.
  /// Returns true if the operation was successful.
  static Future<bool> openDirectory(String directoryPath) async {
    try {
      final safePath = validatePath(directoryPath);

      if (Platform.isWindows) {
        // SECURITY: No runInShell, validated path
        await Process.run('explorer.exe', [safePath]);
        return true;
      } else if (Platform.isMacOS) {
        // SECURITY: No runInShell, validated path
        await Process.run('open', [safePath]);
        return true;
      } else if (Platform.isLinux) {
        // SECURITY: No runInShell, validated path
        await Process.run('xdg-open', [safePath]);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Opens the file explorer and selects/highlights the specified file.
  /// Validates the path to prevent command injection.
  /// Returns true if the operation was successful.
  static Future<bool> openAndSelectFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        throw ArgumentError('File does not exist: $filePath');
      }

      // Validate the path
      final safePath = file.absolute.path;
      for (final char in _dangerousChars) {
        if (safePath.contains(char)) {
          throw ArgumentError('Path contains invalid character: $char');
        }
      }

      if (Platform.isWindows) {
        // SECURITY: No runInShell, validated path, /select highlights the file
        await Process.run('explorer.exe', ['/select,', safePath]);
        return true;
      } else if (Platform.isMacOS) {
        // SECURITY: No runInShell, -R reveals the file in Finder
        await Process.run('open', ['-R', safePath]);
        return true;
      } else if (Platform.isLinux) {
        // Linux doesn't have a standard way to select a file, just open the folder
        final directory = file.parent.absolute.path;
        await Process.run('xdg-open', [directory]);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
