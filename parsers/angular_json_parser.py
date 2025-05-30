import logging
import json
import re  # Added missing import
from typing import Dict, Any, Optional

from .base_parser import TranslationParser

class AngularJSONParser(TranslationParser):
    """Parser for Angular Translate JSON format."""
    
    def __init__(self, flatten_nested: bool = True):
        self.flatten_nested = flatten_nested
        
    def _flatten_dict(self, d: Dict[str, Any], parent_key: str = '', sep: str = '.') -> Dict[str, Any]:
        """
        Flatten nested dictionary with dot notation.
        
        Args:
            d: Dictionary to flatten
            parent_key: Parent key for nested items
            sep: Separator for nested keys
            
        Returns:
            Flattened dictionary
        """
        items = []
        for k, v in d.items():
            new_key = f"{parent_key}{sep}{k}" if parent_key else k
            
            if isinstance(v, dict):
                items.extend(self._flatten_dict(v, new_key, sep).items())
            else:
                items.append((new_key, v))
                
        return dict(items)
        
    def _process_interpolation(self, value: Any) -> str:
        """
        Convert value to string, handling Angular interpolation.
        
        Args:
            value: Value to process
            
        Returns:
            Processed string value
        """
        if isinstance(value, (dict, list)):
            # Handle ICU message format
            return json.dumps(value, ensure_ascii=False)
        return str(value)
        
    def parse(self, content: str) -> Dict[str, Any]:
        """
        Parse Angular Translate JSON content into a dictionary.
        
        Args:
            content: String content of the JSON file
            
        Returns:
            Dictionary with translations and metadata
            
        Raises:
            ValueError: If JSON content is invalid
        """
        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {}
        
        try:
            # Parse JSON content
            data = json.loads(content)
            
            if not isinstance(data, dict):
                raise ValueError("Root element must be an object")
                
            # Track line numbers by counting newlines before each key
            content_lines = content.split('\n')
            for i, line in enumerate(content_lines, 1):
                # Simple heuristic to find keys in the JSON
                match = re.search(r'"([^"]+)"\s*:', line)
                if match:
                    key = match.group(1)
                    line_numbers[key] = i
                    
            # Process translations
            if self.flatten_nested:
                flattened = self._flatten_dict(data)
                for key, value in flattened.items():
                    translations[key] = self._process_interpolation(value)
            else:
                for key, value in data.items():
                    translations[key] = self._process_interpolation(value)
                    
            # Look for metadata in common locations
            metadata = None
            if '@metadata' in data:
                metadata = data['@metadata']
            elif '@angular' in data:
                metadata = data['@angular']
                
            if not translations:
                logging.warning("No translations found in JSON content")
                
            return {
                "translations": translations,
                "line_numbers": line_numbers,
                "metadata": metadata,
                "is_flat": self.flatten_nested
            }
            
        except json.JSONDecodeError as e:
            error_msg = f"Invalid JSON syntax: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
            
        except Exception as e:
            error_msg = f"Failed to parse Angular JSON content: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
