import csv
import argparse
import sys
import os
from colorama import init, Fore, Style
import git
from pathlib import Path
from core.constants import SUPPORTED_FORMATS
from GUI import logic  # UPDATED import
from GUI.logic import compare_translations  # Updated to import from GUI.logic

# Initialize colorama
init()

VALID_COLORS = [
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
    "lightblack_ex", "lightred_ex", "lightgreen_ex", "lightyellow_ex",
    "lightblue_ex", "lightmagenta_ex", "lightcyan_ex", "lightwhite_ex"
]

def get_color(color_name):
    """Gets the colorama Fore color object from a color name (case-insensitive)."""
    color_name = color_name.lower()
    if color_name not in VALID_COLORS:
        return None  # Invalid color name
    return getattr(Fore, color_name.upper())

def read_csv_file(content, delimiter=',', has_header=True, key_column='key', value_column='value'):
    """Reads CSV data from a string and returns a dictionary."""
    translations = {}
    # Use StringIO to treat the content string as a file
    try:
        if has_header:
            reader = csv.DictReader(content.splitlines(), delimiter=delimiter)
            if key_column not in reader.fieldnames or value_column not in reader.fieldnames:
                print(f"Warning: CSV data is missing specified key/value columns.")
                return {}
            for row_number, row in enumerate(reader, start=1):
                try:
                    translations[row[key_column]] = row[value_column]
                except KeyError as e:
                    print(f"Error at line {row_number}: Missing key or value column: {row}")
                    return {}
                except csv.Error as e:
                    print(f"Error at line {row_number}: {e}")
                    return {}
        else:
            reader = csv.reader(content.splitlines(), delimiter=delimiter)
            for row_number, row in enumerate(reader, start=1):
                try:
                    # Use integer indices if column names are provided, otherwise error
                    key_index = int(key_column) if key_column.isdigit() else key_column
                    value_index = int(value_column) if value_column.isdigit() else value_column
                    if isinstance(key_index, str) or isinstance(value_index,str):
                        raise KeyError
                    translations[row[key_index]] = row[value_index]
                except IndexError:
                    print(f"Error at line {row_number}: Row has fewer columns than expected.")
                    return {}
                except ValueError:
                    print(f"Error: Invalid column index provided for data without header.")
                    return {}
                except KeyError:
                    print(f"Error: When using --no-header, -k and -v must specify *integer* column indices (0, 1, 2...).")
                    return {}
                except csv.Error as e:
                    print(f"Error at line {row_number}: {e}")
                    return {}
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return {}

    return translations

def read_lang_file(content, trim_whitespace=False):
    """Reads .lang data from a string and returns a dictionary."""
    translations = {}
    try:
        for line_number, line in enumerate(content.splitlines(), start=1):
            line = line.strip()
            if line and not line.startswith("#"):
                try:
                    key, value = line.split("=", 1)
                    if trim_whitespace:
                        key = key.strip()
                        value = value.strip()
                    translations[key] = value
                except ValueError:
                    print(f"Error at line {line_number}: Invalid key-value pair.")
                    return {}
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return {}
    return translations

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


    # Now, read the file content based on the extension
    if old_ext.lower() == ".csv":
        old_translations = read_csv_file(old_content, delimiter=args.delimiter,
                                          has_header=not args.no_header,
                                          key_column=args.key_column,
                                          value_column=args.value_column)
        new_translations = read_csv_file(new_content, delimiter=args.delimiter,
                                          has_header=not args.no_header,
                                          key_column=args.key_column,
                                          value_column=args.value_column)
    elif old_ext.lower() == ".lang":
        old_translations = read_lang_file(old_content, trim_whitespace=args.lang_trim_whitespace)
        new_translations = read_lang_file(new_content, trim_whitespace=args.lang_trim_whitespace)
    else:
        parser.error("Unsupported file type.  Must be .csv or .lang")

except git.InvalidGitRepositoryError:
    print(f"Error: Not a git repository or any of the parent directories: {args.repo}")
    sys.exit(1)

if old_translations and new_translations:
    print("Comparing translations...\n")
    compare_translations(old_translations, new_translations,
                         ignore_case=args.ignore_case,
                         ignore_whitespace=args.ignore_whitespace,
                         output_file=args.output)