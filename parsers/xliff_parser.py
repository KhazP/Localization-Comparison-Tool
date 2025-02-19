import logging
import xml.etree.ElementTree as ET
from typing import Dict, Optional
from .base_parser import TranslationParser

class XLIFFParser(TranslationParser):
    """Parser for XLIFF (XML Localization Interchange File Format) files."""
    
    def __init__(self, source_lang: Optional[str] = None, target_lang: Optional[str] = None):
        self.source_lang = source_lang
        self.target_lang = target_lang
        
    def parse(self, content: str) -> dict:
        """
        Parse XLIFF content into a dictionary of translations.
        
        Args:
            content: String content of the XLIFF file
            
        Returns:
            Dictionary with translations and line numbers
            
        Raises:
            ValueError: If XLIFF content is invalid
        """
        translations = {}
        line_numbers = {}
        
        try:
            # Parse XML content
            root = ET.fromstring(content)
            
            # XLIFF files can have multiple 'file' elements
            for file_num, file_elem in enumerate(root.findall('.//file')):
                # Extract source/target languages if not provided
                if not self.source_lang:
                    self.source_lang = file_elem.get('source-language')
                if not self.target_lang:
                    self.target_lang = file_elem.get('target-language')
                    
                # Process translation units
                for unit_num, unit in enumerate(file_elem.findall('.//trans-unit')):
                    try:
                        key = unit.get('id')
                        if not key:
                            logging.warning(f"Found trans-unit without 'id' attribute in file {file_num + 1}")
                            continue
                            
                        # Get the target element content
                        target = unit.find('target')
                        if target is not None and target.text is not None:
                            translations[key] = target.text
                            # Calculate approximate line number
                            line_numbers[key] = unit_num + 1
                        else:
                            # Fallback to source if target is missing
                            source = unit.find('source')
                            if source is not None and source.text is not None:
                                translations[key] = source.text
                                line_numbers[key] = unit_num + 1
                                logging.debug(f"Using source text for key '{key}' (missing target)")
                            else:
                                logging.warning(f"No target or source text found for key '{key}'")
                                translations[key] = ''
                                line_numbers[key] = unit_num + 1
                                
                    except Exception as e:
                        logging.error(f"Error processing trans-unit: {str(e)}")
                        continue

            if not translations:
                logging.warning("No translations found in XLIFF content")
                
            return {
                "translations": translations,
                "line_numbers": line_numbers,
                "source_lang": self.source_lang,
                "target_lang": self.target_lang
            }
            
        except ET.ParseError as e:
            error_msg = f"Invalid XLIFF XML syntax: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
            
        except Exception as e:
            error_msg = f"Failed to parse XLIFF content: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
