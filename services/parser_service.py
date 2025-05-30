import logging
import os
from typing import Dict, Optional, Any, Type, List

from core.parsing_result import ParsingResult
from parsers.base_parser import TranslationParser
from parsers.json_parser import JSONParser
from parsers.yaml_parser import YAMLParser
from parsers.lang_parser import LangParser
from parsers.xml_parser import XMLParser # Generic XML
from parsers.csv_parser import CSVParser
from parsers.properties_parser import PropertiesParser
from parsers.android_xml_parser import AndroidXMLParser
from parsers.angular_json_parser import AngularJSONParser # For .angular.json etc.
from parsers.resx_parser import RESXParser
from parsers.xliff_parser import XLIFFParser
# Import MixedParser if it's to be integrated here
# from MixedParser.mixed_parser import parse_mixed_file # Assuming this is its interface
import csv # Added for CSVParser default config

logger = logging.getLogger(__name__)

class ParserService:
    """
    Service for selecting and invoking the correct file parser based on file type.
    """
    def __init__(self):
        self._parser_registry: Dict[str, Type[TranslationParser]] = {}
        self._register_default_parsers()

    def _register_default_parsers(self):
        """Registers the built-in parsers."""
        self.register_parser(".json", JSONParser)
        self.register_parser(".yaml", YAMLParser)
        self.register_parser(".yml", YAMLParser) # YAML can have .yml
        self.register_parser(".lang", LangParser)
        self.register_parser(".xml", AndroidXMLParser) # Default .xml to AndroidXML, can be refined
        self.register_parser(".csv", CSVParser)
        self.register_parser(".properties", PropertiesParser)
        self.register_parser(".resx", RESXParser)
        self.register_parser(".xlf", XLIFFParser) # .xlf is a common XLIFF extension
        self.register_parser(".xliff", XLIFFParser)

        # Specific JSON formats - order might matter if extensions overlap
        # e.g. if .json could be generic or angular.
        # For now, AngularJSONParser would need a more specific extension
        # or a config hint to be chosen over the generic JSONParser.
        # Let's assume a distinct extension for now or it's handled by config.
        self.register_parser(".ng.json", AngularJSONParser) # Example for distinct Angular JSON

    def register_parser(self, extension: str, parser_class: Type[TranslationParser]):
        """
        Registers a parser for a given file extension.
        Args:
            extension: The file extension (e.g., ".json").
            parser_class: The class of the parser.
        """
        normalized_ext = extension.lower()
        if normalized_ext in self._parser_registry:
            logger.warning(
                f"Parser for extension '{normalized_ext}' is being overridden "
                f"from {self._parser_registry[normalized_ext].__name__} to {parser_class.__name__}."
            )
        self._parser_registry[normalized_ext] = parser_class
        logger.info(f"Registered {parser_class.__name__} for '{normalized_ext}'.")

    def get_supported_formats(self) -> List[str]:
        """Returns a list of currently supported file extensions."""
        return sorted(list(self._parser_registry.keys()))

    def parse_file_content(self,
                           content: str,
                           file_extension: str,
                           parser_config: Optional[Dict[str, Any]] = None) -> ParsingResult:
        """
        Parses file content using the appropriate parser based on the file extension.

        Args:
            content: The string content of the file.
            file_extension: The file extension (e.g., ".json", ".xml").
            parser_config: Optional dictionary of configuration options specific to the parser.
                           (e.g., delimiter for CSV, flatten_nested for Angular JSON).

        Returns:
            A ParsingResult object.
        """
        normalized_ext = file_extension.lower()
        parser_class = self._parser_registry.get(normalized_ext)

        if not parser_class:
            msg = f"No parser registered for file extension '{normalized_ext}'."
            logger.error(msg)
            return ParsingResult(translations={}, errors=[msg])

        try:
            # Instantiate parser with config if provided
            # This requires parsers to accept **kwargs or specific args from parser_config
            # For now, let's assume parsers can be instantiated without args,
            # or specific config is passed to their parse method if they support it,
            # or they are instantiated with specific args from 'parser_config'.

            # Example: CSVParser takes delimiter, has_header etc. in __init__
            # LangParser takes trim_whitespace, comment_char in __init__
            # AngularJSONParser takes flatten_nested, separator in __init__
            # AndroidXMLParser takes preserve_comments in __init__
            # XLIFFParser takes source_lang, target_lang in __init__

            # A more robust way would be to inspect parser_class.__init__ signature
            # or have a convention. For now, pass relevant known configs.

            instance_config = parser_config or {}
            parser_instance: TranslationParser

            # This is a simplified way to pass config. A more complex system might involve
            # mapping keys in parser_config to specific __init__ args of the parser.
            if parser_class == CSVParser:
                parser_instance = CSVParser(
                    delimiter=instance_config.get('delimiter', ','),
                    has_header=instance_config.get('has_header', True),
                    key_column=instance_config.get('key_column', 'key'),
                    value_column=instance_config.get('value_column', 'value'),
                    quoting=instance_config.get('quoting', csv.QUOTE_MINIMAL)
                )
            elif parser_class == LangParser:
                parser_instance = LangParser(
                    trim_whitespace=instance_config.get('trim_whitespace', True),
                    comment_char=instance_config.get('comment_char', '#')
                )
            elif parser_class == AngularJSONParser:
                 parser_instance = AngularJSONParser(
                    flatten_nested=instance_config.get('flatten_nested', True),
                    separator=instance_config.get('separator', '.')
                )
            elif parser_class == AndroidXMLParser:
                parser_instance = AndroidXMLParser(
                    preserve_comments=instance_config.get('preserve_comments', False)
                )
            elif parser_class == XLIFFParser:
                parser_instance = XLIFFParser(
                    source_lang=instance_config.get('source_lang'),
                    target_lang=instance_config.get('target_lang')
                )
            elif parser_class == XMLParser:
                 parser_instance = XMLParser()
            else: # For JSON, YAML, Properties, RESX - they have simple or no-arg constructors
                parser_instance = parser_class()

            logger.info(f"Using {parser_class.__name__} for extension '{normalized_ext}'.")
            return parser_instance.parse(content)

        except ImportError as e:
            logger.error(f"Import error for parser {parser_class.__name__}: {e}")
            return ParsingResult(translations={}, errors=[f"Parser dependency missing: {e}"])
        except Exception as e:
            logger.error(f"Error instantiating or calling parser {parser_class.__name__} for extension '{normalized_ext}': {e}", exc_info=True)
            return ParsingResult(translations={}, errors=[f"Failed to use parser {parser_class.__name__}: {e}"])

