"""Theme definitions for the Localizer application, based on Material Design 3."""

# Reference M3 Roles (conceptual, actual values may vary per theme)
# primary, onPrimary, primaryContainer, onPrimaryContainer
# secondary, onSecondary, secondaryContainer, onSecondaryContainer
# tertiary, onTertiary, tertiaryContainer, onTertiaryContainer
# error, onError, errorContainer, onErrorContainer
# background, onBackground
# surface, onSurface, surfaceVariant, onSurfaceVariant
# outline, outlineVariant
# shadow, scrim
# inverseSurface, inverseOnSurface, inversePrimary

THEMES = {
    "light": {
        "primary": "#6200EE",  # Example: Purple
        "onPrimary": "#FFFFFF",
        "primaryContainer": "#EADDFF",  # Light purple
        "onPrimaryContainer": "#21005D", # Dark purple

        "secondary": "#03DAC6",  # Example: Teal
        "onSecondary": "#000000",
        "secondaryContainer": "#A7F3E6", # Light teal
        "onSecondaryContainer": "#00201B", # Dark teal

        "tertiary": "#03A9F4", # Example: Light Blue
        "onTertiary": "#000000",
        "tertiaryContainer": "#B3E5FC", # Light blue
        "onTertiaryContainer": "#011C27", # Dark blue

        "error": "#B00020", # Example: Red
        "onError": "#FFFFFF",
        "errorContainer": "#FCD8DF", # Light red
        "onErrorContainer": "#3E001D", # Dark red

        "background": "#FFFBFE", # Near white
        "onBackground": "#1C1B1F", # Dark gray

        "surface": "#FFFBFE", # Near white (can be same as background)
        "onSurface": "#1C1B1F", # Dark gray
        "surfaceVariant": "#E7E0EC", # Grayish
        "onSurfaceVariant": "#49454F", # Darker grayish

        "outline": "#79747E", # Medium gray
        "outlineVariant": "#C4C7C5", # Light gray for less prominent borders

        "shadow": "#000000", # For casting shadows
        "scrim": "rgba(0, 0, 0, 0.5)", # Overlay

        "inverseSurface": "#313033", # Dark gray
        "inverseOnSurface": "#F4EFF4", # Light gray
        "inversePrimary": "#D0BCFF", # Light purple

        # Custom/mapped from old structure
        "inputBackground": "#F3F4F6", # From old light.bg.input
        "textDisabled": "#9CA3AF",    # Muted text, for disabled states
        "textAccent": "#6200EE",      # Same as primary for accented text

        "changes": { # Keeping this structure for now, mapping to M3 semantic colors
            "added": "#4CAF50",       # Green (consider mapping to tertiary or custom)
            "removed": "#F44336",     # Red (consider mapping to error or custom)
            "modified": "#FFC107"     # Amber (consider mapping to secondary or custom)
        },
        "dialog": {
            "background": "#FFFBFE",  # surface
            "overlay": "rgba(0,0,0,0.4)" # scrim
        }
    },
    "dark": {
        "primary": "#D0BCFF",  # Example: Light Purple
        "onPrimary": "#381E72", # Dark Purple
        "primaryContainer": "#4F378B", # Medium Purple
        "onPrimaryContainer": "#EADDFF", # Light Purple

        "secondary": "#80CBC4",  # Example: Light Teal
        "onSecondary": "#003731", # Dark Teal
        "secondaryContainer": "#004F48", # Medium Teal
        "onSecondaryContainer": "#9CF1E7", # Light Teal

        "tertiary": "#81D4FA", # Example: Light Blue
        "onTertiary": "#00344A", # Dark Blue
        "tertiaryContainer": "#004C6A", # Medium Blue
        "onTertiaryContainer": "#B3E5FC", # Light Blue

        "error": "#F2B8B5", # Example: Light Red
        "onError": "#601410", # Dark Red
        "errorContainer": "#8C1D18", # Medium Red
        "onErrorContainer": "#FCD8DF", # Light Red

        "background": "#1C1B1F", # Dark Gray
        "onBackground": "#E6E1E5", # Light Gray

        "surface": "#1C1B1F", # Dark Gray (can be same as background)
        "onSurface": "#E6E1E5", # Light Gray
        "surfaceVariant": "#49454F", # Medium Dark Gray
        "onSurfaceVariant": "#CAC4D0", # Light Grayish

        "outline": "#938F99", # Light-Medium Gray
        "outlineVariant": "#444746", # Dark gray for less prominent borders

        "shadow": "#000000",
        "scrim": "rgba(0, 0, 0, 0.6)",

        "inverseSurface": "#E6E1E5", # Light Gray
        "inverseOnSurface": "#313033", # Dark Gray
        "inversePrimary": "#6200EE", # Purple

        # Custom/mapped from old structure
        "inputBackground": "#374151", # From old dark.bg.input
        "textDisabled": "#6B7280",    # Muted text
        "textAccent": "#D0BCFF",      # Same as primary for accented text

        "changes": {
            "added": "#4CAF50",
            "removed": "#F44336",
            "modified": "#FFC107"
        },
        "dialog": {
            "background": "#2C2B2F", # Slightly lighter than main surface for emphasis
            "overlay": "rgba(0,0,0,0.5)"
        }
    },
    "amoled": { # Best effort mapping to M3
        "primary": "#BB86FC", # Light Purple (accent)
        "onPrimary": "#000000",
        "primaryContainer": "#3700B3", # Darker Purple
        "onPrimaryContainer": "#FFFFFF",

        "secondary": "#03DAC6", # Teal (another accent)
        "onSecondary": "#000000",
        "secondaryContainer": "#018786", # Darker Teal
        "onSecondaryContainer": "#FFFFFF",

        "tertiary": "#3B82F6", # Blue from original amoled.bg.accent
        "onTertiary": "#FFFFFF",
        "tertiaryContainer": "#1E40AF", # Darker blue
        "onTertiaryContainer": "#FFFFFF",

        "error": "#CF6679", # Light Red
        "onError": "#000000",
        "errorContainer": "#B00020", # Dark Red
        "onErrorContainer": "#FFFFFF",

        "background": "#000000", # Pure black
        "onBackground": "#FFFFFF", # Pure white

        "surface": "#000000", # Pure black
        "onSurface": "#FFFFFF", # Pure white
        "surfaceVariant": "#121212", # Slightly lighter black from old amoled.bg.input
        "onSurfaceVariant": "#9CA3AF", # Gray from old amoled.text.secondary

        "outline": "#1F1F1F", # Very dark gray from old amoled.border.default
        "outlineVariant": "#0A0A0A",

        "shadow": "#000000",
        "scrim": "rgba(0,0,0,0.8)", # From old amoled.dialog.overlay

        "inputBackground": "#121212",
        "textDisabled": "#6B7280",
        "textAccent": "#BB86FC", # primary

        "changes": {
            "added": "#4ADE80",
            "removed": "#F87171",
            "modified": "#FCD34D"
        },
        "dialog": {
            "background": "#121212",
            "overlay": "rgba(0,0,0,0.8)"
        }
    },
    "high_contrast": { # Best effort mapping to M3
        "primary": "#1E90FF", # Dodger Blue from old accent
        "onPrimary": "#FFFFFF",
        "primaryContainer": "#0000FF", # Blue
        "onPrimaryContainer": "#FFFFFF",

        "secondary": "#000000", # Black, for high contrast elements
        "onSecondary": "#FFFFFF",
        "secondaryContainer": "#333333",
        "onSecondaryContainer": "#FFFFFF",

        "tertiary": "#1E90FF", # Re-using primary
        "onTertiary": "#FFFFFF",
        "tertiaryContainer": "#CDEBFF",
        "onTertiaryContainer": "#000000",

        "error": "#FF4500", # OrangeRed from old removed
        "onError": "#FFFFFF",
        "errorContainer": "#FF0000", # Red
        "onErrorContainer": "#FFFFFF",

        "background": "#FFFFFF", # White
        "onBackground": "#000000", # Black

        "surface": "#FFFFFF", # White
        "onSurface": "#000000", # Black
        "surfaceVariant": "#F8F9FA", # Very light gray from old secondary bg
        "onSurfaceVariant": "#000000", # Black

        "outline": "#000000", # Black from old border
        "outlineVariant": "#333333",

        "shadow": "#000000",
        "scrim": "rgba(0,0,0,0.3)",

        "inputBackground": "#FFFFFF",
        "textDisabled": "#A9A9A9", # Dark Gray
        "textAccent": "#1E90FF", # primary

        "changes": {
            "added": "#32CD32", # LimeGreen
            "removed": "#FF4500", # OrangeRed
            "modified": "#FFD700"  # Gold
        },
        "dialog": {
            "background": "#FFFFFF",
            "overlay": "rgba(0,0,0,0.3)"
        }
    },
    "minimalist": { # Best effort mapping to M3
        "primary": "#2F4F4F", # DarkSlateGray from old accent
        "onPrimary": "#FFFFFF",
        "primaryContainer": "#5A7D7C",
        "onPrimaryContainer": "#FFFFFF",

        "secondary": "#708090", # SlateGray from old text.secondary
        "onSecondary": "#FFFFFF",
        "secondaryContainer": "#A0AEC0",
        "onSecondaryContainer": "#000000",

        "tertiary": "#A9A9A9", # DarkGray from old text.accent
        "onTertiary": "#000000",
        "tertiaryContainer": "#D3D3D3", # LightGray
        "onTertiaryContainer": "#000000",

        "error": "#FF6B6B", # Light Red from old removed
        "onError": "#FFFFFF",
        "errorContainer": "#FFBABA",
        "onErrorContainer": "#000000",

        "background": "#FFFFFF", # White
        "onBackground": "#2F4F4F", # DarkSlateGray

        "surface": "#FFFFFF", # White
        "onSurface": "#2F4F4F", # DarkSlateGray
        "surfaceVariant": "#F5F5F5", # Very light gray from old bg.secondary
        "onSurfaceVariant": "#708090", # SlateGray

        "outline": "#B0C4DE", # LightSteelBlue from old border
        "outlineVariant": "#C0D0E0",

        "shadow": "#000000",
        "scrim": "rgba(0,0,0,0.1)",

        "inputBackground": "#FFFFFF",
        "textDisabled": "#BFBFBF", # Lighter gray
        "textAccent": "#2F4F4F", # primary

        "changes": {
            "added": "#4ADE80",
            "removed": "#FF6B6B",
            "modified": "#FFD700" # Gold
        },
        "dialog": {
            "background": "#FFFFFF",
            "overlay": "rgba(0,0,0,0.1)"
        }
    },
    "earth_tones": { # Best effort mapping to M3
        "primary": "#8B4513", # SaddleBrown from old accent
        "onPrimary": "#FFFFFF",
        "primaryContainer": "#D2B48C", # Tan (related to old text.accent)
        "onPrimaryContainer": "#5C2E0B",

        "secondary": "#CD853F", # Peru from old text.secondary
        "onSecondary": "#000000",
        "secondaryContainer": "#F5DEB3", # Wheat
        "onSecondaryContainer": "#5C2E0B",

        "tertiary": "#A0522D", # Sienna
        "onTertiary": "#FFFFFF",
        "tertiaryContainer": "#E9967A", # DarkSalmon
        "onTertiaryContainer": "#5C2E0B",

        "error": "#CD5C5C", # IndianRed from old removed
        "onError": "#FFFFFF",
        "errorContainer": "#E9967A", # DarkSalmon
        "onErrorContainer": "#5C2E0B",

        "background": "#F5F5DC", # Beige from old bg.primary
        "onBackground": "#8B4513", # SaddleBrown

        "surface": "#F5F5DC", # Beige
        "onSurface": "#8B4513", # SaddleBrown
        "surfaceVariant": "#E8E4C9", # Lighter beige from old bg.secondary
        "onSurfaceVariant": "#8B4513",

        "outline": "#DEB887", # BurlyWood from old border
        "outlineVariant": "#E8E4C9",

        "shadow": "rgba(139,69,19,0.3)", # Shadow based on primary
        "scrim": "rgba(139,69,19,0.2)",

        "inputBackground": "#F5F5DC",
        "textDisabled": "#A0522D", # Sienna (lighter than primary)
        "textAccent": "#8B4513", # primary

        "changes": {
            "added": "#228B22", # ForestGreen
            "removed": "#CD5C5C", # IndianRed
            "modified": "#DAA520"  # Goldenrod
        },
        "dialog": {
            "background": "#E8E4C9",
            "overlay": "rgba(139,69,19,0.2)"
        }
    },
    "pastel": { # Best effort mapping to M3
        "primary": "#FFB6C1", # LightPink from old accent
        "onPrimary": "#696969", # DimGray (for contrast)
        "primaryContainer": "#FFDDE1",
        "onPrimaryContainer": "#696969",

        "secondary": "#ADD8E6", # LightBlue from old text.accent
        "onSecondary": "#696969",
        "secondaryContainer": "#DDEEFF",
        "onSecondaryContainer": "#696969",

        "tertiary": "#98FB98", # PaleGreen from old border/changes
        "onTertiary": "#696969",
        "tertiaryContainer": "#DDFFDD",
        "onTertiaryContainer": "#696969",

        "error": "#FFB6C1", # Re-using primary as error for pastel, as it's soft
        "onError": "#696969",
        "errorContainer": "#FFDDE1",
        "onErrorContainer": "#696969",

        "background": "#FFFACD", # LemonChiffon from old bg.primary
        "onBackground": "#696969", # DimGray

        "surface": "#FFFACD", # LemonChiffon
        "onSurface": "#696969", # DimGray
        "surfaceVariant": "#FFF8DC", # Cornsilk from old bg.secondary
        "onSurfaceVariant": "#808080", # Gray

        "outline": "#98FB98", # PaleGreen from old border
        "outlineVariant": "#D3D3D3", # LightGray

        "shadow": "rgba(105,105,105,0.2)", # Shadow based on onBackground
        "scrim": "rgba(105,105,105,0.1)",

        "inputBackground": "#FFFACD",
        "textDisabled": "#BEBEBE", # Lighter gray
        "textAccent": "#FFB6C1", # primary

        "changes": {
            "added": "#98FB98",
            "removed": "#FFB6C1",
            "modified": "#FFD700"  # Gold
        },
        "dialog": {
            "background": "#FFF8DC",
            "overlay": "rgba(105,105,105,0.1)"
        }
    }
}

def get_theme(base_theme: str, custom_theme: str = None) -> dict:
    """Get theme colors based on base theme and custom theme selection"""
    # Fallback to "light" if base_theme is not found, previously was "dark"
    # M3 typically defaults to light.
    effective_base_theme = base_theme if base_theme in THEMES else "light"

    if custom_theme and custom_theme in THEMES:
        return THEMES[custom_theme]
    return THEMES.get(effective_base_theme, THEMES["light"])

# Example of how to access a color:
# current_theme = get_theme("light")
# primary_color = current_theme["primary"]
# on_primary_color = current_theme["onPrimary"]
# added_color = current_theme["changes"]["added"]
