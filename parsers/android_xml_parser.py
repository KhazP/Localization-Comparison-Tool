import xml.etree.ElementTree as ET
# import re # Not strictly needed if we simplify escape handling based on task
from typing import Dict, List # Added List
from .base_parser import BaseParser
from ..core.errors import ParsingError # Assuming ..core.errors is correct

class AndroidXmlParser(BaseParser): # Renamed and changed parent class
    """Parser for Android XML string resources. Focuses on <string> elements."""
    
    # __init__ can be removed if preserve_comments is not used for string extraction.
    # def __init__(self, preserve_comments: bool = True):
    #     self.preserve_comments = preserve_comments
        
    def _parse_android_escapes(self, value: str) -> str:
        """
        Handle common Android XML string escapes.
        Simplified: handles basic XML character entities.
        More complex Android-specific formats (like placeholders) are passed through.
        """
        if not value:
            return "" # Return empty string for None or empty input
            
        # Basic XML unescaping. Note: ET.fromstring already handles standard XML entities.
        # However, Android string values might contain them literally if not put in CDATA.
        # For strings extracted via .text, ET usually resolves entities.
        # This explicit replacement is more for text that might be constructed or from attributes.
        # Let's assume .text gives resolved entities, but be cautious with quotes/apostrophes
        # if they are not standard XML entities e.g. &apos; might need specific handling if not resolved.
        # The original parser did this, so retaining some form of it.
        
        # Standard entities like &lt;, &gt;, &amp; are typically handled by the XML parser.
        # &apos; and &quot; might need explicit handling depending on how text is obtained
        # and whether it's from an attribute or text content.
        # string_elem.text should provide the text content with entities resolved.
        # The main things to worry about are @string/ and ?android: style references,
        # and potentially \', \", \n, \t if they are not standard XML escapes.
        # For now, the provided replacements are kept, but their necessity might be reduced
        # due to ET's own processing.

        # Simplified: focus on what's explicitly mentioned and common.
        # The problem statement asks to preserve core logic.
        temp_value = value.replace("\\'", "'").replace('\\"', '"') # Handle \' and \"
        temp_value = temp_value.replace("\\n", "\n").replace("\\t", "\t") # Handle \n and \t

        # The example shows HTML escapes. ET.text should handle these.
        # If they are double-escaped (e.g. &amp;lt;), then one round of unescaping is needed.
        # For simplicity, and aligning with `string_elem.text` behavior,
        # we assume standard entities are resolved by ET.fromstring.
        # The custom list from original code for HTML entities:
        temp_value = temp_value.replace("&lt;", "<") \
                    .replace("&gt;", ">") \
                    .replace("&amp;", "&") \
                    .replace("&apos;", "'") \
                    .replace("&quot;", '"')
        # Other placeholders like %1$s are part of the string value and should be kept.
        return temp_value
        
    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature
        translations: Dict[str, str] = {}
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            root = ET.fromstring(content)
            
            # Process regular <string> elements only, as per Dict[str, str] requirement
            for string_elem in root.findall('.//string'):
                key = string_elem.get('name')
                if not key:
                    # Skip string elements without a 'name' attribute
                    continue
                        
                # Handle 'translatable' attribute
                translatable = string_elem.get('translatable', 'true').lower()
                if translatable == 'false':
                    # Skip non-translatable strings
                    continue
                        
                value_text = "" # Default to empty string
                if string_elem.text is not None:
                    value_text = self._parse_android_escapes(string_elem.text)
                
                translations[str(key)] = str(value_text) # Ensure string types
            
            # Plurals and string-arrays are ignored to fit Dict[str, str]
            return translations
            
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except ET.ParseError as e:
            raise ParsingError(f"Invalid Android XML syntax: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors
            raise ParsingError(f"An unexpected error occurred during Android XML parsing: {e}", filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.xml'] # Android resource files are .xml