# Example Usage (for testing purposes, not part of the class itself)
if __name__ == '__main__':
    # This block would require the script to be runnable, potentially adjusting imports
    # or being in the project's root for relative imports to work easily.

    logging.basicConfig(level=logging.INFO)

    service = ParserService()
    print("Supported formats:", service.get_supported_formats())

    json_content = '{"hello": "world", "test": "value"}'
    result = service.parse_file_content(json_content, ".json")
    if result: # __bool__ method in ParsingResult makes this check work
        print("JSON Parsed:", result.translations)
    if result.errors:
        print("JSON Errors:", result.errors)

    lang_content = "key1=value1\n#comment\nkey2 = value2"
    result = service.parse_file_content(lang_content, ".lang", parser_config={'trim_whitespace': True})
    if result:
        print("Lang Parsed:", result.translations)
    if result.errors:
        print("Lang Errors:", result.errors)

    result = service.parse_file_content("dummy content", ".foo")
    if result.errors:
        print("Foo Errors:", result.errors) # Expected: No parser registered...

    csv_content = "key,value\nname,Alice\nage,30"
    result = service.parse_file_content(csv_content, ".csv", parser_config={'has_header': True})
    if result:
        print("CSV Parsed:", result.translations)
        print("CSV Line Numbers:", result.line_numbers)
    if result.errors:
        print("CSV Errors:", result.errors)

    xml_content = '<resources><string name="app_name">My App</string><string name="hello">Hello</string></resources>'
    result = service.parse_file_content(xml_content, ".xml") # Uses AndroidXMLParser by default
    if result:
        print("XML (Android) Parsed:", result.translations)
    if result.errors:
        print("XML (Android) Errors:", result.errors)
