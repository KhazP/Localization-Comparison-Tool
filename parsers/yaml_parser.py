import logging
try:
    import yaml
    from yaml.error import YAMLError
except ImportError:
    yaml = None

from .base_parser import TranslationParser

class YAMLParser(TranslationParser):
    def parse(self, content: str) -> dict:
        if not yaml:
            raise ImportError("PyYAML is not installed.")
        try:
            data = yaml.safe_load(content)
            if data is None:
                logging.warning("YAML parser returned None, defaulting to empty dict")
                return {}
            if not isinstance(data, dict):
                logging.error(f"YAML content is not a dictionary, got {type(data)}")
                return {}
            return data
        except YAMLError as e:
            logging.error(f"YAML parse error: {str(e)}")
            raise ValueError(f"Invalid YAML content: {e}")
