import csv
import html
import json
import logging
import os
import re
import sys # Keep for sys.path if relative imports fail, remove if they work.
import xml.etree.ElementTree as ET
from collections import Counter
from dataclasses import dataclass, field
from functools import lru_cache
from typing import Any, Dict, List, Optional # Correctly sorted

# Third-party imports
import git
import requests
from colorama import Fore, Style, init
try:
    import yaml
except ImportError:
    yaml = None

# Local application/library specific imports
# Attempting relative imports:
from ..core.errors import (
    CSVParsingError, FileParsingError, JSONParsingError, LangParsingError,
    ParsingError, PropertiesParsingError, ResxParsingError, UnknownFormatError,
    XMLParsingError, XliffParsingError, YAMLParsingError
)
from ..core.parsing_result import ParsingResult
from ..utils.logger_service import logger_service

# Precompile regex pattern for XML fallback parsing
# Moved to be near its usage or top-level constants if broadly used.
# For now, keep it here as it's specific to this file's logic.
_xml_string_pattern = re.compile(r'<string\s+name="([^"]+)">(.*?)</string>', flags=re.DOTALL)

# The sys.path.append might be removable if relative imports work.
# If they don't (e.g. due to how scripts in GUI are run), this will be reinstated.
# sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Get logger from service instead of basic config
logger = logger_service.get_logger()

# Parser instances - if they have no internal state, they can be singletons
_json_parser = JSONParser()
_yaml_parser = YAMLParser()
_lang_parser = LangParser()

# Parser Registry
# Maps file extensions to parser functions/methods.
# Some parsers might need functools.partial if they take non-standard parameters
# not provided by parse_content_by_ext (e.g., read_csv_file's delimiter).
# For now, assuming parsers mostly conform to (content: str, trim_whitespace: bool)
# or just (content: str) where trim_whitespace is handled internally or not applicable.
PARSER_REGISTRY = {
    '.json': _json_parser.parse,
    '.yaml': _yaml_parser.parse,
    '.yml': _yaml_parser.parse,  # Common alternative for YAML
    '.lang': _lang_parser.parse,
    '.xliff': parse_xliff,
    '.xlf': parse_xliff,  # Common alternative for XLIFF
    '.properties': parse_properties_file,
    '.resx': parse_resx,
    '.xml': parse_android_xml, # Default for .xml, specific heuristic inside
    '.angular.json': parse_angular_translate_json, # Specific JSON variant
    '.ngjson': parse_angular_translate_json, # Another specific JSON variant for Angular
    '.csv': read_csv_file, # Uses default delimiter, header settings
    # '.txt': read_lang_file, # Example: if .txt should default to .lang format
    # Note: read_xml_lang_content is more of a fallback/content-sniffer, not directly extension based here
    # parse_android_xml also has internal heuristics.
}

init()  # Initialize colorama

VALID_COLORS = [  # Keep for potential future use with command line
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
    "lightblack_ex", "lightred_ex", "lightgreen_ex", "lightyellow_ex",
    "lightblue_ex", "lightmagenta_ex", "lightcyan_ex", "lightwhite_ex"
]

def get_color(color_name: str) -> Optional[str]:
    """Gets the colorama Fore color object from a color name.

    Args:
        color_name: The name of the color (case-insensitive).
                    Valid names are defined in `VALID_COLORS`.

    Returns:
        The corresponding colorama Fore object (which is a string sequence)
        if the color name is valid, otherwise None.
    """
    color_name_lower = color_name.lower()
    if color_name_lower not in VALID_COLORS:
        return None
    return getattr(Fore, color_name_lower.upper())

# New base class and parser subclasses
class TranslationParser:
    """Abstract base class for translation file parsers."""
    def parse(self, content: str, trim_whitespace: bool = False) -> ParsingResult:
        """Parses the given string content into a ParsingResult.

        This method must be implemented by subclasses.

        Args:
            content: The string content of the file to parse.
            trim_whitespace: Optional flag to indicate if leading/trailing
                             whitespace should be trimmed from keys and values
                             by parsers that support it. Defaults to False.

        Returns:
            A ParsingResult object containing translations, line numbers (if available),
            and any errors encountered.

        Raises:
            NotImplementedError: If the subclass does not implement this method.
        """
        raise NotImplementedError

class LangParser(TranslationParser):
    def parse(self, content: str, trim_whitespace: bool = False) -> ParsingResult:
        """
        Parses .lang file content (key=value) and returns a ParsingResult.
        The trim_whitespace argument is passed to the underlying read_lang_file.
        """
        # Directly use the refactored read_lang_file
        return read_lang_file(content, trim_whitespace=trim_whitespace)

class JSONParser(TranslationParser):
    def parse(self, content: str) -> ParsingResult:
        """Parses JSON content and returns a ParsingResult."""
        try:
            data = json.loads(content)
            if not isinstance(data, dict):
                logging.error("JSON content is not a dictionary.")
                # Or raise JSONParsingError("JSON content is not a dictionary.")
                return ParsingResult(translations={}, errors=["JSON content is not a dictionary."])
            return ParsingResult(translations=data)
        except json.JSONDecodeError as e:
            logging.error(f"JSON parse error: {str(e)}")
            # Or raise JSONParsingError(f"JSON parse error: {str(e)}")
            return ParsingResult(translations={}, errors=[f"JSON parse error: {str(e)}"])

class YAMLParser(TranslationParser):
    def parse(self, content: str) -> ParsingResult:
        """Parses YAML content and returns a ParsingResult."""
        if not yaml:
            logging.error("PyYAML not installed. YAML parsing unavailable.")
            # Or raise YAMLParsingError("PyYAML not installed. YAML parsing unavailable.")
            return ParsingResult(translations={}, errors=["PyYAML not installed. YAML parsing unavailable."])

        try:
            data = yaml.safe_load(content)
            if not isinstance(data, dict):
                logging.error("YAML content did not parse to a dictionary.")
                # Or raise YAMLParsingError("YAML content did not parse to a dictionary.")
                return ParsingResult(translations={}, errors=["YAML content did not parse to a dictionary."])
            return ParsingResult(translations=data)
        except yaml.YAMLError as e:
            logging.error(f"YAML parse error: {str(e)}")
            # Or raise YAMLParsingError(f"YAML parse error: {str(e)}")
            return ParsingResult(translations={}, errors=[f"YAML parse error: {str(e)}"])

