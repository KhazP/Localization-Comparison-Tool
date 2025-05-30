import logging
import xml.etree.ElementTree as ET
import re
from typing import Dict, Optional
from .base_parser import TranslationParser

class AndroidXMLParser(TranslationParser):
    """Parser for Android XML string resources."""
    
    def __init__(self, preserve_comments: bool = True):
        self.preserve_comments = preserve_comments
        
    def _parse_android_escapes(self, value: str) -> str:
        """Handle Android-specific string escapes."""
        # Android XML uses HTML escapes and some special formats
        if not value:
            return value
            
        # Handle HTML entities
        value = value.replace("&lt;", "<") \
                    .replace("&gt;", ">") \
                    .replace("&amp;", "&") \
                    .replace("&apos;", "'") \
                    .replace("&quot;", '"')
                    
        # Handle special Android formats
        formats = {
            r'%\d+\$[sd]',  # Positional args like %1$s
            r'%[sd]',       # Simple args like %s
            r'@string/\w+', # String references
            r'@android:'    # Android system references
        }
        
        return value
        
    def parse(self, content: str) -> dict:
        """
        Parse Android XML string resources into a dictionary.
        
        Args:
            content: String content of the Android XML file
            
        Returns:
            Dictionary with translations and line numbers
            
        Raises:
            ValueError: If XML content is invalid
        """
        translations = {}
        line_numbers = {}
        plurals = {}
        string_arrays = {}
        
        try:
            # Parse XML content
            root = ET.fromstring(content)
            
            # Process regular strings
            for i, string_elem in enumerate(root.findall('.//string'), 1):
                try:
                    key = string_elem.get('name')
                    if not key:
                        logging.warning(f"Found string element without 'name' attribute at position {i}")
                        continue
                        
                    # Handle translatable attribute
                    translatable = string_elem.get('translatable', 'true').lower()
                    if translatable == 'false':
                        logging.debug(f"Skipping non-translatable string '{key}'")
                        continue
                        
                    # Get text content, preserving CDATA if present
                    if string_elem.text is not None:
                        value = string_elem.text
                        value = self._parse_android_escapes(value)
                        translations[key] = value
                        line_numbers[key] = i
                    else:
                        logging.warning(f"Empty string found for key '{key}'")
                        translations[key] = ''
                        line_numbers[key] = i
                        
                except Exception as e:
                    logging.error(f"Error processing string element: {str(e)}")
                    continue
                    
            # Process plurals
            for plural_elem in root.findall('.//plurals'):
                key = plural_elem.get('name')
                if key:
                    plural_dict = {}
                    for item in plural_elem.findall('item'):
                        quantity = item.get('quantity')
                        if quantity and item.text:
                            plural_dict[quantity] = self._parse_android_escapes(item.text)
                    if plural_dict:
                        plurals[key] = plural_dict
                        
            # Process string arrays
            for array_elem in root.findall('.//string-array'):
                key = array_elem.get('name')
                if key:
                    array_items = []
                    for item in array_elem.findall('item'):
                        if item.text:
                            array_items.append(self._parse_android_escapes(item.text))
                    if array_items:
                        string_arrays[key] = array_items

            return {
                "translations": translations,
                "line_numbers": line_numbers,
                "plurals": plurals if plurals else None,
                "string_arrays": string_arrays if string_arrays else None
            }
            
        except ET.ParseError as e:
            error_msg = f"Invalid Android XML syntax: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
            
        except Exception as e:
            error_msg = f"Failed to parse Android XML content: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
