import 'dart:developer' as developer;
import 'dart:io'; // process.run, file reading
import 'package:libgit2dart/libgit2dart.dart';

// Represents basic information about a Git branch
class GitBranch {
  final String name;
  final String sha; // Commit hash
  final bool isRemote;
  GitBranch(this.name, this.sha, {this.isRemote = false});
}

// Represents basic information about a Git commit
class GitCommit {
  final String sha;
  final String message;
  final DateTime date;
  final String author;
  GitCommit(this.sha, this.message, this.date, this.author);
}

// Represents a file changed in a diff
class GitDiffFile {
  final String path;
  final String status; // 'added', 'deleted', 'modified', 'renamed', 'unknown'
  final int additions;
  final int deletions;

  GitDiffFile(this.path, this.status, {this.additions = 0, this.deletions = 0});
}

abstract class GitService {
  Future<bool> isValidRepository(String path);
  Future<List<GitBranch>> getBranches(String repoPath);
  Future<List<GitCommit>> getCommits(String repoPath,
      {String? branchName, int? limit});
  Future<List<GitDiffFile>> compareBranches(
      String repoPath, String baseBranch, String targetBranch);
  Future<List<GitDiffFile>> compareCommits(
      String repoPath, String baseSha, String targetSha);
  Future<String> getFileContentAtBranch(
      String repoPath, String branchName, String filePath);
  Future<List<String>> getFilesInCommit(String repoPath, String ref);

  // Conflict Management
  Future<List<String>> getConflictedFiles(String repoPath);
  Future<void> resolveConflict(
      String repoPath, String filePath, ResolutionStrategy strategy);
  Future<void> resolveSingleConflict(String repoPath, String filePath,
      ConflictMarker marker, ResolutionStrategy strategy);
  Future<void> markFileResolved(String repoPath, String filePath);
  Future<void> abortMerge(String repoPath);
  Future<List<ConflictMarker>> parseConflictMarkers(String filePath);

  // Operations
  Future<void> checkoutBranch(String repoPath, String branchName);
  Future<void> mergeBranch(String repoPath, String branchName);
  Future<void> gitFetch(String repoPath);
  Future<void> pull(String repoPath);
}