@lru_cache(maxsize=32)
def read_csv_file(content: str, delimiter: str = ',', has_header: bool = True,
                  key_column: str = 'key', value_column: str = 'value') -> ParsingResult:
    """Reads and parses CSV data from a string into a structured format.

    This function processes CSV content, attempting to extract key-value pairs
    for translations. It can handle CSV files with or without a header row and
    allows customization of column names for keys and values, and the delimiter.
    Line numbers for each translation key are tracked if possible.

    Args:
        content: A string containing the CSV data.
        delimiter: The character used to separate fields in the CSV. Defaults to ','.
        has_header: Boolean indicating if the CSV has a header row. If True,
            the function will attempt to use `key_column` and `value_column`
            to identify the correct columns. If these are not found, and
            `has_header` was initially True, it may switch to treating the
            first row as data.
        key_column: The name of the column to use for translation keys when
            `has_header` is True. Defaults to 'key'.
        value_column: The name of the column to use for translation values when
            `has_header` is True. Defaults to 'value'.

    Returns:
        A `ParsingResult` object containing:
        - `translations`: A dictionary of extracted key-value translation pairs.
        - `line_numbers`: A dictionary mapping keys to their approximate line
                          numbers in the source content.
        - `errors`: A list of strings describing any non-critical errors or
                    warnings encountered during parsing (e.g., empty file,
                    missing columns, malformed rows).

    Raises:
        CSVParsingError: For critical CSV formatting errors that prevent parsing,
                         or other unexpected exceptions during processing.
    """
    errors: List[str] = []
    translations: Dict[str, str] = {}
    line_numbers: Dict[str, int] = {}

    if not content.strip():
        errors.append("CSV content is empty or consists only of whitespace.")
        return ParsingResult(translations=translations, line_numbers=line_numbers, errors=errors)

    # Remove BOM (Byte Order Mark) if present, and leading/trailing whitespace from the whole content
    content = content.strip().lstrip('\ufeff')
    
    lines = content.splitlines()
    if not lines:
        errors.append("CSV content is empty after stripping initial whitespace and BOM.")
        return ParsingResult(translations=translations, line_numbers=line_numbers, errors=errors)

    try:
        original_has_header = has_header  # Keep track of user's original preference
        
        # Auto-detect header based on expected column names if header is initially true
        if has_header:
            current_fields = [field.strip() for field in lines[0].split(delimiter)]
            if key_column not in current_fields or value_column not in current_fields:
                logging.debug(
                    f"CSV header not detected or missing key/value columns ('{key_column}', '{value_column}') "
                    f"in detected header: {current_fields}. Switching to no-header mode."
                )
                has_header = False # Switch to no-header mode
                # Add a warning only if the user explicitly expected a header
                if original_has_header:
                    errors.append(
                        f"Expected header with columns '{key_column}' and '{value_column}' not found. "
                        "Attempting to parse as CSV without headers."
                    )


        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {}  # Track line numbers for each key
        
        if has_header:
            reader = csv.DictReader(lines, delimiter=delimiter)
            # Check if fieldnames could be read at all (e.g. if lines was just one empty line after splitlines)
            if not reader.fieldnames:
                error_msg = (f"CSV Error: Could not read header row or fieldnames. "
                             f"Ensure the CSV is not empty and the delimiter '{delimiter}' is correct.")
                errors.append(error_msg)
                logging.warning(error_msg)
                return ParsingResult(translations=translations, line_numbers=line_numbers, errors=errors)

            if key_column not in reader.fieldnames or value_column not in reader.fieldnames:
                # This case should ideally be caught by the header auto-detection logic above
                # if original_has_header was true. If it's reached, it implies has_header remained true
                # but columns are still missing (e.g. user forced has_header=True for a file without it)
                errors.append(
                    f"Missing required columns in CSV header. Expected '{key_column}' and '{value_column}', "
                    f"but found: {', '.join(reader.fieldnames or [])}."
                )
                # Attempt to parse what we can, or return error if critical
                # For now, let's be strict if header was expected and columns are missing.
                return ParsingResult(translations={}, line_numbers=line_numbers, errors=errors)

            for row_num, row in enumerate(reader, start=2):  # Start from line 2 if header is present
                key = row.get(key_column)
                value = row.get(value_column)
                if key is None:
                    errors.append(f"Missing key in row {row_num} (expected column '{key_column}'). Row: {row}")
                    continue
                if value is None:
                    errors.append(f"Missing value in row {row_num} for key '{key}' (expected column '{value_column}'). Row: {row}")
                    value = "" # Assign empty string if value is missing but key exists
                translations[key] = value
                line_numbers[key] = row_num
        else: # No header
            reader = csv.reader(lines, delimiter=delimiter)
            for row_num, row in enumerate(reader, start=1):
                if len(row) < 2:
                    err_msg = f"Row {row_num} has insufficient columns (expected at least 2, got {len(row)}). Row: {row}"
                    errors.append(err_msg)
                    # Decide if this is critical or recoverable. For now, skip row.
                    logging.warning(err_msg)
                    continue
                key = row[0]
                translations[key] = row[1]
                line_numbers[key] = row_num
        
        if not translations and not errors: # No translations but also no parsing errors yet
            errors.append("No translations found in CSV file, or all rows had errors.")
            return ParsingResult(translations={}, line_numbers=line_numbers, errors=errors)
        
        return ParsingResult(translations=translations, line_numbers=line_numbers, errors=errors)
        
    except csv.Error as e:
        logging.error(f"Critical CSV parsing error: {str(e)}")
        # This is a critical error affecting the whole file parsing.
        raise CSVParsingError(f"CSV parsing error: {str(e)}")
    except Exception as e:
        logging.error(f"Unexpected error during CSV parsing: {str(e)}")
        # This could be an UnknownFormatError or a more specific CSVParsingError
        raise CSVParsingError(f"Unexpected error processing CSV data: {str(e)}")

def read_xml_lang_content(content: str, trim_whitespace: bool = False) -> ParsingResult:
    """
    Parse XML-like content (specifically <string name="key">value</string>)
    and extract string elements with their line numbers.
    Returns a ParsingResult.
    """
    translations: Dict[str, str] = {}
    line_numbers: Dict[str, int] = {}
    errors: List[str] = []

    try:
        # Process content line by line to track line numbers
        lines = content.splitlines()
        current_key: Optional[str] = None
        current_line_num: int = 0
        
        for i, line_text in enumerate(lines, 1):
            stripped_line = line_text.strip()
            if not stripped_line or stripped_line.startswith('<!--') or stripped_line.startswith('//'):
                continue
                
            # Look for string element start: <string name="key">
            key_match = re.search(r'<string\s+name="([^"]+)">', stripped_line)
            if key_match:
                current_key = key_match.group(1)
                current_line_num = i
                # If the value is on the same line and ends with </string>
                # e.g. <string name="key">value</string>
                value_match_same_line = re.search(r'>([^<]+)</string>', stripped_line)
                if value_match_same_line:
                    translations[current_key] = value_match_same_line.group(1).strip() if trim_whitespace else value_match_same_line.group(1)
                    line_numbers[current_key] = current_line_num
                    current_key = None # Reset current key as it's processed
            
            # Handle multi-line values or values on a new line
            # e.g. <string name="key">
            #          value
            #      </string>
            elif current_key and '</string>' in stripped_line:
                # Extract content before </string>
                value_match_end = re.search(r'([^<]+)</string>', stripped_line)
                if value_match_end:
                    # This logic might need refinement for multi-line values if they don't start on the key line.
                    # Assuming the value starts after ">" on the key_match line or on subsequent lines.
                    # For simplicity, this part assumes the value ends on this line.
                    # A more robust multi-line handling would buffer lines until </string>
                    translations[current_key] = value_match_end.group(1).strip() if trim_whitespace else value_match_end.group(1)
                    line_numbers[current_key] = current_line_num # Line where key was defined
                else: # Tag structure is like <string name="key"></string> (empty value)
                    translations[current_key] = ""
                    line_numbers[current_key] = current_line_num
                current_key = None # Reset current key

        # Fallback to broader regex parsing if the line-by-line logic yields no results
        # This regex is less precise about line numbers.
        if not translations and "<string" in content:
            logging.debug("Using fallback regex for read_xml_lang_content as line-by-line parsing found nothing.")
            for match in re.finditer(_xml_string_pattern, content): # Using precompiled pattern
                key = match.group(1)
                # Correctly handle CDATA sections if present, and general XML character entities
                value_text = match.group(2) # html.unescape might be needed if entities are used
                translations[key] = value_text.strip() if trim_whitespace else value_text
                # Approximate line number by counting newlines before match start
                line_number = content[:match.start()].count('\n') + 1
                line_numbers[key] = line_number
                if key in translations: # Add to line_numbers if key was added
                    line_numbers[key] = line_number

    except Exception as e:
        error_message = f"Error parsing XML-like content: {str(e)}"
        logging.error(error_message)
        errors.append(error_message)
        # Depending on severity, could raise XMLParsingError(error_message)
        
    return ParsingResult(translations=translations, line_numbers=line_numbers, errors=errors)

