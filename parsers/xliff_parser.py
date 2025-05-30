import logging
import xml.etree.ElementTree as ET
from typing import Dict, Optional, List, Any # Added List, Any
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class

logger = logging.getLogger(__name__)

class XLIFFParser(TranslationParser):
    """Parser for XLIFF (XML Localization Interchange File Format) files."""
    
    def __init__(self, source_lang: Optional[str] = None, target_lang: Optional[str] = None):
        self.preset_source_lang = source_lang
        self.preset_target_lang = target_lang
        
    def _get_text_from_element(self, element: Optional[ET.Element]) -> str:
        """
        Extracts text from an XLIFF element (like <source> or <target>),
        preserving inline tags (e.g., <g>, <x/>) by serializing them.
        """
        if element is None:
            return ""

        text_parts = []
        if element.text:
            text_parts.append(element.text)

        for child in element:
            try:
                # Serialize child element to string, including its tag, attributes, and content.
                # method='xml' ensures it's a well-formed XML fragment.
                # 'unicode' ensures a string output.
                child_xml_string = ET.tostring(child, encoding='unicode', method='xml')
                text_parts.append(child_xml_string)
            except Exception as e:
                logger.warning(f"XLIFF: Could not serialize child element {child.tag}: {e}. Attempting fallback.")
                # Fallback: try to get text content of child if serialization fails
                child_text_content = child.text if child.text else ""
                text_parts.append(child_text_content)

            if child.tail:
                text_parts.append(child.tail)
        
        return "".join(text_parts).strip()


    def parse(self, content: str) -> ParsingResult:
        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {}
        parsing_errors: List[str] = []
        metadata: Dict[str, Any] = {}

        file_source_lang = self.preset_source_lang
        file_target_lang = self.preset_target_lang

        try:
            # Basic sanitization for common invalid XML characters
            import re
            sanitized_content = re.sub(r'[^\x09\x0A\x0D\x20-\uD7FF\uE000-\uFFFD\U00010000-\U0010FFFF]', '', content)


            if not sanitized_content.strip():
                parsing_errors.append("XLIFF content is empty or became empty after sanitization.")
                return ParsingResult(translations={}, errors=parsing_errors)

            root = ET.fromstring(sanitized_content)

            # Define common XLIFF namespaces
            # XLIFF 1.2 is 'urn:oasis:names:tc:xliff:document:1.2'
            # XLIFF 2.0 is 'urn:oasis:names:tc:xliff:document:2.0'
            # Using a more general approach to find elements that might have a namespace.
            doc_namespace_uri = ""
            if '}' in root.tag:
                doc_namespace_uri = root.tag.split('}')[0][1:]
            
            ns_map = {}
            if doc_namespace_uri:
                ns_map['xliff'] = doc_namespace_uri # Use 'xliff' as the prefix for the detected namespace

            def findall_namespaced(parent_el, path_segment):
                if doc_namespace_uri: # If namespace detected, use it
                    return parent_el.findall(f".//xliff:{path_segment}", namespaces=ns_map)
                else: # Otherwise, search without namespace
                    return parent_el.findall(f".//{path_segment}")

            # Find <file> elements
            file_elements = findall_namespaced(root, 'file')
            if not file_elements and root.tag.endswith("xliff"): # If no <file> but root is <xliff>
                file_elements = [root] # Treat root as the single "file" for searching units (common in simpler XLIFFs)
            elif not file_elements: # If still no file elements, could be malformed or very simple
                logger.warning("No <file> elements found in XLIFF. Attempting to find <trans-unit> directly under root.")
                file_elements = [root] # Default to root


            for file_idx, file_elem in enumerate(file_elements):
                # Extract source/target languages from <file> if not preset
                current_file_source_lang = file_elem.get('source-language', file_source_lang)
                current_file_target_lang = file_elem.get('target-language', file_target_lang)

                if current_file_source_lang and 'source_language' not in metadata: # Store first found
                    metadata['source_language'] = current_file_source_lang
                if current_file_target_lang and 'target_language' not in metadata: # Store first found
                    metadata['target_language'] = current_file_target_lang

                # Adapt for XLIFF 2.0 where <trans-unit> becomes <unit>
                trans_units = findall_namespaced(file_elem, 'trans-unit') # XLIFF 1.2
                if not trans_units:
                    trans_units = findall_namespaced(file_elem, 'unit') # XLIFF 2.0

                for unit_idx, unit_elem in enumerate(trans_units):
                    key = 'unknown_id' # Default key for error messages
                    try:
                        key = unit_elem.get('id')
                        if not key:
                            msg = f"Found translation unit without 'id' in file {file_idx+1} (approx. unit {unit_idx+1}). Skipping."
                            logger.warning(msg)
                            parsing_errors.append(msg)
                            continue

                        source_elem, target_elem = None, None

                        if doc_namespace_uri and doc_namespace_uri.endswith('2.0'): # XLIFF 2.0 structure
                            # In XLIFF 2.0, <source> and <target> are inside <segment>
                            segment_elem = findall_namespaced(unit_elem, 'segment')
                            if segment_elem:
                                source_elem = findall_namespaced(segment_elem[0], 'source')
                                target_elem = findall_namespaced(segment_elem[0], 'target')
                        else: # XLIFF 1.2 structure (or no namespace)
                            source_elem = findall_namespaced(unit_elem, 'source')
                            target_elem = findall_namespaced(unit_elem, 'target')

                        target_text = ""
                        if target_elem and target_elem[0] is not None:
                            target_text = self._get_text_from_element(target_elem[0])
                        elif source_elem and source_elem[0] is not None:
                            source_text = self._get_text_from_element(source_elem[0])
                            target_text = source_text
                            msg = f"XLIFF: Target for key '{key}' is missing or empty. Using source text."
                            logger.debug(msg)
                        else:
                            msg = f"XLIFF: No source or target text found for key '{key}'. Storing as empty."
                            logger.warning(msg)
                            parsing_errors.append(msg)

                        if key in translations:
                            msg = f"Duplicate key '{key}' found. Value ('{target_text}') will overwrite previous ('{translations[key]}')."
                            logger.warning(msg)
                            parsing_errors.append(msg)

                        translations[key] = target_text
                        line_numbers[key] = unit_idx + 1 # Approximate order
                                
                    except Exception as e:
                        msg = f"Error processing XLIFF unit ID '{key}' in file {file_idx+1} (approx. unit {unit_idx+1}): {str(e)}"
                        logger.error(msg, exc_info=True)
                        parsing_errors.append(msg)

            if not translations and not parsing_errors and not metadata.get('source_language'):
                logger.warning("XLIFF parser found no translatable units and no language metadata. File might be empty or malformed.")
            elif not translations and not parsing_errors:
                 logger.info("XLIFF parser found no translatable units, though language metadata might be present.")

            return ParsingResult(
                translations=translations,
                line_numbers=line_numbers if line_numbers else None,
                metadata=metadata if metadata else None,
                errors=parsing_errors if parsing_errors else None
            )
            
        except ET.ParseError as e:
            error_msg = f"Invalid XLIFF XML syntax: {str(e)}"
            if hasattr(e, 'lineno') and hasattr(e, 'offset'):
                error_msg += f" (line {e.lineno}, column {e.offset})"
            logger.error(error_msg)
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors)
            
        except Exception as e:
            error_msg = f"Failed to parse XLIFF content due to an unexpected error: {str(e)}"
            logger.error(error_msg, exc_info=True)
            parsing_errors.append(error_msg)
            return ParsingResult(translations={}, errors=parsing_errors)
