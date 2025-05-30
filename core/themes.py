"""Defines theme dictionaries for the application's UI, providing various color schemes."""

# THEMES dictionary: Keys are theme names, values are dictionaries defining
# color categories (bg, text, border, changes, dialog) and their specific hex color codes.
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
            "hover": "#60A5FA" # Added hover for consistency
        },
        "text": {
            "primary": "#111827",
            "secondary": "#374151",
            "accent": "#2563EB",
            "disabled": "#9CA3AF" # Added disabled for consistency
        },
        "border": {
            "default": "#E5E7EB",
            "accent": "#3B82F6",
            "focus": "#60A5FA" # Added focus for consistency
        },
        "changes": {
            "added": "#22C55E",    # green
            "removed": "#EF4444",  # red
            "modified": "#FCD34D" # Added modified for consistency
        },
        "dialog": { # Added dialog for consistency
            "background": "#F3F4F6",
            "overlay": "rgba(0,0,0,0.4)"
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
            "hover": "#4DAAFF" # Added hover for consistency
        },
        "text": {
            "primary": "#000000",
            "secondary": "#2C3E50",
            "accent": "#1E90FF",
            "disabled": "#95A5A6" # Added disabled for consistency
        },
        "border": {
            "default": "#000000",
            "accent": "#1E90FF",
            "focus": "#4DAAFF" # Added focus for consistency
        },
        "changes": {
            "added": "#32CD32",
            "removed": "#FF4500",
            "modified": "#FFA500" # Added modified for consistency
        },
        "dialog": { # Added dialog for consistency
            "background": "#F8F9FA",
            "overlay": "rgba(0,0,0,0.5)"
        }
    },
    "minimalist": {
        "bg": {
            "primary": "#FFFFFF",
            "secondary": "#F5F5F5",
            "input": "#FFFFFF",
            "accent": "#2F4F4F",
            "hover": "#5F9EA0" # Added hover for consistency
        },
        "text": {
            "primary": "#2F4F4F",
            "secondary": "#708090",
            "accent": "#A9A9A9",
            "disabled": "#BFBFBF" # Added disabled for consistency
        },
        "border": {
            "default": "#B0C4DE",
            "accent": "#2F4F4F",
            "focus": "#5F9EA0" # Added focus for consistency
        },
        "changes": {
            "added": "#4ADE80",
            "removed": "#FF6B6B",
            "modified": "#FFD700" # Added modified for consistency
        },
        "dialog": { # Added dialog for consistency
            "background": "#F5F5F5",
            "overlay": "rgba(0,0,0,0.3)"
        }
    },
    "earth_tones": {
        "bg": {
            "primary": "#F5F5DC",
            "secondary": "#E8E4C9",
            "input": "#F5F5DC",
            "accent": "#8B4513",
            "hover": "#A0522D" # Added hover for consistency
        },
        "text": {
            "primary": "#8B4513",
            "secondary": "#CD853F",
            "accent": "#D2B48C",
            "disabled": "#A0522D" # Added disabled for consistency
        },
        "border": {
            "default": "#DEB887",
            "accent": "#8B4513",
            "focus": "#A0522D" # Added focus for consistency
        },
        "changes": {
            "added": "#228B22",
            "removed": "#CD5C5C",
            "modified": "#DAA520" # Added modified for consistency
        },
        "dialog": { # Added dialog for consistency
            "background": "#E8E4C9",
            "overlay": "rgba(0,0,0,0.3)"
        }
    },
    "pastel": {
        "bg": {
            "primary": "#FFFACD",
            "secondary": "#FFF8DC",
            "input": "#FFFACD",
            "accent": "#FFB6C1",
            "hover": "#FFC0CB" # Added hover for consistency
        },
        "text": {
            "primary": "#696969",
            "secondary": "#808080",
            "accent": "#ADD8E6",
            "disabled": "#A9A9A9" # Added disabled for consistency
        },
        "border": {
            "default": "#98FB98",
            "accent": "#FFD700",
            "focus": "#FFFFE0" # Added focus for consistency
        },
        "changes": {
            "added": "#98FB98",
            "removed": "#FFB6C1",
            "modified": "#FAFAD2" # Added modified for consistency
        },
        "dialog": { # Added dialog for consistency
            "background": "#FFF8DC",
            "overlay": "rgba(0,0,0,0.2)"
        }
    },
    # New 'modern_dark' theme.
    # This theme uses a contemporary color palette with desaturated blues for accents,
    # neutral grays for backgrounds, and clear text colors.
    # It's designed for improved contrast and readability and serves as the application's default dark theme.
    # Typography (font sizes, weights) is typically handled at the component level in Flet, not defined here.
    "modern_dark": {
        "bg": {
            "primary": "#20232A",     # Dark, slightly desaturated gray
            "secondary": "#2C313A",   # Slightly lighter gray for cards/containers
            "input": "#39404A",       # Input field background
            "accent": "#4A90E2",      # Desaturated blue accent
            "hover": "#5A9DEF"        # Lighter blue for hover
        },
        "text": {
            "primary": "#EAEAEA",     # Light gray for main text (good contrast)
            "secondary": "#B0B0B0",   # Updated for better contrast on bg.secondary
            "accent": "#5A9DEF",      # Accent text (matches hover)
            "disabled": "#9E9E9E"     # Updated for better contrast
        },
        "border": {
            "default": "#636A78",     # Updated for better contrast against bg.primary
            "accent": "#4A90E2",      # Desaturated blue accent border
            "focus": "#5A9DEF"        # Lighter blue for focus
        },
        "changes": {
            "added": "#50C878",       # Muted green for additions
            "removed": "#FF9797",     # Updated for better contrast on bg.secondary
            "modified": "#FBC02D"     # Muted yellow for modifications
        },
        "dialog": {
            "background": "#2C313A",  # Consistent with secondary background
            "overlay": "rgba(0,0,0,0.6)" # Slightly darker overlay
        }
    }
}

def get_theme(base_theme: str, custom_theme: str = None) -> dict:
    """Get theme colors based on base theme and custom theme selection"""
    if custom_theme and custom_theme in THEMES:
        return THEMES[custom_theme]
    # Default to 'modern_dark' if no specific theme or 'dark' is requested
    if base_theme == "dark" or base_theme is None:
        return THEMES["modern_dark"]
    return THEMES.get(base_theme, THEMES["modern_dark"])