def parse_xliff(content: str) -> ParsingResult:
    """
    Parse XLIFF (XML-based) to extract translation units.
    Returns a ParsingResult.
    """
    translations: Dict[str, str] = {}
    errors: List[str] = []
    try:
        root = ET.fromstring(content)
        # Typical XLIFF structure uses <trans-unit id="..."><target>...</target>
        for unit in root.findall('.//trans-unit'): # Consider namespace awareness if needed
            key = unit.get('id')
            if key:
                target_elem = unit.find('target') # Consider namespace for target
                translations[key] = target_elem.text.strip() if target_elem is not None and target_elem.text else ''
            else:
                errors.append(f"XLIFF unit found without id: {ET.tostring(unit, encoding='unicode')[:100]}")
    except ET.ParseError as e:
        error_msg = f"XLIFF parse error: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
        # raise XliffParsingError(error_msg) # Optionally raise critical error
    except Exception as e:
        error_msg = f"Unexpected error parsing XLIFF: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
    return ParsingResult(translations=translations, errors=errors)

def parse_properties_file(content: str) -> ParsingResult:
    """
    Parse Java .properties format (key=value pairs).
    Returns a ParsingResult. Line numbers are not currently tracked.
    """
    translations: Dict[str, str] = {}
    errors: List[str] = []
    try:
        for line_num, line_text in enumerate(content.splitlines(), start=1):
            stripped_line = line_text.strip()
            if not stripped_line or stripped_line.startswith('#') or stripped_line.startswith('!'):
                continue
            if '=' in stripped_line:
                key, value = stripped_line.split('=', 1)
                translations[key.strip()] = value.strip() # Backslash escapes are not handled here yet
            else:
                # Line is not a comment and does not contain '=', could be an error or continuation
                errors.append(f"Line {line_num} is not a valid key-value pair or comment: '{stripped_line}'")
    except Exception as e:
        error_msg = f"Error parsing .properties file: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
        # raise PropertiesParsingError(error_msg) # Optionally raise critical error
    return ParsingResult(translations=translations, errors=errors)

def parse_resx(content: str) -> ParsingResult:
    """
    Parse .resx file (XML for .NET resources).
    Returns a ParsingResult based on <data name="..."><value>...</value>.
    """
    translations: Dict[str, str] = {}
    errors: List[str] = []
    try:
        root = ET.fromstring(content)
        for data_elem in root.findall('.//data'):
            key = data_elem.get('name')
            if key:
                value_elem = data_elem.find('value')
                translations[key] = value_elem.text.strip() if value_elem is not None and value_elem.text else ''
            else:
                errors.append(f"RESX data element found without name: {ET.tostring(data_elem, encoding='unicode')[:100]}")
    except ET.ParseError as e:
        error_msg = f"RESX parse error: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
        # raise ResxParsingError(error_msg) # Optionally raise critical error
    except Exception as e:
        error_msg = f"Unexpected error parsing RESX: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
    return ParsingResult(translations=translations, errors=errors)

def parse_android_xml(content: str) -> ParsingResult:
    """
    Parse Android XML format (<string name="...">...</string>).
    Returns a ParsingResult. Line numbers are not robustly tracked here, use read_xml_lang_content for that.
    """
    translations: Dict[str, str] = {}
    errors: List[str] = []
    try:
        root = ET.fromstring(content)
        for string_elem in root.findall('.//string'): # This finds all <string> elements anywhere
            key = string_elem.get('name')
            if key:
                translations[key] = string_elem.text.strip() if string_elem.text else ''
            else:
                errors.append(f"Android XML <string> element found without 'name' attribute: {ET.tostring(string_elem, encoding='unicode')[:100]}")
    except ET.ParseError as e:
        error_msg = f"Android XML parse error: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
        # raise XMLParsingError(error_msg) # Optionally raise critical error
    except Exception as e:
        error_msg = f"Unexpected error parsing Android XML: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
    return ParsingResult(translations=translations, errors=errors)

def parse_angular_translate_json(content: str) -> ParsingResult:
    """
    Parse Angular Translate JSON or similar JSON-based i18n.
    Returns a ParsingResult. Supports flattening nested structures.
    """
    translations: Dict[str, str] = {}
    errors: List[str] = []
    try:
        data = json.loads(content)
        if not isinstance(data, dict):
            errors.append("Angular JSON content is not a dictionary.")
            # raise JSONParsingError("Angular JSON content is not a dictionary.")
            return ParsingResult(translations={}, errors=errors)

        # Usually a nested structure, flatten if needed
        def flatten(d: Dict, prefix: str = ''):
            for k, v in d.items():
                full_key = f"{prefix}.{k}" if prefix else k
                if isinstance(v, dict):
                    flatten(v, full_key)
                elif isinstance(v, str):
                    translations[full_key] = v
                else:
                    errors.append(f"Value for key '{full_key}' is not a string: {v}")

        flatten(data)
    except json.JSONDecodeError as e:
        error_msg = f"Angular JSON parse error: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
        # raise JSONParsingError(error_msg) # Optionally raise critical error
    except Exception as e:
        error_msg = f"Unexpected error parsing Angular JSON: {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
    return ParsingResult(translations=translations, errors=errors)

