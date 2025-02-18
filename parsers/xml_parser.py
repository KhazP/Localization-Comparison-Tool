import xml.etree.ElementTree as ET
import logging
from typing import Dict
from .base_parser import TranslationParser

class XMLParser(TranslationParser):
    def parse(self, content: str) -> Dict[str, str]:
        translations = {}
        
        try:
            root = ET.fromstring(content)
            for string_elem in root.findall('.//string'):
                key = string_elem.get('name')
                if not key:
                    logging.warning("Found <string> element without 'name' attribute")
                    continue
                    
                text = string_elem.text
                if text is None:
                    logging.debug(f"Empty string element for key: {key}")
                    text = ''
                    
                translations[key] = text
                
            return translations
            
        except ET.ParseError as e:
            logging.error(f"XML parse error: {str(e)}")
            raise ValueError(f"Invalid XML content: {e}")
        except (TypeError, AttributeError) as e:
            logging.error(f"XML structure error: {str(e)}")
            raise ValueError(f"Invalid XML structure: {e}")
