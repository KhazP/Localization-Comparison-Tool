import logging
import xml.etree.ElementTree as ET
from typing import Dict, Optional, List, Any # Added List, Any
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class

logger = logging.getLogger(__name__)

class RESXParser(TranslationParser):
    """Parser for .NET resource (RESX) files."""
    
    def parse(self, content: str) -> ParsingResult:
        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {} # Approximate line numbers
        comments: Dict[str, str] = {} # For <comment> tags
        parsing_errors: List[str] = []
        metadata: Dict[str, Any] = {}

        try:
            # Basic sanitization for common invalid XML characters
            # Allow tab, newline, carriage return, and typical printable ASCII and beyond.
            # Excludes most C0 control characters except whitespace, and C1 controls.
            import re
            sanitized_content = re.sub(r'[^\x09\x0A\x0D\x20-\uD7FF\uE000-\uFFFD\U00010000-\U0010FFFF]', '', content)


            if not sanitized_content.strip():
                parsing_errors.append("RESX content is empty or became empty after sanitization.")
                return ParsingResult(translations={}, errors=parsing_errors)

            root = ET.fromstring(sanitized_content)
            
            # RESX files use <data name="key"><value>text</value><comment>text</comment></data>
            # Iterating over 'data' elements. These are typically direct children of the root,
            # but using .//data makes it more robust if they are nested within other schema elements.
            data_elements = list(root.findall('.//data'))

            for i, data_elem in enumerate(data_elements):
                key_for_error = 'unknown'
                try:
                    key = data_elem.get('name')
                    key_for_error = key if key else 'unknown' # For more specific error logging

                    if not key:
                        msg = f"Found data element without 'name' attribute at approx. position {i+1}."
                        logger.warning(msg)
                        parsing_errors.append(msg)
                        continue
                        
                    value_elem = data_elem.find('value')
                    value_text = "" # Default to empty string if no value or text
                    if value_elem is not None and value_elem.text is not None:
                        value_text = value_elem.text
                    elif value_elem is None:
                         logger.debug(f"No <value> element found for key '{key}'. Defaulting to empty string.")
                    # If value_elem exists but value_elem.text is None, it's an empty tag <value/>, value_text remains ""
                    
                    if key in translations:
                        msg = f"Duplicate key '{key}' found in RESX. Value ('{value_text}') will overwrite previous ('{translations[key]}')."
                        logger.warning(msg)
                        parsing_errors.append(msg)

                    translations[key] = value_text
                    # Line numbers are approximate, based on element order.
                    # For accurate line numbers, a line-aware XML parser would be needed.
                    line_numbers[key] = i + 1

                    comment_elem = data_elem.find('comment')
                    if comment_elem is not None and comment_elem.text:
                        comment_text = comment_elem.text.strip()
                        if comment_text: # Only add if comment is not just whitespace
                            if key in comments:
                                 msg = f"Duplicate comment for key '{key}' found. New comment ('{comment_text}') will overwrite previous ('{comments[key]}')."
                                 logger.warning(msg)
                                 # parsing_errors.append(msg) # Comments are secondary, duplicates might not be critical errors
                            comments[key] = comment_text

                except Exception as e: # Catch errors during individual <data> element processing
                    msg = f"Error processing RESX data element for key '{key_for_error}' (approx. position {i+1}): {str(e)}"
                    logger.error(msg, exc_info=True)
                    parsing_errors.append(msg)
                    # Continue to process other <data> elements

            if comments:
                metadata['comments'] = comments

            if not translations and not parsing_errors and not comments:
                logger.info("RESX parser found no translatable strings or comments after processing.")

            return ParsingResult(
                translations=translations,
                line_numbers=line_numbers if line_numbers else None,
                metadata=metadata if metadata else None,
                errors=parsing_errors if parsing_errors else None
            )
            
        except ET.ParseError as e:
            # Error parsing the XML structure itself
            error_msg = f"Invalid RESX XML syntax: {str(e)}"
            # e.lineno and e.offset might be available here for more precise error location
            if hasattr(e, 'lineno') and hasattr(e, 'offset'):
                error_msg += f" (line {e.lineno}, column {e.offset})"
            logger.error(error_msg)
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors)
            
        except Exception as e:
            # Other unexpected errors during parsing initialization or top-level processing
            error_msg = f"Failed to parse RESX content due to an unexpected error: {str(e)}"
            logger.error(error_msg, exc_info=True)
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors)
