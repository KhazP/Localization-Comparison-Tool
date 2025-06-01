# import os # Not needed for this function

def get_readable_file_size(size_in_bytes: float) -> str:
    """Convert file size in bytes to human readable format."""
    for unit in ['B', 'KB', 'MB', 'GB']:
        if size_in_bytes < 1024.0: # Use float for comparison
            if unit == 'B':
                return f"{size_in_bytes:.0f} {unit}" # No decimal for bytes
            return f"{size_in_bytes:.1f} {unit}"
        size_in_bytes /= 1024.0
    return f"{size_in_bytes:.1f} TB" # Handle Terabytes as well
