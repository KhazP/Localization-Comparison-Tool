import pytest
import os
from parsers.json_parser import JsonParser # Assuming 'parsers' is discoverable
from core.errors import ParsingError     # Assuming 'core' is discoverable
from typing import Dict

@pytest.fixture
def parser():
    return JsonParser()

@pytest.fixture
def create_file(tmp_path):
    def _create_file(dir_name, file_name, content, encoding='utf-8'):
        # dir_name is relative to tmp_path
        file_dir = tmp_path / dir_name
        file_dir.mkdir(parents=True, exist_ok=True)
        file_path = file_dir / file_name
        with open(file_path, 'w', encoding=encoding) as f:
            f.write(content)
        return file_path
    return _create_file

def test_parse_valid_json(parser: JsonParser, create_file):
    content = '{"key1": "value1", "key2": "value2", "number_key": 123, "bool_key": true, "nested": {"n_key": "n_val"}}'
    # Using tmp_path provided by pytest for temporary file creation
    file_path = create_file("json_parser_test_files", "valid.json", content)
    
    expected_output = {
        "key1": "value1",
        "key2": "value2",
        "number_key": "123", # Values are stringified
        "bool_key": "True",   # Booleans are stringified
        "nested": "{'n_key': 'n_val'}" # Nested objects are stringified by default by the parser's {str(k): str(v)}
    }
    result = parser.parse(str(file_path))
    assert result == expected_output

def test_parse_empty_object_json(parser: JsonParser, create_file):
    file_path = create_file("json_parser_test_files", "empty_object.json", '{}')
    assert parser.parse(str(file_path)) == {}

def test_parse_malformed_json(parser: JsonParser, create_file):
    content = '{"key1": "value1", "key2": "value2"' # Missing comma and brace
    file_path = create_file("json_parser_test_files", "malformed.json", content)
    
    with pytest.raises(ParsingError) as excinfo:
        parser.parse(str(file_path))
    assert "Invalid JSON syntax" in str(excinfo.value)
    assert str(file_path) in str(excinfo.value)

def test_parse_json_not_an_object(parser: JsonParser, create_file):
    file_path = create_file("json_parser_test_files", "not_an_object.json", '["value1", "value2"]')
    
    with pytest.raises(ParsingError) as excinfo:
        parser.parse(str(file_path))
    assert "JSON root must be an object (dictionary)" in str(excinfo.value)
    assert str(file_path) in str(excinfo.value)

def test_parse_empty_file(parser: JsonParser, create_file):
    file_path = create_file("json_parser_test_files", "empty_file.json", '')
    
    with pytest.raises(ParsingError) as excinfo:
        parser.parse(str(file_path))
    # json.load or json.loads raises JSONDecodeError for empty string
    assert "Invalid JSON syntax" in str(excinfo.value) 
    assert str(file_path) in str(excinfo.value)

def test_parse_file_not_found(parser: JsonParser, tmp_path):
    # Create a path that doesn't exist within tmp_path for a more realistic test
    non_existent_file = tmp_path / "non_existent_dir" / "non_existent_file.json"
    # Ensure the directory also doesn't exist, or make file non-existent in an existing dir
    # For this test, os.path.join is fine if not using tmp_path, but with tmp_path, direct construction is better.
    # non_existent_file = "non_existent_file.json" # This would be relative to CWD
    
    with pytest.raises(ParsingError) as excinfo:
        parser.parse(str(non_existent_file))
    assert "File not found" in str(excinfo.value)
    assert str(non_existent_file) in str(excinfo.value)

def test_parse_valid_utf8_json(parser: JsonParser, create_file):
    content = '{"greeting": "Hello, 世界", "你好": "value"}'
    file_path = create_file("json_parser_test_files", "valid_utf8.json", content, encoding='utf-8')
    
    expected_output = {"greeting": "Hello, 世界", "你好": "value"}
    result = parser.parse(str(file_path))
    assert result == expected_output

def test_get_supported_extensions(parser: JsonParser):
    assert parser.get_supported_extensions() == ['.json']
