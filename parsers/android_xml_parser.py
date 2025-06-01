import logging
import xml.etree.ElementTree as ET
import re # Keep re
from typing import Dict, Optional, List, Any # Added List, Any
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class

logger = logging.getLogger(__name__)

class AndroidXMLParser(TranslationParser):
    """Parser for Android XML string resources."""
    
    def __init__(self, preserve_comments: bool = False): # preserve_comments currently not used
        self.preserve_comments = preserve_comments
        
    def _parse_android_text(self, element: Optional[ET.Element]) -> str:
        """
        Extracts and potentially unescapes text from an XML element.
        Handles simple text, and text within CDATA sections.
        Concatenates text from mixed content (text and child elements like <b>, <i>, <u>).
        Android XML often uses HTML-like tags for formatting.
        """
        if element is None:
            return ""

        text_parts = []
        if element.text:
            text_parts.append(element.text)
        
        for child in element:
            if child.tag == ET.Comment: # Skip comments if not preserving
                continue
            # CDATA sections are handled by ET.tostring if we serialize the whole element.
            # However, if we are manually reconstructing, we'd need to handle CDATA explicitly.
            # The current approach of serializing child elements directly simplifies this.

            # Re-serialize the child element to a string to capture its tags and content
            try:
                # method='xml' ensures it's well-formed XML fragment.
                # 'unicode' ensures we get a string, not bytes.
                child_xml_string = ET.tostring(child, encoding='unicode', method='xml')

                # ET.tostring might wrap the content if the child itself has no single root tag
                # for its direct content (e.g. child.text + subchildren + child.tail).
                # For Android <string> tags, this usually means getting the inner content with tags.
                # Example: <item>This is <b>bold</b></item> -> ET.tostring(child_b_tag) -> "<b>bold</b>"
                # We need to be careful if child_xml_string itself becomes a full <item>...</item> tag again.
                # This is not the case here as we iterate over children of <string> or <item>.

                text_parts.append(child_xml_string)
            except Exception as e:
                logger.warning(f"Could not serialize child element {child.tag}: {e}. Falling back to text content.")
                # Fallback: try to get text content if serialization fails
                child_text_content = ""
                if child.text:
                    child_text_content += child.text
                # Recursively get text from children of this child might be too much here,
                # as we are aiming to reconstruct the formatted string.
                # For now, if direct serialization fails, we take what text is available.
                text_parts.append(child_text_content)


            if child.tail: # Text immediately following the child tag
                text_parts.append(child.tail)

        full_text = "".join(text_parts).strip()

        # Standard XML/HTML entities are handled by ElementTree's parsing and serialization.
        # Android specific escapes like \' or \" are typically used in attributes, not text content.
        # If they appear in text, they are usually literal or HTML escaped (e.g. &apos; &quot;).
        # The ET.tostring method should preserve HTML entities correctly.

        return full_text

    def parse(self, content: str) -> ParsingResult:
        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {} # Approximate line numbers
        plurals: Dict[str, Dict[str, str]] = {}
        string_arrays: Dict[str, List[str]] = {}
        parsing_errors: List[str] = []
        parsing_warnings: List[str] = [] # New list for warnings
        metadata: Dict[str, Any] = {}

        try:
            # Basic sanitization for common invalid XML characters
            # Allow tab, newline, carriage return, and typical printable ASCII and beyond.
            # Excludes most C0 control characters except whitespace, and C1 controls.
            sanitized_content = re.sub(r'[^\x09\x0A\x0D\x20-\uD7FF\uE000-\uFFFD\U00010000-\U0010FFFF]', '', content)


            if not sanitized_content.strip():
                parsing_errors.append("XML content is empty or became empty after sanitization.")
                return ParsingResult(translations={}, errors=parsing_errors, warnings=parsing_warnings)

            root = ET.fromstring(sanitized_content)
            
            # Using enumerate with root.iter() provides an index, but not a direct line number.
            # Actual line numbers would require a different parsing strategy (e.g. SAX or line-by-line pre-processing).
            # For now, 'idx' serves as an order identifier.
            processed_elements_count = 0 # To give a rough idea of position for errors

            for element in root.iter():
                processed_elements_count += 1
                current_item_ref = f"approx. item {processed_elements_count}"

                if element.tag == 'string':
                    key = element.get('name')
                    if not key:
                        msg = f"Found <string> element without 'name' attribute ({current_item_ref})."
                        logger.warning(msg)
                        parsing_errors.append(msg)
                        continue
                        
                    translatable = element.get('translatable', 'true').lower()
                    if translatable == 'false':
                        logger.debug(f"Skipping non-translatable string '{key}'.")
                        continue
                    
                    value = self._parse_android_text(element)

                    original_key = key
                    counter = 1
                    while key in translations:
                        key = f"{original_key}_{counter}"
                        counter += 1

                    if key != original_key:
                        msg = f"Duplicate string key '{original_key}' found ({current_item_ref}). Renamed to '{key}'."
                        logger.warning(msg)
                        parsing_warnings.append(msg) # Add to warnings

                    translations[key] = value
                    line_numbers[key] = processed_elements_count # Approximate order/pseudo-line number
                        
                elif element.tag == 'plurals':
                    key = element.get('name')
                    if not key:
                        msg = f"Found <plurals> element without 'name' attribute ({current_item_ref})."
                        logger.warning(msg)
                        parsing_errors.append(msg)
                        continue

                    current_plurals: Dict[str, str] = {}
                    for item_elem in element.findall('item'):
                        quantity = item_elem.get('quantity')
                        item_value = self._parse_android_text(item_elem) # Use the same text parsing logic
                        if quantity:
                            current_plurals[quantity] = item_value
                        else:
                            msg = f"Plural item for key '{key}' is missing 'quantity' attribute ({current_item_ref})."
                            logger.warning(msg)
                            parsing_errors.append(msg)
                    if current_plurals:
                        original_key = key
                        counter = 1
                        # Check for duplicates in plurals dict and also in line_numbers to avoid collision with renamed string keys
                        while key in plurals or f"plurals_{key}" in line_numbers:
                            key = f"{original_key}_{counter}"
                            counter += 1

                        if key != original_key:
                            msg = f"Duplicate plurals key '{original_key}' found ({current_item_ref}). Renamed to '{key}'."
                            logger.warning(msg)
                            parsing_warnings.append(msg) # Add to warnings

                        plurals[key] = current_plurals
                        # Also add to line_numbers for plurals parent
                        line_numbers[f"plurals_{key}"] = processed_elements_count

                elif element.tag == 'string-array':
                    key = element.get('name')
                    if not key:
                        msg = f"Found <string-array> element without 'name' attribute ({current_item_ref})."
                        logger.warning(msg)
                        parsing_errors.append(msg)
                        continue

                    current_array_items: List[str] = []
                    for item_elem in element.findall('item'):
                        item_value = self._parse_android_text(item_elem) # Use the same text parsing logic
                        current_array_items.append(item_value)

                    if current_array_items:
                        original_key = key
                        counter = 1
                        # Check for duplicates in string_arrays dict and also in line_numbers to avoid collision
                        while key in string_arrays or f"string-array_{key}" in line_numbers:
                            key = f"{original_key}_{counter}"
                            counter += 1

                        if key != original_key:
                            msg = f"Duplicate string-array key '{original_key}' found ({current_item_ref}). Renamed to '{key}'."
                            logger.warning(msg)
                            parsing_warnings.append(msg) # Add to warnings

                        string_arrays[key] = current_array_items
                        # Also add to line_numbers for string-array parent
                        line_numbers[f"string-array_{key}"] = processed_elements_count

            if plurals:
                metadata['plurals'] = plurals
            if string_arrays:
                metadata['string_arrays'] = string_arrays

            if not translations and not plurals and not string_arrays and not parsing_errors:
                logger.info("Android XML parser found no translatable strings, plurals, or string-arrays.")

            return ParsingResult(
                translations=translations,
                line_numbers=line_numbers if line_numbers else None,
                metadata=metadata if metadata else None,
                errors=parsing_errors if parsing_errors else None,
                warnings=parsing_warnings if parsing_warnings else None
            )
            
        except ET.ParseError as e:
            error_msg = f"Invalid Android XML syntax: {str(e)}"
            logger.error(error_msg) # Consider adding e.lineno and e.offset if available and useful
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors, warnings=parsing_warnings)
            
        except Exception as e:
            error_msg = f"Failed to parse Android XML content: {str(e)}"
            logger.error(error_msg, exc_info=True)
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors, warnings=parsing_warnings)
