import flet as ft
import re  # Add this import
from flet import (
    Checkbox,
    Column,
    Container,
    ElevatedButton,
    FilePicker,
    FilePickerResultEvent,
    Icon,
    Page,
    Row,
    SnackBar,
    Text,
    TextField,
    border,
    border_radius,
    padding,
    ProgressRing,
    IconButton,
    Tooltip,
    AnimatedSwitcher,
    Colors,  # Add this import
    Icons,   # Add this import
    ButtonStyle,
    RoundedRectangleBorder,
    TextStyle,
    FontWeight,
    ScrollMode,
    ResponsiveRow,
    Divider,
    Card,
    ClipBehavior,
    VerticalDivider,  # Added missing import
    TextButton,  # <-- Added
    Tabs,  # <-- Added
    Tab  # <-- Added
)
import os
import logic
import logging  # Add this import
from pathlib import Path
from core.constants import SUPPORTED_FORMATS, USER_MESSAGES, GOOGLE_CLOUD_LANGUAGES
from core.themes import THEMES  # Updated import path
from components import (
    FileInputComponent,
    ResultsViewComponent,
    SettingsDialogComponent,
    StatsPanelComponent
)
import threading  # Add at top if not already imported
from utils.logger_service import logger_service
import datetime                        # Added to fix NameError
from utils import history_manager      # New import for history management
from core.config import ConfigManager
from components.onboarding import OnboardingTutorial
import asyncio
import time
from utils.file_cache_service import file_cache_service
from utils.file_processing_service import file_processing_service

# Get logger from service
logger = logger_service.get_logger()

