"""Theme definitions for the Localizer application."""

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
            "modified": "#FCD34D",    # Modified items
            "warning": "#FCD34D",      # Warning items (same as modified)
            "identical": "#6B7280"    # Identical items (using secondary text color)
        },
        "dialog": {
            "background": "#1F2937",  # Dialog background
            "overlay": "rgba(0,0,0,0.5)" # Dialog overlay
        }
    },
    "light": {
        "bg": {
            "primary": "#FFFFFF",     # Main background
            "secondary": "#F3F4F6",   # Card/container background
            "input": "#F9FAFB",       # Input field background
            "accent": "#3B82F6",      # Primary accent color
            "hover": "#D1D5DB"        # Hover state color (light gray)
        },
        "text": {
            "primary": "#111827",     # Main text (dark gray)
            "secondary": "#4B5563",   # Secondary/muted text (medium gray)
            "accent": "#2563EB",      # Accent text (blue)
            "disabled": "#9CA3AF"     # Disabled text (light gray)
        },
        "border": {
            "default": "#D1D5DB",     # Default borders (light gray)
            "accent": "#3B82F6",      # Accent borders (blue)
            "focus": "#60A5FA"        # Focus state borders (lighter blue)
        },
        "changes": {
            "added": "#22C55E",       # Added items (green)
            "removed": "#EF4444",     # Removed items (red)
            "modified": "#F59E0B",    # Modified items (amber)
            "warning": "#F59E0B",      # Warning items (amber)
            "identical": "#6B7280"    # Identical items (using a gray from dark theme's disabled)
        },
        "dialog": {
            "background": "#FFFFFF",  # Dialog background
            "overlay": "rgba(0,0,0,0.3)" # Dialog overlay (light black)
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
            "modified": "#FCD34D",    # Yellow for changes
            "warning": "#FCD34D",      # Warning items (same as modified)
            "identical": "#6B7280"    # Identical items (using a gray from dark theme's disabled)
        },
        "dialog": {
            "background": "#121212",  # Slightly lighter black
            "overlay": "rgba(0,0,0,0.8)" # Dark overlay
        }
    },
    "high_contrast": {
        "bg": {
            "primary": "#FFFFFF",     # Main background (white)
            "secondary": "#F0F0F0",   # Card/container background (light gray)
            "input": "#FFFFFF",       # Input field background (white)
            "accent": "#0000FF",      # Primary accent color (blue)
            "hover": "#D0D0D0"        # Hover state color (gray)
        },
        "text": {
            "primary": "#000000",     # Main text (black)
            "secondary": "#000000",   # Secondary/muted text (black for high contrast)
            "accent": "#0000FF",      # Accent text (blue)
            "disabled": "#7F7F7F"     # Disabled text (dark gray)
        },
        "border": {
            "default": "#000000",     # Default borders (black)
            "accent": "#0000FF",      # Accent borders (blue)
            "focus": "#0000FF"        # Focus state borders (blue)
        },
        "changes": {
            "added": "#008000",       # Added items (green)
            "removed": "#FF0000",     # Removed items (red)
            "modified": "#FFA500",    # Modified items (orange)
            "warning": "#FFA500",      # Warning items (orange)
            "identical": "#696969"    # Identical items (dim gray)
        },
        "dialog": {
            "background": "#FFFFFF",  # Dialog background (white)
            "overlay": "rgba(0,0,0,0.5)" # Dialog overlay (black, semi-transparent)
        }
    },
    "minimalist": {
        "bg": {
            "primary": "#FFFFFF",     # Main background (white)
            "secondary": "#F5F5F5",   # Card/container background (very light gray)
            "input": "#FFFFFF",       # Input field background (white)
            "accent": "#2F4F4F",      # Primary accent color (dark slate gray)
            "hover": "#E0E0E0"        # Hover state color (light gray)
        },
        "text": {
            "primary": "#2F4F4F",     # Main text (dark slate gray)
            "secondary": "#708090",   # Secondary/muted text (slate gray)
            "accent": "#2F4F4F",      # Accent text (dark slate gray, for better visibility)
            "disabled": "#A9A9A9"     # Disabled text (dark gray)
        },
        "border": {
            "default": "#D3D3D3",     # Default borders (light gray)
            "accent": "#2F4F4F",      # Accent borders (dark slate gray)
            "focus": "#5F9EA0"        # Focus state borders (cadet blue, related to accent)
        },
        "changes": {
            "added": "#4CAF50",       # Added items (green)
            "removed": "#F44336",     # Removed items (red)
            "modified": "#FFC107",    # Modified items (amber)
            "warning": "#FF9800",      # Warning items (orange)
            "identical": "#B0BEC5"    # Identical items (blue grey lighten-3)
        },
        "dialog": {
            "background": "#FFFFFF",  # Dialog background (white)
            "overlay": "rgba(0,0,0,0.3)" # Dialog overlay (light black)
        }
    },
    "earth_tones": {
        "bg": {
            "primary": "#F5F5DC",     # Beige background
            "secondary": "#E8E4C9",   # Lighter beige for containers
            "input": "#F5F5DC",       # Input background
            "accent": "#8B4513",      # Saddle brown accent
            "hover": "#D2B48C"        # Tan hover
        },
        "text": {
            "primary": "#8B4513",     # Saddle brown text
            "secondary": "#A0522D",   # Sienna secondary text
            "accent": "#8B4513",      # Saddle brown accent text
            "disabled": "#BC8F8F"     # Rosy brown disabled text
        },
        "border": {
            "default": "#DEB887",     # Burlywood border
            "accent": "#8B4513",      # Saddle brown accent border
            "focus": "#A0522D"        # Sienna focus border
        },
        "changes": {
            "added": "#228B22",       # Forest green for adds
            "removed": "#CD5C5C",     # Indian red for removes
            "modified": "#DAA520",    # Goldenrod for modified
            "warning": "#FF8C00",      # DarkOrange for warning
            "identical": "#A0522D"    # Identical items (sienna - secondary text color)
        },
        "dialog": {
            "background": "#F5F5DC",  # Beige dialog background
            "overlay": "rgba(0,0,0,0.4)" # Dim overlay
        }
    },
    "pastel": {
        "bg": {
            "primary": "#FFFACD",     # Lemon chiffon background
            "secondary": "#FFF0F5",   # Lavender blush for containers
            "input": "#FAFAD2",       # Light goldenrod yellow input
            "accent": "#FFB6C1",      # Light pink accent
            "hover": "#FFDEAD"        # Navajo white hover
        },
        "text": {
            "primary": "#778899",     # Light slate gray text
            "secondary": "#B0C4DE",   # Light steel blue secondary text
            "accent": "#DB7093",      # Pale violet red accent text
            "disabled": "#D3D3D3"     # Light gray disabled text
        },
        "border": {
            "default": "#E6E6FA",     # Lavender border
            "accent": "#FFB6C1",      # Light pink accent border
            "focus": "#ADD8E6"        # Light blue focus border
        },
        "changes": {
            "added": "#90EE90",       # Light green for adds
            "removed": "#FF7F7F",     # Light coral for removes (custom, lighter than F87171)
            "modified": "#FFDAB9",    # Peachpuff for modified
            "warning": "#FFA07A",      # Light salmon for warning
            "identical": "#B0C4DE"    # Identical items (light steel blue - secondary text color)
        },
        "dialog": {
            "background": "#FFFACD",  # Lemon chiffon dialog background
            "overlay": "rgba(0,0,0,0.2)" # Very light dim overlay
        }
    }
}

def get_theme(base_theme: str, custom_theme: str = None) -> dict:
    """Get theme colors based on base theme and custom theme selection"""
    if custom_theme and custom_theme in THEMES:
        return THEMES[custom_theme]
    return THEMES.get(base_theme, THEMES["dark"])