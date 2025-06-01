import argparse
import sys
import os
from colorama import init # Keep init for now, Fore and Style might be removed
# from colorama import Fore, Style # Removed as get_color will be removed
import git
from pathlib import Path
from core.constants import SUPPORTED_FORMATS
# from GUI.logic import compare_translations # This will be replaced by ComparisonService
# Import ParserService and ParsingResult (already present)
from services.parser_service import ParserService
from core.parsing_result import ParsingResult
# Import ComparisonService
from services.comparison_service import ComparisonService

# Initialize colorama
init()

# VALID_COLORS and get_color are no longer needed if ComparisonService handles formatting without direct color codes here.
# VALID_COLORS = [ ... ]
# def get_color(color_name): ...

# Removed local read_csv_file function. ParserService will be used later.
# Removed local read_lang_file function. ParserService will be used later.

def get_file_content(repo_path, file_path, commit_id):
    """Fetches the content of a file from a Git repository at a specific commit."""
    try:
        repo = git.Repo(repo_path, search_parent_directories=True)
        if commit_id == "working":
            # Read from the working tree (uncommitted changes)
            with open(os.path.join(repo.working_tree_dir, file_path), "r", encoding="utf-8") as f:
                content = f.read()
        else:
            commit = repo.commit(commit_id)
            blob = commit.tree / file_path
            content = blob.data_stream.read().decode("utf-8")
        return content
    except git.InvalidGitRepositoryError:
        print(f"Error: Not a git repository: {repo_path}")
        sys.exit(1)
    except git.NoSuchPathError:
        print(f"Error: File not found in repository: {file_path}")
        sys.exit(1)
    except (git.BadName, ValueError) as e:
        print (f"Error: Invalid commit ID or file not found in commit: {commit_id}")
        sys.exit(1)
    except FileNotFoundError:
        print(f"Error: File not found in working tree: {file_path}")
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)

# --- Main part of the script ---

parser = argparse.ArgumentParser(description="Compare two translation files, optionally from a Git repository.")
parser.add_argument("old_file", help="Path to the old file, or a file path within the Git repository.")
parser.add_argument("new_file", help="Path to the new file, commit ID, or 'working'.")
parser.add_argument("-C", "--repo", help="Path to the Git repository (defaults to current directory).", default=".")
parser.add_argument("-i", "--ignore-case", action="store_true",
                    help="Perform a case-insensitive comparison.")
parser.add_argument("-w", "--ignore-whitespace", action="store_true",
                    help="Ignore leading and trailing whitespace in values.")
parser.add_argument("-o", "--output", help="Path to the output file (optional).")
parser.add_argument("-d", "--delimiter", help="Delimiter character for CSV files (default: ,)", default=",")
parser.add_argument("--no-header", action="store_true",
                    help="Indicates that CSV files do not have a header row.")
parser.add_argument("-k", "--key-column", default="key",
                    help="Name or index of the key column (default: key)")
parser.add_argument("-v", "--value-column", default="value",
                    help="Name or index of the value column (default: value)")
parser.add_argument("--lang-trim-whitespace", action="store_true",
                    help="Trim whitespace around the '=' in .lang files.")

args = parser.parse_args()

# --- Git Handling ---
# Determine if comparing local files or using Git
_, old_ext = os.path.splitext(args.old_file)
try:
    repo = git.Repo(args.repo, search_parent_directories=True) # Find Git repository
    repo_path = repo.working_tree_dir

    if args.new_file == "working":
        old_content = get_file_content(args.repo, args.old_file, "HEAD")
        new_content = get_file_content(args.repo, args.old_file, "working")
    else:
        old_content = get_file_content(args.repo, args.old_file, "HEAD")
        new_content = get_file_content(args.repo, args.old_file, args.new_file)


    # Instantiate ParserService
    parser_service = ParserService()

    old_translations = {}
    new_translations = {}

    # Determine parser config based on file type and args
    parser_config = {}
    file_type_supported = True

    if old_ext.lower() == ".csv":
        parser_config = {
            'delimiter': args.delimiter,
            'has_header': not args.no_header,
            'key_column': args.key_column,
            'value_column': args.value_column
        }
    elif old_ext.lower() == ".lang":
        parser_config = {
            'trim_whitespace': args.lang_trim_whitespace
        }
    else:
        # The script's original logic only supported .csv and .lang.
        # We'll stick to that for now. ParserService can handle more,
        # but this script's argument parsing is specific.
        print(f"Error: Unsupported file type '{old_ext}'. This script currently only supports .csv and .lang files.")
        sys.exit(1)

    # Parse old file content
    old_result = parser_service.parse_file_content(old_content, old_ext, parser_config)
    if old_result.errors:
        print(f"Error parsing old file ({args.old_file}):")
        for error in old_result.errors:
            print(f"- {error}")
        sys.exit(1)
    old_translations = old_result.translations

    # Parse new file content (extension is assumed to be the same)
    new_result = parser_service.parse_file_content(new_content, old_ext, parser_config)
    if new_result.errors:
        print(f"Error parsing new file content (from commit/working tree for {args.old_file}):")
        for error in new_result.errors:
            print(f"- {error}")
        sys.exit(1)
    new_translations = new_result.translations

except git.InvalidGitRepositoryError:
    print(f"Error: Not a git repository or any of the parent directories: {args.repo}")
    sys.exit(1)
except Exception as e:
    print(f"An unexpected error occurred during parsing or file handling: {e}")
    sys.exit(1)


if old_result and new_result and old_result.translations is not None and new_result.translations is not None:
    print("Comparing translations...\n")

    comparison_service = ComparisonService()

    comparison_config = {
        'ignore_case_keys': args.ignore_case,
        'compare_values': True, # Assuming CLI should always compare values
        'ignore_whitespace_values': args.ignore_whitespace
    }

    comparison_details_dict = comparison_service.compare_translations(
        old_result, # Pass the full ParsingResult from source/old file
        new_result, # Pass the full ParsingResult from target/new file
        comparison_config
    )

    # Format the structured output for console display
    # The `is_gui` parameter in format_comparison_as_text is not strictly needed if no colorama.
    formatted_text_output = comparison_service.format_comparison_as_text(comparison_details_dict)

    print(formatted_text_output)

    if args.output:
        try:
            with open(args.output, 'w', encoding='utf-8') as f:
                f.write(formatted_text_output) # Corrected variable name
            print(f"\nComparison output saved to: {args.output}")
        except IOError as e:
            print(f"\nError saving output to file: {e}")
else:
    print("Could not perform comparison due to parsing errors or empty files.")