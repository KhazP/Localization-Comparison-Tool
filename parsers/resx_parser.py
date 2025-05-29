import xml.etree.ElementTree as ET
from typing import Dict, List
from .base_parser import BaseParser
from ..core.errors import ParsingError # Assuming ..core.errors is correct

class ResxParser(BaseParser): # Renamed and changed parent class
    """Parser for .NET resource (RESX) files."""
    
    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature
        translations: Dict[str, str] = {}
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Parse XML content
            root = ET.fromstring(content)
            
            # RESX files use <data name="key"><value>text</value></data> format
            # Comments (<comment>) are ignored as per Dict[str, str] return type
            for data_elem in root.findall('.//data'):
                key = data_elem.get('name')
                if not key:
                    # logging.warning equivalent: perhaps skip, or raise ParsingError for malformed entry
                    # For now, skip entries without a name, consistent with previous logging behavior
                    continue 
                        
                value_elem = data_elem.find('value')
                value_text = '' # Default to empty string if no <value> or if <value> is empty
                if value_elem is not None and value_elem.text is not None:
                    value_text = value_elem.text
                
                translations[str(key)] = str(value_text) # Ensure string types
            
            return translations
            
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except ET.ParseError as e:
            raise ParsingError(f"Invalid RESX XML syntax: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors
            raise ParsingError(f"An unexpected error occurred during RESX parsing: {e}", filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.resx']