class LibGit2DartService implements GitService {
  // ... (keep previous methods like isValidRepository, getBranches, getCommits)
  @override
  Future<bool> isValidRepository(String path) async {
    try {
      Repository.open(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<GitBranch>> getBranches(String repoPath) async {
    try {
      final repo = Repository.open(repoPath);
      final branches = <GitBranch>[];
      try {
        for (final branch in repo.branches) {
          try {
            final target = branch.target;
            branches.add(GitBranch(branch.name, target.sha));
          } catch (e) {
            developer.log('Error resolving branch ${branch.name}: $e',
                name: 'GitService');
          }
        }
      } catch (e) {
        developer.log('Error accessing repo.branches: $e', name: 'GitService');
      }
      return branches;
    } catch (e) {
      developer.log('Error opening repo for branches: $e', name: 'GitService');
      return [];
    }
  }

  @override
  Future<List<GitCommit>> getCommits(String repoPath,
      {String? branchName, int? limit}) async {
    try {
      final repo = Repository.open(repoPath);
      final commits = <GitCommit>[];
      // ... existing implementation ...
      // For brevity using the previous implementation block is redundant if I replace the whole file?
      // The prompt asks to replace comparisons. I should be careful not to delete getCommits content if I use range.

      // Re-implementing getCommits to ensure it's preserved as I'm replacing a large chunk or start/end.
      // The prompt EndLine is 246. StartLine is 22.
      // I need to include getCommits implementation here.

      final maxCount = limit ?? 20;
      Oid? currentOid;

      if (branchName != null) {
        try {
          for (final branch in repo.branches) {
            if (branch.name == branchName) {
              currentOid = branch.target;
              break;
            }
          }
        } catch (_) {}
      } else {
        try {
          currentOid = repo.head.target;
        } catch (_) {}
      }

      if (currentOid != null) {
        try {
          int count = 0;
          Oid? walkOid = currentOid;
          while (walkOid != null && count < maxCount) {
            final commit = Commit.lookup(repo: repo, oid: walkOid);
            commits.add(GitCommit(
                commit.oid.sha,
                commit.message,
                DateTime.fromMillisecondsSinceEpoch(commit.time * 1000),
                commit.author.name));
            walkOid = commit.parents.isNotEmpty ? commit.parents.first : null;
            count++;
          }
        } catch (e) {
          developer.log('Error walking commits: $e', name: 'GitService');
        }
      }
      return commits;
    } catch (e) {
      developer.log('Error getting commits: $e', name: 'GitService');
      return [];
    }
  }

  @override
  Future<List<GitDiffFile>> compareBranches(
      String repoPath, String baseBranch, String targetBranch) async {
    return _compareRefs(repoPath, baseBranch, targetBranch);
  }

  @override
  Future<List<GitDiffFile>> compareCommits(
      String repoPath, String baseSha, String targetSha) async {
    return _compareRefs(repoPath, baseSha, targetSha);
  }

  Future<List<GitDiffFile>> _compareRefs(
      String repoPath, String base, String target) async {
    // SECURITY: Validate git references before use
    _validateGitRef(base);
    _validateGitRef(target);

    try {
      // 1. Get Statuses (Added, Modified, Deleted)
      // git diff --name-status base target
      final statusOutput = await _runGitCommand(
          repoPath, ['diff', '--name-status', base, target]);
      final statusMap = <String, String>{};

      for (final line in statusOutput.split('\n')) {
        if (line.trim().isEmpty) continue;
        final parts = line.split('\t');
        if (parts.length >= 2) {
          // Status is first char (M, A, D, R, C, U)
          final s = parts[0][0].toUpperCase();
          final path = parts[1].trim();

          String statusFull = 'modified';
          if (s == 'A')
            statusFull = 'added';
          else if (s == 'D')
            statusFull = 'deleted';
          else if (s == 'R')
            statusFull = 'renamed';
          else if (s == 'C')
            statusFull = 'copied';
          else if (s == 'U') statusFull = 'unmerged';

          statusMap[path] = statusFull;
        }
      }

      // 2. Get Stats (Insertions, Deletions)
      // git diff --numstat base target
      final statsOutput =
          await _runGitCommand(repoPath, ['diff', '--numstat', base, target]);
      final files = <GitDiffFile>[];

      for (final line in statsOutput.split('\n')) {
        if (line.trim().isEmpty) continue;
        // output: added deleted path
        // 5       0       file.txt
        final parts = line.split('\t');
        if (parts.length >= 3) {
          final addedStr = parts[0].trim();
          final deletedStr = parts[1].trim();
          final path = parts[2].trim();

          // Handle binary files which output - -
          final added = addedStr == '-' ? 0 : int.tryParse(addedStr) ?? 0;
          final deleted = deletedStr == '-' ? 0 : int.tryParse(deletedStr) ?? 0;

          final status = statusMap[path] ?? 'modified'; // Default to modified

          files.add(
              GitDiffFile(path, status, additions: added, deletions: deleted));
        }
      }

      // Sort files by path
      files.sort((a, b) => a.path.compareTo(b.path));

      return files;
    } catch (e) {
      developer.log('Error comparing refs: $e', name: 'GitService');
      return [];
    }
  }

  @override
  Future<String> getFileContentAtBranch(
      String repoPath, String branchName, String filePath) async {
    try {
      final repo = Repository.open(repoPath);

      // 1. Resolve Ref (Branch Name OR Commit SHA)
      Commit? commit;

      if (RegExp(r'^[0-9a-fA-F]{40}$').hasMatch(branchName)) {
        try {
          commit = Commit.lookup(
              repo: repo, oid: Oid.fromSHA(repo: repo, sha: branchName));
        } catch (_) {}
      }

      if (commit == null) {
        for (final branch in repo.branches) {
          if (branch.name == branchName) {
            commit = Commit.lookup(repo: repo, oid: branch.target);
            break;
          }
        }
      }

      if (commit == null) {
        return 'Error: Reference "$branchName" not found or is not a commit.';
      }

      // 2. Resolve to tree
      final tree = commit.tree;

      // 3. Find the file entry in the tree
      // Note: tree[filePath] throws if not found
      var entry;
      try {
        entry = tree[filePath];
      } catch (_) {
        // File does not exist in this tree (e.g., deleted or not yet created)
        // Return empty string so diff shows as added/deleted
        return '';
      }

      // Check for binary extensions
      final ext = filePath.split('.').last.toLowerCase();
      const binaryExtensions = [
        'png',
        'jpg',
        'jpeg',
        'gif',
        'bmp',
        'ico',
        'pdf',
        'zip',
        'exe',
        'dll',
        'so',
        'dylib',
        'bin',
        'webp'
      ];
      if (binaryExtensions.contains(ext)) {
        return '[Binary File - Content Preview Unavailable]';
      }

      // 4. Get the blob and content
      final blob = Blob.lookup(repo: repo, oid: entry.oid);

      try {
        return blob.content;
      } catch (e) {
        return '[Error: Could not decode file content. It might be binary.]';
      }
    } catch (e) {
      developer.log('Error retrieving file content: $e', name: 'GitService');
      return 'Error retrieving content: $e';
    }
  }

  @override
  Future<List<String>> getFilesInCommit(String repoPath, String ref) async {
    try {
      final repo = Repository.open(repoPath);

      // Resolve reference to commit
      Commit? commit;
      if (RegExp(r'^[0-9a-fA-F]{40}$').hasMatch(ref)) {
        try {
          commit =
              Commit.lookup(repo: repo, oid: Oid.fromSHA(repo: repo, sha: ref));
        } catch (_) {}
      }

      if (commit == null) {
        for (final branch in repo.branches) {
          if (branch.name == ref) {
            commit = Commit.lookup(repo: repo, oid: branch.target);
            break;
          }
        }
      }

      if (commit == null) return [];

      final files = <String>[];
      final tree = commit.tree;

      // Recursive tree walker helper using libgit2dart API
      void walkTree(Tree t, String parentPath) {
        for (final entry in t.entries) {
          final fullPath =
              parentPath.isEmpty ? entry.name : '$parentPath/${entry.name}';

          // Check filemode: GitFilemode.tree = directory, otherwise = file
          if (entry.filemode == GitFilemode.tree) {
            // It's a directory, recurse
            try {
              final subtree = Tree.lookup(repo: repo, oid: entry.oid);
              walkTree(subtree, fullPath);
            } catch (e) {
              developer.log('Error looking up subtree $fullPath: $e',
                  name: 'GitService');
            }
          } else {
            // It's a file (blob, blobExecutable, or link)
            files.add(fullPath);
          }
        }
      }

      walkTree(tree, '');
      developer.log('Found ${files.length} files in $ref', name: 'GitService');
      return files;
    } catch (e) {
      developer.log('Error getting files in commit: $e', name: 'GitService');
      return [];
    }
  }

  // --- CLI Fallback for Conflicts ---

  /// Validates that a git reference (branch name, tag, or SHA) is safe.
  /// Only allows alphanumeric characters, dashes, underscores, dots, and slashes.
  static final _safeGitRefRegex = RegExp(r'^[a-zA-Z0-9_\-\.\/]+$');

  /// Validates a git reference to prevent command injection.
  String _validateGitRef(String ref) {
    if (ref.isEmpty) {
      throw ArgumentError('Git reference cannot be empty');
    }
    if (ref.contains('..') || ref.startsWith('-')) {
      throw ArgumentError('Invalid git reference: $ref');
    }
    if (!_safeGitRefRegex.hasMatch(ref)) {
      throw ArgumentError('Git reference contains invalid characters: $ref');
    }
    return ref;
  }

  /// Validates a file path for git operations.
  String _validateFilePath(String path) {
    if (path.isEmpty) {
      throw ArgumentError('File path cannot be empty');
    }
    // Prevent path traversal and shell metacharacters
    if (path.contains('..') ||
        path.contains(';') ||
        path.contains('|') ||
        path.contains('&') ||
        path.contains('\$') ||
        path.contains('`') ||
        path.contains('\n') ||
        path.contains('\r')) {
      throw ArgumentError('File path contains invalid characters: $path');
    }
    return path;
  }

  Future<String> _runGitCommand(String repoPath, List<String> args) async {
    // Validate repoPath
    _validateFilePath(repoPath);

    try {
      // SECURITY: Removed runInShell: true to prevent shell injection
      final process = await Process.run(
        'git',
        args,
        workingDirectory: repoPath,
      );

      if (process.exitCode != 0) {
        throw Exception('Git command failed: ${process.stderr}');
      }
      return process.stdout.toString();
    } catch (e) {
      if (e.toString().contains('No such file or directory') ||
          e.toString().contains('The system cannot find')) {
        // Try with full path to git on Windows if direct call fails
        try {
          // SECURITY: Use argument list instead of shell string concatenation
          final process = await Process.run(
            'git',
            args,
            workingDirectory: repoPath,
            environment: Platform.environment,
          );
          if (process.exitCode != 0) throw Exception(process.stderr);
          return process.stdout.toString();
        } catch (inner) {
          throw Exception('Git CLI failed: $inner');
        }
      }
      rethrow;
    }
  }

  @override
  Future<List<String>> getConflictedFiles(String repoPath) async {
    try {
      // 'git status --porcelain' returns short status codes
      // U = Updated but unmerged
      // AA = Both added
      // DD = Both deleted
      // ...
      final output = await _runGitCommand(repoPath, ['status', '--porcelain']);
      final files = <String>[];

      for (final line in output.split('\n')) {
        if (line.length < 4) continue;
        final status = line.substring(0, 2);
        final file = line.substring(3).trim();

        // Check for conflict states
        // UU: both modified
        // AA: both added
        // UD: deleted by them
        // DU: deleted by us
        // AU: added by us
        // UA: added by them
        if (['UU', 'AA', 'UD', 'DU', 'AU', 'UA', 'DD'].contains(status)) {
          files.add(file);
        }
      }
      return files;
    } catch (e) {
      developer.log('Error checking conflicts: $e', name: 'GitService');
      return [];
    }
  }

  @override
  Future<void> resolveConflict(
      String repoPath, String filePath, ResolutionStrategy strategy) async {
    // SECURITY: Validate file path before use
    _validateFilePath(filePath);

    try {
      switch (strategy) {
        case ResolutionStrategy.ours:
          // Keep current version
          await _runGitCommand(
              repoPath, ['checkout', '--ours', '--', filePath]);
          await _runGitCommand(repoPath, ['add', '--', filePath]);
          break;
        case ResolutionStrategy.theirs:
          // Accept incoming version
          await _runGitCommand(
              repoPath, ['checkout', '--theirs', '--', filePath]);
          await _runGitCommand(repoPath, ['add', '--', filePath]);
          break;
        case ResolutionStrategy.manual:
          // User edited file manually, just add it
          await _runGitCommand(repoPath, ['add', '--', filePath]);
          break;
      }
    } catch (e) {
      developer.log('Error resolving conflict for $filePath: $e',
          name: 'GitService');
      throw Exception('Failed to resolve conflict: $e');
    }
  }

  @override
  Future<void> abortMerge(String repoPath) async {
    try {
      await _runGitCommand(repoPath, ['merge', '--abort']);
    } catch (e) {
      developer.log('Error aborting merge: $e', name: 'GitService');
      throw Exception('Failed to abort merge: $e');
    }
  }

  @override
  Future<List<ConflictMarker>> parseConflictMarkers(String filePath) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) return [];

      final content = await file.readAsString();
      final markers = <ConflictMarker>[];

      // Simplified regex for standard 2-way conflict block (ours vs theirs)
      final markerRegex = RegExp(
        r'<<<<<<<[^\r\n]*\r?\n([\s\S]*?)=======\r?\n([\s\S]*?)>>>>>>>[^\r\n]*',
        multiLine: true,
      );

      final matches = markerRegex.allMatches(content);

      for (final match in matches) {
        markers.add(ConflictMarker(
          ours: match.group(1) ?? '',
          theirs: match.group(2) ?? '',
          start: match.start,
          end: match.end,
        ));
      }

      return markers;
    } catch (e) {
      developer.log('Error parsing conflict markers: $e', name: 'GitService');
      return [];
    }
  }

