import os
import json
import xml.etree.ElementTree as ET
from typing import Dict, Optional, Any
import logging

try:
    import yaml
except ImportError:
    yaml = None
    # logger.warning("PyYAML not installed. YAML export will not be available.") 
    # Cannot use logger before it's defined. A simple print or module-level warning might be an option.
    # Or, handle the absence of yaml directly in the save_translations function.

# It's good practice to get a logger specific to this module.
# from .logger_service import logger_service # Assuming logger_service is in the same utils dir
# logger = logger_service.get_logger(__name__)
# For now, using a standard logger.
logger = logging.getLogger(__name__)


def save_translations(
    translations: Dict[str, str], 
    filepath: str, 
    file_format: Optional[str] = None
) -> Tuple[bool, str]: # Added Tuple to imports for core/comparison_service.py, should be here too
    """
    Save translations to a file in the specified format.
    If file_format is None or 'auto', it's auto-detected from filepath extension.
    Returns (success_status, error_message_if_any).
    """
    
    effective_format = file_format
    if not effective_format or effective_format == "auto":
        _name, ext = os.path.splitext(filepath)
        ext = ext.lower()
        if ext == ".json": effective_format = "json"
        elif ext in {".yaml", ".yml"}: effective_format = "yaml"
        elif ext == ".lang": effective_format = "lang" # Simple key=value
        elif ext == ".xml": effective_format = "xml" 
        elif ext == ".properties": effective_format = "properties"
        elif ext == ".csv": effective_format = "csv"
        elif ext == ".resx": effective_format = "resx"
        # Add other auto-detections for formats like .xlf, .po etc. if needed
        else:
            err_msg = f"Unsupported file extension for auto-detection: {ext}"
            logger.error(err_msg)
            return False, err_msg

    content: Optional[str] = None
    logger.info(f"Attempting to save translations to '{filepath}' in format '{effective_format}'.")

    try:
        # Ensure directory exists
        dir_name = os.path.dirname(filepath)
        if dir_name: # If there's a directory part
            os.makedirs(dir_name, exist_ok=True)

        if effective_format == "json":
            content = json.dumps(translations, indent=4, ensure_ascii=False)
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
        elif effective_format == "yaml":
            if not yaml:
                raise ImportError("PyYAML module is not installed. Cannot save as YAML.")
            # yaml.dump directly writes to the file stream
            with open(filepath, 'w', encoding='utf-8') as f:
                yaml.dump(translations, f, allow_unicode=True, sort_keys=False)
        elif effective_format == "lang": # Simple key=value
            lines = [f"{key}={value}" for key, value in translations.items()]
            content = "\n".join(lines)
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
        elif effective_format == "properties": # Similar to .lang but often ISO-8859-1
            # Java .properties files often use ISO-8859-1 encoding and specific escape sequences.
            # This is a simplified writer. For full compliance, escaping would be needed.
            lines = [f"{key}={value}" for key, value in translations.items()]
            content = "\n".join(lines)
            # Consider encoding based on typical .properties usage, e.g. 'iso-8859-1'
            # or provide encoding as a parameter. For now, sticking to UTF-8.
            with open(filepath, 'w', encoding='utf-8') as f: # Or 'iso-8859-1'
                f.write(content)
        elif effective_format == "xml": 
            # Generic XML structure: <resources><string name="key">value</string></resources>
            # This is similar to Android XML strings.
            root_el = ET.Element("resources")
            for key, value in sorted(translations.items()):
                string_el = ET.SubElement(root_el, "string", name=str(key))
                string_el.text = str(value)
            
            # Pretty print XML
            try:
                ET.indent(root_el, space="\t", level=0) # Python 3.9+
            except AttributeError:
                # Fallback for older Python versions (no ET.indent)
                # This results in non-indented XML
                pass 
            
            tree = ET.ElementTree(root_el)
            with open(filepath, 'wb') as f: # Write bytes for XML
                 tree.write(f, encoding='utf-8', xml_declaration=True)
        elif effective_format == "resx":
            # .NET RESX format
            root_el = ET.Element("root")
            # Add RESX schema headers if necessary (simplified here)
            # Example headers:
            # resheader_mimetype = ET.SubElement(root_el, "resheader", name="mimetype")
            # resheader_mimetype.text = "text/microsoft-resx"
            # ... other headers ...
            for key, value in sorted(translations.items()):
                data_el = ET.SubElement(root_el, "data", name=str(key))
                value_el = ET.SubElement(data_el, "value")
                value_el.text = str(value)
                # Optionally add <comment> element if comments are supported/provided
            
            try:
                ET.indent(root_el, space="\t", level=0) # Python 3.9+
            except AttributeError:
                pass
            
            tree = ET.ElementTree(root_el)
            with open(filepath, 'wb') as f:
                 tree.write(f, encoding='utf-8', xml_declaration=True)
        elif effective_format == "csv":
            import csv # Import locally for this format
            # Standard: key,value. Add header.
            # Quoting can be specified if needed, e.g. csv.QUOTE_ALL
            with open(filepath, 'w', encoding='utf-8', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(['key', 'value']) # Header row
                for key, value in translations.items():
                    writer.writerow([str(key), str(value)])
        else:
            err_msg = f"Unsupported format for saving: {effective_format}"
            logger.error(err_msg)
            return False, err_msg
        
        logger.info(f"Successfully saved translations to '{filepath}'.")
        return True, ""

    except ImportError as e:
        err_msg = f"Import error for saving format {effective_format}: {e}"
        logger.error(err_msg)
        return False, err_msg
    except Exception as e:
        err_msg = f"Error saving translations to {filepath} in format {effective_format}: {e}"
        logger.error(err_msg, exc_info=True) # Add exc_info for more details
        return False, err_msg
