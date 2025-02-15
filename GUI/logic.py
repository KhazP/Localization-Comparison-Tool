# logic.py (All the logic functions)
import csv
import xml.etree.ElementTree as ET
import git  # If you plan on adding git functionality to this module later
import os
import sys
from colorama import init, Fore, Style
import logging
from enum import Enum, auto
import xml_parser  # New import added at top
# New import for mixed parser
sys.path.append("E:/ProgramTests/LocalizerAppMain")
from MixedParser import mixed_parser

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
    logging.debug("Forcing CSV parse, ignoring XML markers.")
    
    if not content.strip():
        return ParsingResult(error=FileError.EMPTY_FILE)
    
    content = content.strip().lstrip('\ufeff')  # Remove BOM and whitespace
    try:
        lines = content.splitlines()
        if not lines:
            return ParsingResult(error=FileError.EMPTY_FILE)
        
        # Auto-detect header based on expected column names
        if has_header:
            fields = [field.strip() for field in lines[0].split(delimiter)]
            if key_column not in fields or value_column not in fields:
                logging.debug("CSV header not detected; switching to no-header mode.")
                has_header = False
        
        translations = {}
        if has_header:
            reader = csv.DictReader(lines, delimiter=delimiter)
            logging.debug(f"CSV header: {reader.fieldnames}")
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

def read_xml_lang_content(content: str, trim_whitespace: bool = False) -> dict:
    """Parse XML content and extract string elements with their name attributes,
    with a fallback regex extraction if no strings are found."""
    translations = {}
    try:
        # Strip comments and blank lines
        lines = [line.strip() for line in content.splitlines() if line.strip() 
                 and not line.strip().startswith('<!--') 
                 and not line.strip().startswith('//')]
        content = '\n'.join(lines)
        if not content.startswith('<?xml'):
            content = '<?xml version="1.0" encoding="UTF-8"?>\n' + content
        logging.debug(f"Parsing XML content: {content[:200]}")
        root = ET.fromstring(content)
        for string_elem in root.findall('.//string'):
            key = string_elem.get('name')
            value = string_elem.text if string_elem.text is not None else ""
            if key:
                key = key.strip()
                if trim_whitespace:
                    value = value.strip()
                translations[key] = value
                logging.debug(f"Found key: {key} = {value}")
    except ET.ParseError as e:
        logging.error(f"XML parsing error: {str(e)}\nContent: {content[:200]}")
    # Fallback: If no translations found and content appears to contain <string> tags, use regex.
    if not translations and "<string" in content:
        import re
        logging.debug("No translations found via XML parsing; using regex fallback.")
        pattern = r'<string\s+name="([^"]+)">(.*?)</string>'
        for match in re.findall(pattern, content, flags=re.DOTALL):
            key = match[0].strip()
            value = match[1].strip() if trim_whitespace else match[1]
            translations[key] = value
            logging.debug(f"(Regex) Found key: {key} = {value}")
    logging.info(f"Total translations found: {len(translations)}")
    return translations

def parse_content_by_ext(content: str, ext: str, trim_whitespace: bool = False) -> dict:
    """Parse content based on file extension and content type."""
    logging.debug(f"Parsing file with extension: {ext}")
    logging.debug(f"Content starts with: {content[:100]}")
    
    # Always check content type first, regardless of extension
    content = content.lstrip()
    
    # If content looks like XML, use XML parser
    if content.startswith(('<?xml', '<lang', '<string')):
        logging.debug("Content appears to be XML, using XML parser")
        translations = read_xml_lang_content(content, trim_whitespace)
        logging.debug(f"XML parser found {len(translations)} entries")
        return translations
    
    # For true CSV files (not containing XML)
    if ext.lower() == '.csv' and not content.startswith('<'):
        logging.debug("Using CSV parser")
        result = read_csv_file(content)
        translations = result.translations if result.success else {}
        logging.debug(f"CSV parser found {len(translations)} entries")
        return translations
    
    # For true .lang files (not containing XML)
    if ext.lower() == '.lang' and not content.startswith('<'):
        logging.debug("Using .lang parser")
        translations = read_lang_file(content, trim_whitespace)
        logging.debug(f"Lang parser found {len(translations)} entries")
        return translations
    
    # For plain text files that aren't XML
    if ext.lower() == '.txt' and not content.startswith('<'):
        logging.debug("Using plain text parser")
        translations = read_lang_file(content, trim_whitespace)
        logging.debug(f"Text parser found {len(translations)} entries")
        return translations

    # For any other files, try XML first then fallback to plain text
    logging.debug("Trying XML parser as fallback")
    translations = read_xml_lang_content(content, trim_whitespace)
    if translations:
        return translations
        
    logging.debug("Falling back to plain text parser")
    return read_lang_file(content, trim_whitespace)

