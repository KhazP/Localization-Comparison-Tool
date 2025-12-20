import 'dart:io';
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
  Future<List<GitCommit>> getCommits(String repoPath, {String? branchName, int? limit});
  Future<List<GitDiffFile>> compareBranches(String repoPath, String baseBranch, String targetBranch);
  Future<List<GitDiffFile>> compareCommits(String repoPath, String baseSha, String targetSha);
  Future<String> getFileContentAtBranch(String repoPath, String branchName, String filePath);
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
             print('GitService: Error resolving branch ${branch.name}: $e');
           }
        }
      } catch (e) {
         print('GitService: Error accessing repo.branches: $e');
      }
      return branches;
    } catch (e) {
      print('GitService: Error opening repo for branches: $e');
      return []; 
    }
  }

  @override
  Future<List<GitCommit>> getCommits(String repoPath, {String? branchName, int? limit}) async {
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
           print('GitService: Could not find branch $branchName');
         }
       } else {
         try {
           final head = repo.head;
           currentOid = head.target;
         } catch (_) {
            print('GitService: Could not find HEAD');
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
               commit.author.name
             ));
             
             // Move to parent
             walkOid = commit.parents.isNotEmpty ? commit.parents.first : null;
             count++;
           }
         } catch (e) {
           print('GitService: Error walking commits: $e');
         }
       }
       
       return commits;
    } catch (e) {
      print('GitService: Error getting commits: $e');
      return [];
    }
  }

  @override
  Future<List<GitDiffFile>> compareBranches(String repoPath, String baseBranch, String targetBranch) async {
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
        print('GitService: Could not find one or both branches');
        return [];
      }
      
      // 2. Get commits and trees
      final baseCommit = Commit.lookup(repo: repo, oid: baseB.target);
      final targetCommit = Commit.lookup(repo: repo, oid: targetB.target);
      
      final baseTree = baseCommit.tree;
      final targetTree = targetCommit.tree;

      // 3. Perform diff
      final diff = Diff.treeToTree(repo: repo, oldTree: baseTree, newTree: targetTree);
      
      final diffFiles = <GitDiffFile>[];
      
      // 4. Parse diff
      for (final delta in diff.deltas) {
        final path = delta.newFile.path;
        final statusStr = delta.status.toString().split('.').last; // 'added', 'modified'
        diffFiles.add(GitDiffFile(path, statusStr));
      }
      
      return diffFiles;

    } catch (e) {
      print('GitService: Error comparing branches: $e');
      return [];
    }
  }

  @override
  Future<List<GitDiffFile>> compareCommits(String repoPath, String baseSha, String targetSha) async {
    try {
      final repo = Repository.open(repoPath);

      // 1. Lookup commits by SHA or Ref
      final baseCommit = Commit.lookup(repo: repo, oid: Oid.fromSHA(repo: repo, sha: baseSha));
      final targetCommit = Commit.lookup(repo: repo, oid: Oid.fromSHA(repo: repo, sha: targetSha));

      // 2. Get trees
      final baseTree = baseCommit.tree;
      final targetTree = targetCommit.tree;

      // 3. Perform diff
      final diff = Diff.treeToTree(repo: repo, oldTree: baseTree, newTree: targetTree);
      
      final diffFiles = <GitDiffFile>[];
      
      // 4. Parse diff
      for (final delta in diff.deltas) {
        final path = delta.newFile.path;
        final statusStr = delta.status.toString().split('.').last; // 'added', 'modified'
        diffFiles.add(GitDiffFile(path, statusStr));
      }
      
      return diffFiles;
    } catch (e) {
      print('GitService: Error comparing commits: $e');
      // Re-throw or return empty? For now return empty but log error.
      // Better to maybe throw so UI can show error. 
      // Let's return empty list for safety but log it.
      return [];
    }
  }

  @override
  Future<String> getFileContentAtBranch(String repoPath, String branchName, String filePath) async {
    try {
      final repo = Repository.open(repoPath);

      // 1. Resolve Ref (Branch Name OR Commit SHA)
      Commit? commit;
      
      if (RegExp(r'^[0-9a-fA-F]{40}$').hasMatch(branchName)) {
         try {
           commit = Commit.lookup(repo: repo, oid: Oid.fromSHA(repo: repo, sha: branchName));
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
      final entry = tree[filePath];
      if (entry == null) {
        return '[File does not exist in this version]';
      }

      // Check for binary extensions
      final ext = filePath.split('.').last.toLowerCase();
      const binaryExtensions = ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'ico', 'pdf', 'zip', 'exe', 'dll', 'so', 'dylib', 'bin', 'webp'];
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
      print('GitService: Error retrieving file content: $e');
      return 'Error retrieving content: $e';
    }
  }
}