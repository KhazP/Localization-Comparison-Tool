import logging
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class
from typing import Dict # Keep for internal type hints

class LangParser(TranslationParser):
    def __init__(self, trim_whitespace: bool = True, comment_char: str = '#'):
        self.trim_whitespace = trim_whitespace
        self.comment_char = comment_char

    def parse(self, content: str) -> ParsingResult: # Update return type annotation
        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {} # Added to store line numbers
        errors: list[str] = [] # To collect non-critical errors/warnings
        
        try:
            for line_num, line_text in enumerate(content.splitlines(), 1):
                processed_line = line_text.strip() if self.trim_whitespace else line_text

                if not processed_line or processed_line.startswith(self.comment_char):
                    continue
                    
                if '=' in processed_line:
                    key, value = processed_line.split('=', 1)
                    if self.trim_whitespace:
                        key = key.strip()
                        value = value.strip()

                    if key:  # Only add if key is not empty
                        if key in translations:
                            # Log duplicate key as a warning/error
                            msg = f"Duplicate key '{key}' found at line {line_num}."
                            logging.warning(msg)
                            errors.append(msg)
                        translations[key] = value
                        line_numbers[key] = line_num # Store line number
                    else:
                        msg = f"Empty key found at line {line_num} with value '{value}'."
                        logging.warning(msg)
                        errors.append(msg)
                else:
                    # Log lines that are not comments, not empty, and don't contain '='
                    # Only consider it a notable event if the line isn't empty after processing
                    if processed_line: # Check if the line had content after potential stripping
                        msg = f"Skipping invalid line (no '=' separator or empty after strip) at line {line_num}: '{line_text[:50]}...'"
                        logging.debug(msg) # Low severity
                        # errors.append(msg) # Decide if this should be a reported error

            return ParsingResult(
                translations=translations,
                line_numbers=line_numbers if line_numbers else None, # Add line_numbers to result
                errors=errors if errors else None
            )
            
        except Exception as e:
            logging.error(f"Lang parse error: {str(e)}")
            # For a general exception, this is critical, so it becomes a main error for the ParsingResult
            return ParsingResult(translations={}, errors=[f"Invalid .lang content: {e}"])
