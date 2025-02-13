import re

def highlight_line(line: str, change_type: str = None) -> str:
    # Process change indicator
    if change_type == "added" and line.startswith("+"):
        indicator = "+ "
        line = line[2:]
    elif change_type == "removed" and line.startswith("-"):
        indicator = "- "
        line = line[2:]
    elif change_type == "modified" and line.startswith("M"):
        indicator = "M "
        line = line[2:]
    else:
        indicator = ""
        
    # (Optional) Additional processing with regex can be added here
    # For now, simply reassemble the line with its indicator.
    # For key-value pairs, bold is not applied in plain text.
    if ":" in line:
        key, value = line.split(":", 1)
        line = f"{key.strip()} :{value}"
    
    return indicator + line
