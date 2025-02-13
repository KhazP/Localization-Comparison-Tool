# logic.py (All the logic functions)
import csv
import xml.etree.ElementTree as ET
import git  # If you plan on adding git functionality to this module later
import os
import sys
from colorama import init, Fore, Style
import logging
from enum import Enum, auto

# Setup logging at the top of the file
logging.basicConfig(level=logging.DEBUG,
                   format='%(asctime)s - %(levelname)s - %(message)s',
                   filename='localizer_debug.log')

init()  # Initialize colorama

VALID_COLORS = [  # Keep for potential future use with command line
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
    "lightblack_ex", "lightred_ex", "lightgreen_ex", "lightyellow_ex",
    "lightblue_ex", "lightmagenta_ex", "lightcyan_ex", "lightwhite_ex"
]

def get_color(color_name):
    """Gets the colorama Fore color object from a color name (case-insensitive)."""
    color_name = color_name.lower()
    if color_name not in VALID_COLORS:
        return None
    return getattr(Fore, color_name.upper())

class FileError(Enum):
    EMPTY_FILE = auto()
    INVALID_XML_SYNTAX = auto()
    MISSING_XML_ATTRIBUTES = auto()
    INVALID_CSV_FORMAT = auto()
    MISSING_CSV_COLUMNS = auto()
    INVALID_ENCODING = auto()
    UNKNOWN_FORMAT = auto()
    FILE_NOT_FOUND = auto()
    PERMISSION_ERROR = auto()

class ParsingResult:
    def __init__(self, success=False, translations=None, error=None, details=None):
        self.success = success
        self.translations = translations or {}
        self.error = error
        self.details = details
    
    def __bool__(self):
        return self.success

def read_csv_file(content, delimiter=',', has_header=True, key_column='key', value_column='value'):
    """Reads CSV or XML data from a string and returns a ParsingResult."""
    logging.debug(f"Starting read_csv_file with content starting: {content[:100]}")
    
    # Clean and check content
    if not content.strip():
        return ParsingResult(error=FileError.EMPTY_FILE)
    
    content = content.strip().lstrip('\ufeff')  # Remove BOM and whitespace
    
    # Check for XML format first
    if any(marker in content.lower()[:100] for marker in ['<?xml', '<lang']):
        try:
            # Handle quoted XML content
            if content.startswith('"') and content.endswith('"'):
                content = content[1:-1]
            
            # Clean up double quotes around tags
            content = content.replace('""<', '<').replace('>""', '>')
            logging.debug("Attempting XML parsing")
            root = ET.fromstring(content)
            translations = {}
            # Use different search based on the root tag
            if root.tag.lower() == "lang":
                string_elements = root.findall("string")
            else:
                string_elements = root.findall('.//string')
            if not string_elements:
                logging.error("No <string> elements found")
                return ParsingResult(
                    error=FileError.MISSING_XML_ATTRIBUTES,
                    details="No <string> elements found in XML"
                )
            for string_elem in string_elements:
                key = string_elem.get("name")
                if not key:
                    logging.error("A <string> element is missing 'name' attribute")
                    return ParsingResult(
                        error=FileError.MISSING_XML_ATTRIBUTES,
                        details="Found <string> element without 'name' attribute"
                    )
                translations[key] = string_elem.text if string_elem.text is not None else ""
            if translations:
                logging.debug(f"Successfully parsed {len(translations)} XML translations")
                return ParsingResult(True, translations)
            else:
                logging.error("XML parsed but no translations found")
                return ParsingResult(
                    error=FileError.EMPTY_FILE,
                    details="Parsed XML contained no translations"
                )
        except ET.ParseError as e:
            return ParsingResult(
                error=FileError.INVALID_XML_SYNTAX,
                details=f"XML syntax error: {str(e)}"
            )
    
    # Try CSV parsing
    try:
        lines = content.splitlines()
        translations = {}
        
        if not lines:
            return ParsingResult(error=FileError.EMPTY_FILE)
        
        if has_header:
            reader = csv.DictReader(lines, delimiter=delimiter)
            if not reader.fieldnames:
                return ParsingResult(
                    error=FileError.MISSING_CSV_COLUMNS,
                    details=f"Expected columns: {key_column}, {value_column}"
                )
            
            if key_column not in reader.fieldnames or value_column not in reader.fieldnames:
                return ParsingResult(
                    error=FileError.MISSING_CSV_COLUMNS,
                    details=f"Missing required columns. Found: {', '.join(reader.fieldnames)}"
                )
            
            for row in reader:
                translations[row[key_column]] = row[value_column]
        else:
            reader = csv.reader(lines, delimiter=delimiter)
            for row in reader:
                if len(row) < 2:
                    return ParsingResult(
                        error=FileError.INVALID_CSV_FORMAT,
                        details=f"Row has insufficient columns: {row}"
                    )
                translations[row[0]] = row[1]
        
        if not translations:
            return ParsingResult(
                error=FileError.EMPTY_FILE,
                details="No translations found in file"
            )
        
        return ParsingResult(True, translations)
        
    except csv.Error as e:
        return ParsingResult(
            error=FileError.INVALID_CSV_FORMAT,
            details=f"CSV parsing error: {str(e)}"
        )
    except Exception as e:
        return ParsingResult(
            error=FileError.UNKNOWN_FORMAT,
            details=f"Unexpected error: {str(e)}"
        )

