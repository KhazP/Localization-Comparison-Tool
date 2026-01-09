
import json
import os
import glob

def update_json_files():
    # Define the keys to add
    new_keys = {
        "quality": {
            "charCount": {
                "one": "1 char",
                "other": "${count} chars"
            },
            "lengthDiff": "Target is ${target} (${percent}%) vs source ${source}"
        }
    }

    # Get all .i18n.json files
    files = glob.glob(os.path.join('lib', 'i18n', '*.i18n.json'))

    for file_path in files:
        if 'en.i18n.json' in file_path:
            continue

        print(f"Checking {file_path}...")

        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)

            # Ensure quality section exists
            if "quality" not in data:
                data["quality"] = {}

            # Check and add charCount
            if "charCount" not in data["quality"]:
                data["quality"]["charCount"] = new_keys["quality"]["charCount"]
                print(f"  Added quality.charCount to {file_path}")

            # Check and add lengthDiff
            if "lengthDiff" not in data["quality"]:
                data["quality"]["lengthDiff"] = new_keys["quality"]["lengthDiff"]
                print(f"  Added quality.lengthDiff to {file_path}")

            # Write back
            with open(file_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)

        except Exception as e:
            print(f"Error processing {file_path}: {e}")

if __name__ == "__main__":
    update_json_files()
