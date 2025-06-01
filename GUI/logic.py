import os
import sys
import logging
from utils.logger_service import logger_service

# Add parent directory to Python path to find modules
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# import csv # No longer needed
import xml.etree.ElementTree as ET # Still needed for save_translations
import git  # If you plan on adding git functionality to this module later
from colorama import init, Fore, Style
# from enum import Enum, auto # No longer needed as FileError is removed
import json # Still needed for json.loads in parse_content_by_ext and save_translations
# import requests # No longer needed, mt_service handles it
# import html # No longer needed, mt_service handles it
from typing import Optional
# import re # No longer needed as extract_placeholders is removed
# from functools import lru_cache # No longer needed
from core.constants import SUPPORTED_FORMATS, USER_MESSAGES
# FileParsingError, CSVParsingError, UnknownFormatError are no longer used in this file.
from core.errors import ParsingError # ParsingError might be used by other functions if they are ever changed to raise it.
try:
    import yaml # Still needed for yaml.safe_load in parse_content_by_ext and save_translations
except ImportError:
    yaml = None

# Removed _xml_string_pattern

# Import ParserService and ParsingResult (from core)
from services.parser_service import ParserService
from core.parsing_result import ParsingResult as CoreParsingResult # Alias to avoid confusion
# Import ComparisonService
from services.comparison_service import ComparisonService
# Import MachineTranslationService
from services.mt_service import MachineTranslationService # Added import
from typing import Dict, Any # For type hinting the return of compare_translations

# Get logger from service instead of basic config
logger = logger_service.get_logger()

init()  # Initialize colorama

VALID_COLORS = [  # Keep for potential future use with command line
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
    "lightblack_ex", "lightred_ex", "lightgreen_ex", "lightyellow_ex",
    "lightblue_ex", "lightmagenta_ex", "lightcyan_ex", "lightwhite_ex"
]

def get_color(color_name):
    """Gets the colorama Fore color object from a color name (case-insensitive)."""
    color_name = color_name.lower()
    if (color_name not in VALID_COLORS):
        return None
    return getattr(Fore, color_name.upper())

# Removed FileError enum
# Removed local ParsingResult class
# Removed FileError enum
# Removed local ParsingResult class
# Removed local TranslationParser base class and its subclasses (LangParser, JSONParser, YAMLParser)

# Removed read_csv_file
# Removed read_xml_lang_content
# Removed parse_xliff
# Removed parse_properties_file
# Removed parse_resx
# Removed parse_android_xml
# Removed parse_angular_translate_json

def parse_content_by_ext(content: str, ext: str, parser_config: Optional[dict] = None) -> CoreParsingResult:
    """
    Parses file content using ParserService.

    Args:
        content: The string content of the file.
        ext: The file extension (e.g., ".json", ".xml").
        parser_config: Optional dictionary of configuration options specific to the parser.
                       (e.g., delimiter for CSV, flatten_nested for Angular JSON).

    Returns:
        A core.parsing_result.ParsingResult object.
    """
    logging.debug(f"GUI/logic.py:parse_content_by_ext called for extension '{ext}'")
    
    # Ensure content is a string, as ParserService expects it.
    if not isinstance(content, str):
        logging.error(f"Content for parsing must be a string, got {type(content)}")
        # Return a ParsingResult object with an error
        return CoreParsingResult(errors=[f"Invalid content type: {type(content)}. Expected string."])

    service_instance = ParserService()

    # The 'trim_whitespace' parameter from the old signature is no longer directly used here.
    # If specific trimming is needed for a parser, it should be part of its configuration
    # passed via 'parser_config' and handled by the parser itself or within ParserService.
    
    try:
        # Call the parser service
        result = service_instance.parse_file_content(content, ext, parser_config)
        return result
    except Exception as e:
        # This is a fallback for unexpected errors during the service call itself.
        # ParserService.parse_file_content is expected to catch its own internal errors
        # and return a ParsingResult with errors populated.
        logging.error(f"Unexpected error calling ParserService from GUI/logic.py: {e}", exc_info=True)
        return CoreParsingResult(errors=[f"Failed to parse content via ParserService: {e}"])

# Removed read_lang_file
# Removed read_xml_lang_file

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
    """Translate text using MachineTranslationService."""
    if not api_key: # This check can also be in the service, but keeping it here is fine.
        logger.warning("Machine translation called with no API key.")
        return None
        
    try:
        mt_service = MachineTranslationService()
        # Assuming the service method is named 'translate' and handles its own exceptions internally
        # or may raise specific service-related exceptions.
        translated_text = mt_service.translate(
            text=text,
            source_lang=source_lang,
            target_lang=target_lang,
            api_key=api_key
        )
        return translated_text # The service should handle html unescaping if it's a general concern
            
    except Exception as e:
        # Catching a broad exception here in case the service call itself fails unexpectedly
        # or if the service is not found (e.g. ImportError if mt_service.py doesn't exist yet)
        logger.error(f"Error calling MachineTranslationService: {str(e)}", exc_info=True)
        
    return None

