import os
import json
import datetime
import logging

HISTORY_FILE = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                            "config", "history.json")

def load_history() -> list:
    """Load history entries from the JSON history file."""
    if os.path.exists(HISTORY_FILE):
        try:
            # Check if file is empty
            if os.path.getsize(HISTORY_FILE) == 0:
                return []
                
            with open(HISTORY_FILE, "r", encoding="utf-8") as f:
                return json.load(f)
        except json.JSONDecodeError as e:
            logging.warning(f"Invalid JSON in history file: {e}. Creating new history.")
            # If the file exists but contains invalid JSON, return an empty list
            return []
        except Exception as e:
            logging.error(f"Error loading history: {e}")
    
    # If the file doesn't exist or there was an error, return an empty list
    return []

def save_history(entry: dict) -> None:
    """Append a history entry and save the file."""
    # Ensure the config directory exists
    os.makedirs(os.path.dirname(HISTORY_FILE), exist_ok=True)
    
    history = load_history()
    history.append(entry)
    
    # Get max_history_entries from config, default to 100 if not found
    config_file = os.path.join(os.path.dirname(HISTORY_FILE), "config.json")
    max_entries = 100  # Default value
    
    if os.path.exists(config_file):
        try:
            with open(config_file, "r", encoding="utf-8") as f:
                config = json.load(f)
                max_entries = config.get("max_history_entries", 100)
        except Exception:
            # If config can't be read, use default
            pass
    
    # Limit history size
    if len(history) > max_entries:
        history = history[-max_entries:]  # Keep only the most recent entries
    
    try:
        with open(HISTORY_FILE, "w", encoding="utf-8") as f:
            json.dump(history, f, indent=2, ensure_ascii=False)
    except Exception as e:
        logging.error(f"Error saving history: {e}")

def clear_history() -> None:
    """Clear all history entries by overwriting the history file with an empty list."""
    try:
        # Ensure the config directory exists
        os.makedirs(os.path.dirname(HISTORY_FILE), exist_ok=True)
        
        with open(HISTORY_FILE, "w", encoding="utf-8") as f:
            json.dump([], f, indent=2, ensure_ascii=False)
    except Exception as e:
        logging.error(f"Error clearing history: {e}")

def purge_old_entries(max_age_days=30) -> None:
    """Remove history entries older than the specified number of days."""
    history = load_history()
    if not history:
        return
    
    current_time = datetime.datetime.now()
    filtered_history = []
    
    for entry in history:
        try:
            # Support both ISO format and the old format
            timestamp = entry.get('timestamp', '')
            if 'T' in timestamp:  # ISO format (YYYY-MM-DDTHH:MM:SS.ssssss)
                entry_time = datetime.datetime.fromisoformat(timestamp)
            else:  # Old format (YYYY-MM-DD HH:MM:SS)
                entry_time = datetime.datetime.strptime(timestamp, "%Y-%m-%d %H:%M:%S")
                
            age = (current_time - entry_time).days
            if age <= max_age_days:
                filtered_history.append(entry)
        except (ValueError, KeyError):
            # Keep entries with invalid timestamps (shouldn't happen with proper entries)
            filtered_history.append(entry)
    
    if len(filtered_history) != len(history):
        try:
            with open(HISTORY_FILE, "w", encoding="utf-8") as f:
                json.dump(filtered_history, f, indent=2, ensure_ascii=False)
        except Exception as e:
            logging.error(f"Error purging old history entries: {e}")
