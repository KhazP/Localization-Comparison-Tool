import xml.etree.ElementTree as ET
import logging

def parse_xml_file(content: str, trim_whitespace: bool = False) -> dict:
    """
    Parses XML content and extracts key-value pairs from <string> elements.
    Only the 'name' attribute and text content are used.
    Unsupported tags/attributes are ignored.
    """
    translations = {}
    try:
        root = ET.fromstring(content)
        # Iterate over all <string> elements anywhere in the XML
        for elem in root.findall('.//string'):
            key = elem.get('name')
            if key:
                key = key.strip() if trim_whitespace else key
                value = elem.text.strip() if (elem.text and trim_whitespace) else (elem.text or '')
                translations[key] = value
    except ET.ParseError as e:
        logging.error(f"XML parse error: {str(e)}")
    return translations
