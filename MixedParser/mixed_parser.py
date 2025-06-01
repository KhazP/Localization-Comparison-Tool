import xml.etree.ElementTree as ET
import logging
from typing import Dict, List # Added List for errors
from parsers.base_parser import TranslationParser # Import base class
from core.parsing_result import ParsingResult # Import ParsingResult

logger = logging.getLogger(__name__) # Use module-level logger

class MixedFileParser(TranslationParser):
    """
    Parses files containing a mix of key=value pairs and XML <string> elements.
    XML definitions take precedence in case of duplicate keys.
    """
    def __init__(self, trim_whitespace: bool = True): # Added trim_whitespace to constructor
        self.trim_whitespace = trim_whitespace

    def _parse_xml_part(self, content: str) -> tuple[Dict[str, str], List[str]]:
        """Helper: Parse XML portions extracting <string> elements."""
        translations: Dict[str, str] = {}
        errors: List[str] = []
        try:
            # Attempt to create a root element to handle fragments better
            # This is a simplified approach; robustly handling mixed content
            # often requires more sophisticated parsing or well-defined sections.
            # For now, we assume the XML parts are parsable, possibly within other text.
            # A common strategy for mixed files is to extract XML blocks first.
            # This parser tries to parse the whole content as XML if <string> is present.
            # This might fail if key-value pairs are not well-formed XML text.
            # A more robust mixed parser might need to identify XML sections vs KV sections.
            # For this version, we'll keep the original logic: try to parse whole content as XML.

            # Filter out non-XML lines before attempting to parse, to avoid ParseError on KV lines.
            # This is a heuristic. A true mixed parser might need a state machine.
            xml_lines = [line for line in content.splitlines() if line.strip().startswith("<")]
            if not xml_lines: # No XML lines found
                return translations, errors

            # Join only XML lines to form a potentially valid XML document (or fragment)
            xml_content_to_parse = "\n".join(xml_lines)

            # Wrap in a dummy root if it's a fragment
            if not xml_content_to_parse.strip().startswith("<resources") and not xml_content_to_parse.strip().startswith("<?xml"):
                xml_content_to_parse = f"<resources>{xml_content_to_parse}</resources>"

            root = ET.fromstring(xml_content_to_parse)
            for elem in root.findall('.//string'): # Find <string> anywhere
                key = elem.get('name')
                if key:
                    key = key.strip() if self.trim_whitespace else key
                    value = (elem.text.strip() if elem.text and self.trim_whitespace else (elem.text or ''))
                    translations[key] = value
        except ET.ParseError as e:
            msg = f"XML parse error in mixed content: {str(e)}. Some XML data might be lost."
            logger.warning(msg) # Log as warning, as KV pairs might still be parsed
            errors.append(msg)
        return translations, errors

    def _parse_kv_part(self, content: str) -> Dict[str, str]:
        """Helper: Parse key=value lines, attempting to skip XML-like lines."""
        translations: Dict[str, str] = {}
        for line_num, line_text in enumerate(content.splitlines(), 1):
            stripped_line = line_text.strip()

            # Skip empty lines and lines that look like XML tags or comments
            if not stripped_line or stripped_line.startswith("<") or \
               stripped_line.startswith("#") or stripped_line.startswith("!"): # Properties comment chars
                continue

            if '=' in stripped_line:
                try:
                    key, value = stripped_line.split("=", 1)
                    if self.trim_whitespace:
                        key = key.strip()
                        value = value.strip()

                    if not key: # Skip if key becomes empty after stripping
                        logger.debug(f"Skipping line {line_num} due to empty key in mixed content.")
                        continue

                    translations[key] = value
                except ValueError:
                    logger.debug(f"Skipping invalid key-value line {line_num} in mixed content: '{line_text[:50]}...'")
                    continue # Skip malformed lines
        return translations

    def parse(self, content: str) -> ParsingResult:
        """
        Parses a file containing both key-value pairs and XML strings.
        XML definitions take precedence in case of duplicate keys.
        """
        xml_translations: Dict[str, str] = {}
        parsing_errors: List[str] = []

        # Attempt to parse XML parts from the content
        # The _parse_xml_part now tries to be a bit smarter by only feeding XML-like lines
        # to the XML parser.
        if "<string" in content: # Heuristic: only try XML parsing if <string> tag is present
            xml_translations, xml_errors = self._parse_xml_part(content)
            parsing_errors.extend(xml_errors)

        # Parse key-value pairs from the entire content (it will skip XML lines)
        kv_translations = self._parse_kv_part(content)

        # Merge both; XML entries take precedence.
        # Key-value pairs are parsed first, then XML translations overwrite any common keys.
        merged_translations = kv_translations.copy()
        merged_translations.update(xml_translations) # XML takes precedence

        return ParsingResult(
            translations=merged_translations,
            errors=parsing_errors if parsing_errors else None
            # Line numbers are not reliably tracked in this mixed mode.
        )
