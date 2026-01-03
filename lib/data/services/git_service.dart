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
  GitDiffFile(this.path, this.status);
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
  @override
  Future<bool> isValidRepository(String path) async {
    try {
      // libgit2dart 1.x: Repository.open throws if not found/valid
      Repository.open(path);
      // If we opened it, it's valid.
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

      // Get local branches
      try {
        for (final branch in repo.branches) {
          try {
            // branch is a Branch object, get the name and target
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
      final maxCount = limit ?? 20;

      Oid? currentOid;

      if (branchName != null) {
        try {
          // Find the branch by name
          for (final branch in repo.branches) {
            if (branch.name == branchName) {
              currentOid = branch.target;
              break;
            }
          }
        } catch (_) {
          developer.log('Could not find branch $branchName',
              name: 'GitService');
        }
      } else {
        try {
          final head = repo.head;
          currentOid = head.target;
        } catch (_) {
          developer.log('Could not find HEAD', name: 'GitService');
        }
      }

      // Manual linear walk - simple approach without RevWalk since API varies
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

            // Move to parent
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
    try {
      final repo = Repository.open(repoPath);

      // 1. Find branches by name
      Branch? baseB;
      Branch? targetB;

      for (final branch in repo.branches) {
        if (branch.name == baseBranch) baseB = branch;
        if (branch.name == targetBranch) targetB = branch;
      }

      if (baseB == null || targetB == null) {
        developer.log('Could not find one or both branches',
            name: 'GitService');
        return [];
      }

      // 2. Get commits and trees
      final baseCommit = Commit.lookup(repo: repo, oid: baseB.target);
      final targetCommit = Commit.lookup(repo: repo, oid: targetB.target);

      final baseTree = baseCommit.tree;
      final targetTree = targetCommit.tree;

      // 3. Perform diff
      final diff =
          Diff.treeToTree(repo: repo, oldTree: baseTree, newTree: targetTree);

      final diffFiles = <GitDiffFile>[];

      // 4. Parse diff
      for (final delta in diff.deltas) {
        final path = delta.newFile.path;
        final statusStr =
            delta.status.toString().split('.').last; // 'added', 'modified'
        diffFiles.add(GitDiffFile(path, statusStr));
      }

      return diffFiles;
    } catch (e) {
      developer.log('Error comparing branches: $e', name: 'GitService');
      return [];
    }
  }

  @override
  Future<List<GitDiffFile>> compareCommits(
      String repoPath, String baseSha, String targetSha) async {
    try {
      final repo = Repository.open(repoPath);

      // 1. Lookup commits by SHA or Ref
      final baseCommit =
          Commit.lookup(repo: repo, oid: Oid.fromSHA(repo: repo, sha: baseSha));
      final targetCommit = Commit.lookup(
          repo: repo, oid: Oid.fromSHA(repo: repo, sha: targetSha));

      // 2. Get trees
      final baseTree = baseCommit.tree;
      final targetTree = targetCommit.tree;

      // 3. Perform diff
      final diff =
          Diff.treeToTree(repo: repo, oldTree: baseTree, newTree: targetTree);

      final diffFiles = <GitDiffFile>[];

      // 4. Parse diff
      for (final delta in diff.deltas) {
        final path = delta.newFile.path;
        final statusStr =
            delta.status.toString().split('.').last; // 'added', 'modified'
        diffFiles.add(GitDiffFile(path, statusStr));
      }

      return diffFiles;
    } catch (e) {
      developer.log('Error comparing commits: $e', name: 'GitService');
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

  Future<String> _runGitCommand(String repoPath, List<String> args) async {
    try {
      final process = await Process.run(
        'git',
        args,
        workingDirectory: repoPath,
        runInShell: true,
      );

      if (process.exitCode != 0) {
        throw Exception('Git command failed: ${process.stderr}');
      }
      return process.stdout.toString();
    } catch (e) {
      if (e.toString().contains('No such file or directory')) {
        // Try 'cmd /c git ...' for Windows if direct call fails
        try {
          final process = await Process.run(
            'cmd',
            ['/c', 'git', ...args],
            workingDirectory: repoPath,
          );
          if (process.exitCode != 0) throw Exception(process.stderr);
          return process.stdout.toString();
        } catch (inner) {
          throw Exception('Git CL failed: $inner');
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
    try {
      switch (strategy) {
        case ResolutionStrategy.ours:
          // Keep current version
          await _runGitCommand(repoPath, ['checkout', '--ours', filePath]);
          await _runGitCommand(repoPath, ['add', filePath]);
          break;
        case ResolutionStrategy.theirs:
          // Accept incoming version
          await _runGitCommand(repoPath, ['checkout', '--theirs', filePath]);
          await _runGitCommand(repoPath, ['add', filePath]);
          break;
        case ResolutionStrategy.manual:
          // User edited file manually, just add it
          await _runGitCommand(repoPath, ['add', filePath]);
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
    try {
      await _runGitCommand(repoPath, ['add', filePath]);
      developer.log('Marked $filePath as resolved', name: 'GitService');
    } catch (e) {
      developer.log('Error marking file as resolved: $e', name: 'GitService');
      throw Exception('Failed to mark file as resolved: $e');
    }
  }

  // --- Basic Git Operations ---

  @override
  Future<void> checkoutBranch(String repoPath, String branchName) async {
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
