import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/project.dart';
import 'package:uuid/uuid.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';

/// Repository for managing Localizer projects stored in `.localizer/` folders.
/// 
/// Projects are identified by a `.localizer/project.json` marker file within
/// their root directory. This repository handles:
/// - Creating new projects
/// - Loading existing projects
/// - Saving project changes
/// - Detecting project folders
class ProjectRepository {
  static const String _configFolderName = '.localizer';
  static const String _projectFileName = 'project.json';
  

  
  final SecureStorageService _secureStorageService;
  final Uuid _uuid = const Uuid();

  ProjectRepository({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;

  /// Creates a new project in the specified folder.
  /// 
  /// Creates the `.localizer/` folder and `project.json` file.
  /// Returns the created Project.
  /// 
  /// Throws [ProjectCreationException] if the folder already contains a project
  /// or if file operations fail.
  Future<Project> createProject({
    required String folderPath,
    required String projectName,
  }) async {
    final configFolder = Directory('$folderPath/$_configFolderName');
    final projectFile = File('$folderPath/$_configFolderName/$_projectFileName');

    // Check if project already exists
    if (await projectFile.exists()) {
      throw ProjectCreationException(
        'This folder already contains a project. '
        'Please choose a different folder or open the existing project.',
      );
    }

    // Create the .localizer folder
    try {
      await configFolder.create(recursive: true);
    } catch (e) {
      throw ProjectCreationException(
        'Could not create project folder. '
        'Please check you have permission to write to this location.',
      );
    }

    // Create the project
    final now = DateTime.now();
    final project = Project(
      id: _uuid.v4(),
      name: projectName,
      rootPath: folderPath,
      createdAt: now,
      lastOpenedAt: now,
    );

    // Write project.json
    try {
      await projectFile.writeAsString(project.toJsonString());
    } catch (e) {
      // Clean up the folder we created
      try {
        await configFolder.delete(recursive: true);
      } catch (_) {
        // Ignore cleanup errors
      }
      throw ProjectCreationException(
        'Could not save project file. '
        'Please check you have permission to write to this location.',
      );
    }

    debugPrint('ProjectRepository: Created project "${project.name}" at $folderPath');
    await _addToRecentProjects(folderPath);
    await _secureStorageService.storeLastProject(folderPath);
    return project;
  }

  /// Loads a project from the specified folder.
  /// 
  /// Returns null if no project exists at the path.
  /// Throws [ProjectLoadException] if the project file is corrupted.
  Future<Project?> loadProject(String folderPath) async {
    final projectFile = File('$folderPath/$_configFolderName/$_projectFileName');

    if (!await projectFile.exists()) {
      return null;
    }

    try {
      final contents = await projectFile.readAsString();
      final json = jsonDecode(contents) as Map<String, dynamic>;
      final project = Project.fromJson(json, folderPath);
      
      debugPrint('ProjectRepository: Loaded project "${project.name}" from $folderPath');
      return project;
    } catch (e) {
      throw ProjectLoadException(
        'The project file appears to be corrupted. '
        'You may need to recreate the project.',
      );
    }
  }

  /// Saves updates to an existing project.
  /// 
  /// Updates the lastOpenedAt timestamp automatically.
  Future<void> saveProject(Project project) async {
    final projectFile = File(project.projectFilePath);
    
    // Update last opened time
    project.lastOpenedAt = DateTime.now();

    try {
      await projectFile.writeAsString(project.toJsonString());
      debugPrint('ProjectRepository: Saved project "${project.name}"');
    } catch (e) {
      throw ProjectSaveException(
        'Could not save project changes. '
        'Please check you have permission to write to this location.',
      );
    }
  }

  /// Checks if the given folder contains a Localizer project.
  Future<bool> isProjectFolder(String folderPath) async {
    final projectFile = File('$folderPath/$_configFolderName/$_projectFileName');
    return await projectFile.exists();
  }

  /// Opens a project and updates its lastOpenedAt timestamp.
  /// 
  /// Returns the updated project, or null if no project found.
  Future<Project?> openProject(String folderPath) async {
    final project = await loadProject(folderPath);
    if (project != null) {
      await saveProject(project); // Updates lastOpenedAt
      await _addToRecentProjects(folderPath);
      await _secureStorageService.storeLastProject(folderPath);
    }
    return project;
  }

  /// Gets the path of the last opened project, if any.
  Future<String?> getLastProjectPath() async {
    final path = await _secureStorageService.getLastProject();
    if (path == null) return null;
    
    // Validate path still exists
    if (!await Directory(path).exists()) {
      await _secureStorageService.clearLastProject();
      return null;
    }
    return path;
  }

  /// Validates that a project still exists at its stored path.
  /// 
  /// Returns true if the project folder and marker file exist.
  Future<bool> validateProject(Project project) async {
    return await isProjectFolder(project.rootPath);
  }


  /// Loads valid recent projects.
  /// 
  /// Filters out paths that no longer exist or are invalid projects.
  /// Updates the stored list to remove invalid entries.
  Future<List<Project>> getRecentProjects() async {
    final paths = await _secureStorageService.getRecentProjectPaths();
    final validProjects = <Project>[];
    final validPaths = <String>[];

    for (final path in paths) {
      try {
        final project = await loadProject(path);
        if (project != null) {
          validProjects.add(project);
          validPaths.add(path);
        }
      } catch (e) {
        // Skip invalid/corrupted projects
        debugPrint('ProjectRepository: Skipping invalid recent project at $path: $e');
      }
    }

    // Update storage if any paths were removed
    if (validPaths.length != paths.length) {
      await _secureStorageService.storeRecentProjectPaths(validPaths);
    }

    // Sort by last opened (newest first)
    validProjects.sort((a, b) => b.lastOpenedAt.compareTo(a.lastOpenedAt));
    
    return validProjects;
  }

  Future<void> _addToRecentProjects(String path) async {
    final paths = await _secureStorageService.getRecentProjectPaths();
    
    // Remove if already exists (to move to top)
    paths.remove(path);
    
    // Add to top
    paths.insert(0, path);
    
    // Limit to 10 recent projects
    if (paths.length > 10) {
      paths.removeRange(10, paths.length);
    }
    
    await _secureStorageService.storeRecentProjectPaths(paths);
  }
}

/// Exception thrown when project creation fails.
class ProjectCreationException implements Exception {
  final String message;
  ProjectCreationException(this.message);
  
  @override
  String toString() => message;
}

/// Exception thrown when project loading fails.
class ProjectLoadException implements Exception {
  final String message;
  ProjectLoadException(this.message);
  
  @override
  String toString() => message;
}

/// Exception thrown when project saving fails.
class ProjectSaveException implements Exception {
  final String message;
  ProjectSaveException(this.message);
  
  @override
  String toString() => message;
}