def compare_translations(source_result: CoreParsingResult,
                       target_result: CoreParsingResult,
                       config: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
    """
    Compares two sets of translations using ComparisonService.
    
    Args:
        source_result: CoreParsingResult object for the source/reference translations.
        target_result: CoreParsingResult object for the target/new translations.
        config: Dictionary with comparison settings for ComparisonService.

    Returns:
        A structured dictionary containing the comparison results from ComparisonService.
    """
    logger.debug("GUI/logic.py:compare_translations called")
    
    # Ensure results are valid before proceeding
    if source_result.errors or target_result.errors:
        # This case should ideally be handled by the caller before even calling compare_translations.
        # If we reach here, it means parsing succeeded enough to get a result object, but it might contain errors.
        # ComparisonService might still be able to compare what was successfully parsed.
        # For now, log and proceed. Caller (e.g., flet_gui) should check individual parsing results first.
        if source_result.errors:
            logger.warning(f"Source parsing result contains errors: {source_result.errors}")
        if target_result.errors:
            logger.warning(f"Target parsing result contains errors: {target_result.errors}")

    service_instance = ComparisonService()

    # The config dict is passed directly to the service.
    # Keys for config (as expected by ComparisonService):
    #   'ignore_case_keys': bool
    #   'compare_values': bool
    #   'ignore_whitespace_values': bool
    # GUI/flet_gui.py's compare_files_gui currently builds a config like:
    #   config = {
    #       "ignore_case": self.config["ignore_case"], -> should be 'ignore_case_keys' for service
    #       "ignore_whitespace": self.config["ignore_whitespace"], -> 'ignore_whitespace_values'
    #       "compare_values": self.config["compare_values"],
    #       "ignore_patterns": self.config["ignore_patterns"], -> Not used by ComparisonService.compare_translations
    #       "log_missing_strings": self.config["log_missing_strings"], -> Not used by service
    #       "auto_fill_missing": self.config["auto_fill_missing"], -> Not used by service
    #   }
    # So, flet_gui.py will need to map its config keys to the ones expected by ComparisonService.
    # For now, this wrapper will just pass it through.

    comparison_dict_result = service_instance.compare_translations(source_result, target_result, config)

    return comparison_dict_result

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
        content = None
        if format == "json":
            import json
            content = json.dumps(translations, indent=4, ensure_ascii=False)
        elif format in {"yaml", "yml"}:
            import yaml
            content = yaml.dump(translations, allow_unicode=True)
        elif format == "lang":
            content = "\n".join(f"{key}={value}" for key, value in translations.items())
        elif format == "xml":
            import xml.etree.ElementTree as ET
            root = ET.Element("resources")
            for key, value in sorted(translations.items()):
                string_elem = ET.SubElement(root, "string", name=key)
                string_elem.text = value
            content = '<?xml version="1.0" encoding="UTF-8"?>\n' + ET.tostring(root, encoding='unicode', method='xml')
        elif format == "auto":
            ext = os.path.splitext(filepath)[1].lower()
            if ext == ".json":
                import json
                content = json.dumps(translations, indent=4, ensure_ascii=False)
            elif ext in {".yaml", ".yml"}:
                import yaml
                content = yaml.dump(translations, allow_unicode=True)
            elif ext == ".lang":
                content = "\n".join(f"{key}={value}" for key, value in translations.items())
            elif ext == ".xml":
                import xml.etree.ElementTree as ET
                root = ET.Element("resources")
                for key, value in sorted(translations.items()):
                    string_elem = ET.SubElement(root, "string", name=key)
                    string_elem.text = value
                content = '<?xml version="1.0" encoding="UTF-8"?>\n' + ET.tostring(root, encoding='unicode', method='xml')
            else:
                return False, "Unsupported file extension for auto-detection"
        else:
            return False, "Unsupported format"

        if content is not None:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            return True, ""

        return False, "Unsupported format"

    except Exception as e:
        return False, str(e)

# Removed extract_placeholders function (now in ComparisonService)
# Removed validate_placeholders function (now in ComparisonService)

from core.constants import SUPPORTED_FORMATS, USER_MESSAGES
# from parsers.xml_parser import XMLParser  # No longer needed here