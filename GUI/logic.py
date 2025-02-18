import os
import sys

# Add parent directory to Python path to find modules
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import csv
import xml.etree.ElementTree as ET
import git  # If you plan on adding git functionality to this module later
from colorama import init, Fore, Style
import logging
from enum import Enum, auto
import xml_parser  # New import added at top
import json
import requests
import html
from typing import Optional
import re
from functools import lru_cache
from constants import SUPPORTED_FORMATS, USER_MESSAGES
try:
    import yaml
except ImportError:
    yaml = None

# Precompile regex pattern for XML fallback parsing
_xml_string_pattern = re.compile(r'<string\s+name="([^"]+)">(.*?)</string>', flags=re.DOTALL)

# Setup logging at the top of the file
logging.basicConfig(
    level=logging.WARNING,  # Set default level to WARNING
    format='%(asctime)s - %(levelname)s - %(message)s',
    filename='localizer_debug.log',
    filemode='w'  # Overwrite log file on each run
)
logger = logging.getLogger(__name__)
logger.disabled = True  # Disable logging by default

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
    def __init__(self, success=False, translations=None, line_numbers=None, error=None, details=None):
        self.success = success
        self.translations = translations or {}
        self.line_numbers = line_numbers or {}  # Added line_numbers
        self.error = error
        self.details = details
    
    def __bool__(self):
        return self.success

# New base class and parser subclasses
class TranslationParser:
    def parse(self, content: str) -> dict:
        raise NotImplementedError

class LangParser(TranslationParser):
    def parse(self, content: str) -> dict:
        # Reuse the existing plain text lang parser function
        return read_lang_file(content)

class JSONParser(TranslationParser):
    def parse(self, content: str) -> dict:
        try:
            return json.loads(content)
        except json.JSONDecodeError as e:
            logging.error(f"JSON parse error: {str(e)}")
            return {}

class YAMLParser(TranslationParser):
    def parse(self, content: str) -> dict:
        if yaml:
            try:
                data = yaml.safe_load(content)
                if isinstance(data, dict):
                    return data
                else:
                    logging.error("YAML content is not a dict")
                    return {}
            except yaml.YAMLError as e:
                logging.error(f"YAML parse error: {str(e)}")
                return {}
        else:
            logging.error("PyYAML not installed")
            return {}

class FileParsingError(Exception):
    """Base exception for file parsing issues."""
    pass

class CSVParsingError(FileParsingError):
    """Raised when CSV parsing fails."""
    pass

class UnknownFormatError(FileParsingError):
    """Raised when file format is not recognized."""
    pass

@lru_cache(maxsize=32)
def read_csv_file(content, delimiter=',', has_header=True, key_column='key', value_column='value'):
    """Reads CSV data and returns a ParsingResult with translations and line numbers."""
    
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
        line_numbers = {}  # Track line numbers for each key
        
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
            for row_num, row in enumerate(reader, start=2):  # Start from line 2 if header is present
                key = row[key_column]
                translations[key] = row[value_column]
                line_numbers[key] = row_num
        else:
            reader = csv.reader(lines, delimiter=delimiter)
            for row_num, row in enumerate(reader, start=1):
                if len(row) < 2:
                    return ParsingResult(
                        error=FileError.INVALID_CSV_FORMAT,
                        details=f"Row has insufficient columns: {row}"
                    )
                key = row[0]
                translations[key] = row[1]
                line_numbers[key] = row_num
        
        if not translations:
            return ParsingResult(
                error=FileError.EMPTY_FILE,
                details="No translations found in file"
            )
        
        return ParsingResult(True, translations, line_numbers)
        
    except csv.Error as e:
        raise CSVParsingError(f"CSV parsing error: {str(e)}")
    except Exception as e:
        raise UnknownFormatError(f"Unexpected CSV error: {str(e)}")

def read_xml_lang_content(content: str, trim_whitespace: bool = False) -> dict:
    """Parse XML content and extract string elements with their line numbers."""
    translations = {}
    line_numbers = {}  # Track line numbers
    
    try:
        # Process content line by line to track line numbers
        lines = content.splitlines()
        current_key = None
        current_line = 0
        
        for i, line in enumerate(lines, 1):
            line = line.strip()
            if not line or line.startswith('<!--') or line.startswith('//'):
                continue
                
            # Look for string element start
            key_match = re.search(r'<string\s+name="([^"]+)">', line)
            if key_match:
                current_key = key_match.group(1)
                current_line = i
                # If the value is on the same line
                value_match = re.search(r'>([^<]+)</string>', line)
                if value_match:
                    translations[current_key] = value_match.group(1)
                    line_numbers[current_key] = current_line
                    current_key = None
            
            # Handle multi-line values
            elif current_key and '</string>' in line:
                value = re.search(r'([^<]+)</string>', line)
                if value:
                    translations[current_key] = value.group(1)
                    line_numbers[current_key] = current_line
                current_key = None

        # Fallback to regex parsing if needed
        if not translations and "<string" in content:
            for match in re.finditer(r'<string\s+name="([^"]+)"[^>]*>([^<]*)', content):
                key = match.group(1)
                value = match.group(2)
                translations[key] = value
                # Approximate line number by counting newlines before match
                line_number = content[:match.start()].count('\n') + 1
                line_numbers[key] = line_number

    except Exception as e:
        logging.error(f"Error parsing XML content: {str(e)}")
        
    return {
        "translations": translations,
        "line_numbers": line_numbers
    }

