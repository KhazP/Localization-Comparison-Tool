import pytest
import json
import yaml
from parsers.json_parser import JSONParser
from parsers.yaml_parser import YAMLParser
from parsers.lang_parser import LangParser
from parsers.android_xml_parser import AndroidXMLParser
from core.parsing_result import ParsingResult

# JSON Parser Tests
def test_json_parser_valid():
    parser = JSONParser()
    content = '{"key": "value", "nested": {"inner": "data"}}'
    result = parser.parse(content)
    assert result == {"key": "value", "nested": {"inner": "data"}}

def test_json_parser_invalid():
    parser = JSONParser()
    with pytest.raises(ValueError):
        parser.parse('{"broken": "json"')

# YAML Parser Tests
def test_yaml_parser_valid():
    parser = YAMLParser()
    content = """
    key: value
    nested:
      inner: data
    """
    result = parser.parse(content)
    assert result == {"key": "value", "nested": {"inner": "data"}}

def test_yaml_parser_empty():
    parser = YAMLParser()
    result = parser.parse("")
    assert result == {}

def test_yaml_parser_invalid():
    parser = YAMLParser()
    with pytest.raises(ValueError):
        parser.parse("invalid: yaml: : content")

# Lang Parser Tests
def test_lang_parser_basic():
    parser = LangParser()
    content = "key=value\nother.key=other value"
    result = parser.parse(content)
    assert result == {"key": "value", "other.key": "other value"}

def test_lang_parser_with_comments():
    parser = LangParser()
    content = """
    # This is a comment
    key=value
    # Another comment
    other.key=other value
    """
    result = parser.parse(content)
    assert result == {"key": "value", "other.key": "other value"}

def test_lang_parser_empty_lines():
    parser = LangParser()
    content = """
    
    key=value
    
    other.key=other value
    
    """
    result = parser.parse(content)
    assert result == {"key": "value", "other.key": "other value"}

def test_lang_parser_whitespace_handling():
    parser = LangParser(trim_whitespace=True)
    content = "  key  =  value  \n  other.key  =  other value  "
    result = parser.parse(content)
    assert result == {"key": "value", "other.key": "other value"}

def test_lang_parser_no_trim():
    parser = LangParser(trim_whitespace=False)
    content = "  key  =  value  "
    result = parser.parse(content)
    assert result == {"  key  ": "  value  "}

# Android XML Parser Tests
def test_android_xml_parser_duplicate_keys():
    """
    Tests AndroidXMLParser's handling of duplicate keys for strings, plurals, and string-arrays.
    """
    parser = AndroidXMLParser()
    xml_content = """<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Strings -->
    <string name="app_name">My App</string>
    <string name="app_name">My App V2</string> <!-- Duplicate -->
    <string name="unique_string">Unique Value</string>

    <!-- Plurals -->
    <plurals name="item_count">
        <item quantity="one">1 item</item>
        <item quantity="other">%d items</item>
    </plurals>
    <plurals name="item_count"> <!-- Duplicate -->
        <item quantity="one">One item</item>
        <item quantity="other">Many items</item>
    </plurals>
    <plurals name="unique_plural">
        <item quantity="one">1 unique plural</item>
        <item quantity="other">%d unique plurals</item>
    </plurals>

    <!-- String Arrays -->
    <string-array name="options_menu">
        <item>Settings</item>
        <item>Help</item>
    </string-array>
    <string-array name="options_menu"> <!-- Duplicate -->
        <item>Profile</item>
        <item>Logout</item>
    </string-array>
    <string-array name="unique_array">
        <item>Unique Item 1</item>
        <item>Unique Item 2</item>
    </string-array>
</resources>
    """
    result: ParsingResult = parser.parse(xml_content)

    # Assertions for Translations (Strings)
    assert "app_name" in result.translations
    assert result.translations["app_name"] == "My App"
    assert "app_name_1" in result.translations
    assert result.translations["app_name_1"] == "My App V2"
    assert "unique_string" in result.translations
    assert result.translations["unique_string"] == "Unique Value"

    # Assertions for Metadata (Plurals)
    assert result.metadata is not None
    assert "plurals" in result.metadata
    plurals_data = result.metadata["plurals"]

    assert "item_count" in plurals_data
    assert plurals_data["item_count"] == {"one": "1 item", "other": "%d items"}
    assert "item_count_1" in plurals_data
    assert plurals_data["item_count_1"] == {"one": "One item", "other": "Many items"}
    assert "unique_plural" in plurals_data
    assert plurals_data["unique_plural"] == {"one": "1 unique plural", "other": "%d unique plurals"}

    # Assertions for Metadata (String Arrays)
    assert "string_arrays" in result.metadata
    string_arrays_data = result.metadata["string_arrays"]

    assert "options_menu" in string_arrays_data
    assert string_arrays_data["options_menu"] == ["Settings", "Help"]
    assert "options_menu_1" in string_arrays_data
    assert string_arrays_data["options_menu_1"] == ["Profile", "Logout"]
    assert "unique_array" in string_arrays_data
    assert string_arrays_data["unique_array"] == ["Unique Item 1", "Unique Item 2"]

    # Assertions for Errors/Warnings
    assert result.errors is not None
    assert len(result.errors) == 3 # Expecting 3 warnings for the 3 duplicate keys

    # Check for specific warning messages (content may vary slightly based on approx. item number)
    # We'll check for the core part of the message.
    app_name_warning_found = any("Duplicate string key 'app_name' found" in error and "Renamed to 'app_name_1'" in error for error in result.errors)
    item_count_warning_found = any("Duplicate plurals key 'item_count' found" in error and "Renamed to 'item_count_1'" in error for error in result.errors)
    options_menu_warning_found = any("Duplicate string-array key 'options_menu' found" in error and "Renamed to 'options_menu_1'" in error for error in result.errors)

    assert app_name_warning_found, "Warning for app_name duplication not found."
    assert item_count_warning_found, "Warning for item_count duplication not found."
    assert options_menu_warning_found, "Warning for options_menu duplication not found."

    # Assertions for Line Numbers
    assert result.line_numbers is not None
    # String line numbers (exact numbers depend on XML structure and parser's counting)
    assert "app_name" in result.line_numbers
    assert "app_name_1" in result.line_numbers
    assert "unique_string" in result.line_numbers

    # Plurals line numbers
    assert "plurals_item_count" in result.line_numbers
    assert "plurals_item_count_1" in result.line_numbers
    assert "plurals_unique_plural" in result.line_numbers

    # String-array line numbers
    assert "string-array_options_menu" in result.line_numbers
    assert "string-array_options_menu_1" in result.line_numbers
    assert "string-array_unique_array" in result.line_numbers