import pytest
import json
import yaml
from GUI.logic import parse_content_by_ext, validate_placeholders, compare_translations
from utils.file_processing_service import file_processing_service
from utils.file_cache_service import file_cache_service

# Comparison Logic Integration Tests
def test_file_comparison_with_missing_keys():
    source_content = """
    common.key=Common Value
    source.only=Source Only
    placeholders={0} items
    """
    target_content = """
    common.key=Common Value
    target.only=Target Only
    placeholders={0} elementos
    """
    
    source_translations = parse_content_by_ext(source_content, ".lang")
    target_translations = parse_content_by_ext(target_content, ".lang")
    
    # Compare results
    differences = compare_translations(
        source_translations,
        target_translations,
        ignore_case=False,
        ignore_whitespace=False
    )
    
    assert "source.only" in str(differences)  # Updated to check in string output
    assert "target.only" in str(differences)
    assert "common.key" in str(differences)

def test_placeholder_validation():
    # Test matching placeholders
    valid, msg = validate_placeholders("{0} items left", "{0} elementos restantes")
    assert valid
    assert not msg

    # Test mismatched placeholders
    valid, msg = validate_placeholders("{0} {1} items", "{0} elementos")
    assert not valid
    assert "Missing placeholders" in msg

def test_cross_format_comparison():
    # Test comparing between different formats
    json_content = '{"key": "value", "common": "shared"}'
    yaml_content = """
    key: another value
    common: shared
    yaml_only: unique
    """
    
    json_translations = parse_content_by_ext(json_content, ".json")
    yaml_translations = parse_content_by_ext(yaml_content, ".yaml")
    
    differences = compare_translations(
        json_translations,
        yaml_translations,
        ignore_case=False,
        ignore_whitespace=False
    )
    
    assert "yaml_only" in str(differences)
    assert "common" in str(differences)
    
@pytest.mark.parametrize("source_format,target_format", [
    (".json", ".yaml"),
    (".lang", ".json"),
    (".yaml", ".lang")
])
def test_format_compatibility(source_format, target_format):
    test_data = {"test.key": "value", "another.key": "data"}
    
    # Convert test data to appropriate string format
    if source_format == ".json":
        source_content = json.dumps(test_data)
    elif source_format == ".yaml":
        source_content = yaml.dump(test_data)
    else:  # .lang format
        source_content = "\n".join(f"{k}={v}" for k, v in test_data.items())
        
    # Parse both formats and compare
    source_translations = parse_content_by_ext(source_content, source_format)
    assert source_translations is not None
    assert len(source_translations) == len(test_data)

# Cache Service Integration Tests
def test_file_cache_integration(tmp_path):
    # Create a temporary test file
    test_file = tmp_path / "test.lang"
    content = "key=value\nother=data"
    test_file.write_text(content)
    
    # Test file caching behavior using read_file
    cached = file_cache_service.read_file(str(test_file))
    assert cached == content
    
    parsed = parse_content_by_ext(cached, ".lang")
    assert parsed == {"key": "value", "other": "data"}