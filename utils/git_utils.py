import os
import logging
from typing import Optional

try:
    import git
except ImportError:
    git = None
    # logger.warning("GitPython not installed. Git-related operations will not be available.")
    # Cannot use logger before it's defined.

# It's good practice to get a logger specific to this module.
# from .logger_service import logger_service # Assuming logger_service is in the same utils dir
# logger = logger_service.get_logger(__name__)
# For now, using a standard logger.
logger = logging.getLogger(__name__)

if git is None:
    logger.warning(
        "GitPython is not installed. Git-related functionality in 'git_utils' will be disabled. "
        "Please install GitPython (e.g., 'pip install GitPython') to enable these features."
    )

def get_file_content_from_git(
    repo_path: str, 
    file_path: str, 
    commit_id: str # 'working' for working tree, or commit hash/branch/tag
) -> Optional[str]:
    """
    Fetches the content of a file from a Git repository at a specific commit or from the working tree.
    Returns the file content as a string, or None if an error occurs.
    """
    if git is None:
        logger.error("GitPython is not installed. Cannot fetch file content from Git.")
        return None

    try:
        # search_parent_directories=True helps find .git folder if repo_path is a subdirectory
        repo = git.Repo(repo_path, search_parent_directories=True)
        
        if commit_id.lower() == "working":
            # Path to the file in the working tree
            full_file_path = os.path.join(repo.working_tree_dir, file_path)
            if not os.path.exists(full_file_path): # Check existence before opening
                logger.error(f"File not found in working tree: {full_file_path}")
                return None
            with open(full_file_path, "r", encoding="utf-8") as f:
                content = f.read()
        else:
            try:
                commit = repo.commit(commit_id)
            except git.exc.BadName as e: # More specific exception for invalid commit ID/ref
                logger.error(f"Invalid commit ID or reference '{commit_id}': {e}")
                return None
            
            try:
                blob = commit.tree / file_path
                content = blob.data_stream.read().decode("utf-8")
            except KeyError: # File not found in the specific commit's tree
                logger.error(f"File '{file_path}' not found in commit '{commit_id}'.")
                return None
            except git.exc.NoSuchPathError: # Should be caught by KeyError in this context with tree traversal
                logger.error(f"File '{file_path}' does not exist in commit '{commit_id}'.")
                return None
        return content
        
    except git.exc.InvalidGitRepositoryError:
        logger.error(f"Not a valid Git repository: {repo_path}")
        return None
    except FileNotFoundError: # Should be caught by os.path.exists for "working" tree case
        logger.error(f"File not found (potentially working tree issue): {file_path}")
        return None
    except Exception as e:
        logger.error(f"An unexpected error occurred in get_file_content_from_git: {e}", exc_info=True)
        return None
