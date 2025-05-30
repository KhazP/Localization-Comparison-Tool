import logging
import json
import re
from typing import Dict, Any, Optional, List # Added List, Optional
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class

logger = logging.getLogger(__name__)

class AngularJSONParser(TranslationParser):
    """Parser for Angular Translate JSON format."""
    
    def __init__(self, flatten_nested: bool = True, separator: str = '.'):
        self.flatten_nested = flatten_nested
        self.separator = separator # Separator for flattening
        
    def _flatten_dict(self, d: Dict[str, Any], parent_key: str = '') -> Dict[str, Any]:
        """
        Flatten nested dictionary with a specified separator.
        """
        items = []
        for k, v in d.items():
            new_key = f"{parent_key}{self.separator}{k}" if parent_key else k
            
            if isinstance(v, dict) and self.flatten_nested: # Only flatten if it's a dict AND flattening is enabled
                items.extend(self._flatten_dict(v, new_key).items())
            else: # If not a dict, or flattening is disabled, or it's a dict but we don't flatten further
                items.append((new_key, v)) # Store value as is (could be string, dict, list, etc.)
                
        return dict(items)
        
    def _process_value(self, value: Any) -> str:
        """
        Convert value to string. Handles simple types, lists, and dicts (ICU format).
        """
        if isinstance(value, str):
            return value
        if isinstance(value, (int, float, bool)):
            return str(value)
        if isinstance(value, (dict, list)):
            # For ICU message format or other complex structures, serialize back to JSON string
            try:
                return json.dumps(value, ensure_ascii=False)
            except TypeError as e:
                logger.warning(f"Could not serialize value to JSON string: {value}. Error: {e}. Using str().")
                return str(value) # Fallback
        if value is None:
            return "" # Represent None as empty string
            
        logger.warning(f"Unexpected value type '{type(value)}' encountered. Converting using str().")
        return str(value) # Fallback for other types
        
    def parse(self, content: str) -> ParsingResult:
        translations: Dict[str, str] = {}
        # Line numbers are hard to get accurately for nested JSON without a more sophisticated parser.
        # The previous regex approach was a very rough heuristic.
        # For now, we'll omit line_numbers unless a robust method is implemented.
        # line_numbers: Dict[str, int] = {}
        parsing_errors: List[str] = []
        metadata_out: Dict[str, Any] = {}

        try:
            data = json.loads(content)
            
            if not isinstance(data, dict):
                msg = "Root element of Angular JSON must be an object."
                logger.error(msg)
                parsing_errors.append(msg)
                return ParsingResult(translations={}, errors=parsing_errors)
                
            # Extract @metadata or @angular if present
            if '@metadata' in data:
                metadata_out['angular_metadata'] = data.pop('@metadata') # Use pop to remove it from processing
            elif '@angular' in data: # Check for @angular as another common metadata key
                 metadata_out['angular_metadata'] = data.pop('@angular')


            processed_data = self._flatten_dict(data) if self.flatten_nested else data

            for key, value in processed_data.items():
                translations[key] = self._process_value(value)

            if not translations and not parsing_errors: # Check if any actual translations were extracted
                if 'angular_metadata' in metadata_out : # If only metadata was found
                    logger.info("Angular JSON contained only metadata, no translatable strings.")
                else:
                    logger.warning("No translations found in Angular JSON content.")
                    # parsing_errors.append("No translations found.") # Optional: report as error

            metadata_out['is_flat'] = self.flatten_nested # Store how it was parsed

            return ParsingResult(
                translations=translations,
                # line_numbers=line_numbers, # Omitting for now
                metadata=metadata_out if metadata_out else None,
                errors=parsing_errors if parsing_errors else None
            )
            
        except json.JSONDecodeError as e:
            error_msg = f"Invalid Angular JSON syntax: {str(e)}"
            logger.error(error_msg)
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors)
            
        except Exception as e:
            error_msg = f"Failed to parse Angular JSON content: {str(e)}"
            logger.error(error_msg, exc_info=True)
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors)
