import re
from typing import List # For type hinting

# Logger can be added if needed for these utilities, but often they are pure functions.
# import logging
# logger = logging.getLogger(__name__)

def extract_placeholders(text: str) -> List[str]:
    """Extract all placeholders from a text string."""
    if not isinstance(text, str): # Ensure input is a string
        return []
        
    # Common placeholder patterns
    patterns = [
        r'\{[^}]+\}',          # {name}, {0}, {value}
        r'%[dsfuoxc]',         # %s, %d, %f etc. (common C-style)
        r'%[0-9]+\$[dsfuoxc]', # %1$s, %2$d (positional C-style)
        r'%[0-9]*\.[0-9]*[efg]',# %.2f, %3.1f (float formatting)
        r'\$[a-zA-Z_][a-zA-Z0-9_]*', # $variable (PHP, etc.)
        r'#[a-zA-Z_][a-zA-Z0-9_]*#', # #variable# (custom)
        r'\[\[[^\]]+\]\]'      # [[variable]] (custom)
    ]
    combined_pattern = '|'.join(patterns)
    return [p.group(0) for p in re.finditer(combined_pattern, text)]

def validate_placeholders(source_text: str, target_text: str) -> tuple[bool, str]:
    """
    Validate that placeholders match between source and target text.
    Returns (is_valid, error_message).
    """
    if not isinstance(source_text, str) or not isinstance(target_text, str):
        # Non-string inputs might not be suitable for placeholder extraction.
        return True, "" # Assuming valid if not strings, or raise error.

    source_placeholders = extract_placeholders(source_text)
    target_placeholders = extract_placeholders(target_text)
    
    if not source_placeholders and not target_placeholders:
        return True, "" # Both empty, no placeholders to mismatch.
    
    if source_placeholders == target_placeholders: # Strict order and count match
        return True, ""
        
    # More detailed error reporting:
    src_set = set(source_placeholders)
    tgt_set = set(target_placeholders)
    
    missing_in_tgt_report = src_set - tgt_set
    extra_in_tgt_report = tgt_set - src_set
    
    error_parts = []
    if missing_in_tgt_report:
        error_parts.append(f"Missing: {', '.join(sorted(list(missing_in_tgt_report)))}")
    if extra_in_tgt_report:
        error_parts.append(f"Extra: {', '.join(sorted(list(extra_in_tgt_report)))}")

    if not error_parts and source_placeholders != target_placeholders:
        # This means the sets of unique placeholders are the same, but counts or order differ.
        error_parts.append("Order or count of placeholders differs.")
        # Consider adding more detail using collections.Counter if necessary for debugging.
        # from collections import Counter
        # src_counts = Counter(source_placeholders)
        # tgt_counts = Counter(target_placeholders)
        # for p, c_src in src_counts.items():
        #    c_tgt = tgt_counts.get(p, 0)
        #    if c_src != c_tgt:
        #        error_parts.append(f"Placeholder '{p}': source has {c_src}, target has {c_tgt}.")
        # (Ensure Counter is imported if this detail is added)

    return False, "; ".join(error_parts) if error_parts else "Placeholder mismatch (order or count unclear)."
