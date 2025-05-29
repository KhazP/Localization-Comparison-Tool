import logging
from typing import Dict, List, Optional, Tuple # Added Tuple

from colorama import Fore, Style, init as colorama_init

# Assuming string_utils and translation_service are in utils directory,
# and core is at the same level as utils, or python path is set up correctly.
# If running from project root, this would be:
# from utils.string_utils import validate_placeholders
# from utils.translation_service import machine_translate
# However, the sandbox environment might have specific path requirements.
# Let's try relative imports first if these modules are considered part of the same top-level package.
# If 'core' and 'utils' are sibling directories under a common project root added to PYTHONPATH:
# Changed to relative imports
from ..utils.string_utils import validate_placeholders
from ..utils.translation_service import machine_translate


# Initialize Colorama
colorama_init(autoreset=True)

# Get a logger for this module
logger = logging.getLogger(__name__)
# If logger_service is intended for use:
# from utils.logger_service import logger_service
# logger = logger_service.get_logger(__name__)


VALID_COLORS = [
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
    "lightblack_ex", "lightred_ex", "lightgreen_ex", "lightyellow_ex",
    "lightblue_ex", "lightmagenta_ex", "lightcyan_ex", "lightwhite_ex"
]

def get_color(color_name: str):
    """Gets the colorama Fore color object from a color name (case-insensitive)."""
    color_name = color_name.lower()
    if color_name not in VALID_COLORS:
        return None # Or Fore.RESET or some default
    return getattr(Fore, color_name.upper())


def compare_translations(
    source_translations: Dict[str, str], 
    target_translations: Dict[str, str], 
    ignore_case: bool = False, 
    ignore_whitespace: bool = False, # This was in original signature but not used in provided snippet
    is_gui: bool = False, 
    # compare_values: bool = False, # This was in original signature but not used
    ignore_patterns: Optional[List[str]] = None, 
    log_missing_keys: bool = False, # Renamed from original for clarity
    target_locale_name: str = "target", # For logging messages
    # auto_fill_missing: bool = False, # This functionality was commented out as potentially problematic
    # mt_settings: Optional[Dict] = None, # Not used directly by compare_translations, but by translate_missing_keys
    include_summary: bool = True
) -> str:
    """
    Compares two translation dictionaries.
    source_translations: The reference dictionary (e.g., English).
    target_translations: The dictionary to compare against the source (e.g., a translation).
    """
    
    def normalize_key(k: str) -> str:
        key_str = str(k).strip() # Ensure key is string and stripped
        # ignore_whitespace for keys is implicitly handled by strip().
        return key_str.lower() if ignore_case else key_str

    # Normalize keys and ensure values are strings.
    # Filter out keys based on ignore_patterns.
    source_map = {
        normalize_key(k): str(v) for k, v in (source_translations or {}).items()
        if not any(str(k).startswith(p) for p in (ignore_patterns or []))
    }
    target_map = {
        normalize_key(k): str(v) for k, v in (target_translations or {}).items()
        if not any(str(k).startswith(p) for p in (ignore_patterns or []))
    }
    
    logger.debug(f"Source keys after normalization for comparison: {len(source_map)}")
    logger.debug(f"Target keys after normalization for comparison: {len(target_map)}")

    missing_in_target = set(source_map.keys()) - set(target_map.keys())
    obsolete_in_target = set(target_map.keys()) - set(source_map.keys())
    
    output_lines: List[str] = []
    
    # Placeholder validation for common keys
    invalid_placeholders: List[Tuple[str, str, str]] = [] # (normalized_key, error_message, target_value)
    common_keys_normalized = set(source_map.keys()) & set(target_map.keys())
    
    # To retrieve original values for placeholder check, iterate through original dicts
    # and match normalized keys. This is complex if multiple original keys map to the same normalized key.
    # A simpler approach for now: use values from the normalized maps for placeholder checks.
    # This assumes that stringification for the map (str(v)) doesn't lose placeholder info.
    for norm_key in common_keys_normalized:
        s_text = source_map[norm_key]
        t_text = target_map[norm_key]
        is_valid, error_msg = validate_placeholders(s_text, t_text)
        if not is_valid:
            invalid_placeholders.append((norm_key, error_msg, t_text))

    placeholder_mismatch_count = len(invalid_placeholders)
    
    # Determine max key length for alignment based on keys that will be displayed
    display_keys_set = set()
    for key_norm, _, _ in invalid_placeholders: display_keys_set.add(key_norm)
    for key_norm in missing_in_target: display_keys_set.add(key_norm)
    for key_norm in obsolete_in_target: display_keys_set.add(key_norm)
    max_key_length = max((len(k) for k in display_keys_set), default=20) if display_keys_set else 20

    # Report placeholder mismatches
    for key_norm, error_msg, text_val in sorted(invalid_placeholders):
        line = f"~ {key_norm.ljust(max_key_length)} : {text_val} ({error_msg})"
        output_lines.append(Fore.YELLOW + line + Style.RESET_ALL if not is_gui else line)

    # Report missing keys
    for key_norm in sorted(missing_in_target):
        value_from_source = source_map[key_norm] # Value from the source map
        line = f"+ {key_norm.ljust(max_key_length)} : {value_from_source} (missing in {target_locale_name})"
        output_lines.append(Fore.GREEN + line + Style.RESET_ALL if not is_gui else line)
        if log_missing_keys: 
            logger.warning(f"Missing translation key '{key_norm}' for locale '{target_locale_name}'")

    # Report obsolete keys
    for key_norm in sorted(obsolete_in_target):
        value_from_target = target_map[key_norm] # Value from the target map
        line = f"- {key_norm.ljust(max_key_length)} : {value_from_target} (obsolete in {target_locale_name})"
        output_lines.append(Fore.RED + line + Style.RESET_ALL if not is_gui else line)

    missing_count = len(missing_in_target)
    obsolete_count = len(obsolete_in_target)

    if include_summary:
        if output_lines: output_lines.append("") # Add a separator line
        summary_lines = [
            "--- Summary ---",
            f"Missing in {target_locale_name}: {missing_count}",
            f"Obsolete in {target_locale_name}: {obsolete_count}",
            f"Placeholder mismatches: {placeholder_mismatch_count}"
        ]
        output_lines.extend(summary_lines)

    return "\n".join(output_lines)


