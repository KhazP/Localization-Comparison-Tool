import xml.etree.ElementTree as ET  # Import XML parser

def parse_xml_file(content: str, trim_whitespace: bool = False) -> dict:
    """Parses XML content and returns a dictionary of translations."""
    translations = {}
    try:
        root = ET.fromstring(content)
        # Try wildcard namespace first, then fall back to plain search
        strings = root.findall('.//{*}string')
        if not strings:
            strings = root.findall('.//string')
        for string_elem in strings:
            key = string_elem.get('name')
            value = string_elem.text if string_elem.text is not None else ""
            if key is not None:
                if trim_whitespace:
                    key = key.strip()
                    value = value.strip()
                translations[key] = value
    except ET.ParseError as e:
        print(f"Error parsing XML: {e}")
    return translations
# ...existing code...
