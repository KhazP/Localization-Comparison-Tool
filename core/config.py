import os
import json
from typing import Dict, Any, Optional
import logging

logger = logging.getLogger(__name__)

class ConfigManager:
    """Handles loading, validating and saving configuration settings from a JSON file."""
    CONFIG_FILE = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                               "config", "config.json")
    
    # Centralized default configuration
    DEFAULT_CONFIG = {
        # Comparison settings
        "auto_fill_missing": False,
        "log_missing_strings": False,
        "ignore_patterns": [],
        "preferred_format": "auto",
        "ignore_whitespace": False,
        "ignore_case": False,
        "compare_values": True,
        "group_by_namespace": True,
        "show_preview": False,
        "show_line_numbers": False,
        
        # Machine translation settings
        "mt_enabled": False,
        "mt_api_key": "",
        "mt_source_lang": "en",
        "mt_target_lang": "tr",
        
        # Theme and appearance
        "theme": "system",
        "custom_theme": "minimalist",
        
        # Accessibility
        "enable_keyboard_nav": True,
        "high_contrast": False,
        "large_text": False,
        "font_size_scale": 1.0,
        
        # History and pagination
        "page_size": 50,
        "use_infinite_scroll": True,
        "max_history_entries": 100,
        
        # Onboarding
        "tutorial_completed": False,
    }
    
    @staticmethod
    def get_default_config() -> Dict[str, Any]:
        """Returns a copy of the default configuration."""
        return ConfigManager.DEFAULT_CONFIG.copy()
    
    @staticmethod
    def load() -> Dict[str, Any]:
        """Load configuration from the file, merging with defaults."""
        config = ConfigManager.get_default_config()
        
        if os.path.exists(ConfigManager.CONFIG_FILE):
            try:
                with open(ConfigManager.CONFIG_FILE, "r", encoding="utf-8") as f:
                    saved_config = json.load(f)
                    # Only update keys that exist in defaults to avoid invalid settings
                    for key in config:
                        if key in saved_config:
                            config[key] = saved_config[key]
                    
                    # Log any unexpected keys in saved config
                    for key in saved_config:
                        if key not in config:
                            logger.warning(f"Unknown config key found in saved config: {key}")
                    
                    return config
            except (json.JSONDecodeError, IOError) as e:
                logger.error(f"Error loading config: {e}")
                return config
        return config
    
    @staticmethod
    def save(config: Dict[str, Any]) -> bool:
        """Save configuration to the file after validating it."""
        # Create config directory if it doesn't exist
        os.makedirs(os.path.dirname(ConfigManager.CONFIG_FILE), exist_ok=True)
        
        # Get a clean copy of defaults to check against
        default_config = ConfigManager.get_default_config()
        
        # Validate config against defaults
        validated_config = {}
        for key, default_value in default_config.items():
            if key in config:
                # Basic type validation
                if isinstance(default_value, (bool, int, float, str, list, dict)):
                    if isinstance(config[key], type(default_value)) or config[key] is None:
                        validated_config[key] = config[key]
                    else:
                        logger.warning(f"Type mismatch in config for key '{key}': expected {type(default_value)}, got {type(config[key])}")
                        validated_config[key] = default_value
                else:
                    validated_config[key] = config[key]
            else:
                # Use default if key is missing
                validated_config[key] = default_value
                logger.debug(f"Missing config key '{key}', using default: {default_value}")
        
        try:
            with open(ConfigManager.CONFIG_FILE, "w", encoding="utf-8") as f:
                json.dump(validated_config, f, indent=4)
            return True
        except (IOError, TypeError) as e:
            logger.error(f"Error saving config: {e}")
            return False
    
    @staticmethod
    def reset() -> Dict[str, Any]:
        """Reset configuration to defaults and save."""
        default_config = ConfigManager.get_default_config()
        ConfigManager.save(default_config)
        return default_config
    
    @staticmethod
    def validate_required_fields(config: Dict[str, Any]) -> Dict[str, str]:
        """Validate that required fields are properly set.
        Returns a dictionary of error messages keyed by field name."""
        errors = {}
        
        # Validate MT settings
        if config.get("mt_enabled", False):
            if not config.get("mt_api_key"):
                errors["mt_api_key"] = "API key is required when machine translation is enabled"
        
        return errors
