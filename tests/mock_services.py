from unittest.mock import MagicMock
from typing import Dict, Optional

class MockTranslateService:
    def __init__(self, mock_responses: Optional[Dict[str, str]] = None):
        self.mock_responses = mock_responses or {
            "en->es": {
                "Hello": "Hola",
                "World": "Mundo",
                "File": "Archivo"
            },
            "en->fr": {
                "Hello": "Bonjour",
                "World": "Monde",
                "File": "Fichier"
            }
        }
        self.calls = []

    async def translate_text(self, text: str, source_lang: str, target_lang: str) -> str:
        """Mock translation that returns pre-defined responses or the original text"""
        key = f"{source_lang}->{target_lang}"
        self.calls.append({
            "text": text,
            "source": source_lang,
            "target": target_lang
        })
        return self.mock_responses.get(key, {}).get(text, text)

    def get_call_count(self) -> int:
        return len(self.calls)

    def reset(self):
        self.calls = []

class MockFileService:
    def __init__(self):
        self.files = {}
        self.read_calls = []
        self.write_calls = []

    def read_file(self, path: str) -> str:
        self.read_calls.append(path)
        if path not in self.files:
            raise FileNotFoundError(f"Mock file not found: {path}")
        return self.files[path]

    def write_file(self, path: str, content: str):
        self.write_calls.append((path, content))
        self.files[path] = content

    def file_exists(self, path: str) -> bool:
        return path in self.files

    def reset(self):
        self.files = {}
        self.read_calls = []
        self.write_calls = []

class MockConfigService:
    def __init__(self):
        self.config = {
            "theme": "light",
            "auto_fill_missing": False,
            "mt_enabled": False,
            "mt_api_key": "",
            "mt_source_lang": "en",
            "mt_target_lang": "es"
        }
        self.save_calls = []

    def get_config(self) -> dict:
        return self.config.copy()

    def update_config(self, new_config: dict):
        self.config.update(new_config)
        self.save_calls.append(new_config)

    def reset(self):
        self.config = {}
        self.save_calls = []