import logging
from .base_parser import TranslationParser

class LangParser(TranslationParser):
    def __init__(self, trim_whitespace: bool = True, comment_char: str = '#'):
        self.trim_whitespace = trim_whitespace
        self.comment_char = comment_char

    def parse(self, content: str) -> dict:
        translations = {}
        
        try:
            for line in content.splitlines():
                # Skip empty lines and comments
                line = line.strip() if self.trim_whitespace else line
                if not line or line.startswith(self.comment_char):
                    continue
                    
                # Parse key=value
                if '=' in line:
                    key, value = line.split('=', 1)
                    if self.trim_whitespace:
                        key = key.strip()
                        value = value.strip()
                    if key:  # Only add if key is not empty
                        translations[key] = value
                else:
                    logging.debug(f"Skipping invalid line: {line}")
                    
            return translations
            
        except Exception as e:
            logging.error(f"Lang parse error: {str(e)}")
            raise ValueError(f"Invalid .lang content: {e}")