class App:
    """Main GUI application class implementing localization comparison using flet."""

    def __init__(self, page: ft.Page):
        """Initialize the application, load configuration and setup UI elements."""
        self.page = page
        # Add color cache
        self._cached_colors = {}
        
        # Replace the existing THEMES with the imported one
        self.THEMES = THEMES

        # Load configuration with defaults already merged
        self.config = ConfigManager.load()
        
        # Apply configuration-dependent setup
        self.log_missing_strings = self.config["log_missing_strings"]
        self.current_theme = self.config["theme"]
        self.COLORS = self.THEMES[self.current_theme if self.current_theme != "system" else "dark"]
        self._cached_colors[self.current_theme] = self.COLORS

        # Update page theme mode based on saved theme
        if self.current_theme == "system":
            page.theme_mode = ft.ThemeMode.SYSTEM
        elif self.current_theme in ["dark", "amoled"]:
            page.theme_mode = ft.ThemeMode.DARK
        else:
            page.theme_mode = ft.ThemeMode.LIGHT

        # Remove theme toggle button initialization and keep only settings button
        self.settings_button = IconButton(
            icon=Icons.SETTINGS,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Settings",  # Changed from "Theme Settings"
            on_click=self.open_settings
        )

        self.log_missing_strings = False  # New flag for missing strings logging

        # Add new configuration variables
        self.config = {
            "auto_fill_missing": False,
            "log_missing_strings": False,
            "ignore_patterns": [],
            "preferred_format": "auto",  # auto, json, yaml, lang, xml
            "ignore_whitespace": False,
            "ignore_case": False,
            "compare_values": True,
            "group_by_namespace": True,  # Add this line
            "show_preview": False,  # Add this line
            "show_line_numbers": False,  # Add this line
        }

        # Add MT settings to config
        self.config.update({
            "mt_enabled": False,
            "mt_api_key": "",
            "mt_source_lang": "en",
            "mt_target_lang": "tr"
        })

        # Initialize configuration from defaults then merge saved settings
        saved_config = ConfigManager.load()
        if saved_config:
            self.config.update(saved_config)
        
        # Set initial theme from config
        self.current_theme = self.config.get("theme", "system")
        self.COLORS = self.THEMES[self.current_theme if self.current_theme != "system" else "dark"]
        self._cached_colors[self.current_theme] = self.COLORS

        # Update page theme mode based on saved theme
        if self.current_theme == "system":
            page.theme_mode = ft.ThemeMode.SYSTEM
        elif self.current_theme in ["dark", "amoled"]:
            page.theme_mode = ft.ThemeMode.DARK
        else:
            page.theme_mode = ft.ThemeMode.LIGHT

        # Create tabs for settings dialog
        general_tab = Tab(
            text="General",
            icon=Icons.SETTINGS,
            content=Container(
                content=Column(
                    controls=[
                        Container(
                            content=Column(
                                controls=[
                                    Text("Theme Settings", size=16, weight="bold"),
                                    ft.Dropdown(
                                        label="Theme Mode",
                                        value=self.current_theme,  # Use saved theme
                                        options=[
                                            ft.dropdown.Option("system", "System Default"),
                                            ft.dropdown.Option("dark", "Dark Theme"),
                                            ft.dropdown.Option("light", "Light Theme"),
                                            ft.dropdown.Option("amoled", "AMOLED Dark"),
                                            ft.dropdown.Option("high_contrast", "High Contrast"),
                                            ft.dropdown.Option("minimalist", "Minimalist"),
                                            ft.dropdown.Option("earth_tones", "Earth Tones"),
                                            ft.dropdown.Option("pastel", "Pastel"),
                                        ],
                                        on_change=self.handle_theme_change,
                                    ),
                                    TextButton("Custom Themes", on_click=self.open_custom_theme_settings),
                                ],
                                spacing=8
                            ),
                            padding=10,
                        ),
                    ],
                ),
                padding=20,
            ),
        )

        # Create tabs for settings dialog with the updated general tab
        self.settings_tabs = Tabs(
            selected_index=0,
            animation_duration=300,
            tabs=[
                general_tab,
                Tab(
                    text="Comparison",
                    icon=Icons.COMPARE_ARROWS,
                    content=Container(
                        content=Column(
                            controls=[
                                Container(
                                    content=Column(
                                        controls=[
                                            Text("Comparison Settings", size=16, weight="bold"),
                                            ft.Checkbox(
                                                label="Show File Preview",
                                                value=self.config["show_preview"],
                                                on_change=self.handle_preview_toggle
                                            ),
                                            ft.Checkbox(
                                                label="Show Line Numbers",  # Add this checkbox
                                                value=self.config["show_line_numbers"],
                                                on_change=self.handle_line_numbers_toggle
                                            ),
                                            ft.Checkbox(
                                                label="Auto-Fill Missing Keys",
                                                value=self.config["auto_fill_missing"],
                                                on_change=self.handle_auto_fill_change
                                            ),
                                            ft.Checkbox(
                                                label="Log Missing Keys",
                                                value=self.config["log_missing_strings"],
                                                on_change=self.handle_log_missing_change
                                            ),
                                            ft.Checkbox(
                                                label="Ignore Whitespace",
                                                value=self.config["ignore_whitespace"],
                                                on_change=self.handle_whitespace_change
                                            ),
                                            ft.Checkbox(
                                                label="Ignore Case",
                                                value=self.config["ignore_case"],
                                                on_change=self.handle_case_change
                                            ),
                                            ft.Checkbox(
                                                label="Group by Namespace",
                                                value=self.config["group_by_namespace"],
                                                on_change=self.handle_group_by_namespace_change
                                            ),
                                        ],
                                        spacing=8
                                    ),
                                    padding=10,
                                ),
                            ],
                        ),
                        padding=20,
                    ),
                ),
                Tab(
                    text="File Format",
                    icon=Icons.FILE_PRESENT,
                    content=Container(
                        content=Column(
                            controls=[
                                Container(
                                    content=Column(
                                        controls=[
                                            Text("File Format Settings", size=16, weight="bold"),
                                            ft.Dropdown(
                                                label="Preferred Format",
                                                value=self.config["preferred_format"],
                                                options=[
                                                    ft.dropdown.Option("auto", "Auto-Detect"),
                                                    ft.dropdown.Option("json", "JSON"),
                                                    ft.dropdown.Option("yaml", "YAML"),
                                                    ft.dropdown.Option("lang", ".lang"),
                                                    ft.dropdown.Option("xml", "XML"),
                                                ],
                                                on_change=self.handle_format_change,
                                            ),
                                        ],
                                        spacing=8
                                    ),
                                    padding=10,
                                ),
                                Container(
                                    content=Column(
                                        controls=[
                                            Text("Ignore Patterns", size=16, weight="bold"),
                                            TextField(
                                                value=",".join(self.config["ignore_patterns"]),
                                                hint_text="Enter regex patterns (comma-separated)",
                                                on_change=self.handle_patterns_change,
                                                multiline=True,
                                                min_lines=2,
                                                max_lines=4,
                                            ),
                                            Text(
                                                "Example: temp_, test_, debug_",
                                                size=12,
                                                color=self.COLORS["text"]["secondary"],
                                            ),
                                        ],
                                        spacing=8
                                    ),
                                    padding=10,
                                ),
                            ],
                        ),
                        padding=20,
                    ),
                ),
                Tab(
                    text="Translation",
                    icon=Icons.TRANSLATE,
                    content=Container(
                        content=Column(
                            controls=[
                                Container(
                                    content=Column(
                                        controls=[
                                            Text("Machine Translation Settings", size=16, weight="bold"),
                                            ft.Checkbox(
                                                label="Enable Machine Translation",
                                                value=self.config["mt_enabled"],
                                                on_change=self.handle_mt_enabled_change
                                            ),
                                            TextField(
                                                label="Google Cloud API Key",
                                                value=self.config["mt_api_key"],
                                                password=True,
                                                can_reveal_password=True,
                                                on_change=self.handle_mt_api_key_change
                                            ),
                                            ft.Dropdown(
                                                label="Source Language",
                                                value=self.config["mt_source_lang"],
                                                options=[
                                                    ft.dropdown.Option(code, name)
                                                    for code, name in sorted(GOOGLE_CLOUD_LANGUAGES.items(), key=lambda x: x[1])
                                                ],
                                                on_change=self.handle_mt_source_lang_change
                                            ),
                                            ft.Dropdown(
                                                label="Target Language",
                                                value=self.config["mt_target_lang"],
                                                options=[
                                                    ft.dropdown.Option(code, name)
                                                    for code, name in sorted(GOOGLE_CLOUD_LANGUAGES.items(), key=lambda x: x[1])
                                                ],
                                                on_change=self.handle_mt_target_lang_change
                                            ),
                                        ],
                                        spacing=8
                                    ),
                                    padding=10,
                                ),
                            ],
                        ),
                        padding=20,
                    ),
                ),
            ],
            expand=1,
        )

        # Add keyboard navigation settings to config
        self.config.update({
            "enable_keyboard_nav": True,
            "high_contrast": False,
            "large_text": False,
            "font_size_scale": 1.0
        })

        # Update accessibility tab to remove the keyboard navigation option
        accessibility_tab = Tab(
            text="Accessibility",
            icon=Icons.ACCESSIBILITY,
            content=Container(
                content=Column(
                    controls=[
                        Text("Accessibility Settings", size=16, weight="bold"),
                        # Removed: Keyboard Navigation option
                        ft.Checkbox(
                            label="High Contrast Mode",
                            value=self.config["high_contrast"],
                            on_change=self.handle_contrast_change,
                            tooltip="Enable high contrast colors"
                        ),
                        ft.Checkbox(
                            label="Large Text",
                            value=self.config["large_text"],
                            on_change=self.handle_text_size_change,
                            tooltip="Increase text size"
                        ),
                        ft.Slider(
                            min=1.0,
                            max=2.0,
                            divisions=4,
                            value=self.config["font_size_scale"],
                            label="Text Size Scale",
                            on_change=self.handle_font_scale_change,
                            tooltip="Adjust overall text size"
                        ),
                    ],
                    spacing=20,
                ),
                padding=20,
            ),
        )
        
        # Add accessibility tab to settings
        self.settings_tabs.tabs.append(accessibility_tab)

        # Update button creation with accessibility improvements
        def create_accessible_button(text, icon, tooltip, on_click, tab_index):
            return ElevatedButton(
                text=text,
                icon=icon,
                tooltip=tooltip,
                on_click=on_click,
                focusable=True,
                data={"tab_index": tab_index},
                style=ButtonStyle(
                    color=self.COLORS["text"]["primary"],
                    bgcolor=self.COLORS["bg"]["accent"],
                    shape=RoundedRectangleBorder(radius=8),
                ),
            )

        # Update text field creation with accessibility improvements
        def create_accessible_textfield(hint_text, label, tooltip, tab_index):
            return TextField(
                hint_text=hint_text,
                label=label,
                tooltip=tooltip,
                focusable=True,
                data={"tab_index": tab_index},
            )

        # Update settings dialog to use tabs
        self.settings_dialog = ft.AlertDialog(
            title=Text("Settings", size=20),
            content=Container(
                content=Column(
                    controls=[self.settings_tabs],
                    scroll=ft.ScrollMode.AUTO,
                ),
                width=500,  # Made slightly wider to accommodate tabs
                height=400,  # Fixed height for better appearance
            ),
            actions=[
                TextButton("Reset to Default", on_click=self.reset_settings),
                TextButton("Close", on_click=self.close_settings),
            ],
        )

        # Initialize file paths
        self.source_file_path = ""
        self.target_file_path = ""
        
        # Then initialize UI elements
        self.output_text = TextField(
            value="Comparison results will appear here",
            multiline=True,
            read_only=True,
            min_lines=20,  # Increased minimum lines
            max_lines=None,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",  # Make background transparent
            expand=True,
        )
        self.source_text = TextField(
            value="Source file content will appear here",
            multiline=True,
            read_only=True,
            min_lines=20,
            max_lines=None,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )
        self.target_text = TextField(
            value="Target file content will appear here",
            multiline=True,
            read_only=True,
            min_lines=20,
            max_lines=None,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )
        # New summary text field for comparison summary
        self.summary_text = TextField(
            value="Summary will appear here",
            read_only=True,
            multiline=True,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )
        # Update results container to clip overflowing text
        self.results_container = Container(
            content=self.summary_text,
            padding=padding.all(16),
            expand=True,
            clip_behavior=ft.ClipBehavior.HARD_EDGE  # Changed from CLIP to HARD_EDGE
        )
        self.status_label = Text(
            value="Ready",
            color=self.COLORS["text"]["secondary"],
            size=14,
        )
        self.loading_ring = ProgressRing(
            width=20,
            height=20,
            stroke_width=2,
            color=self.COLORS["bg"]["accent"],
            visible=False,
        )
        # Initialize checkboxes and button
        # Remove these checkbox initializations since they're now in settings only
        # self.ignore_case_checkbox = self.create_checkbox("Ignore Case")
        # self.ignore_whitespace_checkbox = self.create_checkbox("Ignore Whitespace")
        # self.only_missing_checkbox = self.create_checkbox("Only Missing Keys", value=True)
        # Only keep the ignore pattern field
        self.ignore_pattern_field = TextField(
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            hint_text="Enter regex patterns (comma-separated)",
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )
        self.compare_button = self.create_compare_button()
        
        self.source_label = Text("No file selected", color=self.COLORS["text"]["secondary"], expand=True)
        self.target_label = Text("No file selected", color=self.COLORS["text"]["secondary"], expand=True)
        self.source_icon = Icon(Icons.DESCRIPTION, color=self.COLORS["text"]["secondary"], size=20)
        self.target_icon = Icon(Icons.DESCRIPTION, color=self.COLORS["text"]["secondary"], size=20)
        
        self.source_picker = FilePicker(on_result=lambda e: self.handle_file_picked(e, self.source_label, self.source_icon, "source"))
        self.target_picker = FilePicker(on_result=lambda e: self.handle_file_picked(e, self.target_label, self.target_icon, "target"))
        
        page.overlay.extend([self.source_picker, self.target_picker])
        # Page setup
        page.title = "Localization Helper"
        page.theme_mode = ft.ThemeMode.SYSTEM
        page.padding = 0  # We'll handle padding in the main container
        page.bgcolor = "#111827"  # Matches Tailwind's gray-900
        page.snack_bar = SnackBar(
            content=Text(""),
            bgcolor="#374151",  # Tailwind gray-700
        )
        
        # Configure default and dark themes
        page.theme = ft.Theme(color_scheme_seed=Colors.GREEN)
        page.dark_theme = ft.Theme(color_scheme_seed=Colors.BLUE)

        # Create modern file input
        def create_file_input(label: str, is_source=True):
            # Create a Browse button and wrap it in an AnimatedContainer for hover effects.
            browse_button = ElevatedButton(
                "Browse",
                icon=Icons.UPLOAD,
                tooltip=f"Select a {label}",
                on_click=self.open_source_picker if is_source else self.open_target_picker,
                bgcolor=self.COLORS["bg"]["accent"],
                color=self.COLORS["text"]["primary"],
                height=36,
                style=ButtonStyle(shape=RoundedRectangleBorder(radius=8)),
                focusable=True,
                data={"tab_index": 1 if is_source else 2}
            )
            # Wrap in a container to enable hover state transition.
            hover_button = Container(
                content=browse_button,
                animate=ft.Animation(duration=200, curve="easeInOut"),
                on_hover=lambda e, btn=browse_button: self._on_browse_hover(e, btn)
            )
            return Container(
                content=Column(
                    controls=[
                        Text(label, color=self.COLORS["text"]["secondary"], size=14, weight=FontWeight.W_500),
                        Container(
                            content=Row(
                                controls=[
                                    self.source_icon if is_source else self.target_icon,
                                    self.source_label if is_source else self.target_label,
                                    hover_button,
                                ],
                                alignment="center",
                                spacing=8,
                            ),
                            border=border.all(2, self.COLORS["border"]["default"]),
                            border_radius=8,
                            bgcolor=self.COLORS["bg"]["input"],
                            padding=12,
                        ),
                    ],
                    spacing=8,
                )
            )

        # Main content area with vertical scrolling
        self.file_input = FileInputComponent(page, self)
        self.source_file_container = self.file_input.source_file_container
        self.target_file_container = self.file_input.target_file_container

        # Add statistics fields after other UI element initializations
        self.stats_text_total = Text(
            value="0",
            size=24,
            weight=FontWeight.BOLD,
            color=self.COLORS["text"]["primary"],
        )
        self.stats_text_missing = Text(
            value="0",
            size=24,
            weight=FontWeight.BOLD,
            color=self.COLORS["changes"]["removed"],
        )
        self.stats_text_obsolete = Text(
            value="0",
            size=24,
            weight=FontWeight.BOLD,
            color=self.COLORS["changes"]["added"],
        )

        # Create statistics panel
        self.stats_panel = Card(
            content=Container(
                content=Row(
                    controls=[
                        Container(
                            content=Column(
                                controls=[
                                    Text("Total Keys", size=14, color=self.COLORS["text"]["secondary"]),
                                    self.stats_text_total,
                                ],
                                horizontal_alignment="center",
                                spacing=4,
                            ),
                            padding=padding.all(16),
                            expand=True,
                        ),
                        VerticalDivider(
                            color=self.COLORS["border"]["default"],
                            width=1,
                        ),
                        Container(
                            content=Column(
                                controls=[
                                    Text("Missing in Target", size=14, color=self.COLORS["text"]["secondary"]),
                                    self.stats_text_missing,
                                ],
                                horizontal_alignment="center",
                                spacing=4,
                            ),
                            padding=padding.all(16),
                            expand=True,
                        ),
                        VerticalDivider(
                            color=self.COLORS["border"]["default"],
                            width=1,
                        ),
                        Container(
                            content=Column(
                                controls=[
                                    Text("Missing in Source", size=14, color=self.COLORS["text"]["secondary"]),
                                    self.stats_text_obsolete,
                                ],
                                horizontal_alignment="center",
                                spacing=4,
                            ),
                            padding=padding.all(16),
                            expand=True,
                        ),
                    ],
                    alignment="center",
                ),
                bgcolor=self.COLORS["bg"]["secondary"],
                border_radius=8,
            ),
            elevation=1,
        )

        # Add preview containers after file input initialization
        self.preview_section = Container(
            visible=False,
            content=ResponsiveRow(
                controls=[
                    Container(
                        content=Column(
                            controls=[
                                Text("Source File Preview", 
                                     size=14, 
                                     weight=FontWeight.W_500,
                                     color=self.COLORS["text"]["secondary"]),
                                Container(
                                    content=TextField(
                                        value="No file selected",
                                        multiline=True,
                                        read_only=True,
                                        min_lines=3,
                                        max_lines=5,
                                        text_style=TextStyle(
                                            color=self.COLORS["text"]["secondary"],
                                            size=14,
                                            font_family="Consolas",
                                        ),
                                    ),
                                    border=border.all(color=self.COLORS["border"]["default"]),
                                    border_radius=8,
                                    padding=8,
                                    bgcolor=self.COLORS["bg"]["input"],
                                    expand=True,
                                ),
                            ],
                            spacing=8,
                            expand=True,
                        ),
                        col={"sm": 12, "md": 6},
                        padding=5,
                        expand=True,
                    ),
                    Container(
                        content=Column(
                            controls=[
                                Text("Target File Preview", 
                                     size=14, 
                                     weight=FontWeight.W_500,
                                     color=self.COLORS["text"]["secondary"]),
                                Container(
                                    content=TextField(
                                        value="No file selected",
                                        multiline=True,
                                        read_only=True,
                                        min_lines=3,
                                        max_lines=5,
                                        text_style=TextStyle(
                                            color=self.COLORS["text"]["secondary"],
                                            size=14,
                                            font_family="Consolas",
                                        ),
                                    ),
                                    border=border.all(color=self.COLORS["border"]["default"]),
                                    border_radius=8,
                                    padding=8,
                                    bgcolor=self.COLORS["bg"]["input"],
                                    expand=True,
                                ),
                            ],
                            spacing=8,
                            expand=True,
                        ),
                        col={"sm": 12, "md": 6},
                        padding=5,
                        expand=True,
                    ),
                ],
                spacing=10,
            ),
            margin=padding.only(top=10, bottom=10),
        )

        # In the main_card_container initialization, add the stats_panel
        self.main_card_container = Container(
            expand=True,
            content=Column(
                expand=True,
                controls=[
                    # File inputs (fixed height remains)
                    Container(
                        content=ResponsiveRow(
                            controls=[
                                Container(
                                    content=self.file_input.source_file_container,
                                    col={"sm": 12, "md": 6},
                                ),
                                Container(
                                    content=self.file_input.target_file_container,
                                    col={"sm": 12, "md": 6},
                                ),
                            ],
                        ),
                        height=120,
                    ),
                    # NEW: Preview section
                    self.preview_section,
                    # Compare button (fixed height)
                    Container(
                        content=self.compare_button,
                        height=50,
                    ),
                    # NEW: Statistics panel
                    Container(
                        content=self.stats_panel,
                        padding=padding.only(top=8, bottom=8),
                    ),
                    # Results area using dynamic sizing
                    Container(
                        content=Card(
                            content=Column(
                                expand=True,
                                controls=[
                                    # Results header (unchanged)
                                    Container(
                                        content=Row(
                                            controls=[
                                                Text(
                                                    "Results",
                                                    size=16,
                                                    weight="w500",
                                                    color=self.COLORS["text"]["secondary"],
                                                ),
                                                IconButton(
                                                    icon=Icons.COPY,
                                                    icon_color=self.COLORS["text"]["secondary"],
                                                    tooltip="Copy comparison results",
                                                    on_click=self.copy_results,
                                                ),
                                            ],
                                            alignment="spaceBetween",
                                        ),
                                        padding=padding.only(left=16, right=16, top=16),
                                    ),
                                    Divider(
                                        color=self.COLORS["border"]["default"],
                                        height=1,
                                    ),
                                    # Removed: Split view container of source_text and target_text
                                    # NEW: Container for output summary only
                                    Container(
                                        content=self.results_container,
                                        padding=padding.all(16),
                                        expand=True,
                                    ),
                                    # Status indicators in footer (unchanged)
                                    Container(
                                        content=Row(
                                            controls=[
                                                self.loading_ring,
                                                self.status_label,
                                            ],
                                            spacing=8,
                                            vertical_alignment="center",
                                        ),
                                        padding=padding.only(left=16, right=16, top=8, bottom=16),
                                        expand=True,
                                    ),
                                ],
                                spacing=32,
                            ),
                            elevation=1,
                        ),
                        expand=True,
                    ),
                ],
                spacing=24,
            ),
            bgcolor=self.COLORS["bg"]["secondary"],
            padding=24,
            border_radius=12,
        )
        # Create a history button to the left of the settings button
        self.history_button = IconButton(
            icon=Icons.HISTORY,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Comparison History",
            on_click=self.open_history_dialog
        )
        self.settings_button = IconButton(
            icon=Icons.SETTINGS,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Settings",
            on_click=self.open_settings
        )
        
        # Update header row: place history_button to the left of settings_button
        self.content = Container(
            expand=True,
            height=page.height,
            padding=32,
            content=Column(
                expand=True,
                scroll=ScrollMode.AUTO,
                controls=[
                    # Header: replace placeholder with history_button and settings_button
                    Container(
                        content=Row(
                            controls=[
                                self.history_button,
                                Text(
                                    "Localization Comparison Tool",
                                    size=32,
                                    weight="bold",
                                    text_align="center",
                                    expand=True,
                                ),
                                self.settings_button,
                            ],
                            alignment="spaceBetween",
                        ),
                        padding=padding.only(bottom=24),
                        height=100,
                    ),
                    # ...existing main card container...
                    self.main_card_container,
                ],
                spacing=32,
            ),
        )
        self.page.add(self.content)
        self.page.on_window_event = self.handle_window_event

        self.user_friendly_errors = USER_MESSAGES

        page.overlay.append(self.settings_dialog)

        # Ensure updated colors once UI is built
        self.update_theme_colors()

        # Add expand/collapse control
        self.expand_all = True
        self.expand_collapse_button = IconButton(
            icon=Icons.UNFOLD_LESS,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Collapse All",
            on_click=self.toggle_expand_all,
        )

        # Modify the results header to include the expand/collapse button
        self.results_header = Container(
            content=Row(
                controls=[
                    Text(
                        "Results",
                        size=16,
                        weight="w500",
                        color=self.COLORS["text"]["secondary"],
                    ),
                    Row(
                        controls=[
                            self.expand_collapse_button,
                            IconButton(
                                icon=Icons.COPY,
                                icon_color=self.COLORS["text"]["secondary"],
                                tooltip="Copy comparison results",
                                on_click=self.copy_results,
                            ),
                        ],
                        spacing=0,
                    ),
                ],
                alignment="spaceBetween",
            ),
            padding=padding.only(left=16, right=16, top=16),
        )

        # Add directory picker support
        self.source_dir_path = ""
        self.target_dir_path = ""
        
        # Initialize directory pickers - FIXED
        self.source_dir_picker = FilePicker(
            on_result=lambda e: self.handle_dir_picked(e, "source")
        )
        self.target_dir_picker = FilePicker(
            on_result=lambda e: self.handle_dir_picked(e, "target")
        )
        
        page.overlay.extend([self.source_dir_picker, self.target_dir_picker])

        # Add tabbed results view
        self.results_tabs = Tabs(
            selected_index=0,
            animation_duration=300,
            tabs=[],  # Will be populated dynamically
            visible=False,
            expand=True,
        )

        # Initialize results view component
        self.results_view = ResultsViewComponent(page, self, self.COLORS)
        
        # Update results area card to clip its content as well
        self.results_area = Container(
            content=Card(
                content=Column(
                    expand=True,
                    controls=[
                        self.results_view.results_header,
                        Divider(
                            color=self.COLORS["border"]["default"],
                            height=1,
                        ),
                        Container(
                            content=self.results_view.results_container,
                            padding=padding.all(16),
                            expand=True,
                            clip_behavior=ft.ClipBehavior.HARD_EDGE  # Changed here too
                        ),
                    ],
                    spacing=0,
                ),
                elevation=1,
                clip_behavior=ft.ClipBehavior.HARD_EDGE  # Changed here too
            ),
            expand=True,
        )

        # Force a UI refresh after app loads to ensure theme consistency
        threading.Timer(0.1, self.force_refresh_ui).start()

        # Initialize onboarding tutorial
        self.tutorial = OnboardingTutorial(page, self)
        
        # Force a UI refresh after app loads and show tutorial if needed
        threading.Timer(0.1, self.post_init).start()

    def post_init(self):
        """Perform post-initialization tasks."""
        self.force_refresh_ui()
        
        # Show tutorial for first-time users
        if not self.config.get("tutorial_completed", False):
            self.tutorial.start_tutorial()

    def force_refresh_ui(self):
        """
        Force a UI refresh by updating the page.
        """
        logger.info("Forced UI refresh: applied theme '%s' with colors: %s", self.current_theme, self.COLORS)
        self.page.update()

    def create_checkbox(self, label: str, value: bool = False):
        """
        Create a checkbox with a tooltip.
        """
        return Checkbox(
            label=label,
            tooltip=f"Toggle option: {label}",
            value=value,
            fill_color=self.COLORS["bg"]["accent"],
            check_color=self.COLORS["text"]["primary"],
            label_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
            ),
        )

    def create_compare_button(self):
        """
        Create and return a compare button container with compare and translate buttons.
        """
        compare_button = ElevatedButton(
            content=Row(
                controls=[
                    Icon(Icons.REFRESH),
                    Text("Compare Files", size=16),
                ],
                alignment="center",
                spacing=8,
            ),
            tooltip="Click to compare the source and target files",
            on_click=self.compare_files_gui,
            style=ButtonStyle(
                color=self.COLORS["text"]["primary"],
                bgcolor=self.COLORS["bg"]["accent"],
                shape=RoundedRectangleBorder(radius=8),
            ),
            height=48,
            expand=True,
        )
        
        translate_button = ElevatedButton(
            content=Row(
                controls=[
                    Icon(Icons.TRANSLATE),
                    Text("Translate Missing", size=16),
                ],
                alignment="center",
                spacing=8,
            ),
            tooltip="Translate missing keys using Google Cloud Translate",
            on_click=self.translate_missing_keys,
            style=ButtonStyle(
                color=self.COLORS["text"]["primary"],
                bgcolor=self.COLORS["bg"]["accent"],
                shape=RoundedRectangleBorder(radius=8),
            ),
            height=48,
            expand=True,
            visible=False,
        )
        
        button_row = Row(
            controls=[compare_button, translate_button],
            alignment="center",
            spacing=16,
        )
        
        return Container(
            content=button_row,
            animate=ft.Animation(duration=200, curve="easeInOut"),
            on_hover=lambda event: self._on_compare_button_hover(event, compare_button)
        )

    def translate_missing_keys(self, event):
        """
        Translate missing keys using machine translation.
        """
        if not self.config["mt_enabled"] or not self.config["mt_api_key"]:
            self.show_snackbar("Please enable machine translation and set API key in settings")
            return

        def update_progress(progress):
            self.loading_ring.visible = True
            self.status_label.value = f"Translating... {int(progress * 100)}%"
            self.page.update()

        try:
            with open(self.source_file_path, 'r', encoding='utf-8') as source_file:
                source_content = source_file.read()
            with open(self.target_file_path, 'r', encoding='utf-8') as target_file:
                target_content = target_file.read()
            ext_source = Path(self.source_file_path).suffix.lower()
            ext_target = Path(self.target_file_path).suffix.lower()

            source_dict = logic.parse_content_by_ext(source_content, ext_source)
            target_dict = logic.parse_content_by_ext(target_content, ext_target)

            self.loading_ring.visible = True
            self.status_label.value = "Translating missing keys..."
            self.page.update()

            updated_dict, errors = logic.translate_missing_keys(
                source_dict,
                target_dict,
                self.config["mt_source_lang"],
                self.config["mt_target_lang"],
                self.config["mt_api_key"],
                update_progress
            )

            if errors:
                error_msg = "\n".join(errors[:5])
                if len(errors) > 5:
                    error_msg += f"\n...and {len(errors) - 5} more errors"
                self.show_snackbar(f"Some translations failed: {error_msg}")

            save_dialog = FilePicker(
                on_result=lambda result: self.save_translated_file(result, updated_dict)
            )
            self.page.overlay.append(save_dialog)
            save_dialog.save_file(file_name=f"new_target{ext_target}")

        except (IOError, OSError) as err:
            self.show_snackbar(f"Translation error: {str(err)}")
            self.status_label.value = "Translation failed"
        finally:
            self.loading_ring.visible = False
            self.page.update()

    async def compare_files_async(self, event):
        """
        Compare source and target files asynchronously to keep UI responsive.
        """
        self.loading_ring.visible = True
        self.status_label.value = "Comparing files..."
        self.page.update()
        
        # Update progress bar to show activity
        def update_progress(progress_value):
            self.loading_ring.value = progress_value if progress_value < 1.0 else None
            self.page.update()
        
        try:
            # Start async comparison
            task_id = file_processing_service.compare_files_async(
                self.source_file_path, 
                self.target_file_path,
                self.config,
                update_progress
            )
            
            # Poll for results
            while not file_processing_service.is_task_complete(task_id):
                await asyncio.sleep(0.1)  # Short sleep to avoid blocking UI
                
            # Get the final result
            result = file_processing_service.get_task_status(task_id)
            
            if result['status'] == 'error':
                raise Exception(result['error'])
                
            # Process successful result
            comparison_data = result['result']
            comparison_result = comparison_data['comparison']
            source_dict = comparison_data['source_dict']
            target_dict = comparison_data['target_dict']
            source_lines = comparison_data['source_lines']
            target_lines = comparison_data['target_lines']
            stats = comparison_data['stats']
            
            # Store line numbers for reference
            self.source_line_numbers = source_lines
            self.target_line_numbers = target_lines
            
            # Update UI with results
            self.update_statistics(stats['total_keys'], stats['missing_keys'], stats['obsolete_keys'])
            
            # Build the comparison view
            self.build_results_table(comparison_result)
            
            # Show completed status
            self.status_label.value = (
                f"Comparison complete: {stats['total_keys']} keys, "
                f"{stats['missing_keys']} missing, {stats['obsolete_keys']} obsolete"
            )
                
        except FileNotFoundError as e:
            logging.error(f"File not found: {str(e)}")
            self.show_snackbar("Error: File not found")
            self.status_label.value = "Comparison failed: File not found"
        except UnicodeError as e:
            logging.error(f"Encoding error: {str(e)}")
            self.show_snackbar("Error: Unable to read file encoding")
            self.status_label.value = "Comparison failed: Encoding error"
        except Exception as e:
            logging.error(f"Error during comparison: {str(e)}")
            self.show_snackbar(f"Error: {str(e)}")
            self.status_label.value = "Comparison failed"
        finally:
            # Hide loading indicator when done
            self.loading_ring.visible = False
            self.page.update()
    
    async def compare_directories_async(self, event):
        """
        Compare all matching files in source and target directories asynchronously
        with improved error handling and UI feedback.
        """
        self.loading_ring.visible = True
        self.status_label.value = "Comparing directories..."
        self.page.update()
        
        # Update progress bar to show activity
        def update_progress(progress_value):
            self.loading_ring.value = progress_value if progress_value < 1.0 else None
            self.page.update()
        
        try:
            # Start async directory comparison
            task_id = file_processing_service.compare_directories_async(
                self.source_dir_path,
                self.target_dir_path,
                self.config,
                update_progress
            )
            
            # Poll for results
            while not file_processing_service.is_task_complete(task_id):
                await asyncio.sleep(0.1)  # Short sleep to avoid blocking UI
                
            # Get the final result
            result = file_processing_service.get_task_status(task_id)
            
            if result['status'] == 'error':
                raise Exception(result['error'])
                
            # Process successful result
            comparison_data = result['result']
            if 'error' in comparison_data:
                self.show_snackbar(comparison_data['error'])
                return
                
            file_results = comparison_data['file_results']
            stats = comparison_data['stats']
            
            # Clear existing tabs and recreate
            self.results_tabs.tabs.clear()
            
            # Create tab for each file
            for filename, file_data in file_results.items():
                if 'error' in file_data:
                    # Create tab for file with error
                    self.results_tabs.tabs.append(
                        ft.Tab(
                            text=filename,
                            content=Container(
                                content=Text(f"Error: {file_data['error']}"),
                                padding=10,
                            )
                        )
                    )
                else:
                    # Create tab for successful comparison
                    stats = file_data['stats']
                    comparison = file_data['comparison']
                    
                    self.results_tabs.tabs.append(
                        ft.Tab(
                            text=filename,
                            content=Container(
                                content=Column(
                                    controls=[
                                        Text(
                                            f"Total: {stats['total_keys']} keys | "
                                            f"Missing: {stats['missing_keys']} | "
                                            f"Obsolete: {stats['obsolete_keys']}",
                                            size=14,
                                            color=self.COLORS["text"]["secondary"],
                                        ),
                                        TextField(
                                            value=comparison,
                                            multiline=True,
                                            read_only=True,
                                            min_lines=10,
                                            max_lines=None,
                                            text_style=TextStyle(
                                                color=self.COLORS["text"]["secondary"],
                                                size=14,
                                                font_family="Consolas",
                                            ),
                                        ),
                                    ],
                                    scroll=ft.ScrollMode.AUTO,
                                    spacing=8,
                                ),
                                padding=10,
                            ),
                        )
                    )
            
            # Update statistics
            self.update_statistics(
                stats['total_files'],
                stats['total_missing'],
                stats['total_obsolete']
            )
            
            # Make tabs visible and update container
            self.results_tabs.visible = True
            self.results_container.content = self.results_tabs
            
            # Update status message
            self.status_label.value = (
                f"Compared {stats['total_files']} files. "
                f"Found {stats['total_missing']} missing and {stats['total_obsolete']} obsolete keys."
            )
        
        except Exception as e:
            logging.error(f"Directory comparison error: {str(e)}")
            self.show_snackbar(f"Error comparing directories: {str(e)}")
            self.status_label.value = "Comparison failed"
            self.update_statistics(0, 0, 0)
        finally:
            self.loading_ring.visible = False
            self.page.update()
    
    def compare_files_gui(self, event):
        """
        Entry point for file comparison that launches the async operation.
        This replaces the original synchronous method.
        """
        asyncio.run_coroutine_threadsafe(
            self.compare_files_async(event), 
            asyncio.get_event_loop()
        )
    
    def compare_directories(self, event):
        """
        Entry point for directory comparison that launches the async operation.
        This replaces the original synchronous method.
        """
        asyncio.run_coroutine_threadsafe(
            self.compare_directories_async(event), 
            asyncio.get_event_loop()
        )
    
    def get_file_lines(self, file_path):
        """
        Count lines in a file using the optimized file cache service.
        """
        try:
            return file_cache_service.count_lines(file_path)
        except Exception as e:
            logging.error(f"Error counting lines: {str(e)}")
            return 0
    
    def update_file_preview(self, file_path: str, field_type: str):
        """
        Update file preview using the optimized file cache service.
        """
        try:
            preview_text = file_cache_service.preview_file(file_path)
            
            preview_field = self.preview_section.content.controls[0 if field_type == "source" else 2].content.controls[1].content
            preview_field.value = preview_text
            
        except Exception as e:
            logging.error(f"Error reading preview: {str(e)}")
            preview_field = self.preview_section.content.controls[0 if field_type == "source" else 2].content.controls[1].content
            preview_field.value = "Error reading file preview"

    def _on_browse_hover(self, e, button):
        hover_color = "#60A5FA" if self.page.theme_mode == "dark" else "#E0E7FF"
        if e.data == "true":
            button.bgcolor = hover_color
        else:
            button.bgcolor = self.COLORS["bg"]["accent"]
        button.update()

    def _on_compare_button_hover(self, e, button):
        hover_color = "#60A5FA" if self.page.theme_mode == "dark" else "#E0E7FF"
        if e.data == "true":
            button.bgcolor = hover_color
        else:
            button.bgcolor = self.COLORS["bg"]["accent"]
        button.update()

    def get_file_lines(self, file_path):
        """Count number of lines in a file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                return sum(1 for line in f)
        except:
            return 0

    def handle_file_picked(self, e: FilePickerResultEvent, field, icon, field_type):
        """
        Handle file selection and update its related UI components.
        """
        if e.files and len(e.files) > 0:
            file_path = e.files[0].path
            if self.validate_file(file_path):
                file_name = Path(file_path).name
                file_size = self.get_readable_file_size(os.path.getsize(file_path))
                line_count = self.get_file_lines(file_path)
                field.value = f"{file_name} ({file_size}, {line_count} lines)"
                # File type indicator logic
                ext = Path(file_path).suffix.lower()
                if ext == ".csv":
                    # ...set icon for CSV...
                    pass
                elif ext in [".lang", ".txt"]:
                    # ...set icon for lang/txt...
                    pass
                else:
                    # ...set a default icon...
                    pass
                # Update preview only if enabled
                if self.config["show_preview"]:
                    self.update_file_preview(file_path, field_type)
                    self.preview_section.visible = True
                
                if field_type == "source":
                    self.source_file_path = file_path
                else:
                    self.target_file_path = file_path
                icon.color = Colors.BLUE_400
                self.update_compare_button()
                self.page.update()
            else:
                field.value = ""
                icon.color = "red"  # visually indicate error
                field.update()
                icon.update()

    def update_file_preview(self, file_path: str, field_type: str):
        """
        Update the preview text field with the first few lines of the file.
        """
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                # Read first 5 lines
                preview_lines = []
                for i, line in enumerate(f):
                    if i >= 5:
                        break
                    preview_lines.append(line.rstrip())
                
                preview_text = '\n'.join(preview_lines)
                if len(preview_lines) == 5:
                    preview_text += "\n..."
                
                # Get the appropriate preview TextField
                preview_field = self.preview_section.content.controls[0 if field_type == "source" else 2].content.controls[1].content
                preview_field.value = preview_text
                
        except (OSError, UnicodeDecodeError) as error:
            logging.error("Error reading preview: %s", error)
            preview_field = self.preview_section.content.controls[0 if field_type == "source" else 2].content.controls[1].content
            preview_field.value = "Error reading file preview"

    def get_readable_file_size(self, size_in_bytes):
        """Convert file size in bytes to human readable format"""
        for unit in ['B', 'KB', 'MB', 'GB']:
            if size_in_bytes < 1024:
                if unit == 'B':
                    return f"{size_in_bytes} {unit}"
                return f"{size_in_bytes:.1f} {unit}"
            size_in_bytes /= 1024
        return f"{size_in_bytes:.1f} TB"

    def clear_file(self, field, icon, clear_btn):
        field.value = ""
        icon.color = Colors.GREY_400
        if field == self.source_field:
            self.source_file_path = ""
        else:
            self.target_file_path = ""
        self.update_compare_button()
        self.page.update()

    def validate_file(self, file_path: str) -> bool:
        import os
        if not file_path or not file_path.strip():
            self.show_validation_error("file_empty")
            return False
        if not os.path.isfile(file_path):
            self.show_validation_error("file_not_found")
            return False
        ext = os.path.splitext(file_path)[1].lower()
        if ext not in SUPPORTED_FORMATS:
            self.show_validation_error("file_type")
            return False
        return True

    def show_validation_error(self, error_key: str):
        message = self.user_friendly_errors.get(error_key, "An unknown error occurred.")
        self.show_snackbar(message)

    def handle_source_selected(self, file_path: str):
        self.source_file_path = file_path
        self.update_compare_button()

    def handle_target_selected(self, file_path: str):
        self.target_file_path = file_path
        self.update_compare_button()

    def handle_source_cleared(self):
        self.source_file_path = ""
        self.update_compare_button()

    def handle_target_cleared(self):
        self.target_file_path = ""
        self.update_compare_button()

    def update_compare_button(self):
        """Enable/disable compare button based on file selection"""
        self.compare_button.content.disabled = not (self.source_file_path and self.target_file_path)
        self.page.update()

    def show_snackbar(self, message):
        self.page.snack_bar.content = Text(message)
        self.page.snack_bar.open = True
        self.page.update()

    def compare_files_gui(self, event):
        """
        Compare source and target files and update the UI with the comparison result.
        """
        self.loading_ring.visible = True
        self.status_label.value = "Comparing files..."
        self.page.update()

        try:
            try:
                with open(self.source_file_path, 'r', encoding='utf-8') as f:
                    source_content = f.read()
            except UnicodeDecodeError:
                with open(self.source_file_path, 'r', encoding='latin-1') as f:
                    source_content = f.read()

            try:
                with open(self.target_file_path, 'r', encoding='utf-8') as f:
                    target_content = f.read()
            except UnicodeDecodeError:
                with open(self.target_file_path, 'r', encoding='latin-1') as f:
                    target_content = f.read()

            ext_source = Path(self.source_file_path).suffix.lower()
            ext_target = Path(self.target_file_path).suffix.lower()

            source_result = logic.parse_content_by_ext(source_content, ext_source)
            target_result = logic.parse_content_by_ext(target_content, ext_target)
            
            if isinstance(source_result, dict) and "translations" in source_result:
                source_dict = source_result["translations"]
                source_lines = source_result.get("line_numbers", {})
            else:
                source_dict = source_result
                source_lines = {}
            if isinstance(target_result, dict) and "translations" in target_result:
                target_dict = target_result["translations"]
                target_lines = target_result.get("line_numbers", {})
            else:
                target_dict = target_result
                target_lines = {}

            self.source_line_numbers = source_lines
            self.target_line_numbers = target_lines

            logging.info("Source file entries: %s", len(source_dict))
            logging.info("Target file entries: %s", len(target_dict))
            logging.info("Sample source entries: %s", dict(list(source_dict.items())[:3]))
            logging.info("Sample target entries: %s", dict(list(target_dict.items())[:3]))

            ignore_patterns = []
            pattern_str = self.ignore_pattern_field.value.strip()
            if pattern_str:
                ignore_patterns = [p.strip() for p in pattern_str.split(",") if p.strip()]

            mt_settings = {
                'enabled': self.config["mt_enabled"],
                'api_key': self.config["mt_api_key"],
                'source_lang': self.config["mt_source_lang"],
                'target_lang': self.config["mt_target_lang"]
            }

            comparison_result = logic.compare_translations(
                target_dict,
                source_dict,
                ignore_case=self.config["ignore_case"],
                ignore_whitespace=self.config["ignore_whitespace"],
                is_gui=True,
                include_summary=False,
                compare_values=self.config["compare_values"],
                ignore_patterns=self.config["ignore_patterns"],
                log_missing_keys=self.config["log_missing_strings"],
                auto_fill_missing=self.config["auto_fill_missing"],
                mt_settings=mt_settings
            )

            missing_keys_set = set(source_dict.keys()) - set(target_dict.keys())
            obsolete_keys_set = set(target_dict.keys()) - set(source_dict.keys())

            total_keys = len(source_dict)
            missing_keys = len(missing_keys_set)
            obsolete_keys = len(obsolete_keys_set)
            self.update_statistics(total_keys, missing_keys, obsolete_keys)

            self.output_text.value = comparison_result
            self.build_results_table(comparison_result)
            self.status_label.value = f"Comparison complete. Found {len(source_dict)} source and {len(target_dict)} target entries."

            history_entry = {
                "timestamp": datetime.datetime.now().isoformat(),
                "source_file": os.path.basename(self.source_file_path),
                "target_file": os.path.basename(self.target_file_path),
                "diff": comparison_result
            }
            history_manager.save_history(history_entry)

        except (ValueError, OSError) as err:
            import traceback
            error_details = traceback.format_exc()
            print("Error details: %s", error_details)
            self.show_snackbar("Error: %s" % err)
            self.status_label.value = "Comparison failed"
            self.update_statistics(0, 0, 0)
        finally:
            self.loading_ring.visible = False
            self.page.update()

        translate_button = self.compare_button.content.controls[1]
        translate_button.visible = self.config["mt_enabled"]
        self.page.update()

    def group_keys_by_namespace(self, lines: list[str]) -> dict:
        groups = {}
        for line in lines:
            # Assume lines are in format: "+ key : value ..." (or "-" or "~")
            # Remove indicator and split by ":" to isolate key.
            try:
                indicator, rest = line.split(" ", 1)
                key_part = rest.split(":", 1)[0].strip()
            except ValueError:
                key_part = "General"
            namespace = key_part.split(".")[0] if "." in key_part else "General"
            groups.setdefault(namespace, []).append(line)
        return groups

    def build_results_table(self, comparison_result: str):
        """Initialize the results table with search field and content"""
        from flet import Icon, Column, Row, Text, TextField
        lines = comparison_result.splitlines()
        sorted_lines = sorted(lines, key=lambda l: {'-': 0, '~': 1, '+': 2}.get(l[0], 3))
        result_rows = []
        
        line_number = 1  # Initialize line counter
        
        if self.config.get("group_by_namespace"):
            groups = self.group_keys_by_namespace(sorted_lines)
            for namespace, group_lines in groups.items():
                header = Row(controls=[Text(f"Namespace: {namespace}", weight="bold")])
                result_rows.append(header)
                for line in group_lines:
                    row = self.create_result_row(line, line_number if self.config["show_line_numbers"] else None)
                    result_rows.append(row)
                    line_number += 1
        else:
            for line in sorted_lines:
                row = self.create_result_row(line, line_number if self.config["show_line_numbers"] else None)
                result_rows.append(row)
                line_number += 1

        # Store the original rows for filtering
        self.original_result_rows = result_rows

        # Create results column with fixed search field
        self.results_column = Column(
            controls=[
                TextField(
                    hint_text="Search results...",
                    on_change=lambda e: self.filter_results(e.control.value),
                    border=border.all(color=self.COLORS["border"]["default"]),
                    content_padding=padding.all(10),
                ),
                Column(  # Wrapper for filtered results
                    controls=result_rows,
                    scroll=ft.ScrollMode.AUTO,
                    spacing=2,
                    expand=True,
                )
            ],
            spacing=10,
            scroll=ft.ScrollMode.AUTO,
        )
        
        # Update the container content
        self.results_container.content = self.results_column
        self.page.update()

    def filter_results(self, query: str):
        """Filter results based on search query"""
        query = query.lower()
        
        # Start with namespace headers and their content
        filtered_rows = []
        current_namespace = None
        namespace_has_matches = False
        namespace_content = []
        
        for row in self.original_result_rows:
            # Check if this is a namespace header
            if len(row.controls) == 1 and isinstance(row.controls[0], Text) and row.controls[0].weight == "bold":
                # If we had a previous namespace and it had matches, add it
                if current_namespace and namespace_has_matches:
                    filtered_rows.append(current_namespace)
                    filtered_rows.extend(namespace_content)
                
                # Store new namespace header
                current_namespace = row
                namespace_content = []
                namespace_has_matches = False
                continue
            
            # For content rows, check if they match the query
            if len(row.controls) > 1 and isinstance(row.controls[1], Text):
                text = row.controls[1].value.lower()
                if query in text:
                    if current_namespace:
                        namespace_content.append(row)
                        namespace_has_matches = True
                    else:
                        filtered_rows.append(row)
        
        # Add last namespace if it had matches
        if current_namespace and namespace_has_matches:
            filtered_rows.append(current_namespace)
            filtered_rows.extend(namespace_content)
        
        # Update only the results portion while keeping the search field
        self.results_column.controls[1].controls = filtered_rows
        self.page.update()

    def create_result_row(self, line: str, line_number: int = None) -> Row:
        """Helper method to create a result row with proper icon and text"""
        controls = []
        
        # Extract key using improved regex to match keys with letters,dots or dashes
        key_match = re.search(r'^[+-~]\s*([\w\.\-]+)\s*:', line)
        if key_match:
            key = key_match.group(1).strip()
            # Look up the original line number using the key from the parser
            if line.startswith("+"):
                actual_line = self.source_line_numbers.get(key, "?")
            elif line.startswith("-"):
                actual_line = self.target_line_numbers.get(key, "?")
            else:
                actual_line = self.target_line_numbers.get(key, "?")

        else:
            actual_line = "?"

        # Add line number if enabled
        if self.config["show_line_numbers"] and line_number is not None:
            controls.append(
                Text(
                    f"{actual_line:>4} │ ",
                    size=14,
                    weight="w400",
                    color=self.COLORS["text"]["secondary"],
                    font_family="Consolas",
                )
            )
            
        # Add appropriate icon
        if line.startswith("+"):
            icon = Icon(Icons.ADD, color="green")
        elif line.startswith("-"):
            icon = Icon(Icons.REMOVE, color="red")
        elif line.startswith("~"):
            icon = Icon(Icons.WARNING, color="yellow")
        else:
            icon = Icon(Icons.HELP, color="grey")
            
        controls.extend([
            icon,
            Text(line, font_family="Consolas")
        ])
        
        return Row(controls=controls, spacing=8)

    def update_statistics(self, total_keys: int, missing_keys: int, obsolete_keys: int):
        from flet import Container, Column, Text
        translated_keys = total_keys - missing_keys
        translation_percentage = (translated_keys / total_keys * 100) if total_keys else 0
        self.stats_text_total.value = str(total_keys)
        self.stats_text_missing.value = str(missing_keys)
        self.stats_text_obsolete.value = str(obsolete_keys)
        if not hasattr(self, "stats_text_percentage"):
            self.stats_text_percentage = Text(
                value="0%",
                size=24,
                weight=FontWeight.BOLD,
                color="lightblue"
            )
            self.stats_panel.content.content.controls.append(
                Container(
                    content=Column(
                        controls=[
                            Text("Translated %", size=14, color=self.COLORS["text"]["secondary"]),
                            self.stats_text_percentage,
                        ],
                        horizontal_alignment="center",
                        spacing=4,
                    ),
                    padding=padding.all(16),
                    expand=True,
                )
            )
        self.stats_text_percentage.value = f"{translation_percentage:.1f}%"
        self.page.update()

    def toggle_section(self, e, column):
        """Toggle visibility of a namespace section"""
        column.visible = not column.visible
        e.control.icon = Icons.EXPAND_LESS if column.visible else Icons.EXPAND_MORE
        self.page.update()

    def toggle_expand_all(self, e):
        # Toggle expand/collapse functionality.
        self.expand_all = not self.expand_all
        # Dummy implementation: update the status_label based on expand_all state.
        self.status_label.value = "Expanded" if self.expand_all else "Collapsed"
        self.page.update()

    def clear_text_field(self, text_field, clear_btn):
        # Clear the text field and hide the clear button
        text_field.value = ""
        clear_btn.visible = False
        text_field.update()
        clear_btn.update()

    def copy_results(self, e):
        """Copy results text to clipboard and show feedback"""
        self.page.set_clipboard(self.output_text.value)
        self.show_snackbar("Results copied to clipboard")

    def open_source_picker(self, e):
        self.source_picker.pick_files()

    def open_target_picker(self, e):
        self.target_picker.pick_files()

    def handle_window_event(self, e):
        # Add window event handling as needed
        pass

    def format_comparison_line(self, key: str, value: str, change_type: str, max_key_length: int):
        if change_type == "added":
            indicator = "+ "
        elif change_type == "removed":
            indicator = "- "
        else:
            indicator = "  "
        line = f"{indicator}{key.ljust(max_key_length)} : {value}"
        # Delegate syntax highlighting to our helper module.
        import syntax_highlighter
        return syntax_highlighter.highlight_line(line, change_type)

    # Update format_summary method
    def format_summary(self, added: int, removed: int) -> str:
        return f"--- Summary ---\nAdded: {added}\nRemoved: {removed}"

    def open_settings(self, e):
        """Open the settings dialog."""
        self.settings_dialog.open = True
        self.register_keyboard_navigation()  # Register handler when dialog opens
        self.page.update()

    def close_settings(self, e):
        self.settings_dialog.open = False
        self.unregister_keyboard_navigation()  # Unregister handler when dialog closes
        self.page.update()

    def reset_colors(self, e):
        self.COLORS = self.THEMES["dark"]
        self.update_theme_colors()
        self.page.update()

    def update_theme_colors(self):
        """Update the colors in the UI using the current theme settings."""
        # Get current theme and handle system theme - UPDATED
        theme_key = self.config.get("theme", "system")
        
        if theme_key == "system":
            import darkdetect
            system_theme = "dark" if darkdetect.isDark() else "light"
            self.COLORS = self.THEMES[system_theme]
        else:
            self.COLORS = self.THEMES[theme_key]
            
        # Cache the colors
        self._cached_colors[theme_key] = self.COLORS

        # Update page theme colors
        self.page.bgcolor = self.COLORS["bg"]["primary"]
        self.page.theme = ft.Theme(color_scheme_seed=Colors.GREEN)
        self.page.dark_theme = ft.Theme(color_scheme_seed=Colors.BLUE)

        # Rest of UI updates...
        # ...existing code...

        # Merge custom theme if available
        custom_theme = self.config.get("custom_theme", {})
        if isinstance(custom_theme, dict):
            if "main" in custom_theme:
                self.COLORS["bg"]["primary"] = custom_theme["main"]
            if "accent" in custom_theme:
                self.COLORS["bg"]["accent"] = custom_theme["accent"]
            if "background" in custom_theme:
                self.COLORS["bg"]["secondary"] = custom_theme["background"]
            if "text" in custom_theme:
                self.COLORS["text"]["primary"] = custom_theme["text"]

        # Update UI elements with cached colors
        self.page.bgcolor = self.COLORS["bg"]["primary"]
        self.content.bgcolor = self.COLORS["bg"]["secondary"]
        # Status label
        self.status_label.color = self.COLORS["text"]["secondary"]
        
        # Update the compare and translate buttons
        for button in self.compare_button.content.controls:
            if isinstance(button, ElevatedButton):
                button.style = ButtonStyle(
                    color=self.COLORS["text"]["primary"],
                    bgcolor=self.COLORS["bg"]["accent"],
                    shape=RoundedRectangleBorder(radius=8),
                )

        # Settings button icon
        self.settings_button.icon_color = self.COLORS["text"]["secondary"]

        # File picker icons and labels
        self.source_icon.color = self.COLORS["text"]["secondary"]
        self.target_icon.color = self.COLORS["text"]["secondary"]
        self.source_label.color = self.COLORS["text"]["secondary"]
        self.target_label.color = self.COLORS["text"]["secondary"]

        # Update file input containers (assumes create_file_input returns a Column)
        for container in [self.source_file_container, self.target_file_container]:
            if isinstance(container.content, Column):
                file_input_col = container.content
                file_input_col.controls[0].color = self.COLORS["text"]["secondary"]  # Label text
                inner = file_input_col.controls[1]  # Row container holding file icon/label and browse button
                inner.bgcolor = self.COLORS["bg"]["input"]
                inner.border = border.all(2, self.COLORS["border"]["default"])

        # Text fields update
        for tf in [self.output_text, self.source_text, self.target_text, self.summary_text]:
            tf.text_style = TextStyle(color=self.COLORS["text"]["secondary"], size=14, font_family="Consolas", weight=FontWeight.W_400)
            tf.bgcolor = "transparent"

        # Update progress ring color
        self.loading_ring.color = self.COLORS["bg"]["accent"]

        # Update main card container background color:
        self.main_card_container.bgcolor = self.COLORS["bg"]["secondary"]

        # Update statistics panel colors
        self.stats_text_total.color = self.COLORS["text"]["primary"]
        self.stats_text_missing.color = self.COLORS["changes"]["removed"]
        self.stats_text_obsolete.color = self.COLORS["changes"]["added"]
        self.stats_panel.content.bgcolor = self.COLORS["bg"]["secondary"]

        # Update preview section colors
        if hasattr(self, 'preview_section'):
            for container in self.preview_section.content.controls:
                if isinstance(container, Container) and container.content:
                    # Update text colors
                    container.content.controls[0].color = self.COLORS["text"]["secondary"]
                    # Update preview container colors
                    preview_container = container.content.controls[1]
                    preview_container.bgcolor = self.COLORS["bg"]["input"]
                    preview_container.border = border.all(color=self.COLORS["border"]["default"])

        if hasattr(self, 'file_input'):
            self.file_input.update_colors(self.COLORS)

        logging.info("Theme updated to '%s'. Current COLORS: %s", theme_key, self.COLORS)

    def handle_case_change(self, e):
        self.config["ignore_case"] = e.control.value
        ConfigManager.save(self.config)
        self.ignore_case_checkbox.value = e.control.value  # Update main UI checkbox
        self.page.update()

    def reset_settings(self, e):
        """Reset all settings to defaults."""
        # Use the centralized reset function
        self.config = ConfigManager.reset()
        
        # Update UI to reflect reset values
        self.current_theme = self.config["theme"]
        self.log_missing_strings = self.config["log_missing_strings"]
        
        # Update colors based on theme
        self.update_theme_colors()
        
        # Update all settings controls to match reset values
        # ...update UI controls code...
        
        self.show_snackbar("Settings reset to defaults.")
        self.page.update()

    def handle_mt_enabled_change(self, e):
        """Handle machine translation enabled setting change"""
        self.config["mt_enabled"] = e.control.value
        
        # Validate MT settings
        errors = ConfigManager.validate_required_fields(self.config)
        if "mt_api_key" in errors and self.config["mt_enabled"]:
            self.show_snackbar(errors["mt_api_key"])
        
        ConfigManager.save(self.config)
        self.page.update()

    def handle_mt_api_key_change(self, e):
        """Handle machine translation API key change"""
        new_key = e.control.value.strip() if e.control.value else ""
        self.config["mt_api_key"] = new_key
        
        # Validate MT settings if enabled
        if self.config["mt_enabled"] and not new_key:
            self.show_snackbar("API key cannot be empty when machine translation is enabled.")
        
        ConfigManager.save(self.config)
        self.page.update()

    def handle_mt_source_lang_change(self, e):
        self.config["mt_source_lang"] = e.control.value
        ConfigManager.save(self.config)
        self.page.update()

    def handle_mt_target_lang_change(self, e):
        self.config["mt_target_lang"] = e.control.value
        ConfigManager.save(self.config)
        self.page.update()

    def handle_group_by_namespace_change(self, e):
        """Handle toggling of namespace grouping"""
        self.config["group_by_namespace"] = e.control.value
        ConfigManager.save(self.config)
        # Rebuild results table if we have results
        if self.output_text.value and self.output_text.value != "Comparison results will appear here":
            self.build_results_table(self.output_text.value)
        self.page.update()

    def update_statistics(self, total_keys: int, missing_keys: int, obsolete_keys: int):
        from flet import Container, Column, Text
        translated_keys = total_keys - missing_keys
        translation_percentage = (translated_keys / total_keys * 100) if total_keys else 0
        self.stats_text_total.value = str(total_keys)
        self.stats_text_missing.value = str(missing_keys)
        self.stats_text_obsolete.value = str(obsolete_keys)
        if not hasattr(self, "stats_text_percentage"):
            self.stats_text_percentage = Text(
                value="0%",
                size=24,
                weight=FontWeight.BOLD,
                color="lightblue"
            )
            self.stats_panel.content.content.controls.append(
                Container(
                    content=Column(
                        controls=[
                            Text("Translated %", size=14, color=self.COLORS["text"]["secondary"]),
                            self.stats_text_percentage,
                        ],
                        horizontal_alignment="center",
                        spacing=4,
                    ),
                    padding=padding.all(16),
                    expand=True,
                )
            )
        self.stats_text_percentage.value = f"{translation_percentage:.1f}%"
        self.page.update()

    def handle_theme_change(self, e):
        """Handle theme mode changes using themes from themes.py"""
        selected = e.control.value
        self.current_theme = selected
        
        # Set theme mode and colors based on selection
        if selected == "system":
            self.page.theme_mode = ft.ThemeMode.SYSTEM
            import darkdetect
            system_theme = "dark" if darkdetect.isDark() else "light"
            self.COLORS = self.THEMES[system_theme]
        else:
            # Set explicit theme mode
            if selected in ["dark", "amoled"]:
                self.page.theme_mode = ft.ThemeMode.DARK
            else:
                self.page.theme_mode = ft.ThemeMode.LIGHT
            self.COLORS = self.THEMES[selected]
        
        # Cache and save theme
        self._cached_colors[selected] = self.COLORS
        self.config["theme"] = selected
        ConfigManager.save(self.config)
        
        # Update UI with new colors
        self.update_theme_colors()
        self.page.update()

    def handle_auto_fill_change(self, e):
        """Handle auto-fill settings change"""
        self.config["auto_fill_missing"] = e.control.value
        ConfigManager.save(self.config)
        self.page.update()

    def handle_patterns_change(self, e):
        """Handle ignore patterns change"""
        patterns = [p.strip() for p in e.control.value.split(",") if p.strip()]
        self.config["ignore_patterns"] = patterns
        ConfigManager.save(self.config)
        self.page.update()

    def handle_format_change(self, e):
        """Handle preferred format change"""
        self.config["preferred_format"] = e.control.value
        ConfigManager.save(self.config)
        self.page.update()

    def handle_whitespace_change(self, e):
        """Handle whitespace ignore setting change"""
        self.config["ignore_whitespace"] = e.control.value
        ConfigManager.save(self.config)
        self.page.update()

    def handle_log_missing_change(self, e):
        """Handle log missing keys setting change"""
        self.config["log_missing_strings"] = e.control.value
        ConfigManager.save(self.config)
        self.log_missing_strings = e.control.value  # Update the flag as well
        self.page.update()

    def open_custom_theme_settings(self, e):
        # Remove old dialog_open check
        if self.custom_theme_dialog not in self.page.overlay:
            self.page.overlay.append(self.custom_theme_dialog)
        self.custom_theme_dialog.open = True
        self.register_keyboard_navigation()  # Register handler for custom theme dialog
        self.page.update()

    def save_custom_theme(self, e):
        # ...existing code or placeholder...
        self.custom_theme_dialog.open = False
        self.page.update()

    def close_custom_theme_settings(self, e):
        self.custom_theme_dialog.open = False
        self.unregister_keyboard_navigation()  # Remove handler after closing dialog
        self.page.update()

    def handle_preview_toggle(self, e):
        """Handle toggling of file preview feature"""
        self.config["show_preview"] = e.control.value
        ConfigManager.save(self.config)
        self.preview_section.visible = e.control.value and (self.source_file_path or self.target_file_path)
        self.page.update()

    def open_source_dir_picker(self, e):
        self.source_dir_picker.get_directory_path()
        
    def open_target_dir_picker(self, e):
        self.target_dir_picker.get_directory_path()
        
    def handle_dir_picked(self, e: FilePickerResultEvent, dir_type: str):
        if e.path:
            if dir_type == "source":
                self.source_dir_path = e.path
                self.source_label.value = f"Directory: {Path(e.path).name}"
            else:
                self.target_dir_path = e.path
                self.target_label.value = f"Directory: {Path(e.path).name}"
            
            self.update_compare_button()
            self.page.update()

    def compare_directories(self):
        """Compare all matching files in source and target directories with improved error handling"""
        self.loading_ring.visible = True
        self.status_label.value = "Comparing directories..."
        self.page.update()

        try:
            source_files = {f.name: f for f in Path(self.source_dir_path).glob("*") 
                            if any(f.name.lower().endswith(ext) for ext in SUPPORTED_FORMATS)}
            target_files = {f.name: f for f in Path(self.target_dir_path).glob("*") 
                            if any(f.name.lower().endswith(ext) for ext in SUPPORTED_FORMATS)}
            
            common_files = set(source_files.keys()) & set(target_files.keys())
            if not common_files:
                msg = "No matching files found in the selected directories."
                self.show_snackbar(msg)
                self.status_label.value = msg
                self.update_statistics(0, 0, 0)
                self.results_tabs.tabs.clear()
                self.results_tabs.visible = False
                self.results_container.content = self.results_tabs
                return

            # Clear existing tabs and initialize counters.
            self.results_tabs.tabs.clear()
            total_missing = 0
            total_obsolete = 0
            
            for filename in sorted(common_files):
                source_path = source_files[filename]
                target_path = target_files[filename]
                
                # Read and compare files
                with open(source_path, 'r', encoding='utf-8') as f:
                    source_content = f.read()
                with open(target_path, 'r', encoding='utf-8') as f:
                    target_content = f.read()
                    
                source_dict = logic.parse_content_by_ext(source_content, source_path.suffix)
                target_dict = logic.parse_content_by_ext(target_content, target_path.suffix)
                
                comparison_result = logic.compare_translations(
                    target_dict,
                    source_dict,
                    ignore_case=self.config["ignore_case"],
                    ignore_whitespace=self.config["ignore_whitespace"],
                    is_gui=True,
                    include_summary=True,
                    compare_values=self.config["compare_values"],
                    ignore_patterns=self.config["ignore_patterns"],
                    log_missing_keys=self.config["log_missing_strings"],
                    auto_fill_missing=self.config["auto_fill_missing"],
                )
                
                missing = len(set(source_dict.keys()) - set(target_dict.keys()))
                obsolete = len(set(target_dict.keys()) - set(source_dict.keys()))
                total_missing += missing
                total_obsolete += obsolete
                
                self.results_tabs.tabs.append(
                    ft.Tab(
                        text=filename,
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        f"Missing: {missing}, Obsolete: {obsolete}",
                                        color=self.COLORS["text"]["secondary"],
                                        size=14,
                                    ),
                                    TextField(
                                        value=comparison_result,
                                        multiline=True,
                                        read_only=True,
                                        min_lines=10,
                                        max_lines=None,
                                        text_style=TextStyle(
                                            color=self.COLORS["text"]["secondary"],
                                            size=14,
                                            font_family="Consolas",
                                        ),
                                    ),
                                ],
                                scroll=ft.ScrollMode.AUTO,
                                spacing=8,
                            ),
                            padding=10,
                        ),
                    )
                )
            
            self.update_statistics(len(common_files), total_missing, total_obsolete)
            self.results_tabs.visible = True
            self.results_container.content = self.results_tabs
            self.status_label.value = f"Compared {len(common_files)} files."
            
        except Exception as e:
            logging.error("Directory comparison error: %s", e)
            self.show_snackbar(f"Error comparing directories: {str(e)}")
            self.status_label.value = "Comparison failed"
            self.update_statistics(0, 0, 0)
        finally:
            self.loading_ring.visible = False
            self.page.update()

    def highlight_line(line: str, change_type: str) -> str:
        """Simple syntax highlighting for comparison lines."""
        # No highlighting needed for GUI as we handle colors in the UI
        return line

    def handle_keyboard_nav_change(self, e):
        """Handle keyboard navigation toggle"""
        self.config["enable_keyboard_nav"] = e.control.value
        ConfigManager.save(self.config)
        self.update_keyboard_navigation()
        self.page.update()

    def handle_contrast_change(self, e):
        """Handle high contrast mode toggle"""
        self.config["high_contrast"] = e.control.value
        if e.control.value:
            self.COLORS = self.THEMES["high_contrast"]
            # Force update all text colors for high contrast
            self.page.theme = ft.Theme(
                color_scheme_seed=Colors.BLUE_GREY,
                font_family="Roboto",
                visual_density=ft.ThemeVisualDensity.COMFORTABLE,
            )
        else:
            self.COLORS = self.THEMES[self.current_theme]
        
        self.update_theme_colors()
        self.update_text_sizes()  # Also update text sizes to maintain accessibility
        self.page.update()

    def handle_text_size_change(self, e):
        """Handle large text mode toggle"""
        self.config["large_text"] = e.control.value
        self.update_all_text_sizes()
        self.page.update()

    def handle_font_scale_change(self, e):
        """Handle font size scale adjustment"""
        self.config["font_size_scale"] = e.control.value
        self.update_all_text_sizes()
        self.page.update()

    def update_all_text_sizes(self):
        """Update text sizes throughout the application"""
        scale = self.config["font_size_scale"]
        if self.config["large_text"]:
            scale *= 1.25

        # Base sizes for different text types
        base_sizes = {
            "small": 12,
            "normal": 14,
            "large": 16,
            "header": 32,
            "title": 24
        }

        def update_control_text_size(control):
            """Recursively update text sizes in controls"""
            if isinstance(control, Text):
                # Determine the base size category for this text
                if control.weight == "bold" and control.size >= 24:
                    base_size = base_sizes["title"]
                elif control.weight == "bold":
                    base_size = base_sizes["large"]
                else:
                    base_size = base_sizes["normal"]
                
                # Apply scaling
                control.size = int(base_size * scale)
                control.update()
            
            # Update text style for TextFields
            elif isinstance(control, TextField):
                current_style = control.text_style or TextStyle()
                current_size = current_style.size or base_sizes["normal"]
                control.text_style = TextStyle(
                    size=int(current_size * scale),
                    color=current_style.color,
                    font_family=current_style.font_family,
                    weight=current_style.weight
                )
                control.update()

            # Recursively process containers and their children
            if hasattr(control, "content") and control.content:
                if isinstance(control.content, (Column, Row)):
                    for child in control.content.controls:
                        update_control_text_size(child)
                else:
                    update_control_text_size(control.content)
            
            elif hasattr(control, "controls"):
                for child in control.controls:
                    update_control_text_size(child)

        # Update main content
        update_control_text_size(self.content)
        
        # Update specific sections
        update_control_text_size(self.settings_dialog)
        update_control_text_size(self.preview_section)
        update_control_text_size(self.results_container)
        update_control_text_size(self.stats_panel)

        # Update text field sizes
        text_fields = [
            self.output_text,
            self.source_text,
            self.target_text,
            self.summary_text
        ]
        
        for tf in text_fields:
            tf.text_style = TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=int(14 * scale),  # Scale the default size
                font_family="Consolas",
                weight=FontWeight.W_400,
            )
            tf.update()

        # Update statistics text
        stats_texts = [
            self.stats_text_total,
            self.stats_text_missing,
            self.stats_text_obsolete
        ]
        
        for stat in stats_texts:
            stat.size = int(24 * scale)  # Scale the statistics text size
            stat.update()

        if hasattr(self, "stats_text_percentage"):
            self.stats_text_percentage.size = int(24 * scale)
            self.stats_text_percentage.update()

        self.page.update()

    def update_keyboard_navigation(self):
        """Update keyboard navigation settings"""
        if self.config["enable_keyboard_nav"]:
            self.page.on_keyboard_event = self.handle_keyboard_event
        else:
            self.page.on_keyboard_event = None
        self.page.update()

    def handle_keyboard_event(self, e: ft.KeyboardEvent):
        """Handle keyboard navigation events"""
        if not self.config["enable_keyboard_nav"]:
            return

        if e.key == "Tab":
            self.handle_tab_navigation(e.shift)
        elif e.key == "Enter":
            self.handle_enter_key()
        elif e.key in ["ArrowUp", "ArrowDown"]:
            self.handle_arrow_navigation(e.key)

    def handle_tab_navigation(self, shift: bool):
        """Handle Tab key navigation"""
        def get_focusable_controls(control):
            """Recursively collect focusable controls"""
            focusable_controls = []
            if getattr(control, "focusable", False):
                focusable_controls.append(control)
            if hasattr(control, "controls"):
                for child in control.controls:
                    focusable_controls.extend(get_focusable_controls(child))
            return focusable_controls

        focusable_controls = get_focusable_controls(self.page)

        if not focusable_controls:
            return

        current_index = -1
        for i, control in enumerate(focusable_controls):
            if control.focused:
                current_index = i
                break

        # Calculate next focus index
        if shift:
            next_index = (current_index - 1) if current_index > 0 else len(focusable_controls) - 1
        else:
            next_index = (current_index + 1) if current_index < len(focusable_controls) - 1 else 0

        # Focus next control
        focusable_controls[next_index].focus()
        self.page.update()

    def handle_enter_key(self):
        """Handle Enter key press on focused element"""
        for control in self.page.controls:
            if getattr(control, "focused", False) and hasattr(control, "on_click"):
                control.on_click(None)
                break

    def handle_arrow_navigation(self, key: str):
        """Handle arrow key navigation"""
        if not hasattr(self, "results_tabs") or not self.results_tabs.visible:
            return

        current_tab = self.results_tabs.selected_index
        if key == "ArrowUp" and current_tab > 0:
            self.results_tabs.selected_index -= 1
        elif key == "ArrowDown" and current_tab < len(self.results_tabs.tabs) - 1:
            self.results_tabs.selected_index += 1
        self.page.update()

    # Update create_file_input method to include accessibility features
    def create_file_input(self, label: str, is_source=True):
        browse_button = ElevatedButton(
            "Browse",
            icon=Icons.UPLOAD,
            tooltip=f"Select a {label} file",
            on_click=self.open_source_picker if is_source else self.open_target_picker,
            bgcolor=self.COLORS["bg"]["accent"],
            color=self.COLORS["text"]["primary"],
            height=36,
            style=ButtonStyle(shape=RoundedRectangleBorder(radius=8)),
            focusable=True,
            data={"tab_index": 1 if is_source else 2}
        )

        folder_button = IconButton(
            icon=Icons.FOLDER,
            icon_size=20,
            tooltip=f"Select {label} folder",
            on_click=self.open_source_dir_picker if is_source else self.open_target_dir_picker,
            icon_color=self.COLORS["text"]["secondary"],
            focusable=True,
            data={"tab_index": 3 if is_source else 4}
        )

    def handle_line_numbers_toggle(self, e):
        """Handle toggling of line numbers in results"""
        self.config["show_line_numbers"] = e.control.value
        ConfigManager.save(self.config)
        # Rebuild results table if we have results
        if self.output_text.value and self.output_text.value != "Comparison results will appear here":
            self.build_results_table(self.output_text.value)
        self.page.update()

    # New dedicated methods for keyboard navigation management
    def register_keyboard_navigation(self):
        """Attach keyboard event handler."""
        if self.config.get("enable_keyboard_nav"):
            self.page.on_keyboard_event = self.handle_keyboard_event

    def unregister_keyboard_navigation(self):
        """Detach keyboard event handler."""
        self.page.on_keyboard_event = None

    def update_keyboard_navigation(self):
        """Update keyboard navigation settings by attaching or detaching the event handler."""
        if self.config.get("enable_keyboard_nav"):
            self.register_keyboard_navigation()
        else:
            self.unregister_keyboard_navigation()
        self.page.update()

    def open_file_picker(self, e):
        self.file_picker.get_file_path()

    def handle_file_picked(self, e: FilePickerResultEvent):
        if e.path:
            self.file_path = e.path
            self.file_label.value = f"File: {Path(e.path).name}"
            self.page.update()

    def compare_file(self):
        """Compare the selected file with improved error handling and UI feedback"""
        self.loading_ring.visible = True
        self.status_label.value = "Comparing file..."
        self.page.update()

        try:
            # Read file with explicit encoding fallback
            try:
                with open(self.file_path, 'r', encoding='utf-8') as f:
                    file_content = f.read()
            except UnicodeDecodeError:
                with open(self.file_path, 'r', encoding='latin-1') as f:
                    file_content = f.read()
                logging.warning("File %s using fallback encoding latin-1", self.file_path)
            
            # Parse content based on file extension
            ext = Path(self.file_path).suffix.lower()
            result = logic.parse_content_by_ext(file_content, ext)
            
            # Unpack dictionaries for comparison
            source_dict = result.get("translations", {})
            source_lines = result.get("line_numbers", {})
            
            if not source_dict:
                raise ValueError("No valid translations found in file")

            # Store line numbers for reference
            self.source_line_numbers = source_lines
            
            # Compare against itself to validate format
            comparison_result = logic.compare_translations(
                source_dict,
                source_dict,
                ignore_case=self.config["ignore_case"],
                ignore_whitespace=self.config["ignore_whitespace"],
                is_gui=True,
                include_summary=True,
                compare_values=self.config["compare_values"],
                ignore_patterns=self.config["ignore_patterns"],
                log_missing_keys=self.config["log_missing_strings"],
                auto_fill_missing=self.config["auto_fill_missing"],
            )

            # Clear and update results tabs
            self.results_tabs.tabs.clear()
            self.results_tabs.tabs.append(
                ft.Tab(
                    text=Path(self.file_path).name,
                    content=Container(
                        content=Column(
                            controls=[
                                Text(
                                    f"Total entries: {len(source_dict)}",
                                    size=14,
                                    color=self.COLORS["text"]["secondary"],
                                ),
                                TextField(
                                    value=comparison_result,
                                    multiline=True,
                                    read_only=True,
                                    min_lines=10,
                                    max_lines=None,
                                    text_style=TextStyle(
                                        color=self.COLORS["text"]["secondary"],
                                        size=14,
                                        font_family="Consolas",
                                        weight=FontWeight.W_400,
                                    ),
                                ),
                            ],
                            scroll=ft.ScrollMode.AUTO,
                            spacing=8,
                        ),
                        padding=10,
                    ),
                )
            )

            # Update UI elements
            self.results_tabs.visible = True
            self.results_container.content = self.results_tabs
            self.status_label.value = f"File validation complete. Found {len(source_dict)} entries."
            self.update_statistics(len(source_dict), 0, 0)  # Update statistics panel

        except FileNotFoundError:
            logging.error("File not found: %s", self.file_path)
            self.show_snackbar("Error: File not found")
            self.status_label.value = "Comparison failed: File not found"
        except UnicodeError as e:
            logging.error("Encoding error: %s", e)
            self.show_snackbar("Error: Unable to read file encoding")
            self.status_label.value = "Comparison failed: Encoding error"
        except ValueError as e:
            logging.error("Validation error: %s", e)
            self.show_snackbar("Error: %s" % e)
            self.status_label.value = "Comparison failed: Invalid content"
        except Exception as e:
            logging.error("Unexpected error during comparison: %s", e)
            self.show_snackbar("Unexpected error: %s" % e)
            self.status_label.value = "Comparison failed"
            raise  # Re-raise for debugging
        finally:
            self.loading_ring.visible = False
            self.page.update()

    def open_history_dialog(self, e):
        """Open a dialog showing past comparison reports."""
        # Run purge on old entries (older than 30 days)
        history_manager.purge_old_entries(30)
        
        history = history_manager.load_history()
        if not history:
            history_controls = [Text("No history found.", color=self.COLORS["text"]["secondary"])]
        else:
            history_controls = []
            for i, entry in enumerate(reversed(history), start=1):
                # Format timestamp for display - handle both ISO and old format
                timestamp = entry.get('timestamp', '')
                try:
                    if 'T' in timestamp:  # ISO format
                        dt = datetime.datetime.fromisoformat(timestamp)
                    else:  # Old format
                        dt = datetime.datetime.strptime(timestamp, "%Y-%m-%d %H:%M:%S")
                    formatted_time = dt.strftime("%Y-%m-%d %H:%M:%S")
                except (ValueError, TypeError):
                    formatted_time = timestamp  # Fallback to raw timestamp if parsing fails
                
                # Each entry shows timestamp, file names and a button to load diff
                entry_text = Text(
                    f"{formatted_time}\nSource: {entry['source_file']}  Target: {entry['target_file']}",
                    color=self.COLORS["text"]["secondary"],
                    size=14,
                )
                load_btn = ElevatedButton(
                    text="Load",
                    on_click=lambda e, diff=entry['diff']: self.load_history_entry(diff),
                    style=ButtonStyle(
                        bgcolor=self.COLORS["bg"]["accent"],
                        color=self.COLORS["text"]["primary"],
                    )
                )
                history_controls.append(Row(controls=[entry_text, load_btn], alignment="spaceBetween"))
                history_controls.append(Divider(color=self.COLORS["border"]["default"]))
        
        # Add count indicator to show how many entries are available
        history_count = len(history)
        max_entries = self.config.get("max_history_entries", 100)
        title_text = f"Comparison History ({history_count}/{max_entries})"
        
        self.history_dialog = ft.AlertDialog(
            title=Text(title_text, size=20),
            content=Container(
                content=Column(
                    controls=history_controls,
                    scroll=ft.ScrollMode.AUTO,
                ),
                width=500,
                height=400,
            ),
            # Added a Clear History button alongside Close
            actions=[
                TextButton("Clear History", on_click=self.clear_history_entries),
                TextButton("Close", on_click=lambda e: self.close_history_dialog())
            ],
        )
        if self.history_dialog not in self.page.overlay:
            self.page.overlay.append(self.history_dialog)
        self.history_dialog.open = True
        self.page.update()
    
    def clear_history_entries(self, e):
        """Clear the history, update the dialog, and show a confirmation message."""
        history_manager.clear_history()
        self.show_snackbar("History cleared.")
        # Refresh the history dialog content
        self.history_dialog.content = Container(
            content=Column(
                controls=[Text("No history found.", color=self.COLORS["text"]["secondary"])],
                scroll=ft.ScrollMode.AUTO,
            ),
            width=500,
            height=400,
        )
        self.page.update()
    
    def close_history_dialog(self):
        self.history_dialog.open = False
        self.page.update()
    
    def load_history_entry(self, diff: str):
        # Initialize missing line numbers if not already set
        if not hasattr(self, "target_line_numbers"):
            self.target_line_numbers = {}
        if not hasattr(self, "source_line_numbers"):
            self.source_line_numbers = {}
        # ...existing code...
        self.output_text.value = diff
        self.build_results_table(diff)
        self.show_snackbar("History entry loaded.")
        self.page.update()

    def save_config(self):
        """Save current configuration to disk."""
        ConfigManager.save(self.config)
        self.page.update()

def main(page: ft.Page):
    App(page)

if __name__ == "__main__":
    ft.app(target=main)