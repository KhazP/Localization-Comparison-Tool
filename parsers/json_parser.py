import json
from .base_parser import BaseParser
from ..core.errors import ParsingError
from typing import Dict, List

class JsonParser(BaseParser): # Changed class name and parent
    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            if not isinstance(data, dict):
                raise ParsingError(f"JSON root must be an object (dictionary).", filepath=file_path)
            # Ensure all keys and values are strings
            return {str(k): str(v) for k, v in data.items()}
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except json.JSONDecodeError as e:
            raise ParsingError(f"Invalid JSON syntax: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors
            raise ParsingError(f"An unexpected error occurred during JSON parsing: {e}", filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.json']
