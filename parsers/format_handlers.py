import json
from pathlib import Path
import logging
from typing import Dict, Any, Tuple
import xml.etree.ElementTree as ET

# Optional dependencies with proper error handling
YAML_AVAILABLE = False
LXML_AVAILABLE = False
TOML_AVAILABLE = False

try:
    import yaml
    YAML_AVAILABLE = True
except ImportError:
    pass

try:
    import lxml.etree as lxml_etree
    LXML_AVAILABLE = True
except ImportError:
    pass

try:
    import tomlkit
    TOML_AVAILABLE = True
except ImportError:
    pass

class FormatHandler:
    def load(self, file_path: str) -> Tuple[Dict[str, Any], Any]:
        """Load file and return (translations, metadata)"""
        raise NotImplementedError

    def save(self, translations: Dict[str, Any], file_path: str, metadata: Any = None) -> bool:
        """Save translations while preserving formatting"""
        raise NotImplementedError

class JSONHandler(FormatHandler):
    def load(self, file_path: str) -> Tuple[Dict[str, Any], Any]:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
            return json.loads(content), None

    def save(self, translations: Dict[str, Any], file_path: str, metadata: Any = None) -> bool:
        try:
            with open(file_path, 'w', encoding='utf-8') as file:
                json.dump(translations, file, indent=4, ensure_ascii=False)
            return True
        except Exception as e:
            logging.error(f"Error saving JSON: {str(e)}")
            return False

class YAMLHandler(FormatHandler):
    def __init__(self):
        if not YAML_AVAILABLE:
            raise ImportError("PyYAML is required for YAML handling. Install with: pip install PyYAML")
        self.yaml = yaml
        
    def load(self, file_path: str) -> Tuple[Dict[str, Any], Any]:
        with open(file_path, 'r', encoding='utf-8') as file:
            data = self.yaml.safe_load(file)
            return data, None

    def save(self, translations: Dict[str, Any], file_path: str, metadata: Any = None) -> bool:
        try:
            with open(file_path, 'w', encoding='utf-8') as file:
                self.yaml.dump(translations, file, allow_unicode=True, sort_keys=False)
            return True
        except Exception as e:
            logging.error(f"Error saving YAML: {str(e)}")
            return False

class TOMLHandler(FormatHandler):
    def load(self, file_path: str) -> Tuple[Dict[str, Any], Any]:
        if not TOML_AVAILABLE:
            raise ImportError("tomlkit is required for TOML handling")
        with open(file_path, 'r', encoding='utf-8') as file:
            return tomlkit.parse(file.read()), None

    def save(self, translations: Dict[str, Any], file_path: str, metadata: Any = None) -> bool:
        try:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.write(tomlkit.dumps(translations))
            return True
        except Exception as e:
            logging.error(f"Error saving TOML: {str(e)}")
            return False

class XMLHandler(FormatHandler):
    def load(self, file_path: str) -> Tuple[Dict[str, Any], Any]:
        parser = lxml_etree if LXML_AVAILABLE else ET
        tree = parser.parse(file_path)
        root = tree.getroot()

        translations = {}
        for string in root.findall('.//string'):
            name = string.get('name')
            if name:
                translations[name] = string.text or ""
        return translations, tree

    def save(self, translations: Dict[str, Any], file_path: str, metadata: Any = None) -> bool:
        try:
            root = ET.Element("resources")
            for key, value in sorted(translations.items()):
                string = ET.SubElement(root, "string", name=key)
                string.text = value

            tree = ET.ElementTree(root)
            # Use more robust XML writing with encoding declaration
            with open(file_path, 'wb') as f:
                tree.write(f, encoding='utf-8', xml_declaration=True)
            return True
        except Exception as e:
            logging.error(f"Error saving XML: {str(e)}")
            return False

def get_handler(file_path: str) -> FormatHandler:
    """Factory function to get appropriate format handler"""
    ext = Path(file_path).suffix.lower()
    if ext == '.json':
        return JSONHandler()
    elif ext in ['.yaml', '.yml']:
        return YAMLHandler()
    elif ext == '.toml':
        return TOMLHandler()
    elif ext == '.xml':
        return XMLHandler()
    else:
        raise ValueError(f"Unsupported file format: {ext}")