def parse_content_by_ext(content: str, ext: str, trim_whitespace: bool = False) -> ParsingResult:
    """
    Parses content based on file extension using a registry and fallbacks.
    Args:
        content: The string content to parse.
        ext: The file extension (e.g., '.json', '.xml').
        trim_whitespace: Flag to indicate if leading/trailing whitespace should be trimmed
                         from keys and values by parsers that support it.
    Returns:
        A ParsingResult object.
    """
    normalized_ext = ext.lower()
    logging.info(f"Attempting to parse content with extension: {normalized_ext}")
    logging.debug(f"Content starts with: {content[:100]}")

    # It's good practice to lstrip content once initially.
    # Specific parsers might do further stripping if necessary.
    # content = content.lstrip() # Already done in the original, let's ensure it stays.
                               # Decided to let parsers handle stripping as they see fit or via trim_whitespace.

    parser_func = PARSER_REGISTRY.get(normalized_ext)

    if parser_func:
        logging.info(f"Parser found for extension '{normalized_ext}': {parser_func.__name__}")
        try:
            # Pass trim_whitespace to parsers that might use it.
            # Inspecting signature or using a wrapper class for parsers could make this more robust.
            # For now, assume parsers will ignore it if they don't use it.
            # Specific parsers like read_lang_file and read_xml_lang_content accept it.
            # Others like JSON/YAML parsers don't typically use it.
            # The classes JSONParser, YAMLParser, LangParser don't take it in parse()
            # but their underlying functions might (e.g. LangParser -> read_lang_file)
            
            # A more refined way to pass trim_whitespace:
            if parser_func in [read_lang_file, read_xml_lang_content, _lang_parser.parse]: # _lang_parser.parse calls read_lang_file
                 # For LangParser, trim_whitespace is handled by read_lang_file it calls
                if parser_func == _lang_parser.parse:
                    # The LangParser class itself doesn't take trim_whitespace in parse method.
                    # read_lang_file (which it calls) does. This is a bit of a workaround.
                    # Ideally, LangParser.parse would take it.
                    # For now, we know read_lang_file is called by it.
                    # This highlights a need for consistent parameter handling in parser interface.
                    # Let's assume read_lang_file's default for trim_whitespace is used unless we adjust LangParser.parse
                    # For now, let's adjust LangParser.parse to accept it.
            # This change will be done in a separate step if needed. # This is being done now.
                    # For this refactoring, let's assume the existing signatures.
                    # If parser is _lang_parser.parse, it calls read_lang_file which has trim_whitespace=False default.
                    # To make trim_whitespace effective for LangParser, its parse method needs to accept and pass it.
            # This is a limitation of current LangParser.parse signature. # Addressed.
                    # For now, we call it without trim_whitespace
                    # result = parser_func(content)
                    # Let's assume for now that if trim_whitespace is True, and the parser is read_lang_file directly
                    # or read_xml_lang_content, we pass it.
                    # This is still not ideal.
                    pass # See block below for actual call

            # Simpler approach: try passing it if the name matches known functions or methods.
            if parser_func is read_csv_file: # read_csv_file doesn't take trim_whitespace
                result = parser_func(content)
            elif parser_func in [read_xml_lang_content, read_lang_file] or \
                 (hasattr(parser_func, '__self__') and isinstance(parser_func.__self__, LangParser)):
                 # For LangParser().parse, it now accepts trim_whitespace
                 result = parser_func(content, trim_whitespace=trim_whitespace)
            else: # For other parsers like JSON, YAML, XLIFF, RESX, PROPERTIES, ANDROID_XML etc.
                  # which do not have trim_whitespace in their signature.
                result = parser_func(content)

            logging.info(f"Parsing with {parser_func.__name__} for ext '{normalized_ext}' completed.")
            if result.errors:
                logging.warning(f"Parser {parser_func.__name__} found {len(result.errors)} errors/warnings.")
            return result
        except Exception as e:
            logging.error(f"Error during parsing with {parser_func.__name__} for ext '{normalized_ext}': {str(e)}", exc_info=True)
            return ParsingResult(translations={}, errors=[f"Parser {parser_func.__name__} failed: {str(e)}"])

    logging.info(f"No direct parser found for extension '{normalized_ext}'. Attempting content sniffing.")

    # Fallback logic (Content Sniffing)
    # Order matters here. XML check is usually safe.
    content_lstripped = content.lstrip() # Use lstripped content for sniffing
    if content_lstripped.startswith(('<?xml', '<resources', '<string', '<xliff', '<data')): # Added more XML root tags
        logging.info("Content appears to be XML-based. Trying read_xml_lang_content (generic string extractor).")
        # This is for generic <string name="key">value</string> type XMLs.
        # Specific XML types like .resx, .xliff should be caught by extension first.
        try:
            result = read_xml_lang_content(content, trim_whitespace=trim_whitespace)
            if result.translations:
                logging.info("Successfully parsed as generic XML (read_xml_lang_content).")
                return result
            else:
                logging.warning("Tried read_xml_lang_content, but no translations found or errors occurred.")
                if result.errors:
                     logging.warning(f"Errors from read_xml_lang_content: {result.errors}")
        except Exception as e:
            logging.error(f"Error during XML content sniffing with read_xml_lang_content: {str(e)}", exc_info=True)
            # Continue to other fallbacks if any

    # Fallback for CSV (example: if it's a .txt file that's actually CSV)
    # This is a simple heuristic. Could be improved (e.g., check for multiple lines, delimiter presence).
    # For now, only if extension was .csv and it failed, or if it's a .txt file.
    if normalized_ext == '.csv' or normalized_ext == '.txt': # Only try CSV for .txt or if .csv parser failed
        # Check if content looks like CSV (e.g. contains delimiter, multiple lines)
        # This is a very basic check.
        if ',' in content or '\t' in content: # Common delimiters
            logging.info("Content might be CSV. Trying read_csv_file as a fallback.")
            try:
                # Assuming default CSV parameters for fallback
                result = read_csv_file(content)
                if result.translations:
                    logging.info("Successfully parsed as CSV using fallback.")
                    return result
                else:
                    logging.warning("Tried read_csv_file as fallback, but no translations found or errors occurred.")
            except Exception as e:
                 logging.error(f"Error during CSV content sniffing with read_csv_file: {str(e)}", exc_info=True)
                 # Continue

    # Fallback to plain text .lang style parser (key=value)
    logging.info("Attempting fallback to plain text (.lang style) parser.")
    try:
        result = read_lang_file(content, trim_whitespace=trim_whitespace)
        if result.translations or result.errors: # Return even if only errors, to show attempt
            logging.info("Parsed with plain text (.lang style) fallback.")
            return result
    except Exception as e:
        logging.error(f"Error during plain text fallback parsing: {str(e)}", exc_info=True)
        return ParsingResult(translations={}, errors=[f"Fallback plain text parser failed: {str(e)}"])

    logging.warning(f"Unsupported file extension or format: {ext}")
    return ParsingResult(translations={}, errors=[f"Unsupported file extension or format: {ext}"])


def read_lang_file(content: str, trim_whitespace: bool = False) -> ParsingResult:
    """
    Reads a plain text .lang file (key=value format) and returns a ParsingResult
    with translations and line numbers.
    """
    translations: Dict[str, str] = {}
    line_numbers: Dict[str, int] = {}
    errors: List[str] = []
    
    try:
        for line_num, line_text in enumerate(content.splitlines(), start=1):
            stripped_line = line_text.strip()
            # Skip blank lines, XML tags and comment lines
            if not stripped_line or stripped_line.startswith("<?xml") or \
               stripped_line.startswith("<!--") or stripped_line.startswith("#"):
                continue
                
            # Handle basic key=value format
            if "=" in stripped_line:
                try:
                    key, value = stripped_line.split("=", 1)
                    if trim_whitespace:
                        key = key.strip()
                        value = value.strip()

                    if not key: # Skip if key is empty after stripping
                        errors.append(f"Warning: Empty key found at line {line_num}: '{line_text}'")
                        continue

                    translations[key] = value
                    line_numbers[key] = line_num  # Store line number for this key
                except ValueError: # Not a valid key=value pair after splitting
                    msg = f"Invalid key-value pair format at line {line_num}: '{stripped_line}'"
                    logging.warning(msg)
                    errors.append(msg)
                    continue
            # Optionally, treat lines without '=' as errors or skip them
            # else:
            #     errors.append(f"Line {line_num} does not contain '=': '{stripped_line}'")

    except Exception as e:
        # This is a more general error during processing, less specific than LangParsingError
        # which would typically be raised by the caller if this function's result is unusable.
        error_message = f"Error processing .lang file content: {str(e)}"
        logging.error(error_message)
        errors.append(error_message)
        # Consider raising LangParsingError(error_message) if this error is critical for the whole file
        
    if not translations and not errors:
        errors.append("No translations found in .lang file, or file was empty/all comments.")

    return ParsingResult(translations=translations, line_numbers=line_numbers, errors=errors)