def parse_xliff(content: str) -> dict:
    """
    Parse XLIFF (XML-based) to extract translation units.
    Returns a {key: value} dict.
    """
    translations = {}
    try:
        root = ET.fromstring(content)
        # Typical XLIFF structure uses <trans-unit id="..."><target>...</target>
        for unit in root.findall('.//trans-unit'):
            key = unit.get('id')
            if key:
                target_elem = unit.find('target')
                translations[key] = target_elem.text if target_elem is not None else ''
    except ET.ParseError as e:
        logging.error(f"XLIFF parse error: {str(e)}")
    return translations

def parse_properties_file(content: str) -> dict:
    """
    Parse Java .properties format (key=value pairs, supporting backslash escapes).
    Returns a {key: value} dict.
    """
    translations = {}
    for line in content.splitlines():
        line = line.strip()
        if not line or line.startswith('#') or '=' not in line:
            continue
        key, value = line.split('=', 1)
        translations[key.strip()] = value.strip()
    return translations

def parse_resx(content: str) -> dict:
    """
    Parse .resx file (XML for .NET resources).
    Returns a {key: value} dict based on <data name="..."><value>...</value>
    """
    translations = {}
    try:
        root = ET.fromstring(content)
        for data_elem in root.findall('.//data'):
            key = data_elem.get('name')
            if key:
                value_elem = data_elem.find('value')
                translations[key] = value_elem.text if value_elem is not None else ''
    except ET.ParseError as e:
        logging.error(f"RESX parse error: {str(e)}")
    return translations

def parse_android_xml(content: str) -> dict:
    """
    Parse Android XML format (<string name="...">...</string>).
    Returns a {key: value} dict.
    """
    translations = {}
    try:
        root = ET.fromstring(content)
        for string_elem in root.findall('.//string'):
            key = string_elem.get('name')
            if key:
                translations[key] = string_elem.text or ''
    except ET.ParseError as e:
        logging.error(f"Android XML parse error: {str(e)}")
    return translations

def parse_angular_translate_json(content: str) -> dict:
    """
    Parse Angular Translate JSON or similar JSON-based i18n.
    Returns a {key: value} dict.
    """
    try:
        data = json.loads(content)
        # Usually a nested structure, flatten if needed
        translations = {}
        def flatten(d, prefix=''):
            for k, v in d.items():
                full_key = f"{prefix}.{k}" if prefix else k
                if isinstance(v, dict):
                    flatten(v, full_key)
                else:
                    translations[full_key] = v
        flatten(data)
        return translations
    except json.JSONDecodeError as e:
        logging.error(f"Angular JSON parse error: {str(e)}")
        return {}

