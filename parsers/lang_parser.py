from .base_parser import BaseParser
from ..core.errors import ParsingError # Assuming ..core.errors is correct
from typing import Dict, List

class LangParser(BaseParser): # Inherit from BaseParser
    def __init__(self, trim_whitespace: bool = True, comment_char: str = '#'):
        self.trim_whitespace = trim_whitespace
        self.comment_char = comment_char

    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature
        translations: Dict[str, str] = {}
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                for line_number, line_content in enumerate(f, 1):
                    processed_line = line_content.strip() if self.trim_whitespace else line_content.rstrip('\r\n')
                    
                    if not processed_line or processed_line.startswith(self.comment_char):
                        continue
                        
                    if '=' in processed_line:
                        key, value = processed_line.split('=', 1)
                        if self.trim_whitespace:
                            key = key.strip()
                            value = value.strip()
                        
                        if key:  # Only add if key is not empty
                            translations[str(key)] = str(value) # Ensure string types
                        # else:
                            # Optionally, log or raise error for empty key after strip
                            # For now, silently ignore as per original logic (empty key not added)
                    # else:
                        # Line without '=', optionally log or raise error
                        # For now, silently ignore as per original logic
                            
            return translations
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except Exception as e: # Catch other potential errors during file processing or parsing
            raise ParsingError(f"An error occurred during .lang file parsing: {e}", 
                               filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.lang']
