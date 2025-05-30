import logging
try:
    import yaml
    from yaml.error import YAMLError
except ImportError:
    yaml = None # Keep this pattern

from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class
from typing import Dict # Keep for internal type hints

class YAMLParser(TranslationParser):
    def parse(self, content: str) -> ParsingResult: # Update return type annotation
        if not yaml:
            # This case should ideally be handled before calling parse,
            # e.g., by checking for yaml availability in a factory.
            # For now, return an error in ParsingResult.
            logging.error("PyYAML is not installed.")
            return ParsingResult(translations={}, errors=["PyYAML is not installed. This parser is unusable."])

        try:
            data = yaml.safe_load(content)

            if data is None:
                logging.warning("YAML parser returned None, defaulting to empty dict for translations.")
                return ParsingResult(translations={}) # No error, just empty

            if not isinstance(data, dict):
                logging.error(f"YAML content is not a dictionary, got {type(data)}")
                return ParsingResult(translations={}, errors=[f"YAML content is not a dictionary, got {type(data)}."])

            # Assuming the YAML directly represents translations with string keys and values
            translations: Dict[str, str] = {}
            for key, value in data.items():
                if isinstance(value, str):
                    translations[str(key)] = value
                else:
                    # Convert non-string values to string, or log/error
                    translations[str(key)] = str(value) # Simple string conversion
                    logging.debug(f"Value for key '{key}' was not a string ({type(value)}), converted to string.")

            return ParsingResult(translations=translations)

        except YAMLError as e:
            logging.error(f"YAML parse error: {str(e)}")
            return ParsingResult(translations={}, errors=[f"Invalid YAML content: {e}"])
        except Exception as e: # Catch any other unexpected errors
            logging.error(f"Unexpected error in YAMLParser: {str(e)}")
            return ParsingResult(translations={}, errors=[f"Unexpected error: {e}"])