def read_xml_lang_file(filepath: str, trim_whitespace: bool = False) -> ParsingResult:
    """
    Reads an XML .lang file, preprocesses it, and returns a ParsingResult.
    Handles file errors and XML parsing errors.
    """
    translations: Dict[str, str] = {}
    errors: List[str] = []
    # Line numbers are not robustly tracked by this specific XML parser.
    # For more detailed XML parsing with line numbers, read_xml_lang_content should be used after reading content.

    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()

        # --- Pre-processing for common XML issues ---
        # Replace '&' that is not part of a valid entity to avoid parsing errors.
        # This is a common issue in manually edited XML files.
        content = re.sub(r'&(?!amp;|lt;|gt;|quot;|apos;)', '&amp;', content)

        root = ET.fromstring(content)
        for string_elem in root.findall('string'): # Assumes <string name="key">value</string> structure
            key = string_elem.get('name')
            value_text = string_elem.text if string_elem.text is not None else ""

            if key is not None:
                if trim_whitespace:
                    key = key.strip()
                    value_text = value_text.strip()
                translations[key] = value_text
            else:
                errors.append(f"XML <string> element found without 'name' attribute in file '{filepath}': {ET.tostring(string_elem, encoding='unicode')[:100]}")

    except FileNotFoundError:
        error_msg = f"File not found: {filepath}"
        logging.error(error_msg)
        errors.append(error_msg)
        # Optionally: raise FileParsingError(error_msg)
    except ET.ParseError as e:
        error_msg = f"Error parsing XML in '{filepath}': {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
        # Optionally: raise XMLParsingError(error_msg)
    except Exception as e:
        error_msg = f"An unexpected error occurred while reading or parsing XML file '{filepath}': {str(e)}"
        logging.error(error_msg)
        errors.append(error_msg)
        # Optionally: raise FileParsingError(error_msg)

    return ParsingResult(translations=translations, errors=errors, line_numbers={}) # No line numbers from this func

# Custom Exceptions for Git operations
class GitFileError(ParsingError):
    """Base error for issues related to fetching files from Git."""
    pass

class GitRepoError(GitFileError):
    """Error for issues with the Git repository itself (e.g., not a repo)."""
    pass

class GitFileNotFoundError(GitFileError, FileNotFoundError): # Inherits from FileNotFoundError for compatibility
    """Error when a file is not found in the Git repository at a specific commit or working tree."""
    pass

def get_file_content(repo_path: str, file_path: str, commit_id: str) -> str:
    """Fetches the content of a file from a Git repository.

    Retrieves file content from a specific commit, branch, tag, or the working tree.

    Args:
        repo_path: Path to the Git repository.
        file_path: Relative path to the file within the repository.
        commit_id: Commit ID, branch, tag, or "working" for the working tree version.

    Returns:
        The decoded content of the file as a string.

    Raises:
        GitRepoError: If `repo_path` is not a valid Git repository or another
                      repository-level issue occurs.
        GitFileNotFoundError: If `file_path` is not found at the specified
                              `commit_id` or in the working tree.
        ValueError: If `commit_id` is invalid (e.g., unknown commit reference).
        GitFileError: For other unspecified Git-related errors.
    """
    try:
        repo = git.Repo(repo_path, search_parent_directories=True)

        if commit_id.lower() == "working":
            full_file_path = os.path.join(repo.working_tree_dir, file_path)
            if not os.path.exists(full_file_path): # Check existence before opening
                err_msg = f"File not found in working tree: {full_file_path}"
                logging.error(err_msg)
                raise GitFileNotFoundError(err_msg)
            try:
                with open(full_file_path, "r", encoding="utf-8") as f:
                    content = f.read()
            except Exception as e: # Catch potential OS errors during open/read
                err_msg = f"Error reading file from working tree '{full_file_path}': {e}"
                logging.error(err_msg)
                raise GitFileError(err_msg) from e
        else:
            try:
                commit_obj = repo.commit(commit_id)
            except (git.BadName, ValueError) as e:
                err_msg = f"Invalid commit ID or reference '{commit_id}' in repo '{repo_path}': {e}"
                logging.error(err_msg)
                raise ValueError(err_msg) from e # Re-raise as ValueError for bad commit_id

            try:
                blob = commit_obj.tree / file_path
                content = blob.data_stream.read().decode("utf-8")
            except (KeyError, git.exc.NoSuchPathError) as e: # KeyError for old GitPython, NoSuchPathError for newer
                err_msg = f"File '{file_path}' not found in commit '{commit_id}' of repo '{repo_path}': {e}"
                logging.error(err_msg)
                raise GitFileNotFoundError(err_msg) from e

        return content

    except git.InvalidGitRepositoryError as e:
        err_msg = f"Not a valid Git repository: {repo_path}. Error: {e}"
        logging.error(err_msg)
        raise GitRepoError(err_msg) from e
    # It seems NoSuchPathError from git.Repo() call itself is less common with search_parent_directories=True
    # but if repo_path is totally wrong, it might occur.
    except git.NoSuchPathError as e:
        err_msg = f"Path for Git repository does not exist or is not accessible: {repo_path}. Error: {e}"
        logging.error(err_msg)
        raise GitRepoError(err_msg) from e
    except GitFileNotFoundError: # To re-raise our specific exception if caught from working tree logic
        raise
    except ValueError: # To re-raise ValueError if caught from commit_id check
        raise
    except Exception as e:
        err_msg = f"An unexpected error occurred fetching file '{file_path}' (commit: {commit_id}) from Git repo '{repo_path}': {e}"
        logging.error(err_msg, exc_info=True)
        raise GitFileError(err_msg) from e

def machine_translate(text: str, source_lang: str, target_lang: str, api_key: str) -> Optional[str]:
    """Translates text using the Google Cloud Translate API (v2).

    Args:
        text: The text to translate.
        source_lang: The source language code (e.g., "en").
        target_lang: The target language code (e.g., "es").
        api_key: The Google Cloud API key for authentication.
                 If empty or None, translation is skipped.

    Returns:
        The translated text as a string if successful, None otherwise.
        Errors during the API call are logged.
    """
    if not api_key:
        logging.warning("Machine translation called without API key.")
        return None
        
    url = "https://translation.googleapis.com/language/translate/v2"
    # Parameters for the Google Translate API v2.
    # 'q' is the text to translate, 'source' and 'target' are languages,
    # 'key' is the API key, 'format': 'text' ensures plain text handling.
    payload = {
        'q': text,
        'source': source_lang,
        'target': target_lang,
        'key': api_key,
        'format': 'text'  # Request plain text to avoid HTML entities in source if not intended
    }
        
    try:
        # Using POST with data payload as is common for APIs handling text.
        response = requests.post(url, data=payload)
        response.raise_for_status()  # Raises HTTPError for bad responses (4XX or 5XX)
        
        result = response.json()

        # Defensive checks for the expected response structure
        if (isinstance(result, dict) and
            'data' in result and isinstance(result['data'], dict) and
            'translations' in result['data'] and
            isinstance(result['data']['translations'], list) and
            len(result['data']['translations']) > 0 and
            isinstance(result['data']['translations'][0], dict) and
            'translatedText' in result['data']['translations'][0]):

            translated_text = result['data']['translations'][0]['translatedText']
            # Google Translate API might return HTML entities for certain characters.
            # html.unescape is used to decode them back to standard characters.
            return html.unescape(translated_text)
        else:
            logging.error(f"Unexpected API response format from Google Translate: {result}")
            return None
            
    except requests.exceptions.HTTPError as e:
        logging.error(f"Translation API HTTP error: {e.response.status_code} - {e.response.text}", exc_info=True)
    except requests.exceptions.Timeout as e:
        logging.error(f"Translation API request timed out: {str(e)}", exc_info=True)
    except requests.exceptions.RequestException as e: # Catch other request-related errors
        logging.error(f"Translation API request error: {str(e)}", exc_info=True)
    except json.JSONDecodeError as e:
        logging.error(f"Failed to decode JSON response from Translation API: {str(e)}. Response text: {response.text if 'response' in locals() else 'N/A'}", exc_info=True)
    except (KeyError, IndexError, TypeError) as e: # Handles issues with parsing the expected JSON structure
        logging.error(f"Error parsing Translation API response data structure: {str(e)}", exc_info=True)
    except Exception as e: # Catch any other unexpected error
        logging.error(f"Unexpected error during machine translation: {str(e)}", exc_info=True)
        
    return None

