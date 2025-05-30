import xml.etree.ElementTree as ET
import logging
from typing import Dict # Keep for internal type hints
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class

class XMLParser(TranslationParser):
    def parse(self, content: str) -> ParsingResult: # Update return type annotation
        translations: Dict[str, str] = {}
        errors: list[str] = []
        
        try:
            # Attempt to remove control characters that can break XML parsing
            # This is a common issue with some XML files.
            # Only allow common whitespace characters: space, tab, newline, carriage return.
            # This is a basic sanitization, more robust solution might be needed for specific invalid chars.
            import re
            sanitized_content = re.sub(r'[^	\n\r -~+ -퟿-�]', '', content)

            if not sanitized_content.strip():
                logging.warning("XML content is empty or became empty after sanitization.")
                return ParsingResult(translations={}, errors=["XML content is empty."])

            root = ET.fromstring(sanitized_content)
            for i, string_elem in enumerate(root.findall('.//string')): # Using findall to get all <string> elements
                key = string_elem.get('name')

                if not key:
                    msg = f"Found <string> element without 'name' attribute at approximate position {i+1}."
                    logging.warning(msg)
                    errors.append(msg)
                    continue # Skip this element
                    
                text = string_elem.text
                if text is None:
                    logging.debug(f"Empty string element for key: '{key}'. Storing as empty string.")
                    text = ''

                if key in translations:
                    msg = f"Duplicate key '{key}' found in XML. Value will be overwritten."
                    logging.warning(msg)
                    errors.append(msg)
                translations[key] = text
                
            return ParsingResult(translations=translations, errors=errors if errors else None)
            
        except ET.ParseError as e:
            logging.error(f"XML parse error: {str(e)}")
            # Add more context if possible, e.g., line number if the parser provides it
            # For ET.ParseError, e.lineno and e.offset might be available but ET doesn't directly give it for fromstring.
            return ParsingResult(translations={}, errors=[f"Invalid XML content: {e}"])
        except (TypeError, AttributeError) as e: # These might indicate issues with the XML structure itself
            logging.error(f"XML structure error: {str(e)}")
            return ParsingResult(translations={}, errors=[f"Invalid XML structure: {e}"])
        except Exception as e: # Catch any other unexpected errors
            logging.error(f"Unexpected error in XMLParser: {str(e)}")
            return ParsingResult(translations={}, errors=[f"Unexpected error: {e}"])
