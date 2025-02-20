import os
import json

class ConfigManager:
    """Handles loading and saving configuration settings from a JSON file."""
    CONFIG_FILE = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                               "config", "config.json")
    
    @staticmethod
    def load() -> dict:
        """Load configuration from the file. Returns a dict or empty dict on error."""
        if os.path.exists(ConfigManager.CONFIG_FILE):
            try:
                with open(ConfigManager.CONFIG_FILE, "r", encoding="utf-8") as f:
                    return json.load(f)
            except (json.JSONDecodeError, IOError) as e:
                print(f"Error loading config: {e}")
        return {}
    
    @staticmethod
    def save(config: dict) -> None:
        """Save configuration to the file. Prints error if saving fails."""
        try:
            with open(ConfigManager.CONFIG_FILE, "w", encoding="utf-8") as f:
                json.dump(config, f, indent=4)
        except (IOError, TypeError) as e:
            print(f"Error saving config: {e}")