def parse_content_by_ext(content: str, ext: str, trim_whitespace: bool = False) -> dict:
    """Parse content based on file extension and content type."""
    logging.debug(f"Parsing file with extension: {ext}")
    logging.debug(f"Content starts with: {content[:100]}")
    
    content = content.lstrip()

    try:
        # New parser-based handling for JSON, YAML, and .lang files.
        if ext.lower() == '.json' and not content.startswith('<'):
            logging.debug("Using JSON parser")
            parser = JSONParser()
            return parser.parse(content)

        if ext.lower() in ['.yaml', '.yml'] and not content.startswith('<'):
            logging.debug("Using YAML parser")
            parser = YAMLParser()
            return parser.parse(content)

        if ext.lower() == '.lang' and not content.startswith('<'):
            logging.debug("Using .lang parser")
            parser = LangParser()
            # This returns {"translations": {...}, "line_numbers": {...}}
            return parser.parse(content)
        
        if ext.lower() == '.xliff':
            return parse_xliff(content)
        elif ext.lower() == '.properties':
            return parse_properties_file(content)
        elif ext.lower() == '.resx':
            return parse_resx(content)
        elif ext.lower() == '.xml' and 'resources' in content:
            # Heuristic for Android XML
            return parse_android_xml(content)
        elif ext.lower() in ['.angular.json', '.ngjson']:
            return parse_angular_translate_json(content)

        # Fallback for XML
        if content.startswith(('<?xml', '<lang', '<string')):
            logging.debug("Content appears to be XML, using XML parser")
            translations = read_xml_lang_content(content, trim_whitespace)
            logging.debug(f"XML parser found {len(translations)} entries")
            return translations
        
        # Fallback for CSV
        if ext.lower() == '.csv' and not content.startswith('<'):
            logging.debug("Using CSV parser")
            result = read_csv_file(content)
            translations = result.translations if result.success else {}
            logging.debug(f"CSV parser found {len(translations)} entries")
            return translations
        
        # Fallback for plain text
        if ext.lower() == '.txt' and not content.startswith('<'):
            logging.debug("Using plain text parser")
            translations = read_lang_file(content, trim_whitespace)
            logging.debug(f"Text parser found {len(translations)} entries")
            return translations

        logging.debug("Trying XML parser as fallback")
        translations = read_xml_lang_content(content, trim_whitespace)
        if translations:
            return translations
            
        logging.debug("Falling back to plain text parser")
        return read_lang_file(content, trim_whitespace)
    except FileParsingError as e:
        logging.error(f"ParsingError: {str(e)}")
        return {"translations": {}, "line_numbers": {}}

def read_lang_file(content, trim_whitespace=False):
    """Reads a plain text .lang file (key=value format) and returns translations and line numbers."""
    translations = {}
    line_numbers = {}  # Track line numbers
    
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
                    line_numbers[key] = line_number  # Store line number for this key
                except ValueError:
                    logging.warning(f"Invalid key-value pair at line {line_number}: {line}")
                    continue
                    
    except Exception as e:
        raise FileParsingError(f"Error in read_lang_file: {str(e)}")
        
    return {
        "translations": translations,
        "line_numbers": line_numbers
    }

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

def machine_translate(text: str, source_lang: str, target_lang: str, api_key: str) -> Optional[str]:
    """Translate text using Google Cloud Translate API."""
    if not api_key:
        return None
        
    try:
        url = "https://translation.googleapis.com/language/translate/v2"
        payload = {
            'q': text,
            'source': source_lang,
            'target': target_lang,
            'key': api_key
        }
        
        response = requests.post(url, params=payload)
        response.raise_for_status()
        
        result = response.json()
        if 'data' in result and 'translations' in result['data']:
            translated_text = result['data']['translations'][0]['translatedText']
            # Decode HTML entities that might be in the response
            return html.unescape(translated_text)
            
    except requests.exceptions.RequestException as e:
        logging.error(f"Translation API error: {str(e)}")
    except (KeyError, IndexError) as e:
        logging.error(f"Unexpected API response format: {str(e)}")
    except Exception as e:
        logging.error(f"Unexpected error during translation: {str(e)}")
        
    return None

def compare_translations(old_translations, new_translations, ignore_case=False, 
                       ignore_whitespace=False, is_gui=False, compare_values=False,
                       ignore_patterns=None, log_missing_keys=False, target_locale="target",
                       auto_fill_missing=False, mt_settings=None, include_summary=True):
    """Compares two translation dictionaries with optional machine translation."""
    
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
    invalid_placeholders = []  # Track keys with placeholder mismatches

    # Check for placeholder consistency in matching keys
    common_keys = source_keys & target_keys
    for key in common_keys:
        source_text = old_translations[key]
        target_text = new_translations[key]
        is_valid, error_msg = validate_placeholders(source_text, target_text)
        if not is_valid:
            invalid_placeholders.append((key, error_msg))
            if log_missing_keys:
                logging.warning(f"Placeholder mismatch in key '{key}': {error_msg}")

    # Auto-fill missing translations if enabled
    if auto_fill_missing:
        for key in missing_in_target:
            new_translations[key] = ""  # Add empty string for missing keys
            if log_missing_keys:
                logging.info(f"Auto-filled missing key: {key}")

    missing_count = len(missing_in_target)
    obsolete_count = len(obsolete_in_target)
    placeholder_count = len(invalid_placeholders)
    output_lines = []

    # Calculate max key length for proper alignment
    max_key_length = max((len(key) for key in (source_keys | target_keys)), default=0)

    # Report placeholder mismatches
    for key, error_msg in invalid_placeholders:
        line = f"~ {key.ljust(max_key_length)} : {new_translations[key]} ({error_msg})"
        if not is_gui:
            line = Fore.YELLOW + line + Style.RESET_ALL
        output_lines.append(line)

    # Log a warning for each missing key if the flag is enabled
    for key in sorted(missing_in_target):
        if log_missing_keys:
            logging.warning(f"Missing translation key '{key}' for locale '{target_locale}'")
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

    # Only add summary section if requested
    if include_summary:
        if output_lines:
            output_lines.append("")
        output_lines.append("--- Summary ---")
        output_lines.append(f"Missing in target: {missing_count}")
        output_lines.append(f"Obsolete in target: {obsolete_count}")
        output_lines.append(f"Placeholder mismatches: {placeholder_count}")

    return "\n".join(output_lines)