@dataclass
class ComparisonConfig:
    """Configuration settings for comparing translation dictionaries."""
    ignore_case: bool = False
    ignore_whitespace: bool = False
    is_gui: bool = False  # Primarily for CLI coloring, consider separate handling if only for UI
    compare_values: bool = False # If True, compare values of common keys
    ignore_patterns: Optional[List[str]] = field(default_factory=list)
    log_missing_keys: bool = False
    target_locale: str = "target"
    auto_fill_missing: bool = False
    mt_settings: Optional[Dict[str, Any]] = None # For potential machine translation integration
    include_summary: bool = True

    def __post_init__(self):
        if self.ignore_patterns is None:
            self.ignore_patterns = []


def compare_translations(old_translations: Dict[str, str],
                       new_translations: Dict[str, str],
                       config: ComparisonConfig) -> str:
    """
    Compares two translation dictionaries based on the provided configuration.

    Args:
        old_translations: The source/reference dictionary of translations.
        new_translations: The target/new dictionary of translations to compare.
        config: A ComparisonConfig object containing all comparison settings.

    Returns:
        A string summarizing the differences found (missing keys, obsolete keys,
        placeholder mismatches, and optionally modified values).
    """
    
    # Filter ignored patterns and normalize keys
    def normalize_key(k: str) -> str:
        k = k.strip()  # Always strip whitespace from keys
        return k.lower() if config.ignore_case else k

    # Normalize values (helper for value comparison)
    def normalize_value(v: str) -> str:
        if config.ignore_whitespace:
            v = "".join(v.split()) # Remove all whitespace
        if config.ignore_case:
            v = v.lower()
        return v

    source_normalized_map: Dict[str, str] = {normalize_key(k): k for k, v in old_translations.items()
                                           if not any(k.startswith(p) for p in config.ignore_patterns)}
    target_normalized_map: Dict[str, str] = {normalize_key(k): k for k, v in new_translations.items()
                                           if not any(k.startswith(p) for p in config.ignore_patterns)}

    source_keys = set(source_normalized_map.keys())
    target_keys = set(target_normalized_map.keys())
    
    # Debug logging
    logging.debug(f"Source file has {len(source_keys)} effective keys after normalization/filtering.")
    logging.debug(f"Target file has {len(target_keys)} effective keys after normalization/filtering.")
    logging.debug(f"First few normalized source keys: {sorted(list(source_keys))[:5]}")
    logging.debug(f"First few normalized target keys: {sorted(list(target_keys))[:5]}")

    missing_in_target_normalized = source_keys - target_keys
    obsolete_in_target_normalized = target_keys - source_keys
    common_normalized_keys = source_keys & target_keys

    invalid_placeholders: List[tuple[str, str]] = []
    modified_values: List[tuple[str, str, str]] = [] # Stores (original_key, old_value, new_value)

    for norm_key in common_normalized_keys:
        original_source_key = source_normalized_map[norm_key]
        original_target_key = target_normalized_map[norm_key] # Should be effectively same as source if keys match

        source_text = old_translations[original_source_key]
        target_text = new_translations[original_target_key]

        # 1. Check Placeholders
        is_valid_placeholder, placeholder_error_msg = validate_placeholders(source_text, target_text)
        if not is_valid_placeholder:
            invalid_placeholders.append((original_target_key, placeholder_error_msg))
            if config.log_missing_keys: # log_missing_keys can double for logging placeholder issues
                logging.warning(f"Placeholder mismatch in key '{original_target_key}': {placeholder_error_msg}")

        # 2. Compare Values if requested
        if config.compare_values:
            norm_source_value = normalize_value(source_text)
            norm_target_value = normalize_value(target_text)
            if norm_source_value != norm_target_value:
                modified_values.append((original_target_key, source_text, target_text))
                if config.log_missing_keys: # Using this flag for general diff logging
                     logging.warning(f"Value mismatch for key '{original_target_key}': SRC='{source_text}', TGT='{target_text}'")


    # Auto-fill missing translations in the new_translations dict if enabled
    # This operates on the actual new_translations dict, using original keys
    if config.auto_fill_missing:
        for norm_key in missing_in_target_normalized:
            original_source_key = source_normalized_map[norm_key]
            # Add with original (non-normalized) key from source
            new_translations[original_source_key] = ""
            if config.log_missing_keys:
                logging.info(f"Auto-filled missing key: {original_source_key}")

    missing_count = len(missing_in_target_normalized)
    obsolete_count = len(obsolete_in_target_normalized)
    placeholder_count = len(invalid_placeholders)
    modified_count = len(modified_values)
    output_lines = []

    # Calculate max key length for proper alignment using original keys
    # Consider all relevant original keys for max_key_length calculation
    all_original_keys_for_report = set()
    for norm_key in missing_in_target_normalized: all_original_keys_for_report.add(source_normalized_map[norm_key])
    for norm_key in obsolete_in_target_normalized: all_original_keys_for_report.add(target_normalized_map[norm_key])
    for key, _ in invalid_placeholders: all_original_keys_for_report.add(key)
    for key, _, _ in modified_values: all_original_keys_for_report.add(key)

    max_key_length = max((len(k) for k in all_original_keys_for_report), default=0) if all_original_keys_for_report else 0


    # Report placeholder mismatches
    for key, error_msg in sorted(invalid_placeholders):
        line = f"~ {key.ljust(max_key_length)} : {new_translations[key]} ({error_msg})"
        if not config.is_gui: # Use is_gui from config
            line = Fore.YELLOW + line + Style.RESET_ALL
        output_lines.append(line)

    # Report modified values
    if config.compare_values:
        for key, old_val, new_val in sorted(modified_values):
            # Shorten values for display if they are too long
            display_old_val = old_val[:30] + '...' if len(old_val) > 30 else old_val
            display_new_val = new_val[:30] + '...' if len(new_val) > 30 else new_val
            line = f"! {key.ljust(max_key_length)} : OLD='{display_old_val}' NEW='{display_new_val}' (Modified)"
            if not config.is_gui:
                line = Fore.CYAN + line + Style.RESET_ALL # Example color
            output_lines.append(line)

    # Report missing keys (present in old, not in new)
    for norm_key in sorted(list(missing_in_target_normalized)):
        original_source_key = source_normalized_map[norm_key]
        if config.log_missing_keys:
            logging.warning(f"Missing translation key '{original_source_key}' for locale '{config.target_locale}'")
        line = f"+ {original_source_key.ljust(max_key_length)} : {old_translations[original_source_key]} (Missing in {config.target_locale})"
        if not config.is_gui:
            line = Fore.GREEN + line + Style.RESET_ALL
        output_lines.append(line)

    # Report obsolete keys (present in new, not in old)
    for norm_key in sorted(list(obsolete_in_target_normalized)):
        original_target_key = target_normalized_map[norm_key]
        line = f"- {original_target_key.ljust(max_key_length)} : {new_translations[original_target_key]} (Obsolete in {config.target_locale})"
        if not config.is_gui:
            line = Fore.RED + line + Style.RESET_ALL
        output_lines.append(line)

    if config.include_summary:
        if output_lines: # Add a separator if there were details
            output_lines.append("")
        output_lines.append("--- Summary ---")
        output_lines.append(f"Missing in {config.target_locale}: {missing_count}")
        output_lines.append(f"Obsolete in {config.target_locale}: {obsolete_count}")
        output_lines.append(f"Placeholder mismatches: {placeholder_count}")
        if config.compare_values:
            output_lines.append(f"Modified values: {modified_count}")

    return "\n".join(output_lines)

