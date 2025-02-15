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
from reports.report_generator import ReportGenerator

class App:
    def __init__(self, page: ft.Page):
        self.page = page
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
            "group_by_namespace": True  # Add this line
        }

        # Add MT settings to config
        self.config.update({
            "mt_enabled": False,
            "mt_api_key": "",
            "mt_source_lang": "en",
            "mt_target_lang": "tr"
        })

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
                                                hint_text="Comma-separated patterns to ignore",
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
        self.content = Container(
            expand=True,
            height=page.height,
            padding=32,
            content=Column(
                expand=True,
                scroll=ScrollMode.AUTO,
                controls=[
                    # Header (fixed height)
                    Container(
                        content=Column(
                            controls=[
                                Row(
                                    controls=[
                                        # Add a placeholder container on the left with width for one button
                                        Container(width=48),  # Width of one IconButton
                                        Text(
                                            "Localization Comparison Tool",
                                            size=32,
                                            weight="bold",
                                            text_align="center",
                                            expand=True,
                                        ),
                                        # Right-side container with single button
                                        Container(
                                            content=Row(
                                                controls=[
                                                    self.settings_button,
                                                ],
                                                spacing=0,
                                            ),
                                            width=48,  # Match left placeholder width
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
                        height=100,  # Fixed height for header
                    ),
                    # Main card with scrollable content (updated layout)
                    self.main_card_container,
                ],
                spacing=32,
            ),
        )
        page.add(self.content)
        self.page.on_window_event = self.handle_window_event

        self.user_friendly_errors = {
            "file_not_found": "File does not exist or is not valid. Please check the path.",
            "file_type": "Unsupported file type. Please select a CSV, .lang, or .txt file.",
            "file_empty": "The selected file is empty. Please choose another file.",
        }

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
                                icon=Icons.UPLOAD_FILE,
                                icon_color=self.COLORS["text"]["secondary"],
                                tooltip="Import Changes",
                                on_click=self.import_changes,
                            ),
                            IconButton(
                                icon=Icons.DOWNLOAD,
                                icon_color=self.COLORS["text"]["secondary"],
                                tooltip="Export Report",
                                on_click=self.export_report,
                            ),
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

        # Add file pickers for export/import
        self.export_picker = FilePicker(
            on_result=self.handle_export_result
        )
        self.import_picker = FilePicker(
            on_result=self.handle_import_result
        )
        page.overlay.extend([self.export_picker, self.import_picker])
        
        # Save comparison data for export
        self.comparison_data = {
            "missing": [],
            "obsolete": [],
            "modified": []
        }

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
        try:
            path = Path(file_path)
            # Allow additional file types: json, yaml, and yml
            if path.suffix.lower()[1:] not in ["csv", "lang", "txt", "json", "yaml", "yml"]:
                self.show_validation_error("file_type")
                return False
            if not path.exists() or not path.is_file():
                self.show_validation_error("file_not_found")
                return False
            if path.stat().st_size == 0:
                self.show_validation_error("file_empty")
                return False
            with open(file_path, 'r', encoding='utf-8') as f:
                f.read(1024)
            return True
        except Exception as e:
            self.show_snackbar(f"Unexpected error: {str(e)}")
            return False

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

            # Update comparison data using the actual sets
            self.comparison_data = {
                "missing": [(k, source_dict[k]) for k in missing_keys_set],
                "obsolete": [(k, target_dict[k]) for k in obsolete_keys_set],
                "modified": [
                    (k, (source_dict[k], target_dict[k])) 
                    for k in source_dict.keys() & target_dict.keys()
                    if source_dict[k] != target_dict[k]
                ]
            }

            # Update UI with results
            self.output_text.value = comparison_result
            self.build_results_table(comparison_result)
            self.status_label.value = f"Comparison complete. Found {len(source_dict)} source and {len(target_dict)} target entries."

            # After comparison is complete, update comparison_data
            self.comparison_data = {
                "missing": [(k, source_dict[k]) for k in missing_keys_set],
                "obsolete": [(k, target_dict[k]) for k in obsolete_keys_set],
                "modified": [
                    (k, (source_dict[k], target_dict[k])) 
                    for k in source_dict.keys() & target_dict.keys()
                    if source_dict[k] != target_dict[k]
                ]
            }

        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            print(f"Error details: {error_details}")
            self.show_snackbar(f"Error: {str(e)}")
            self.status_label.value = "Comparison failed"
            # Reset statistics on error
            self.update_statistics(0, 0, 0)
            self.comparison_data = {"missing": [], "obsolete": [], "modified": []}
        finally:
            self.loading_ring.visible = False
            self.page.update()

        # Add this at the end of the method:
        translate_button = self.compare_button.content.controls[1]
        translate_button.visible = True
        self.page.update()

    def build_results_table(self, comparison_result: str):
        """Build and display the results table with optional namespace grouping"""
        lines = comparison_result.splitlines()
        table_rows = []
        
        if self.config["group_by_namespace"]:
            # Existing grouping logic
            groups, ungrouped = self.group_keys_by_namespace(lines)
            
            # Create expandable sections for each namespace
            for namespace, entries in sorted(groups.items()):
                # Create namespace header
                header_content = Row(
                    controls=[
                        IconButton(
                            icon=Icons.EXPAND_MORE,
                            icon_color=self.COLORS["text"]["secondary"],
                            tooltip="Toggle section",
                        ),
                        Text(
                            f"{namespace} ({len(entries)})",
                            size=16,
                            weight=FontWeight.BOLD,
                            color=self.COLORS["text"]["secondary"],
                        ),
                    ],
                    alignment="center",
                )
                
                # Create container for namespace entries
                entries_column = Column(
                    controls=[self.create_result_row(line) for line, _ in entries],
                    spacing=2,
                    visible=self.expand_all,
                )
                
                # Create expandable section
                section = Container(
                    content=Column(
                        controls=[
                            header_content,
                            Container(
                                content=entries_column,
                                padding=padding.only(left=32),
                            ),
                        ],
                    ),
                    padding=padding.only(top=8, bottom=8),
                )
                
                # Add click handler to header
                header_content.controls[0].on_click = lambda e, col=entries_column: self.toggle_section(e, col)
                
                table_rows.append(section)
            
            # Add ungrouped entries at the bottom
            if ungrouped:
                ungrouped_header = Text(
                    "Other",
                    size=16,
                    weight=FontWeight.BOLD,
                    color=self.COLORS["text"]["secondary"],
                )
                table_rows.append(Container(
                    content=ungrouped_header,
                    padding=padding.only(top=16, bottom=8),
                ))
                
                for line, _ in sorted(ungrouped, key=lambda x: x[1]):
                    table_rows.append(self.create_result_row(line))
        else:
            # Simple flat list without grouping
            for line in lines:
                if line.strip() and not line.startswith("---"):
                    table_rows.append(self.create_result_row(line))

        # Create a column containing all rows
        results_column = Column(
            controls=table_rows,
            scroll=ft.ScrollMode.AUTO,
            spacing=2,
        )
        
        # Update the results container with the new content
        self.results_container.content = results_column
        self.page.update()

    def create_result_row(self, line: str) -> Container:
        """Create a styled row for a single comparison result"""
        text_color = self.COLORS["text"]["primary"]  # default color
        text_weight = ft.FontWeight.NORMAL
        
        # Handle comparison lines
        indicator = line[:1].strip()
        if indicator == "+":
            text_color = self.COLORS["changes"]["added"]
        elif indicator == "-":
            text_color = self.COLORS["changes"]["removed"]
        elif indicator == "~":
            text_color = self.COLORS["text"]["accent"]
        
        # Create a row with the line
        row_content = ft.Text(
            value=line,
            color=text_color,
            weight=text_weight,
            size=14,
            font_family="Consolas",
        )
        
        return Container(
            content=row_content,
            padding=padding.all(8),
        )

    def toggle_section(self, e, column):
        """Toggle visibility of a namespace section"""
        column.visible = not column.visible
        e.control.icon = Icons.EXPAND_LESS if column.visible else Icons.EXPAND_MORE
        self.page.update()

    def toggle_expand_all(self, e):
        """Toggle expand/collapse all sections"""
        self.expand_all = not self.expand_all
        self.expand_collapse_button.icon = (
            Icons.UNFOLD_MORE if self.expand_all else Icons.UNFOLD_LESS
        )
        self.expand_collapse_button.tooltip = (
            "Collapse All" if self.expand_all else "Expand All"
        )
        self.build_results_table(self.output_text.value)
        self.page.update()

    def group_keys_by_namespace(self, lines: list[str]) -> dict:
        """Group comparison lines by their namespace"""
        groups = {}
        ungrouped = []
        
        for line in lines:
            if not line.strip():
                continue
            
            # Skip summary lines
            if line.startswith("---") or line.startswith("Added:") or line.startswith("Removed:"):
                continue
                
            # Extract the key from the line (after the +/- indicator)
            parts = line.split(" : ", 1)
            if len(parts) != 2:
                ungrouped.append(line)
                continue
                
            key_part = parts[0].lstrip("+-~ ").strip()
            value_part = parts[1]
            
            # Split key into namespace parts
            key_segments = key_part.split(".")
            
            if len(key_segments) > 1:
                # Use first segment as namespace
                namespace = key_segments[0]
                if namespace not in groups:
                    groups[namespace] = []
                groups[namespace].append((line, key_part))
            else:
                ungrouped.append((line, key_part))
        
        # Sort each group by key
        for namespace in groups:
            groups[namespace].sort(key=lambda x: x[1])
        
        return groups, ungrouped

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
        """Update colors of all UI elements from self.COLORS."""
        # Page and main container
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
        
        self.page.update()

    def handle_mt_enabled_change(self, e):
        self.config["mt_enabled"] = e.control.value
        self.page.update()

    def handle_mt_api_key_change(self, e):
        self.config["mt_api_key"] = e.control.value
        self.page.update()

    def handle_mt_source_lang_change(self, e):
        self.config["mt_source_lang"] = e.control.value
        self.page.update()

    def handle_mt_target_lang_change(self, e):
        self.config["mt_target_lang"] = e.control.value
        self.page.update()

    def handle_group_by_namespace_change(self, e):
        """Handle toggling of namespace grouping"""
        self.config["group_by_namespace"] = e.control.value
        # Rebuild results table if we have results
        if self.output_text.value and self.output_text.value != "Comparison results will appear here":
            self.build_results_table(self.output_text.value)
        self.page.update()

    def update_statistics(self, total_keys: int, missing_keys: int, obsolete_keys: int):
        """Update the statistics panel with new values"""
        self.stats_text_total.value = str(total_keys)
        self.stats_text_missing.value = str(missing_keys)
        self.stats_text_obsolete.value = str(obsolete_keys)
        self.page.update()

    def handle_theme_change(self, e):
        """Handle theme mode changes"""
        selected = e.control.value
        if (selected == "dark"):
            self.page.theme_mode = ft.ThemeMode.DARK
            self.COLORS = self.THEMES["dark"]
        elif (selected == "light"):
            self.page.theme_mode = ft.ThemeMode.LIGHT
            self.COLORS = self.THEMES["light"]
        else:  # system
            self.page.theme_mode = ft.ThemeMode.SYSTEM
            # Default to dark theme if system preference can't be detected
            self.COLORS = self.THEMES["dark"]
        
        self.update_theme_colors()
        self.page.update()

    def export_report(self, e):
        """Export comparison results to a file"""
        if not self.comparison_data.get("missing") and not self.comparison_data.get("obsolete"):
            self.show_snackbar("No comparison results to export")
            return
        
        # Open file picker for save location
        self.export_picker.save_file(
            allowed_extensions=["html", "md", "txt"],
            file_name="comparison_report"
        )

    def handle_export_result(self, e: ft.FilePickerResultEvent):
        """Handle export file picker result"""
        if not e.path:
            return

        try:
            generator = ReportGenerator()
            success = generator.generate_report(
                self.comparison_data,
                e.path,
                source_file=Path(self.source_file_path).name,
                target_file=Path(self.target_file_path).name
            )
            
            if success:
                self.show_snackbar("Report exported successfully")
            else:
                self.show_snackbar("Failed to export report")
        except Exception as ex:
            self.show_snackbar(f"Error exporting report: {str(ex)}")

    def import_changes(self, e):
        """Import changes from a file"""
        self.import_picker.pick_files(
            allowed_extensions=["json", "yaml", "yml"],
            allow_multiple=False
        )

    def handle_import_result(self, e: ft.FilePickerResultEvent):
        """Handle import file picker result"""
        if not e.files or not e.files[0].path:
            return

        try:
            # Implementation will depend on your import format
            self.show_snackbar("Import functionality not yet implemented")
        except Exception as ex:
            self.show_snackbar(f"Error importing changes: {str(ex)}")

    def handle_auto_fill_change(self, e):
        """Handle auto-fill settings change"""
        self.config["auto_fill_missing"] = e.control.value
        self.page.update()

    def handle_patterns_change(self, e):
        """Handle ignore patterns change"""
        patterns = [p.strip() for p in e.control.value.split(",") if p.strip()]
        self.config["ignore_patterns"] = patterns
        self.page.update()

    def handle_format_change(self, e):
        """Handle preferred format change"""
        self.config["preferred_format"] = e.control.value
        self.page.update()

    def handle_whitespace_change(self, e):
        """Handle whitespace ignore setting change"""
        self.config["ignore_whitespace"] = e.control.value
        self.page.update()

    def handle_log_missing_change(self, e):
        """Handle log missing keys setting change"""
        self.config["log_missing_strings"] = e.control.value
        self.log_missing_strings = e.control.value  # Update the flag as well
        self.page.update()

def highlight_line(line: str, change_type: str) -> str:
    """Simple syntax highlighting for comparison lines."""
    # No highlighting needed for GUI as we handle colors in the UI
    return line

def main(page: ft.Page):
    App(page)

if __name__ == "__main__":
    ft.app(target=main)