def read_lang_file(content, trim_whitespace=False):
    """Reads a plain text .lang file (key=value format) and returns a dictionary."""
    translations = {}
    try:
        for line_number, line in enumerate(content.splitlines(), start=1):
            line = line.strip()
            # Skip blank lines, XML tags and comment lines
            if not line or line.startswith("<?xml") or line.startswith("<!--") or line.startswith("#"):
                continue
                
            # Handle basic key=value format
            if "=" in line:
                try:
                    key, value = line.split("=", 1)
                    if trim_whitespace:
                        key = key.strip()
                        value = value.strip()
                    translations[key] = value
                except ValueError:
                    logging.warning(f"Invalid key-value pair at line {line_number}: {line}")
                    continue
                    
    except Exception as e:
        logging.error(f"Error in read_lang_file: {str(e)}")
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
                       is_gui=False, compare_values=False,
                       ignore_patterns=None):
    """
    Compare two translation dictionaries.
    Only checks string names (keys) to find:
    - Keys present in source but missing from target
    - Keys present in target but missing from source
    """
    # Filter ignored patterns and normalize keys
    def normalize_key(k):
        k = k.strip()  # Always strip whitespace from keys
        return k.lower() if ignore_case else k

    # Build normalized key sets
    source_keys = {normalize_key(k) for k, v in old_translations.items()
                  if not any(k.startswith(p) for p in (ignore_patterns or []))}
    target_keys = {normalize_key(k) for k, v in new_translations.items()
                  if not any(k.startswith(p) for p in (ignore_patterns or []))}
    
    # Debug logging
    logging.debug(f"Source file has {len(source_keys)} keys")
    logging.debug(f"Target file has {len(target_keys)} keys")
    logging.debug(f"First few source keys: {sorted(list(source_keys))[:5]}")
    logging.debug(f"First few target keys: {sorted(list(target_keys))[:5]}")

    # Find what's missing and what's obsolete
    missing_in_target = source_keys - target_keys
    obsolete_in_target = target_keys - source_keys

    missing_count = len(missing_in_target)
    obsolete_count = len(obsolete_in_target)
    output_lines = []

    # Calculate max key length for proper alignment
    max_key_length = max((len(key) for key in (source_keys | target_keys)), default=0)

    # Report missing entries (in source but not target)
    for key in sorted(missing_in_target):
        line = f"+ {key.ljust(max_key_length)} : {old_translations[key]} (missing in source translation)"
        if not is_gui:
            line = Fore.GREEN + line + Style.RESET_ALL
        output_lines.append(line)

    # Report obsolete entries (in target but not source) 
    for key in sorted(obsolete_in_target):
        line = f"- {key.ljust(max_key_length)} : {new_translations[key]} (missing in target translation)"
        if not is_gui:
            line = Fore.RED + line + Style.RESET_ALL
        output_lines.append(line)

    if output_lines:
        output_lines.append("")
    
    output_lines.append("--- Summary ---")
    output_lines.append(f"Missing in target: {missing_count}")
    output_lines.append(f"Obsolete in target: {obsolete_count}")

    return "\n".join(output_lines)