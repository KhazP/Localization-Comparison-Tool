import json
import logging
from .base_parser import TranslationParser

class JSONParser(TranslationParser):
    def parse(self, content: str) -> dict:
        try:
            return json.loads(content)
        except json.JSONDecodeError as e:
            logging.error(f"JSON parse error: {str(e)}")
            raise ValueError(f"Invalid JSON content: {e}")