  @override
  Future<void> resolveSingleConflict(
    String repoPath,
    String filePath,
    ConflictMarker marker,
    ResolutionStrategy strategy,
  ) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        throw Exception('File not found: $filePath');
      }

      final content = await file.readAsString();

      // Validate marker still exists at the expected position
      if (marker.start >= content.length || marker.end > content.length) {
        throw Exception(
            'Conflict marker position is invalid. File may have changed.');
      }

      final conflictBlock = content.substring(marker.start, marker.end);
      if (!conflictBlock.startsWith('<<<<<<<')) {
        throw Exception(
            'Conflict marker not found at expected position. File may have changed.');
      }

      // Determine replacement content
      String replacement;
      switch (strategy) {
        case ResolutionStrategy.ours:
          replacement = marker.ours;
          break;
        case ResolutionStrategy.theirs:
          replacement = marker.theirs;
          break;
        case ResolutionStrategy.manual:
          throw Exception(
              'Manual resolution requires editing the file directly.');
      }

      // Replace the conflict block with the chosen content
      final newContent = content.substring(0, marker.start) +
          replacement +
          content.substring(marker.end);

      await file.writeAsString(newContent);
      developer.log('Resolved single conflict in $filePath',
          name: 'GitService');
    } catch (e) {
      developer.log('Error resolving single conflict: $e', name: 'GitService');
      throw Exception('Failed to resolve conflict: $e');
    }
  }

  @override
  Future<void> markFileResolved(String repoPath, String filePath) async {
    // SECURITY: Validate file path before use
    _validateFilePath(filePath);

    try {
      await _runGitCommand(repoPath, ['add', '--', filePath]);
      developer.log('Marked $filePath as resolved', name: 'GitService');
    } catch (e) {
      developer.log('Error marking file as resolved: $e', name: 'GitService');
      throw Exception('Failed to mark file as resolved: $e');
    }
  }

  // --- Basic Git Operations ---

  @override
  Future<void> checkoutBranch(String repoPath, String branchName) async {
    // SECURITY: Validate branch name before use
    _validateGitRef(branchName);

    try {
      await _runGitCommand(repoPath, ['checkout', branchName]);
    } catch (e) {
      developer.log('Error checking out branch $branchName: $e',
          name: 'GitService');
      throw Exception('Failed to checkout branch: $e');
    }
  }

  @override
  Future<void> mergeBranch(String repoPath, String branchName) async {
    // SECURITY: Validate branch name before use
    _validateGitRef(branchName);

    try {
      // We don't use --no-commit so we can detect conflicts naturally if they occur
      await _runGitCommand(repoPath, ['merge', branchName]);
    } catch (e) {
      developer.log('Error merging branch $branchName: $e', name: 'GitService');
      // If it's a conflict, git merge exits with non-zero.
      // check status to see if we satisfy "conflicted" state.
      final conflicts = await getConflictedFiles(repoPath);
      if (conflicts.isNotEmpty) {
        // This is expected for conflicts, so we don't strictly throw "Failed",
        // but the caller (Bloc) needs to know we are in conflict.
        // We can just return normally (void) and let the bloc check status.
        return;
      }
      throw Exception('Failed to merge branch: $e');
    }
  }

  @override
  Future<void> gitFetch(String repoPath) async {
    try {
      await _runGitCommand(repoPath, ['fetch']);
    } catch (e) {
      // Non-critical often
      developer.log('Error fetching: $e', name: 'GitService');
    }
  }

  @override
  Future<void> pull(String repoPath) async {
    try {
      await _runGitCommand(repoPath, ['pull']);
    } catch (e) {
      developer.log('Error pulling: $e', name: 'GitService');

      // Check for conflicts
      final conflicts = await getConflictedFiles(repoPath);
      if (conflicts.isNotEmpty) return;

      throw Exception('Failed to pull: $e');
    }
  }
}

enum ResolutionStrategy { ours, theirs, manual }

class ConflictMarker {
  final String ours;
  final String theirs;
  final int start;
  final int end;

  ConflictMarker({
    required this.ours,
    required this.theirs,
    required this.start,
    required this.end,
  });
}