from typing import Any, Callable, Dict, List, Optional # Correctly sorted

def translate_missing_keys(
    source_dict: Dict[str, str],
    target_dict: Dict[str, str],
    source_lang: str,
    target_lang: str,
    api_key: str,
    progress_callback: Optional[Callable[[float], None]] = None
) -> tuple[Dict[str, str], List[str]]:
    """Translates keys missing in `target_dict` from `source_dict`.

    Iterates through `source_dict`. If a key is not found in `target_dict` or
    if the value in `target_dict` for that key is empty, it attempts to
    translate the corresponding text using `machine_translate`.

    Args:
        source_dict: The dictionary with source language strings.
        target_dict: The dictionary with target language strings.
                     A copy of this dictionary is made and updated.
        source_lang: Source language code (e.g., "en").
        target_lang: Target language code (e.g., "es").
        api_key: API key for the translation service. If None or empty,
                 no translation is attempted, and an error message is included
                 in the returned list of errors.
        progress_callback: An optional callable that takes a float (0.0 to 1.0)
                           representing the translation progress. Exceptions
                           from the callback are caught and logged.

    Returns:
        A tuple containing:
        - updated_dict (Dict[str, str]): A copy of `target_dict` with new
                                         translations added.
        - errors (List[str]): A list of error messages for keys that failed
                              to translate or other operational issues.
    """
    if not api_key:
        logging.warning("translate_missing_keys called without API key. No translations will be performed.")
        return target_dict.copy(), ["No API key provided for machine translation."]

    updated_dict = target_dict.copy()
    errors: List[str] = []

    if not source_dict:
        logging.info("Source dictionary for translate_missing_keys is empty. No keys to translate.")
        return updated_dict, errors

    total_keys = len(source_dict)
    processed_count = 0
    logging.info(f"Starting translation of missing/empty keys from '{source_lang}' to '{target_lang}'. Total source keys: {total_keys}")

    for key, text in source_dict.items():
        if not text: # Do not attempt to translate empty source text
            logging.debug(f"Skipping translation for key '{key}' as source text is empty.")
            processed_count += 1 # Still count as processed for progress
            if progress_callback and total_keys > 0:
                try:
                    progress_callback(processed_count / total_keys)
                except Exception as e:
                    logging.warning(f"Progress callback failed for key '{key}' (empty text): {e}", exc_info=True)
            continue

        if key not in updated_dict or not updated_dict[key]:
            try:
                logging.debug(f"Translating missing/empty key: '{key}' from '{source_lang}' to '{target_lang}'. Text: '{text[:30]}...'")
                translated_text = machine_translate(text, source_lang, target_lang, api_key)

                if translated_text is not None:
                    updated_dict[key] = translated_text
                    logging.debug(f"Successfully translated key '{key}'.")
                else:
                    error_msg = f"Failed to translate key '{key}' (text: '{text[:30]}...')"
                    logging.warning(error_msg)
                    errors.append(error_msg)
            except Exception as e:
                logging.error(f"Error during translation of key '{key}': {e}", exc_info=True)
                errors.append(f"Error translating key '{key}': {str(e)}")

        processed_count += 1
        if progress_callback:
            try:
                # Ensure division by zero is avoided if total_keys is 0 (though checked by not source_dict)
                progress_value = processed_count / total_keys if total_keys > 0 else 0
                progress_callback(progress_value)
            except Exception as e: # Catch errors from the callback itself
                logging.warning(f"Progress callback failed for key '{key}': {e}", exc_info=True)

    logging.info(f"Finished translating missing keys. Errors: {len(errors)}")
    return updated_dict, errors

# Ensure 'Callable' is imported if not already (it should be via 'Any')
from typing import Callable

def save_translations(
    translations: Dict[str, str],
    filepath: str,
    file_format: str = "auto"
) -> tuple[bool, str]:
    """Saves translations to a file in the specified format.

    Supported formats include "json", "yaml"/"yml", "lang" (key=value), and "xml".
    If `file_format` is "auto", the format is inferred from the filepath extension.
    The XML output is a basic Android-like structure:
    `<resources><string name="key">value</string></resources>`.
    YAML output preserves insertion order if `yaml.dump` supports `sort_keys=False`.

    Args:
        translations: A dictionary of translations {key: value}.
        filepath: The path to the file where translations will be saved.
        file_format: The desired output format (e.g., "json", "yaml", "auto").
                     Defaults to "auto".

    Returns:
        A tuple (success, message):
        - success (bool): True if saving was successful, False otherwise.
        - message (str): An empty string if successful, or an error message
                         if saving failed.
    """
    chosen_format = file_format.lower()
    logging.info(f"Attempting to save translations to '{filepath}' in format '{chosen_format}'.")

    if chosen_format == "auto":
        ext = os.path.splitext(filepath)[1].lower()
        if ext == ".json": chosen_format = "json"
        elif ext in [".yaml", ".yml"]: chosen_format = "yaml"
        elif ext == ".lang": chosen_format = "lang"
        elif ext == ".xml": chosen_format = "xml"
        else:
            msg = f"Unsupported file extension '{ext}' for auto-detection of save format. Cannot save file."
            logging.error(msg)
            return False, msg

    content_to_write: Optional[str] = None

    try:
        if chosen_format == "json":
            content_to_write = json.dumps(translations, indent=4, ensure_ascii=False)
        elif chosen_format == "yaml":
            if yaml is None:
                raise ImportError("PyYAML library is not installed. Cannot save in YAML format.")
            content_to_write = yaml.dump(translations, allow_unicode=True, sort_keys=False)
        elif chosen_format == "lang":
            content_to_write = "\n".join(f"{key}={value}" for key, value in translations.items())
        elif chosen_format == "xml":
            root = ET.Element("resources")
            for key, value in sorted(translations.items()):
                string_elem = ET.SubElement(root, "string", name=key)
                string_elem.text = value
            # ET.indent(root) # For pretty printing in Python 3.9+
            xml_declaration = '<?xml version="1.0" encoding="UTF-8"?>\n'
            content_to_write = xml_declaration + ET.tostring(root, encoding='unicode', method='xml')
        else:
            # This case should ideally be covered by the 'auto' extension check or direct invalid format.
            msg = f"Unsupported format: '{chosen_format}'. Supported formats are json, yaml, lang, xml."
            logging.error(msg)
            return False, msg

        if content_to_write is not None:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content_to_write)
            logging.info(f"Translations successfully saved to '{filepath}' in '{chosen_format}' format.")
            return True, ""
        else:
            # This implies a logic error if a supported format didn't produce content.
            msg = f"Internal error: Content string was not generated for format '{chosen_format}'."
            logging.error(msg)
            return False, msg

    except ImportError as e:
        err_msg = f"Failed to save to '{filepath}' due to missing library: {e}. Please ensure PyYAML is installed for YAML format."
        logging.error(err_msg, exc_info=True)
        return False, err_msg
    except IOError as e:
        err_msg = f"File system error saving to '{filepath}': {e.strerror} (OS error {e.errno}). Check permissions and path."
        logging.error(err_msg, exc_info=True)
        return False, err_msg
    except Exception as e:
        err_msg = f"An unexpected error occurred while saving to '{filepath}' in format '{chosen_format}': {str(e)}"
        logging.error(err_msg, exc_info=True)
        return False, err_msg

