import flet as ft
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
from pathlib import Path
from constants import SUPPORTED_FORMATS, USER_MESSAGES
import json
import re

# New configuration manager class
class ConfigManager:
    CONFIG_FILE = r"E:/ProgramTests/LocalizerAppMain/config.json"
    
    @staticmethod
    def load():
        if os.path.exists(ConfigManager.CONFIG_FILE):
            try:
                with open(ConfigManager.CONFIG_FILE, "r", encoding="utf-8") as f:
                    return json.load(f)
            except Exception as e:
                print(f"Error loading config: {e}")
        return {}
    
    @staticmethod
    def save(config: dict):
        try:
            with open(ConfigManager.CONFIG_FILE, "w", encoding="utf-8") as f:
                json.dump(config, f, indent=4)
        except Exception as e:
            print(f"Error saving config: {e}")

class App:
    def __init__(self, page: ft.Page):
        self.page = page
        # Add color cache
        self._cached_colors = {}
        
        # Theme colors (unchanged)
        self.THEMES = {
            "dark": {
                "bg": {
                    "primary": "#111827",
                    "secondary": "#1F2937",
                    "input": "#374151",
                    "accent": "#3B82F6",
                },
                "text": {
                    "primary": "#F9FAFB",
                    "secondary": "#9CA3AF",
                    "accent": "#60A5FA",
                },
                "border": {
                    "default": "#4B5563",
                    "accent": "#3B82F6",
                },
                "changes": {
                    "added": "#4ADE80",    # green
                    "removed": "#F87171",  # red
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
                    "muted": "#6B7280",
                },
                "border": {
                    "default": "#E5E7EB",
                    "accent": "#3B82F6",
                },
                "changes": {
                    "added": "#22C55E",    # green
                    "removed": "#EF4444",  # red
                }
            }
        }

        # Use dark theme colors
        self.COLORS = self.THEMES["dark"]
        # Cache initial colors
        self._cached_colors[page.theme_mode.value] = self.COLORS

        # Remove theme toggle button initialization and keep only settings button
        self.settings_button = IconButton(
            icon=Icons.SETTINGS,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Settings",  # Changed from "Theme Settings"
            on_click=self.open_settings
        )
        # New Feedback button next to settings button
        self.feedback_button = IconButton(
            icon=Icons.FEEDBACK,
            tooltip="Send Feedback",
            icon_color=self.COLORS["text"]["secondary"],
            on_click=self.open_feedback_dialog
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
            "group_by_namespace": True  # Add this line
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

        # Create tabs for settings dialog
        self.settings_tabs = Tabs(
            selected_index=0,
            animation_duration=300,
            tabs=[
                Tab(
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
                                                value=page.theme_mode.value,
                                                options=[
                                                    ft.dropdown.Option("system", "System Default"),
                                                    ft.dropdown.Option("dark", "Dark Theme"),
                                                    ft.dropdown.Option("light", "Light Theme"),
                                                ],
                                                on_change=self.handle_theme_change,
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
                                                    ft.dropdown.Option("en", "English"),
                                                    ft.dropdown.Option("es", "Spanish"),
                                                    ft.dropdown.Option("fr", "French"),
                                                    ft.dropdown.Option("de", "German"),
                                                ],
                                                on_change=self.handle_mt_source_lang_change
                                            ),
                                            ft.Dropdown(
                                                label="Target Language",
                                                value=self.config["mt_target_lang"],
                                                options=[
                                                    ft.dropdown.Option("tr", "Turkish"),
                                                    ft.dropdown.Option("es", "Spanish"),
                                                    ft.dropdown.Option("fr", "French"),
                                                    ft.dropdown.Option("de", "German"),
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

        # Define feedback dialog
        self.feedback_dialog = ft.AlertDialog(
            title=Text("Feedback"),
            content=Container(
                content=Column(
                    controls=[
                        TextField(label="Your Email (optional)"),
                        TextField(label="Feedback", multiline=True, min_lines=4),
                    ],
                    spacing=8,
                ),
                width=500, height=300,
            ),
            actions=[
                TextButton("Send", on_click=self.send_feedback),
                TextButton("Cancel", on_click=self.close_feedback_dialog),
            ]
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
        self.results_container = Container(
            content=self.summary_text,
            padding=padding.all(16),
            expand=True,
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
        
        self.source_picker = FilePicker(on_result=lambda e: self.handle_file_picked(e, self.source_label, self.source_icon, None, "source"))
        self.target_picker = FilePicker(on_result=lambda e: self.handle_file_picked(e, self.target_label, self.target_icon, None, "target"))
        
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
        self.source_file_container = create_file_input("Source File", is_source=True)
        self.target_file_container = create_file_input("Target File", is_source=False)

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
                                    content=self.source_file_container,
                                    col={"sm": 12, "md": 6},
                                ),
                                Container(
                                    content=self.target_file_container,
                                    col={"sm": 12, "md": 6},
                                ),
                            ],
                        ),
                        height=120,
                    ),
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
        # Initialize expand/collapse control first
        self.expand_all = True
        self.expand_collapse_button = IconButton(
            icon=Icons.UNFOLD_LESS,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Collapse All",
            on_click=self.toggle_expand_all,
        )

        # Create results header with expand/collapse button
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

        # Then in the content initialization
        self.content = Container(
            expand=True,
            height=page.height,
            padding=32,
            content=Column(
                expand=True,
                scroll=ScrollMode.AUTO,
                controls=[
                    # Header container
                    Container(
                        content=Column(
                            controls=[
                                Row(
                                    controls=[
                                        Container(width=48),
                                        Text(
                                            "Localization Comparison Tool",
                                            size=32,
                                            weight="bold",
                                            text_align="center",
                                            expand=True,
                                        ),
                                        Container(
                                            content=Row(
                                                controls=[
                                                    self.settings_button,
                                                    self.feedback_button,
                                                ],
                                                spacing=8,
                                            ),
                                            width=96,
                                        ),
                                    ],
                                    alignment="spaceBetween",
                                ),
                                Text(
                                    "Compare Source and Target Localization Files",
                                    size=16,
                                    color=self.COLORS["text"]["secondary"],
                                    text_align="center",
                                ),
                            ],
                            horizontal_alignment="center",
                            spacing=8,
                        ),
                        padding=padding.only(bottom=24),
                        height=100,
                    ),
                    self.main_card_container,
                ],
                spacing=32,
            ),
        )

    def create_checkbox(self, label: str, value: bool = False):
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
        # Create a container for both buttons
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
            visible=False,  # Initially hidden
        )
        
        button_row = Row(
            controls=[compare_button, translate_button],
            alignment="center",
            spacing=16,
        )
        
        return Container(
            content=button_row,
            animate=ft.Animation(duration=200, curve="easeInOut"),
            on_hover=lambda e: self._on_compare_button_hover(e, compare_button)
        )

    def translate_missing_keys(self, e):
        if not self.config["mt_enabled"] or not self.config["mt_api_key"]:
            self.show_snackbar("Please enable machine translation and set API key in settings")
            return

        def update_progress(value):
            self.loading_ring.visible = True
            self.status_label.value = f"Translating... {int(value * 100)}%"
            self.page.update()

        try:
            # Get the current translations
            with open(self.source_file_path, 'r', encoding='utf-8') as f:
                source_content = f.read()
            with open(self.target_file_path, 'r', encoding='utf-8') as f:
                target_content = f.read()

            ext_source = Path(self.source_file_path).suffix.lower()
            ext_target = Path(self.target_file_path).suffix.lower()

            source_dict = logic.parse_content_by_ext(source_content, ext_source)
            target_dict = logic.parse_content_by_ext(target_content, ext_target)

            # Show progress ring
            self.loading_ring.visible = True
            self.status_label.value = "Translating missing keys..."
            self.page.update()

            # Translate missing keys
            updated_dict, errors = logic.translate_missing_keys(
                source_dict,
                target_dict,
                self.config["mt_source_lang"],
                self.config["mt_target_lang"],
                self.config["mt_api_key"],
                update_progress
            )

            if errors:
                error_msg = "\n".join(errors[:5])  # Show first 5 errors
                if len(errors) > 5:
                    error_msg += f"\n...and {len(errors) - 5} more errors"
                self.show_snackbar(f"Some translations failed: {error_msg}")

            # Prompt for save location
            save_dialog = FilePicker(
                on_result=lambda e: self.save_translated_file(e, updated_dict)
            )
            self.page.overlay.append(save_dialog)
            save_dialog.save_file(
                allowed_extensions=["json", "yaml", "xml", "lang"],
                file_name=f"new_target{ext_target}"
            )

        except Exception as e:
            self.show_snackbar(f"Translation error: {str(e)}")
            self.status_label.value = "Translation failed"
        finally:
            self.loading_ring.visible = False
            self.page.update()

    def save_translated_file(self, e: FilePickerResultEvent, translations: dict):
        if not e.path:
            return

        success, error = logic.save_translations(
            translations, 
            e.path, 
            format=self.config["preferred_format"]
        )

        if success:
            self.show_snackbar("Translations saved successfully")
            self.status_label.value = "Translation complete"
        else:
            self.show_snackbar(f"Error saving translations: {error}")
            self.status_label.value = "Save failed"
        self.page.update()

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

    def handle_file_picked(self, e: FilePickerResultEvent, field, icon, clear_btn, field_type):
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

    def compare_files_gui(self, e):
        self.loading_ring.visible = True
        self.status_label.value = "Comparing files..."
        self.page.update()

        try:
            # Read files with explicit encoding and error handling
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

            # Parse both files
            source_dict = logic.parse_content_by_ext(source_content, ext_source)
            target_dict = logic.parse_content_by_ext(target_content, ext_target)

            # Debug logging
            print(f"Source file entries: {len(source_dict)}")
            print(f"Target file entries: {len(target_dict)}")
            print("Sample source entries:", dict(list(source_dict.items())[:3]))
            print("Sample target entries:", dict(list(target_dict.items())[:3]))

            # Get ignore patterns
            ignore_patterns = []
            pattern_str = self.ignore_pattern_field.value.strip()
            if pattern_str:
                ignore_patterns = [p.strip() for p in pattern_str.split(",") if p.strip()]

            # Add MT settings to comparison
            mt_settings = {
                'enabled': self.config["mt_enabled"],
                'api_key': self.config["mt_api_key"],
                'source_lang': self.config["mt_source_lang"],
                'target_lang': self.config["mt_target_lang"]
            }

            # Compare translations - modify the call to not include summary
            comparison_result = logic.compare_translations(
                target_dict,  # target translations (old_translations)
                source_dict,  # source translations (new_translations)
                ignore_case=self.config["ignore_case"],
                ignore_whitespace=self.config["ignore_whitespace"],
                is_gui=True,
                include_summary=False,  # Add this parameter
                compare_values=self.config["compare_values"],
                ignore_patterns=self.config["ignore_patterns"],
                log_missing_keys=self.config["log_missing_strings"],
                auto_fill_missing=self.config["auto_fill_missing"],
                mt_settings=mt_settings
            )

            # Calculate the sets of missing and obsolete keys
            missing_keys_set = set(source_dict.keys()) - set(target_dict.keys())
            obsolete_keys_set = set(target_dict.keys()) - set(source_dict.keys())

            # Update statistics using the lengths
            total_keys = len(source_dict)
            missing_keys = len(missing_keys_set)
            obsolete_keys = len(obsolete_keys_set)
            self.update_statistics(total_keys, missing_keys, obsolete_keys)

            # Update UI with results
            self.output_text.value = comparison_result
            self.build_results_table(comparison_result)
            self.status_label.value = f"Comparison complete. Found {len(source_dict)} source and {len(target_dict)} target entries."

        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            print(f"Error details: {error_details}")
            self.show_snackbar(f"Error: {str(e)}")
            self.status_label.value = "Comparison failed"
            # Reset statistics on error
            self.update_statistics(0, 0, 0)
        finally:
            self.loading_ring.visible = False
            self.page.update()

        # Add this at the end of the method:
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
        from flet import Icon, Column, Row, Text, TextField
        lines = comparison_result.splitlines()
        # Sort lines by prefix priority: removed ('-'), mismatched ('~'), added ('+')
        sorted_lines = sorted(lines, key=lambda l: {'-': 0, '~': 1, '+': 2}.get(l[0], 3))
        result_rows = []
        if self.config.get("group_by_namespace"):
            groups = self.group_keys_by_namespace(sorted_lines)
            for namespace, group_lines in groups.items():
                # Header row for namespace
                header = Row(controls=[Text(f"Namespace: {namespace}", weight="bold")])
                result_rows.append(header)
                for line in group_lines:
                    if line.startswith("+"):
                        icon = Icon(Icons.ADD, color="green")
                    elif line.startswith("-"):
                        icon = Icon(Icons.REMOVE, color="red")
                    elif line.startswith("~"):
                        icon = Icon(Icons.WARNING, color="yellow")
                    else:
                        icon = Icon(Icons.HELP, color="grey")
                    result_rows.append(Row(controls=[icon, Text(line)], spacing=8))
        else:
            for line in sorted_lines:
                if line.startswith("+"):
                    icon = Icon(Icons.ADD, color="green")
                elif line.startswith("-"):
                    icon = Icon(Icons.REMOVE, color="red")
                elif line.startswith("~"):
                    icon = Icon(Icons.WARNING, color="yellow")
                else:
                    icon = Icon(Icons.HELP, color="grey")
                result_rows.append(Row(controls=[icon, Text(line)], spacing=8))
        # Prepend a search bar for filtering results
        search_field = TextField(
            hint_text="Search results...",
            on_change=lambda e: self.filter_results(e, sorted_lines)
        )
        self.results_container.content = Column(controls=[search_field] + result_rows)
        self.page.update()

    def filter_results(self, e):
        query = e.control.value.lower()
        filtered_rows = [row for row in self.all_result_rows if query in row.controls[1].value.lower()]
        from flet import Column, TextField
        self.results_container.content = Column(
            controls=[TextField(
                        hint_text="Search results...",
                        value=query,
                        on_change=lambda e: self.filter_results(e)
                     )] + filtered_rows
        )
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
        self.settings_dialog.open = True
        self.page.update()

    def close_settings(self, e):
        self.settings_dialog.open = False
        self.page.update()

    def reset_colors(self, e):
        self.COLORS = self.THEMES["dark"]
        self.update_theme_colors()
        self.page.update()

    def update_theme_colors(self):
        """Update colors of all UI elements with caching"""
        theme_key = self.page.theme_mode.value
        if theme_key in self._cached_colors:
            self.COLORS = self._cached_colors[theme_key]
        else:
            # Calculate colors based on theme mode
            selected = theme_key.lower()
            self.COLORS = self.THEMES[selected if selected != "system" else "dark"]
            # Cache the calculated colors
            self._cached_colors[theme_key] = self.COLORS

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

    def handle_case_change(self, e):
        self.config["ignore_case"] = e.control.value
        ConfigManager.save(self.config)
        self.ignore_case_checkbox.value = e.control.value  # Update main UI checkbox
        self.page.update()

    def reset_settings(self, e):
        self.config = {
            "auto_fill_missing": False,
            "log_missing_strings": False,
            "ignore_patterns": [],
            "preferred_format": "auto",
            "ignore_whitespace": False,
            "ignore_case": False,
            "compare_values": True,
            "group_by_namespace": True  # Add default value here too
        }
        
        # Reset theme to system default
        self.page.theme_mode = ft.ThemeMode.SYSTEM
        self.COLORS = self.THEMES["dark"]
        
        # Update UI controls to match reset settings
        for container in self.settings_dialog.content.controls:
            if isinstance(container, Container):
                for control in container.content.controls:
                    if isinstance(control, ft.Checkbox):
                        control.value = False
                    elif isinstance(control, ft.Dropdown):
                        if hasattr(control, "label") and control.label == "Theme Mode":
                            control.value = "system"
                        else:
                            control.value = "auto"
                    elif isinstance(control, TextField):
                        control.value = ""
                        
        self.update_theme_colors()
        self.page.update()

        self.config.update({
            "mt_enabled": False,
            "mt_api_key": "",
            "mt_source_lang": "en",
            "mt_target_lang": "tr"
        })

        # Update all tabs' controls to reflect reset values
        self.settings_tabs.tabs[0].content.content.controls[0].content.controls[1].value = "system"  # Theme dropdown
        # Update other tab controls as needed
        
        ConfigManager.save(self.config)
        self.page.update()

    def handle_mt_enabled_change(self, e):
        self.config["mt_enabled"] = e.control.value
        ConfigManager.save(self.config)
        self.page.update()

    def handle_mt_api_key_change(self, e):
        new_key = e.control.value.strip() if e.control.value else ""
        if not new_key:
            self.show_snackbar("API key cannot be empty.")
            self.config["mt_api_key"] = ""
        else:
            self.config["mt_api_key"] = new_key
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
        """Handle theme mode changes using simplified logic"""
        selected = e.control.value
        self.page.theme_mode = getattr(ft.ThemeMode, selected.upper())
        self.COLORS = self.THEMES[selected if selected != "system" else "dark"]
        ConfigManager.save(self.config)
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
        self.log_missing_strings = e.control.value
        self.page.update()

    def open_feedback_dialog(self, e):
        if not hasattr(self, "feedback_dialog"):
            self.feedback_dialog = ft.AlertDialog(
                title=Text("Feedback"),
                content=Container(
                    content=Column(
                        controls=[
                            TextField(label="Your Email (optional)"),
                            TextField(label="Feedback", multiline=True, min_lines=4)
                        ],
                        spacing=8
                    ),
                    width=500, height=300
                ),
                actions=[
                    TextButton("Send", on_click=self.send_feedback),
                    TextButton("Cancel", on_click=self.close_feedback_dialog)
                ]
            )
        if self.feedback_dialog not in self.page.overlay:
            self.page.overlay.append(self.feedback_dialog)
        self.feedback_dialog.open = True
        self.page.update()

    def send_feedback(self, e):
        import requests
        email = self.feedback_dialog.content.content.controls[0].value
        message = self.feedback_dialog.content.content.controls[1].value

        if not message:
            self.show_snackbar("Please enter your feedback message")
            return

        try:
            response = requests.post(
                "https://formspree.io/f/your-formspree-id",
                data={
                    "email": email if email else "Anonymous",
                    "message": message,
                }
            )
            if response.ok:
                self.show_snackbar("Thank you for your feedback!")
                self.close_feedback_dialog(None)
            else:
                self.show_snackbar("Error sending feedback")
        except Exception as e:
            self.show_snackbar(f"Error sending feedback: {str(e)}")

    def close_feedback_dialog(self, e):
        self.feedback_dialog.open = False
        self.page.update()

def highlight_line(line: str, change_type: str) -> str:
    """Simple syntax highlighting for comparison lines."""
    # No highlighting needed for GUI as we handle colors in the UI
    return line

def main(page: ft.Page):
    App(page)

if __name__ == "__main__":
    ft.app(target=main)