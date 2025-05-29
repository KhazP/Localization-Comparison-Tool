import xml.etree.ElementTree as ET
from typing import Dict, List, Optional # Added List
from .base_parser import BaseParser
from ..core.errors import ParsingError # Assuming ..core.errors is correct

class XliffParser(BaseParser): # Renamed and changed parent class
    """Parser for XLIFF (XML Localization Interchange File Format) files."""
    
    # __init__ can be kept if its parameters are used by the parse method,
    # or if the parser instance needs to be configured.
    # For this task, source_lang and target_lang from __init__ are class members
    # that can be read by parse, so keeping __init__ is fine.
    def __init__(self, source_lang: Optional[str] = None, target_lang: Optional[str] = None):
        self.source_lang = source_lang
        self.target_lang = target_lang
        
    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature
        translations: Dict[str, str] = {}
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            root = ET.fromstring(content)
            
            # Define XLIFF namespace if needed, often it's the default namespace
            # For XLIFF 1.2, the namespace is "urn:oasis:names:tc:xliff:document:1.2"
            # ET.register_namespace('', "urn:oasis:names:tc:xliff:document:1.2") # For output, not strictly needed for findall with local names
            # If elements are namespaced, findall might need nsmap.
            # Example: root.findall('.//{urn:oasis:names:tc:xliff:document:1.2}file')
            # For simplicity, assuming default namespace or no namespace for findall paths as in original.

            for file_elem in root.findall('.//file'): # Original used .//file, implies it works without explicit ns
                # Update source/target language from file if not set in constructor
                current_source_lang = self.source_lang or file_elem.get('source-language')
                current_target_lang = self.target_lang or file_elem.get('target-language')
                # These are not directly used in the key-value extraction below but could be if logic required it.

                for unit in file_elem.findall('.//trans-unit'): # Original used .//trans-unit
                    key = unit.get('id')
                    if not key:
                        # Skip trans-unit without id
                        continue
                            
                    value_text = '' # Default value
                    target_elem = unit.find('target') # Find target element
                    
                    # Priority: target text in the file's target language (if specified and matches)
                    # This level of detail (matching target_elem.get('xml:lang') to current_target_lang)
                    # was not in the original, so stick to simpler logic: take any <target>.
                    if target_elem is not None and target_elem.text is not None:
                        value_text = target_elem.text
                    else:
                        # Fallback to source text if target is missing or empty
                        source_elem = unit.find('source') # Find source element
                        if source_elem is not None and source_elem.text is not None:
                            value_text = source_elem.text
                        # If both target and source are missing/empty, value_text remains ''
                            
                    translations[str(key)] = str(value_text) # Ensure string types
            
            return translations
            
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except ET.ParseError as e:
            raise ParsingError(f"Invalid XLIFF XML syntax: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors
            raise ParsingError(f"An unexpected error occurred during XLIFF parsing: {e}", filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.xlf', '.xliff'] # Common extensions for XLIFF
