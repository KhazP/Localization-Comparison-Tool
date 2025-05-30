import logging
import xml.etree.ElementTree as ET
from typing import Dict, Optional
from .base_parser import TranslationParser

class RESXParser(TranslationParser):
    """Parser for .NET resource (RESX) files."""
    
    def parse(self, content: str) -> dict:
        """
        Parse RESX content into a dictionary of translations.
        
        Args:
            content: String content of the RESX file
            
        Returns:
            Dictionary with translations and line numbers
            
        Raises:
            ValueError: If RESX content is invalid
        """
        translations = {}
        line_numbers = {}
        
        try:
            # Parse XML content
            root = ET.fromstring(content)
            
            # RESX files use <data name="key"><value>text</value></data> format
            for i, data_elem in enumerate(root.findall('.//data'), 1):
                try:
                    key = data_elem.get('name')
                    if not key:
                        logging.warning(f"Found data element without 'name' attribute at position {i}")
                        continue
                        
                    value_elem = data_elem.find('value')
                    if value_elem is not None:
                        # Handle potential None values
                        translations[key] = value_elem.text or ''
                        line_numbers[key] = i
                    else:
                        logging.warning(f"No value element found for key '{key}'")
                        translations[key] = ''
                        line_numbers[key] = i
                        
                except Exception as e:
                    logging.error(f"Error processing data element: {str(e)}")
                    continue
                    
            comment_elems = root.findall('.//data/comment')
            if comment_elems:
                # Store comments in a separate dictionary if needed
                comments = {}
                for data_elem in root.findall('.//data'):
                    key = data_elem.get('name')
                    comment_elem = data_elem.find('comment')
                    if key and comment_elem is not None and comment_elem.text:
                        comments[key] = comment_elem.text

            if not translations:
                logging.warning("No translations found in RESX content")
                
            return {
                "translations": translations,
                "line_numbers": line_numbers,
                "comments": comments if comment_elems else None
            }
            
        except ET.ParseError as e:
            error_msg = f"Invalid RESX XML syntax: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
            
        except Exception as e:
            error_msg = f"Failed to parse RESX content: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
