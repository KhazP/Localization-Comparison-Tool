from .json_parser import JsonParser
from .yaml_parser import YamlParser
from .properties_parser import PropertiesParser
from .csv_parser import CsvParser
from .lang_parser import LangParser
from .resx_parser import ResxParser
from .xliff_parser import XliffParser
from .xml_parser import XmlParser
from .android_xml_parser import AndroidXmlParser
from .angular_json_parser import AngularJsonParser
from .base_parser import BaseParser

# For dynamic discovery
import inspect
import pkgutil
import os # For get_parser_for_file
from typing import Dict, Type, Optional # Optional for get_parser_for_file return type

# __all__ will be defined after the functions

# Existing parser classes (already imported above)
_EXPLICIT_PARSERS = {
    JsonParser,
    YamlParser,
    PropertiesParser,
    CsvParser,
    LangParser,
    ResxParser,
    XliffParser,
    XmlParser,
    AndroidXmlParser,
    AngularJsonParser,
}

def get_available_parsers() -> Dict[str, BaseParser]:
    """
    Discovers and instantiates all BaseParser subclasses
    defined in _EXPLICIT_PARSERS or found in the 'parsers' package.

    Returns:
        A dictionary mapping parser class names to parser instances.
    """
    parsers_map: Dict[str, BaseParser] = {}
    
    # Instantiate explicitly listed parsers
    for parser_class in _EXPLICIT_PARSERS:
        try:
            # Ensure it's a concrete class and a subclass of BaseParser
            if inspect.isclass(parser_class) and \
               issubclass(parser_class, BaseParser) and \
               parser_class is not BaseParser and \
               not inspect.isabstract(parser_class):
                parsers_map[parser_class.__name__] = parser_class()
        except Exception as e:
            print(f"Error instantiating explicitly listed parser {parser_class.__name__}: {e}")

    # Dynamic discovery part (optional if explicit list is comprehensive and preferred)
    # This part can be enabled if new parsers might be added without updating _EXPLICIT_PARSERS
    # For now, relying on the explicit list simplifies and ensures no unintended parsers are picked up.
    """
    # Iterate over all modules in the current package (parsers)
    # __path__ is a list of paths for the package, __name__ is the package name
    for importer, modname, ispkg in pkgutil.iter_modules(__path__, __name__ + '.'):
        if not ispkg: # Ensure it's a module, not a subpackage
            try:
                module = __import__(modname, fromlist='dummy') # Load module
                # Iterate over all members of the loaded module
                for name, obj in inspect.getmembers(module):
                    if inspect.isclass(obj) and \
                       issubclass(obj, BaseParser) and \
                       obj is not BaseParser and \
                       not inspect.isabstract(obj) and \
                       name not in parsers_map: # Avoid re-instantiating if already in explicit list
                        try:
                            parsers_map[name] = obj()
                        except Exception as e:
                            print(f"Error instantiating dynamically discovered parser {name}: {e}")
            except ImportError as e:
                print(f"Error importing module {modname} for dynamic parser discovery: {e}")
    """
    return parsers_map

def get_parser_for_file(file_path: str, available_parsers: Dict[str, BaseParser]) -> Optional[BaseParser]:
    """
    Finds a suitable parser for the given file based on its extension.

    Args:
        file_path: The path to the file.
        available_parsers: A dictionary of available parser instances.

    Returns:
        An instance of a suitable parser, or None if no parser is found.
    """
    _, extension = os.path.splitext(file_path)
    extension = extension.lower()

    if not extension:
        return None # Or raise an error, or handle files without extensions

    # Check for specific parser matches first (e.g. angular_json_parser for 'en.json' if needed)
    # This logic can be enhanced if simple extension matching is not enough.
    # For instance, AngularJsonParser and JsonParser both handle '.json'.
    # We might need a priority or more specific checks if that becomes an issue.
    # For now, the first parser found that supports the extension is returned.

    # Prioritize AndroidXmlParser for .xml if it's an Android XML (more specific)
    # This is tricky without inspecting file content. For now, relying on distinct extensions or
    # assuming the first match is acceptable. If `AndroidXmlParser` and `XmlParser` both claim `.xml`,
    # the one that appears first in `available_parsers.values()` (dict iteration order dependent in older Python)
    # or that is explicitly checked first would win.

    # A simple way to prioritize:
    # If multiple parsers support the same extension, this returns the first one encountered.
    # To make it deterministic or prioritized, sort or check in a specific order.
    # Example: Check AngularJsonParser first for .json, then generic JsonParser.
    if extension == '.json':
        # Example of prioritization:
        if "AngularJsonParser" in available_parsers and extension in available_parsers["AngularJsonParser"].get_supported_extensions():
            # Heuristic: if it's an angular json, its name might give a clue, or it's the default for all .json
            # This is where more sophisticated selection logic might be needed if just extension is not enough.
            # For now, let's assume AngularJsonParser is preferred for .json if available.
             pass # Fall through to general loop, or return it directly:
             # return available_parsers["AngularJsonParser"] 
        # if "JsonParser" in available_parsers and extension in available_parsers["JsonParser"].get_supported_extensions():
        #    return available_parsers["JsonParser"]
    
    # General case:
    for parser_instance in available_parsers.values():
        if extension in parser_instance.get_supported_extensions():
            return parser_instance
    return None

__all__ = [
    "BaseParser",
    "JsonParser",
    "YamlParser",
    "PropertiesParser",
    "CsvParser",
    "LangParser",
    "ResxParser",
    "XliffParser",
    "XmlParser",
    "AndroidXmlParser",
    "AngularJsonParser",
    "get_available_parsers", # Added new function
    "get_parser_for_file",   # Added new function
]
