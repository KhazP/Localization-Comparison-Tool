import pytest
import json
import yaml
from parsers.json_parser import JSONParser
from parsers.yaml_parser import YAMLParser
from parsers.lang_parser import LangParser

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