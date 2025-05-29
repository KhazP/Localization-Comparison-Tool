import re
from typing import Dict, List, Tuple # Added List
from .base_parser import BaseParser
from ..core.errors import ParsingError # Corrected import path

class PropertiesParser(BaseParser): # Inherit from BaseParser
    """Parser for Java Properties files."""
    
    def __init__(self, trim_whitespace: bool = True, handle_escapes: bool = True):
        self.trim_whitespace = trim_whitespace
        self.handle_escapes = handle_escapes
        
    def _unescape(self, value: str) -> str:
        """
        Handle Java properties escape sequences.
        
        Args:
            value: The string to unescape
            
        Returns:
            Unescaped string
        """
        if not self.handle_escapes:
            return value
            
        escapes = {
            '\\n': '\n',
            '\\r': '\r',
            '\\t': '\t',
            '\\f': '\f',
            '\\\\': '\\',
            '\\ ': ' ',
            '\\:': ':',
            '\\=': '=',
            '\\#': '#',
            '\\!': '!'
        }
        
        result = []
        i = 0
        while i < len(value):
            if value[i:i+2] in escapes:
                result.append(escapes[value[i:i+2]])
                i += 2
            elif value[i] == '\\' and value[i+1:i+6].isdigit():
                # Handle Unicode escapes \uXXXX
                try:
                    unicode_char = chr(int(value[i+2:i+6], 16))
                    result.append(unicode_char)
                    i += 6
                except (ValueError, IndexError):
                    result.append(value[i])
                    i += 1
            else:
                result.append(value[i])
                i += 1
                
        return ''.join(result)
        
    def _parse_line(self, line: str, line_number: int) -> Tuple[str, str]:
        """
        Parse a single line of properties file.
        
        Args:
            line: The line to parse
            line_number: Current line number for error reporting
            
        Returns:
            Tuple of (key, value) if valid, else (None, None)
        """
        # Skip empty lines and comments
        line = line.strip() if self.trim_whitespace else line
        if not line or line.startswith(('#', '!')):
            return None, None
            
        # Handle multi-line values with backslash
        if line.endswith('\\'):
            return None, None  # Handled in main parse loop
            
        # Find key-value separator (first '=' or ':' not escaped)
        separators = ['=', ':']
        for i, char in enumerate(line):
            if char in separators and (i == 0 or line[i-1] != '\\'):
                key = line[:i]
                value = line[i+1:]
                
                if self.trim_whitespace:
                    key = key.strip()
                    value = value.strip()
                    
                if not key:
                    logging.warning(f"Empty key found at line {line_number}")
                    return None, None
                    
                if self.handle_escapes:
                    value = self._unescape(value)
                    
                return key, value
                
        logging.warning(f"No key-value separator found at line {line_number}")
        return None, None
        
    def parse(self, content: str) -> dict:
        """
        Parse Java Properties content into a dictionary.
        
        Args:
            content: String content of the properties file
            
        Returns:
            Dictionary with translations and line numbers
            
        Raises:
            ValueError: If content cannot be parsed
        """
        translations = {}
        line_numbers = {}
        
        try:
            lines = content.splitlines()
            current_key = None
            current_value = []
            
            for i, line in enumerate(lines, 1):
                if current_key:
                    # Continue previous multi-line value
                    line = line.strip() if self.trim_whitespace else line
                    if line.endswith('\\'):
                        current_value.append(line[:-1])
                        continue
                    else:
                        current_value.append(line)
                        value = ''.join(current_value)
                        if self.handle_escapes:
                            value = self._unescape(value)
                        translations[current_key] = value
                        line_numbers[current_key] = i - len(current_value) + 1
                        current_key = None
                        current_value = []
                        continue
                        
                # Regular line processing
                if line.strip().endswith('\\'):
                    # Start of multi-line value
                    try:
                        key, start_value = self._parse_line(line[:-1], i)
                        if key:
                            current_key = key
                            current_value = [start_value or '']
                    except Exception as e:
                        logging.error(f"Error parsing line {i}: {str(e)}")
                else:
                    # Single line key-value
                    key, value = self._parse_line(line, i)
                    if key:
                        translations[key] = value
                        line_numbers[key] = i

            return {
                "translations": translations,
                "line_numbers": line_numbers
            }
            
        except Exception as e:
            error_msg = f"Failed to parse properties content: {str(e)}"
            logging.error(error_msg)
            raise ValueError(error_msg)
