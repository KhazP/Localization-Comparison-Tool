import logging
import re
from typing import Dict, Tuple, List, Optional # Added List, Optional
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class

logger = logging.getLogger(__name__)

class PropertiesParser(TranslationParser):
    """Parser for Java Properties files."""
    
    def __init__(self, trim_whitespace: bool = True, handle_escapes: bool = True):
        self.trim_whitespace = trim_whitespace
        self.handle_escapes = handle_escapes
        
    def _unescape(self, value: str) -> str:
        """
        Handle Java properties escape sequences.
        """
        if not self.handle_escapes or not value: # Added check for empty value
            return value
            
        # More comprehensive list of escapes including \uXXXX
        # Using a raw string for the regex pattern
        return re.sub(
            r'\\(u[0-9a-fA-F]{4}|[nrtf\\ :=#!])',
            lambda m:
                chr(int(m.group(1)[1:], 16)) if m.group(1).startswith('u') else
                {
                    'n': '\n', 'r': '\r', 't': '\t', 'f': '\f', '\\': '\\',
                    ' ': ' ', ':': ':', '=': '=', '#': '#', '!': '!'
                }.get(m.group(1), m.group(1)), # Fallback for unrecognized simple escapes
            value
        )
        
    def _parse_line(self, line: str, current_line_number: int) -> Optional[Tuple[str, str, List[str]]]:
        """
        Parse a single logical line (after handling continuations).
        Returns (key, value, errors_for_line) or None if line is a comment/blank.
        """
        errors: List[str] = []
        original_line = line # For logging
        
        if self.trim_whitespace:
            line = line.strip()
            
        if not line or line.startswith(('#', '!')):
            return None # Skip comments and empty lines
            
        # Find key-value separator (first non-escaped '=', ':', or whitespace)
        # Regex to find the first non-escaped separator
        # (?<!\\) is a negative lookbehind asserting that the separator is not preceded by a backslash
        match = re.search(r'(?<!\\)([ \t]*[=:][ \t]|[ \t]+)', line)

        if match:
            separator_pos = match.start()
            key = line[:separator_pos]
            value = line[match.end():] # Use match.end() to skip the separator itself
            
            if self.trim_whitespace:
                key = key.strip()
                # Value trimming should be cautious; leading/trailing spaces might be intentional
                # For properties, typically values are trimmed if the separator was space.
                # If separator included spaces, then value is already "trimmed" by the split.
                # If key-value separator was '=' or ':', then trim value.
                if match.group(1).strip() in [':', '=']:
                     value = value.strip()

            if self.handle_escapes:
                # Unescape key (less common, but possible)
                # key = self._unescape(key) # Typically keys are not escaped, but let's be safe
                # Unescape value
                value = self._unescape(value)
                
            if not key:
                msg = f"Line {current_line_number}: Parsed an empty key from line: '{original_line[:100]}...'"
                logger.warning(msg)
                errors.append(msg)
                # Decide if this is a critical error or just a warning.
                # For now, let's allow it but record an error.
            
            return key, value, errors
            
        else: # No separator, treat the whole line as a key if not empty
            if self.trim_whitespace:
                key = line.strip()
            else:
                key = line

            if key: # Only if the line (now key) is not empty
                if self.handle_escapes:
                    key = self._unescape(key)
                # Value is empty in this case
                return key, "", errors
            else: # Line was whitespace only
                return None


    def parse(self, content: str) -> ParsingResult:
        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {}
        parsing_errors: List[str] = []
        
        try:
            raw_lines = content.splitlines()
            logical_line_buffer = []
            current_logical_line_start_num = 0
            
            for i, raw_line_text in enumerate(raw_lines, 1):
                line_to_process = raw_line_text
                if self.trim_whitespace: # Initial trim for line continuation logic
                    line_to_process = line_to_process.rstrip()

                if not logical_line_buffer:
                    current_logical_line_start_num = i

                if line_to_process.endswith('\\'):
                    # Remove trailing backslash and leading/trailing whitespace from the segment
                    segment = line_to_process[:-1].strip() if self.trim_whitespace else line_to_process[:-1]
                    logical_line_buffer.append(segment)
                else:
                    segment = raw_line_text.strip() if self.trim_whitespace else raw_line_text
                    logical_line_buffer.append(segment)

                    full_logical_line = "".join(logical_line_buffer)
                    logical_line_buffer = [] # Reset buffer

                    parse_attempt = self._parse_line(full_logical_line, current_logical_line_start_num)

                    if parse_attempt:
                        key, value, line_errors = parse_attempt
                        parsing_errors.extend(line_errors)

                        if key is not None: # key could be "" if _parse_line decided so
                            if key in translations:
                                msg = (f"Line {current_logical_line_start_num}: Duplicate key '{key}' found. "
                                       f"Previous value '{translations[key]}' will be overwritten with '{value}'.")
                                logger.warning(msg)
                                parsing_errors.append(msg)

                            translations[key] = value
                            line_numbers[key] = current_logical_line_start_num

            # Check if buffer has unterminated continued line at EOF
            if logical_line_buffer:
                full_logical_line = "".join(logical_line_buffer)
                msg = (f"Line {current_logical_line_start_num}: File ends with an unterminated continued line: "
                       f"'{full_logical_line[:100]}...'. Processing as is.")
                logger.warning(msg)
                parsing_errors.append(msg)
                parse_attempt = self._parse_line(full_logical_line, current_logical_line_start_num)
                if parse_attempt:
                    key, value, line_errors = parse_attempt
                    parsing_errors.extend(line_errors)
                    if key is not None:
                        if key in translations:
                             msg = (f"Line {current_logical_line_start_num}: Duplicate key '{key}' (from EOF continued line). "
                                    f"Value will be overwritten.")
                             logger.warning(msg)
                             parsing_errors.append(msg)
                        translations[key] = value
                        line_numbers[key] = current_logical_line_start_num

            return ParsingResult(
                translations=translations,
                line_numbers=line_numbers,
                errors=parsing_errors if parsing_errors else None
            )
            
        except Exception as e:
            error_msg = f"Failed to parse properties content: {str(e)}"
            logger.error(error_msg, exc_info=True)
            return ParsingResult(translations={}, errors=[error_msg] + parsing_errors)
