import json
import os

# Create large English file (100k entries)
en_data = {f'key_{i:06d}': f'This is English translation string number {i} with some additional text to make it longer and more realistic for testing purposes' for i in range(100000)}
with open('sample translations/english/en_large.json', 'w', encoding='utf-8') as f:
    json.dump(en_data, f, indent=2)

# Create large Turkish file with some differences
tr_data = {}
for i in range(100000):
    # Add missing (removed) keys - skip every 100th key
    if i % 100 == 50:
        continue
    # Add extra (added) keys
    if i % 100 == 75:
        tr_data[f'extra_key_{i:06d}'] = f'Bu ekstra bir anahtar {i}'
    # Add modified translations
    if i % 50 == 0:
        tr_data[f'key_{i:06d}'] = f'[MODIFIED] Bu Turkce ceviri dizesi numara {i} ve test amacli daha uzun ve gercekci yapmak icin bazi ek metinler icerir - GUNCELLENDI'
    else:
        tr_data[f'key_{i:06d}'] = f'Bu Turkce ceviri dizesi numara {i} ve test amacli daha uzun ve gercekci yapmak icin bazi ek metinler icerir'

with open('sample translations/turkish/tr_large.json', 'w', encoding='utf-8') as f:
    json.dump(tr_data, f, indent=2)

print(f"Created en_large.json with {len(en_data)} entries")
print(f"Created tr_large.json with {len(tr_data)} entries")
