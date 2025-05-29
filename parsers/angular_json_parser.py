import json
from typing import Dict, Any, List # Added List
from .base_parser import BaseParser
from ..core.errors import ParsingError # Assuming ..core.errors is correct

class AngularJsonParser(BaseParser): # Renamed and changed parent class
    """Parser for Angular Translate JSON format."""
    
    def __init__(self, flatten_nested: bool = True, key_separator: str = '.'):
        self.flatten_nested = flatten_nested
        self.key_separator = key_separator # Allow customizing separator for flattened keys
        
    def _flatten_dict(self, d: Dict[str, Any], parent_key: str = '') -> Dict[str, Any]:
        items = []
        for k, v in d.items():
            new_key = f"{parent_key}{self.key_separator}{k}" if parent_key else k
            if isinstance(v, dict) and self.flatten_nested: # Check flatten_nested here
                items.extend(self._flatten_dict(v, new_key).items())
            else:
                # If not flattening further, or if v is not a dict, process the value
                items.append((str(new_key), self._process_value(v)))
        return dict(items)
        
    def _process_value(self, value: Any) -> str:
        """
        Convert value to string. Handles complex types like ICU messages by JSON dumping them.
        """
        if isinstance(value, (dict, list)): # ICU messages or arrays
            return json.dumps(value, ensure_ascii=False)
        if value is None:
            return "" # Represent None as empty string
        return str(value) # Ensure everything else is a string
        
    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature and return type
        translations: Dict[str, str] = {}
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            if not isinstance(data, dict):
                raise ParsingError("Root element of Angular JSON must be an object.", filepath=file_path)
                
            if self.flatten_nested:
                processed_data = self._flatten_dict(data)
                # _flatten_dict now also calls _process_value, so items are already str:str
                translations = processed_data
            else: # Process only top-level keys if not flattening
                for key, value in data.items():
                    translations[str(key)] = self._process_value(value)
            
            return translations
            
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except json.JSONDecodeError as e:
            raise ParsingError(f"Invalid JSON syntax: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors
            raise ParsingError(f"An unexpected error occurred during Angular JSON parsing: {e}", filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.json'] # Handles .json files, specifically for Angular i18n structure