def extract_placeholders(text: str) -> List[str]:
    """Extracts all placeholders from a given text string.

    This function uses a list of regular expression patterns to identify
    various common placeholder formats, such as {variable}, %s, %1$d, $variable,
    #variable#, and [[variable]]. The order of patterns can matter if there's
    potential for overlap, though finditer handles non-overlapping matches.

    Args:
        text: The string from which to extract placeholders.

    Returns:
        A list of strings, where each string is a detected placeholder.
        The order of placeholders in the list corresponds to their appearance
        in the input text.
    """
    # Patterns for various placeholder types:
    # 1. {variable_name} or {0} (common in ICU, .NET, Python .format())
    # 2. C-style/Python-style printf formats: %s, %d, %f, %.2f, %10s, %1$.2f, etc.
    #    - %([0-9]+\$)? : Optional positional identifier (e.g., "1$")
    #    - ([0-9]+)?    : Optional width specifier (e.g., "10")
    #    - (\.[0-9]+)?  : Optional precision specifier (e.g., ".2")
    #    - [dfsxXi]: Common type specifiers (string, decimal/int, float, hex). Add more if needed.
    # 3. $variable (common in PHP, shell scripts)
    # 4. #variable# (custom, e.g., some .NET resource comments or other systems)
    # 5. [[variable]] (double square bracket style, e.g., some templating engines)
    patterns = [
        r'\{[^}]+\}',
        r'%([0-9]+\$)?([0-9]+)?(\.[0-9]+)?[dfsxXi]',
        r'\$[a-zA-Z_][a-zA-Z0-9_]*',
        r'#[a-zA-Z_][a-zA-Z0-9_]*#',
        r'\[\[[^\]]+\]\]'
    ]
    
    combined_pattern = re.compile('|'.join(patterns))

    # Using finditer to get all non-overlapping matches in order of appearance
    placeholders = [match.group(0) for match in combined_pattern.finditer(text)]

    return placeholders

def validate_placeholders(source_text: str, target_text: str) -> tuple[bool, str]:
    """Validates that placeholders match between source and target text.

    This function extracts placeholders from both source and target strings
    and checks if they have the same placeholders in the same quantities.
    The order of named placeholders (e.g., {name}) does not strictly matter,
    but the order of positional placeholders (e.g., %1$s, %2$d) implicitly does
    if they are distinct (e.g. "%1$s %2$s" vs "%2$s %1$s" would be different if
    the placeholders themselves are treated as unique strings by the Counter).

    Args:
        source_text: The source string with placeholders.
        target_text: The target string with placeholders to validate against the source.

    Returns:
        A tuple (is_valid, error_message):
        - is_valid (bool): True if placeholders match, False otherwise.
        - error_message (str): An empty string if valid, or a descriptive
                               message of the mismatch if invalid.
    """
    if not source_text and not target_text: # Both empty or None
        return True, ""
    if not source_text: # Source empty, target is not
        target_placeholders_list = extract_placeholders(target_text)
        if not target_placeholders_list: return True, "" # Target also effectively has no placeholders
        return False, f"Source is empty but target has placeholders: {', '.join(target_placeholders_list)}"
    if not target_text: # Target empty, source is not
        source_placeholders_list = extract_placeholders(source_text)
        if not source_placeholders_list: return True, "" # Source also effectively has no placeholders
        return False, f"Target is empty but source has placeholders: {', '.join(source_placeholders_list)}"
        
    source_placeholders = extract_placeholders(source_text)
    target_placeholders = extract_placeholders(target_text)
    
    # If both lists of placeholders are empty, they are valid.
    if not source_placeholders and not target_placeholders:
        return True, ""

    source_counts = Counter(source_placeholders)
    target_counts = Counter(target_placeholders)

    if source_counts == target_counts:
        # This check ensures that placeholders like %1$s and %2$s are treated distinctly
        # and their counts match. If the string was "%s %s" vs "%s", Counter handles it.
        # For strings like "%1$s %2$s" vs "%2$s %1$s", if strict positional order is critical
        # beyond individual placeholder counts, the original list comparison might be preferred.
        # However, Counter is generally more robust for mixed named/positional placeholders.
        # The current problem description implies Counter logic is preferred.
        # Let's also check if the simple list comparison holds for an extra layer if counts are equal.
        # This handles cases like ("%s %d", "%d %s") where counts are same but order differs.
        # This is important for printf-style formats.
        if source_placeholders == target_placeholders:
            return True, ""
        else:
            # If counts are identical but order is different.
            # This can be significant for format strings where argument order matters.
            # Example: Source: "Hello %s, welcome to %s." Placeholders: ['%s', '%s']
            #          Target: "Welcome %s, hello %s." Placeholders: ['%s', '%s']
            # Counts match, but if the meaning of the %s depends on order, it's a problem.
            # However, for many localization scenarios, if the *types* of placeholders match,
            # translators might reorder them.
            # For now, if counts match, we'll assume it's valid as per Counter logic.
            # A stricter check could be added here if needed.
            # The prompt implies Counter logic is the primary goal for this refactor.
            # So, if source_counts == target_counts, we declare it valid.
            return True, "" # Adhering to Counter comparison as primary.

    error_messages = []
    
    # Check for missing placeholders in target
    missing_details = []
    for ph, count in source_counts.items():
        diff = count - target_counts.get(ph, 0)
        if diff > 0:
            missing_details.append(f"'{ph}' (expected {count}, got {target_counts.get(ph, 0)})")
    if missing_details:
        error_messages.append(f"Missing in target: {'; '.join(missing_details)}")

    # Check for extra placeholders in target
    extra_details = []
    for ph, count in target_counts.items():
        diff = count - source_counts.get(ph, 0)
        if diff > 0:
            extra_details.append(f"'{ph}' (present {count} times, expected {source_counts.get(ph, 0)})")
    if extra_details:
        error_messages.append(f"Extra in target: {'; '.join(extra_details)}")
        
    return False, ". ".join(error_messages)

from core.constants import SUPPORTED_FORMATS, USER_MESSAGES
# from parsers.xml_parser import XMLParser  # Updated import path - Commenting out for now if not used in this file