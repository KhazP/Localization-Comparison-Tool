import xml.etree.ElementTree as ET
import logging

def _parse_xml(content: str, trim_whitespace: bool = False) -> dict:
    """Helper: Parse XML portions extracting <string> elements."""
    translations = {}
    try:
        root = ET.fromstring(content)
        for elem in root.findall('.//string'):
            key = elem.get('name')
            if key:
                key = key.strip() if trim_whitespace else key
                value = (elem.text.strip() if elem.text and trim_whitespace else (elem.text or ''))
                translations[key] = value
    except ET.ParseError as e:
        logging.error(f"XML parse error in mixed file: {str(e)}")
    return translations

def _parse_key_value(content: str, trim_whitespace: bool = False) -> dict:
    """Helper: Parse key=value lines while skipping XML lines."""
    translations = {}
    for line in content.splitlines():
        line = line.strip()
        if not line or line.startswith("<"):
            continue
        if '=' in line:
            try:
                key, value = line.split("=", 1)
                if trim_whitespace:
                    key = key.strip()
                    value = value.strip()
                translations[key] = value
            except ValueError:
                continue
    return translations

def parse_mixed_file(content: str, trim_whitespace: bool = False) -> dict:
    """
    Parses a file containing both key-value pairs and XML strings.
    It extracts XML key-value pairs from <string> elements and also
    processes plain key=value lines, merging the results.
    """
    xml_translations = {}
    kv_translations = {}
    
    # If XML markers exist, try to parse the entire content as XML.
    if "<string" in content:
        xml_translations = _parse_xml(content, trim_whitespace)
    
    # Extract key=value pairs from the remaining text.
    kv_translations = _parse_key_value(content, trim_whitespace)
    
    # Merge both; XML entries take precedence.
    merged = kv_translations.copy()
    merged.update(xml_translations)
    return merged
