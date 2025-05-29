import xml.etree.ElementTree as ET
from typing import Dict, List
from .base_parser import BaseParser
from ..core.errors import ParsingError # Assuming ..core.errors is correct

class XmlParser(BaseParser): # Renamed and changed parent class
    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature
        translations: Dict[str, str] = {}
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            root = ET.fromstring(content)
            # This parser specifically looks for <string name="key">value</string>
            # This is common in Android XML localization files, for example.
            for string_elem in root.findall('.//string'): # Find all <string> elements anywhere
                key = string_elem.get('name')
                if not key:
                    # Skip elements without a 'name' attribute
                    continue 
                    
                text_content = string_elem.text
                value = str(text_content) if text_content is not None else '' # Ensure value is string, default to empty
                    
                translations[str(key)] = value # Ensure key is string
                
            return translations
            
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except ET.ParseError as e:
            raise ParsingError(f"Invalid XML syntax: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors like file access issues (besides FileNotFoundError)
            raise ParsingError(f"An unexpected error occurred during XML parsing: {e}", filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.xml']
