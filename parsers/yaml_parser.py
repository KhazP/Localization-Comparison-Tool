from .base_parser import BaseParser
from ..core.errors import ParsingError
from typing import Dict, List

try:
    import yaml
    from yaml.error import YAMLError
except ImportError:
    yaml = None # Keep this for the check

class YamlParser(BaseParser): # Changed class name and parent
    def parse(self, file_path: str) -> Dict[str, str]: # Changed signature
        if not yaml:
            # This indicates a setup issue, but ParsingError is used as the file can't be parsed
            raise ParsingError("PyYAML is not installed. Please install it to parse YAML files.", filepath=file_path)
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f)
            
            if data is None: # Handle empty YAML file
                return {}
            if not isinstance(data, dict):
                raise ParsingError(f"YAML root must be an object (dictionary).", filepath=file_path)
            
            # Ensure all keys and values are strings
            return {str(k): str(v) for k, v in data.items()}
        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except YAMLError as e:
            raise ParsingError(f"Invalid YAML syntax: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors
            raise ParsingError(f"An unexpected error occurred during YAML parsing: {e}", filepath=file_path, original_exception=e)

    def get_supported_extensions(self) -> List[str]:
        return ['.yaml', '.yml']