def translate_missing_keys(
    source_dict: Dict[str, str], 
    target_dict: Dict[str, str], 
    source_lang: str, 
    target_lang: str, 
    api_key: str, 
    progress_callback: Optional[Callable[[float], None]] = None
) -> Tuple[Dict[str, str], List[str]]:
    """
    Translate missing keys from source_dict to target_lang and add to target_dict.
    Returns (updated_target_dict, list_of_errors_encountered).
    """
    if not api_key:
        logger.warning("translate_missing_keys called without API key.")
        return target_dict, ["No API key provided for machine translation."]

    updated_target_dict = target_dict.copy() # Work on a copy
    translation_errors: List[str] = []
    
    keys_to_translate = [k for k in source_dict if k not in updated_target_dict]
    
    if not keys_to_translate:
        if progress_callback: progress_callback(1.0)
        return updated_target_dict, []

    total_keys_to_translate = len(keys_to_translate)
    for i, key in enumerate(keys_to_translate):
        text_to_translate = str(source_dict[key]) # Ensure text is string
        
        translated_text = machine_translate(text_to_translate, source_lang, target_lang, api_key)
        
        if translated_text is not None:
            updated_target_dict[key] = translated_text
        else:
            # machine_translate already logs errors, so just record the failure for summary
            err_msg = f"Failed to translate key '{key}' (API did not return translation or error)."
            translation_errors.append(err_msg)
            logger.info(err_msg) # Also log it here for context of this operation
        
        if progress_callback:
            progress_callback((i + 1) / total_keys_to_translate)
            
    return updated_target_dict, translation_errors