def translate_missing_keys(source_dict: dict, target_dict: dict, 
                         source_lang: str, target_lang: str, 
                         api_key: str, 
                         progress_callback=None) -> tuple[dict, list[str]]:
    """
    Translate missing keys from source to target language.
    Returns (updated_dict, errors)
    """
    if not api_key:
        return target_dict, ["No API key provided"]

    updated_dict = target_dict.copy()
    errors = []
    total = len(source_dict)
    processed = 0

    for key, text in source_dict.items():
        if key not in target_dict:
            try:
                translated = machine_translate(text, source_lang, target_lang, api_key)
                if translated:
                    updated_dict[key] = translated
                else:
                    errors.append(f"Failed to translate: {key}")
            except Exception as e:
                errors.append(f"Error translating {key}: {str(e)}")

        processed += 1
        if progress_callback:
            progress_callback(processed / total)

    return updated_dict, errors

def save_translations(translations: dict, filepath: str, format: str = "auto") -> tuple[bool, str]:
    """Save translations to file in specified format. Returns (success, error_message)"""
    try:
        format = format.lower() if format != "auto" else filepath.split('.')[-1].lower()
        content = None

        if format in ['json', 'yaml', 'yml']:
            # Sort keys for consistent output
            sorted_translations = dict(sorted(translations.items()))
            
            if format == 'json':
                content = json.dumps(sorted_translations, indent=2, ensure_ascii=False)
            else:  # yaml format
                if not yaml:
                    return False, "PyYAML not installed"
                content = yaml.dump(sorted_translations, allow_unicode=True, sort_keys=False)
        
        elif format == 'lang':
            # Basic key=value format
            lines = [f"{k}={v}" for k, v in sorted(translations.items())]
            content = '\n'.join(lines)
        
        else:  # Default to XML
            root = ET.Element("resources")
            for key, value in sorted(translations.items()):
                string_elem = ET.SubElement(root, "string", name=key)
                string_elem.text = value
            content = '<?xml version="1.0" encoding="UTF-8"?>\n' + ET.tostring(root, encoding='unicode', method='xml')

        if content is not None:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            return True, ""

        return False, "Unsupported format"

    except Exception as e:
        return False, str(e)

def extract_placeholders(text: str) -> list[str]:
    """Extract all placeholders from a text string."""
    # Common placeholder patterns
    patterns = [
        r'\{[^}]+\}',          # {name}, {0}, {value}
        r'%[ds]',              # %s, %d
        r'%[0-9]*\.[0-9]*[fs]',# %.2f, %3.1f
        r'%[0-9]+\$[ds]',      # %1$s, %2$d (positional)
        r'\$[a-zA-Z_][a-zA-Z0-9_]*', # $variable
        r'#[a-zA-Z_][a-zA-Z0-9_]*#', # #variable#
        r'\[\[[^\]]+\]\]'      # [[variable]]
    ]
    
    combined_pattern = '|'.join(patterns)
    placeholders = re.finditer(combined_pattern, text)
    return [p.group() for p in placeholders]

def validate_placeholders(source_text: str, target_text: str) -> tuple[bool, str]:
    """
    Validate that placeholders match between source and target text.
    Returns (is_valid, error_message).
    """
    if not source_text or not target_text:
        return True, ""  # Consider empty strings valid
        
    source_placeholders = extract_placeholders(source_text)
    target_placeholders = extract_placeholders(target_text)
    
    if not source_placeholders and not target_placeholders:
        return True, ""
    
    # Check if lists match (including order for positional placeholders)
    if source_placeholders == target_placeholders:
        return True, ""
        
    # Check for missing or extra placeholders
    missing = set(source_placeholders) - set(target_placeholders)
    extra = set(target_placeholders) - set(source_placeholders)
    
    error_msg = []
    if missing:
        error_msg.append(f"Missing placeholders: {', '.join(missing)}")
    if extra:
        error_msg.append(f"Extra placeholders: {', '.join(extra)}")
        
    return False, "; ".join(error_msg)

from constants import SUPPORTED_FORMATS, USER_MESSAGES