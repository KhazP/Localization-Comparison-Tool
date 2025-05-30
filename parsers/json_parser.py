import json
import logging
from .base_parser import TranslationParser
from typing import Dict # Keep this for internal type hints if any
from core.parsing_result import ParsingResult # Import the new class

class JSONParser(TranslationParser):
    def parse(self, content: str) -> ParsingResult: # Update return type annotation
        try:
            parsed_json = json.loads(content)
            if not isinstance(parsed_json, dict):
                logging.error("JSON content is not a dictionary.")
                # Return an empty ParsingResult with an error message
                return ParsingResult(translations={}, errors=["JSON content is not a dictionary."])

            # Assuming the JSON directly represents translations
            # If keys are not strings, they should be converted or handled appropriately.
            # For now, we assume string keys as per Dict[str, str] for translations.
            translations: Dict[str, str] = {}
            for key, value in parsed_json.items():
                if isinstance(value, str):
                    translations[str(key)] = value
                else:
                    # Convert non-string values to string, or log/error
                    translations[str(key)] = json.dumps(value) # Example: serialize non-string values
                    logging.debug(f"Value for key '{key}' was not a string, serialized to JSON string.")

            return ParsingResult(translations=translations)
        except json.JSONDecodeError as e:
            logging.error(f"JSON parse error: {str(e)}")
            # Return an empty ParsingResult with the error message
            return ParsingResult(translations={}, errors=[f"Invalid JSON content: {e}"])
        except Exception as e: # Catch any other unexpected errors
            logging.error(f"Unexpected error in JSONParser: {str(e)}")
            return ParsingResult(translations={}, errors=[f"Unexpected error: {e}"])
