
import json

def load_json(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def compare_keys(en_data, target_data, path=""):
    missing = []
    if isinstance(en_data, dict):
        if not isinstance(target_data, dict):
            return [f"{path} (type mismatch: expected dict)"]

        for key in en_data:
            new_path = f"{path}.{key}" if path else key
            if key not in target_data:
                missing.append(new_path)
            else:
                missing.extend(compare_keys(en_data[key], target_data[key], new_path))
    return missing

try:
    en = load_json('lib/i18n/en.i18n.json')
    hi = load_json('lib/i18n/hi.i18n.json')

    missing_keys = compare_keys(en, hi)

    if missing_keys:
        print("Missing keys in hi.i18n.json:")
        for key in missing_keys:
            print(key)
    else:
        print("No missing keys found.")

except Exception as e:
    print(f"Error: {e}")
