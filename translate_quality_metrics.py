
import json
import os

translations = {
    "ar": {
        "charCount": {"one": "حرف واحد", "other": "${count} أحرف"},
        "lengthDiff": "الهدف ${target} (${percent}%) مقابل المصدر ${source}"
    },
    "de": {
        "charCount": {"one": "1 Zeichen", "other": "${count} Zeichen"},
        "lengthDiff": "Ziel ist ${target} (${percent}%) vs Quelle ${source}"
    },
    "es": {
        "charCount": {"one": "1 carácter", "other": "${count} caracteres"},
        "lengthDiff": "Objetivo es ${target} (${percent}%) vs fuente ${source}"
    },
    "fr": {
        "charCount": {"one": "1 caractère", "other": "${count} caractères"},
        "lengthDiff": "Cible est ${target} (${percent}%) vs source ${source}"
    },
    "it": {
        "charCount": {"one": "1 carattere", "other": "${count} caratteri"},
        "lengthDiff": "Target è ${target} (${percent}%) vs sorgente ${source}"
    },
    "ja": {
        "charCount": {"one": "1文字", "other": "${count}文字"},
        "lengthDiff": "ターゲット: ${target} (${percent}%) 対 ソース: ${source}"
    },
    "ko": {
        "charCount": {"one": "1자", "other": "${count}자"},
        "lengthDiff": "대상: ${target} (${percent}%) 대 원본: ${source}"
    },
    "pt-BR": {
        "charCount": {"one": "1 caractere", "other": "${count} caracteres"},
        "lengthDiff": "Alvo: ${target} (${percent}%) vs fonte: ${source}"
    },
    "ru": {
        "charCount": {"one": "1 символ", "other": "${count} символов"},
        "lengthDiff": "Цель: ${target} (${percent}%) против источника: ${source}"
    },
    "tr": {
        "charCount": {"one": "1 karakter", "other": "${count} karakter"},
        "lengthDiff": "Hedef ${target} (%${percent}) vs kaynak ${source}"
    },
    "zh-CN": {
        "charCount": {"one": "1 个字符", "other": "${count} 个字符"},
        "lengthDiff": "目标: ${target} (${percent}%) vs 源: ${source}"
    }
}

def translate_json_files():
    base_dir = os.path.join('lib', 'i18n')

    for lang_code, trans in translations.items():
        # Handle filename variations if necessary (e.g. ko vs ko_KR if existed, but assuming std)
        # Checking for standard filenames
        possible_names = [f"{lang_code}.i18n.json"]

        target_file = None
        for name in possible_names:
            path = os.path.join(base_dir, name)
            if os.path.exists(path):
                target_file = path
                break

        if not target_file:
            print(f"Skipping {lang_code}: file not found")
            continue

        print(f"Updating {target_file}...")

        try:
            with open(target_file, 'r', encoding='utf-8') as f:
                data = json.load(f)

            if "quality" not in data:
                data["quality"] = {}

            # Update values
            data["quality"]["charCount"] = trans["charCount"]
            data["quality"]["lengthDiff"] = trans["lengthDiff"]

            with open(target_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)

            print(f"  Updated {lang_code} successfully.")

        except Exception as e:
            print(f"  Error updating {lang_code}: {e}")

if __name__ == "__main__":
    translate_json_files()