def read_lang_file(content, trim_whitespace=False):
    """Reads a plain text .lang file (key=value format) and returns a dictionary."""
    translations = {}
    try:
        for line_number, line in enumerate(content.splitlines(), start=1):
            line = line.strip()
            # Skip comment lines, XML declarations, and HTML/XML comments
            if line and (line.startswith("#") or line.startswith("<!--") or line.startswith("<?xml")):
                continue
            if line:  # Process non-comment lines
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
        print(f"An unexpected error occurred in read_lang_file: {e}")
        return {}
    return translations

def read_xml_lang_file(filepath, trim_whitespace=False):
    """Reads a .lang file (XML format), preprocesses it, and returns a dictionary."""
    translations = {}
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
        # --- Pre-processing ---
        # Replace any '&' that is not already part of a valid entity
        import re
        content = re.sub(r'&(?!amp;|lt;|gt;|quot;|apos;)', '&', content)
        try:
            root = ET.fromstring(content)
        except ET.ParseError as e:
            print(f"Error parsing XML in '{filepath}': {e}")
            return {}
        for string_elem in root.findall('string'):
            key = string_elem.get('name')
            value = string_elem.text if string_elem.text is not None else ""
            if key is not None:
                if trim_whitespace:
                    key = key.strip()
                    value = value.strip()
                translations[key] = value
    except FileNotFoundError:
        print(f"Error: File not found: {filepath}")
        return {}
    except Exception as e:
        print(f"An unexpected error occurred in read_xml_lang_file: {e}")
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
        return {}  # Return empty dict on error
    except git.NoSuchPathError:
        print(f"Error: File not found in repository: {file_path}")
        return {}
    except (git.BadName, ValueError) as e:
        print(f"Error: Invalid commit ID or file not found in commit: {commit_id}")
        return {}
    except FileNotFoundError:
        print(f"Error: File not found in working tree: {file_path}")
        return {}
    except Exception as e:
        print(f"An unexpected error occurred in get_file_content: {e}")
        return {}

def compare_translations(old_translations, new_translations,
                         ignore_case=False, ignore_whitespace=False,
                         is_gui=False, compare_values=False):
    added_count = 0
    removed_count = 0
    modified_count = 0
    output_lines = []

    old_keys = set(old_translations.keys())
    new_keys = set(new_translations.keys())

    added_keys = new_keys - old_keys
    removed_keys = old_keys - new_keys
    common_keys = old_keys & new_keys

    max_key_length = 0
    if all_keys := sorted(old_keys | new_keys):
        max_key_length = max(len(key) for key in all_keys)

    # Added keys
    for key in sorted(added_keys):
        output_lines.append(Fore.GREEN + f"+ {key.ljust(max_key_length)} : {new_translations[key]}" + Style.RESET_ALL if not is_gui else f"+ {key.ljust(max_key_length)} : {new_translations[key]}")
        added_count += 1

    # Removed keys
    for key in sorted(removed_keys):
        output_lines.append(Fore.RED + f"- {key.ljust(max_key_length)} : {old_translations[key]}" + Style.RESET_ALL if not is_gui else f"- {key.ljust(max_key_length)} : {old_translations[key]}")
        removed_count += 1

    # Modified and unchanged keys
    if compare_values:
        for key in sorted(common_keys):
            old_value = old_translations[key]
            new_value = new_translations[key]

            if ignore_case:
                old_value = old_value.lower()
                new_value = new_value.lower()

            if ignore_whitespace:
                old_value = old_value.strip()
                new_value = new_value.strip()

            if old_value == new_value:
                output_lines.append(f"  {key.ljust(max_key_length)} : {old_translations[key]}")  # Unchanged
            else:
                # Modified: Show old and new values
                if is_gui:
                    output_lines.append(f"M {key.ljust(max_key_length)} : {old_translations[key]}")
                    output_lines.append(f"  {key.ljust(max_key_length)} : {new_translations[key]}")
                else:
                    output_lines.append(Fore.YELLOW + f"M {key.ljust(max_key_length)} : {old_translations[key]}" + Style.RESET_ALL)
                    output_lines.append(Fore.YELLOW + f"  {key.ljust(max_key_length)} : {new_translations[key]}" + Style.RESET_ALL)
                modified_count += 1

    output_lines.append("\n--- Summary ---")
    output_lines.append(f"Added:     {added_count}")
    output_lines.append(f"Removed:   {removed_count}")
    if compare_values:
        output_lines.append(f"Modified:  {modified_count}")

    return "\n".join(output_lines)