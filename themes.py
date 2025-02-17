THEMES = {
    "dark": {
        "bg": {
            "primary": "#111827",     # Main background
            "secondary": "#1F2937",   # Card/container background
            "input": "#374151",       # Input field background
            "accent": "#3B82F6",      # Primary accent color
            "hover": "#60A5FA"        # Hover state color
        },
        "text": {
            "primary": "#F9FAFB",     # Main text
            "secondary": "#9CA3AF",   # Secondary/muted text
            "accent": "#60A5FA",      # Accent text
            "disabled": "#6B7280"     # Disabled text
        },
        "border": {
            "default": "#4B5563",     # Default borders
            "accent": "#3B82F6",      # Accent borders
            "focus": "#60A5FA"        # Focus state borders
        },
        "changes": {
            "added": "#4ADE80",       # Added items
            "removed": "#F87171",     # Removed items
            "modified": "#FCD34D"     # Modified items
        },
        "dialog": {
            "background": "#1F2937",  # Dialog background
            "overlay": "rgba(0,0,0,0.5)" # Dialog overlay
        }
    },
    "light": {
        "bg": {
            "primary": "#FFFFFF",
            "secondary": "#F3F4F6",
            "input": "#F9FAFB",
            "accent": "#3B82F6",
        },
        "text": {
            "primary": "#111827",
            "secondary": "#374151",
            "accent": "#2563EB",
        },
        "border": {
            "default": "#E5E7EB",
            "accent": "#3B82F6",
        },
        "changes": {
            "added": "#22C55E",    # green
            "removed": "#EF4444",  # red
        }
    },
    "amoled": {
        "bg": {
            "primary": "#000000",     # Pure black background
            "secondary": "#000000",    # Pure black secondary
            "input": "#121212",       # Slightly lighter black
            "accent": "#3B82F6",      # Blue accent
            "hover": "#60A5FA"        # Lighter blue hover
        },
        "text": {
            "primary": "#FFFFFF",     # Pure white text
            "secondary": "#9CA3AF",   # Gray secondary text
            "accent": "#60A5FA",      # Blue accent text
            "disabled": "#6B7280"     # Dark gray disabled
        },
        "border": {
            "default": "#1F1F1F",     # Very dark gray border
            "accent": "#3B82F6",      # Blue accent border
            "focus": "#60A5FA"        # Light blue focus
        },
        "changes": {
            "added": "#4ADE80",       # Green for adds
            "removed": "#F87171",     # Red for removes
            "modified": "#FCD34D"     # Yellow for changes
        },
        "dialog": {
            "background": "#121212",  # Slightly lighter black
            "overlay": "rgba(0,0,0,0.8)" # Dark overlay
        }
    },
    "high_contrast": {
        "bg": {
            "primary": "#FFFFFF",
            "secondary": "#F8F9FA",
            "input": "#FFFFFF",
            "accent": "#1E90FF",
        },
        "text": {
            "primary": "#000000",
            "secondary": "#2C3E50",
            "accent": "#1E90FF",
        },
        "border": {
            "default": "#000000",
            "accent": "#1E90FF",
        },
        "changes": {
            "added": "#32CD32",
            "removed": "#FF4500",
        }
    },
    "minimalist": {
        "bg": {
            "primary": "#FFFFFF",
            "secondary": "#F5F5F5",
            "input": "#FFFFFF",
            "accent": "#2F4F4F",
        },
        "text": {
            "primary": "#2F4F4F",
            "secondary": "#708090",
            "accent": "#A9A9A9",
        },
        "border": {
            "default": "#B0C4DE",
            "accent": "#2F4F4F",
        },
        "changes": {
            "added": "#4ADE80",
            "removed": "#FF6B6B",
        }
    },
    "earth_tones": {
        "bg": {
            "primary": "#F5F5DC",
            "secondary": "#E8E4C9",
            "input": "#F5F5DC",
            "accent": "#8B4513",
        },
        "text": {
            "primary": "#8B4513",
            "secondary": "#CD853F",
            "accent": "#D2B48C",
        },
        "border": {
            "default": "#DEB887",
            "accent": "#8B4513",
        },
        "changes": {
            "added": "#228B22",
            "removed": "#CD5C5C",
        }
    },
    "pastel": {
        "bg": {
            "primary": "#FFFACD",
            "secondary": "#FFF8DC",
            "input": "#FFFACD",
            "accent": "#FFB6C1",
        },
        "text": {
            "primary": "#696969",
            "secondary": "#808080",
            "accent": "#ADD8E6",
        },
        "border": {
            "default": "#98FB98",
            "accent": "#FFD700",
        },
        "changes": {
            "added": "#98FB98",
            "removed": "#FFB6C1",
        }
    }
}

def get_theme(base_theme: str, custom_theme: str = None) -> dict:
    """Get theme colors based on base theme and custom theme selection"""
    if custom_theme and custom_theme in THEMES:
        return THEMES[custom_theme]
    return THEMES.get(base_theme, THEMES["dark"])
