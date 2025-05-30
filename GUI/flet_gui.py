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
# Import status constants from logic.py to be used for calculating statistics
from GUI.logic import (
    KEY as LG_KEY, # Using LG_ prefix to avoid potential name clashes
    STATUS as LG_STATUS,
    SOURCE_VALUE as LG_SOURCE_VALUE,
    TARGET_VALUE as LG_TARGET_VALUE,
    DETAILS as LG_DETAILS,
    STATUS_MISSING_IN_TARGET,
    STATUS_OBSOLETE_IN_TARGET,
    STATUS_PLACEHOLDER_MISMATCH,
    STATUS_VALUE_CHANGED,
    STATUS_IDENTICAL
)
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
from components.history_dialog import HistoryDialogComponent

# Add darkdetect import at the module level with try/except to handle case if not installed
try:
    import darkdetect
    HAS_DARKDETECT = True
except ImportError:
    HAS_DARKDETECT = False
    logging.warning("darkdetect package not found. System theme detection will fall back to 'dark'.")

# Get logger from service
logger = logger_service.get_logger()

class App:
    """Main GUI application class implementing localization comparison using flet."""

    # --- Typographic Scale ---
    TEXT_SIZE_XSMALL = 10
    TEXT_SIZE_SMALL = 12
    TEXT_SIZE_DEFAULT = 14
    TEXT_SIZE_MEDIUM = 16
    TEXT_SIZE_LARGE = 18 # Reduced from 20 for finer control
    TEXT_SIZE_XLARGE = 22 # Reduced from 24
    TEXT_SIZE_XXLARGE = 28 # Reduced from 32
    TEXT_SIZE_HERO = 36 # For very prominent titles if needed

    # --- Spacing Scale (multiples of 4px and 8px) ---
    BASE_UNIT = 4
    spacing = {
        "xxs": BASE_UNIT,    # 4px
        "xs": BASE_UNIT * 2, # 8px
        "s": BASE_UNIT * 3,  # 12px
        "m": BASE_UNIT * 4,  # 16px
        "l": BASE_UNIT * 6,  # 24px
        "xl": BASE_UNIT * 8, # 32px
        "xxl": BASE_UNIT * 12 # 48px
    }

    def __init__(self, page: ft.Page):
        """Initialize the application, load configuration and setup UI elements."""
        self.page = page

        # --- Typography & Spacing Setup ---
        self.page.fonts = {
            "Roboto": "https://fonts.google.com/specimen/Roboto",  # Example URL, Flet handles web fonts
            "Consolas": "Consolas"  # Assuming Consolas is available or Flet has a fallback
        }
        # Set default font for the page themes
        self.page.theme = ft.Theme(font_family="Roboto")
        self.page.dark_theme = ft.Theme(font_family="Roboto")
        # --- End Typography & Spacing Setup ---

        # Add color cache
        self._cached_colors = {}
        
        # Create a SnackBar for the app
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(""),
            bgcolor=self.COLORS["bg"]["secondary"] if hasattr(self, "COLORS") else "#333333",
        )
        
        # Replace the existing THEMES with the imported one
        self.THEMES = THEMES

        # Load configuration with defaults already merged
        self.config = ConfigManager.load()
        self.current_theme = self.config.get("theme", "system")
        self.COLORS = self.THEMES[self.current_theme if self.current_theme != "system" else "dark"]
        self._cached_colors = {self.current_theme: self.COLORS}

        # Update the snack bar colors now that COLORS is initialized
        self.page.snack_bar.bgcolor = self.COLORS["bg"]["secondary"]

        # Create settings dialog using SettingsDialogComponent
        self.settings_dialog_component = SettingsDialogComponent(page, self, self.config, self.COLORS)
        self.settings_dialog = self.settings_dialog_component.dialog
        
        # Settings button that will use the SettingsDialogComponent
        self.settings_button = IconButton(
            icon=Icons.SETTINGS,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Settings",
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
            self.page.theme_mode = ft.ThemeMode.SYSTEM # Use self.page
        elif self.current_theme in ["dark", "amoled"]:
            self.page.theme_mode = ft.ThemeMode.DARK   # Use self.page
        else:
            self.page.theme_mode = ft.ThemeMode.LIGHT  # Use self.page

        # Add keyboard navigation settings to config
        self.config.update({
            "enable_keyboard_nav": True,
            "high_contrast": False,
            "large_text": False,
            "font_size_scale": 1.0
        })

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
                size=self.TEXT_SIZE_DEFAULT, # Updated
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
                size=self.TEXT_SIZE_DEFAULT, # Updated
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
                size=self.TEXT_SIZE_DEFAULT, # Updated
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
                size=self.TEXT_SIZE_DEFAULT, # Updated
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
            padding=padding.all(self.spacing["m"]), # Updated
            expand=True,
            clip_behavior=ft.ClipBehavior.HARD_EDGE
        )
        self.status_label = Text(
            value="Ready",
            color=self.COLORS["text"]["secondary"],
            size=self.TEXT_SIZE_DEFAULT, # Updated
        )
        self.loading_ring = ProgressRing(
            width=self.TEXT_SIZE_LARGE, # Updated
            height=self.TEXT_SIZE_LARGE, # Updated
            stroke_width=2, # Kept stroke_width
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
                size=self.TEXT_SIZE_DEFAULT, # Updated
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            hint_text="Enter regex patterns (comma-separated)",
            hint_style=TextStyle(
                size=self.TEXT_SIZE_DEFAULT,
                color=self.COLORS["text"]["secondary"] 
            ),
            content_padding=self.spacing["xs"], 
            border=None, 
            cursor_color="transparent", # Keep as is
            bgcolor="transparent", # Keep as is
            expand=True,
        )
        self.compare_button = self.create_compare_button()
        
        # Initialize file input component first to access its properties later
        self.file_input = FileInputComponent(page, self)

        # Initialize results view component before creating the layout
        self.results_view = ResultsViewComponent(page, self, self.COLORS)
        
        # Initialize the stats panel component before creating the layout
        self.stats_panel_component = StatsPanelComponent(page, self, self.COLORS)
        
        # Get references to components for easier access
        self.source_file_container = self.file_input.source_file_container
        self.target_file_container = self.file_input.target_file_container
        self.source_label = self.file_input.source_label
        self.target_label = self.file_input.target_label
        self.source_icon = self.file_input.source_icon
        self.target_icon = self.file_input.target_icon
        self.output_text = self.results_view.output_text
        self.summary_text = self.results_view.summary_text
        
        # Replace these with references to the results_view properties
        self.output_text = self.results_view.output_text
        self.summary_text = self.results_view.summary_text
        
        # Add preview containers after file input initialization
        self.preview_section = Container(
            visible=False,
            content=ResponsiveRow(
                controls=[
                    Container(
                        content=Column(
                            controls=[
                                Text("Source File Preview", 
                                     size=self.TEXT_SIZE_DEFAULT, # Updated
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
                                            size=self.TEXT_SIZE_DEFAULT, # Updated
                                            font_family="Consolas",
                                        ),
                                        content_padding=self.spacing["xs"] # Added padding for input fields
                                    ),
                                    border=border.all(color=self.COLORS["border"]["default"]),
                                    border_radius=self.spacing["xs"], # Updated
                                    padding=self.spacing["xs"], # Updated
                                    bgcolor=self.COLORS["bg"]["input"],
                                    expand=True,
                                ),
                            ],
                            spacing=self.spacing["xs"], # Updated
                            expand=True,
                        ),
                        col={"sm": 12, "md": 6},
                        padding=self.spacing["xxs"], # Updated padding for col container
                        expand=True,
                    ),
                    Container(
                        content=Column(
                            controls=[
                                Text("Target File Preview", 
                                     size=self.TEXT_SIZE_DEFAULT, # Updated
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
                                            size=self.TEXT_SIZE_DEFAULT, # Updated
                                            font_family="Consolas",
                                        ),
                                        content_padding=self.spacing["xs"] # Added padding for input fields
                                    ),
                                    border=border.all(color=self.COLORS["border"]["default"]),
                                    border_radius=self.spacing["xs"], # Updated
                                    padding=self.spacing["xs"], # Updated
                                    bgcolor=self.COLORS["bg"]["input"],
                                    expand=True,
                                ),
                            ],
                            spacing=self.spacing["xs"], # Updated
                            expand=True,
                        ),
                        col={"sm": 12, "md": 6},
                        padding=self.spacing["xxs"], # Updated padding for col container
                        expand=True,
                    ),
                ],
                spacing=self.spacing["s"], # Updated
            ),
            margin=padding.only(top=self.spacing["s"], bottom=self.spacing["s"]), # Updated
        )

        # Initialize results view component BEFORE creating the layout
        self.results_view = ResultsViewComponent(page, self, self.COLORS)
        
        # Replace these with references to the results_view properties
        self.output_text = self.results_view.output_text
        self.summary_text = self.results_view.summary_text
        
        # Update the main_card_container to use the results_view
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
                height=self.spacing["xxl"] * 2 + self.spacing["m"], # 48*2+16 = 112. Or use self.spacing["xxl"]*2.5 for 120
                    ),
                    # NEW: Preview section
                    self.preview_section,
                    # Compare button (fixed height)
                    Container(
                        content=self.compare_button,
                height=self.spacing["xxl"], # Updated
                    ),
                    # NEW: Statistics panel
                    Container(
                        content=self.stats_panel_component.panel,
                padding=padding.only(top=self.spacing["xs"], bottom=self.spacing["xs"]), # Updated
                    ),
                    # Results area using the results_view component
                    Container(
                        content=Card(
                            content=Column(
                                expand=True,
                                controls=[
                                    # Results header from results_view
                                    self.results_view.results_header,
                                    Divider(
                                        color=self.COLORS["border"]["default"],
                                        height=1, # Keep height 1 for divider
                                    ),
                                    # Container for the results_view's results_container
                                    Container(
                                        content=self.results_view.results_container,
                                        padding=padding.all(self.spacing["m"]), # Updated
                                        expand=True,
                                        clip_behavior=ft.ClipBehavior.HARD_EDGE
                                    ),
                                    # Status indicators in footer
                                    Container(
                                        content=Row(
                                            controls=[
                                                self.loading_ring,
                                                self.status_label,
                                            ],
                                            spacing=self.spacing["xs"], # Updated
                                            vertical_alignment="center",
                                        ),
                                        padding=ft.padding.only(left=self.spacing["m"], right=self.spacing["m"], top=self.spacing["xs"], bottom=self.spacing["m"]), # Updated
                                        expand=True, # Should this be True or False? If True, it might push content if results_container is also True. Let's keep for now.
                                    ),
                                ],
                                spacing=0, # Keep spacing 0 for this tight layout
                            ),
                            elevation=1,
                            clip_behavior=ft.ClipBehavior.HARD_EDGE
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
            padding=self.spacing["xl"], # Updated
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
                                    size=self.TEXT_SIZE_XXLARGE, # Updated
                                    weight="bold",
                                    text_align="center",
                                    expand=True,
                                ),
                                self.settings_button,
                            ],
                            alignment="spaceBetween",
                        ),
                        padding=padding.only(bottom=self.spacing["l"]), # Updated
                        height=self.spacing["xxl"] + self.spacing["s"], # Adjusted height: 48 + 12 = 60. Original was 100. Let's try 80 for now.
                                                                    # Using self.spacing["xl"] * 2.5 => 32 * 2.5 = 80
                                                                    # A fixed height might be better adjusted visually later.
                                                                    # Let's use a value like 72 or 80. For now: self.spacing["xxl"] + self.spacing["l"] -> 48 + 24 = 72
                        height=self.spacing["xxl"] + self.spacing["l"], # 72px
                    ),
                    # ...existing main card container...
                    self.main_card_container,
                ],
                spacing=self.spacing["xl"], # Updated
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
            icon=Icons.UNFOLD_LESS, # Initial icon
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Collapse All", # Initial tooltip
            on_click=self.toggle_expand_all,
        )

        # Modify the results header to include the expand/collapse button
        self.results_header = Container( # This is self.results_view.results_header, will be updated in component
            content=Row(
                controls=[
                    Text(
                        "Results",
                        size=self.TEXT_SIZE_MEDIUM, # Updated
                        weight="w500", # Keep weight
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
                                # Consider adding explicit size for IconButton
                            ),
                        ],
                        spacing=0, # Keep spacing 0 for tight button group
                    ),
                ],
                alignment="spaceBetween",
            ),
            padding=ft.padding.only(left=self.spacing["m"], right=self.spacing["m"], top=self.spacing["m"], bottom=self.spacing["xs"]), # Adjusted bottom padding
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

        # Force a UI refresh after app loads to ensure theme consistency
        self.page.on_load = lambda _: asyncio.create_task(self.post_init())

        # Initialize onboarding tutorial
        self.tutorial = OnboardingTutorial(page, self)

        # Initialize HistoryDialogComponent
        self.history_dialog = HistoryDialogComponent(page, self)  # Remove the extra COLORS parameter
        page.overlay.append(self.history_dialog.dialog)  # Add dialog to page overlay
        
    # Remove duplicate methods for file handling that are now handled by FileInputComponent
    # def open_source_picker
    # def open_target_picker
    # def handle_file_picked
    # def _on_browse_hover

    # Update the update_compare_button method to work with FileInputComponent
    def update_compare_button(self):
        """Enable/disable compare button based on file selection"""
        has_source = bool(self.source_file_path) 
        has_target = bool(self.target_file_path)
        self.compare_button.content.controls[0].disabled = not (has_source and has_target)
        self.page.update()

    # Keep the rest of the methods unchanged
    async def post_init(self, e=None):
        """Perform post-initialization tasks using async/await."""
        # Force UI refresh first
        self.force_refresh_ui()
        
        # Show tutorial for first-time users if needed
        if not self.config.get("tutorial_completed", False):
            # Add a small delay to ensure UI is ready
            await asyncio.sleep(0.2)
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
                size=self.TEXT_SIZE_DEFAULT, # Updated
            ),
        )

    def create_compare_button(self):
        """
        Create and return a compare button container with compare and translate buttons.
        """
        compare_button_text_size = self.TEXT_SIZE_MEDIUM # Standardize button text
        button_height = self.spacing["xxl"] # Standardize button height (48px)
        button_radius = self.spacing["xs"] # Standardize button radius (8px)
        button_icon_spacing = self.spacing["xs"] # Standardize icon spacing in button

        compare_button = ElevatedButton(
            content=Row(
                controls=[
                    Icon(Icons.REFRESH), # Icon size can be controlled if needed
                    Text("Compare Files", size=compare_button_text_size),
                ],
                alignment="center",
                spacing=button_icon_spacing, # Updated
            ),
            tooltip="Click to compare the source and target files",
            on_click=self.compare_files_gui,
            style=ButtonStyle(
                color=self.COLORS["text"]["primary"],
                bgcolor=self.COLORS["bg"]["accent"],
                shape=RoundedRectangleBorder(radius=button_radius), # Updated
                padding=padding.symmetric(horizontal=self.spacing["m"]) # Added horizontal padding
            ),
            height=button_height, # Updated
            expand=True,
        )
        
        translate_button = ElevatedButton(
            content=Row(
                controls=[
                    Icon(Icons.TRANSLATE),
                    Text("Translate Missing", size=compare_button_text_size), # Updated
                ],
                alignment="center",
                spacing=button_icon_spacing, # Updated
            ),
            tooltip="Translate missing keys using Google Cloud Translate",
            on_click=self.translate_missing_keys,
            style=ButtonStyle(
                color=self.COLORS["text"]["primary"],
                bgcolor=self.COLORS["bg"]["accent"],
                shape=RoundedRectangleBorder(radius=button_radius), # Updated
                padding=padding.symmetric(horizontal=self.spacing["m"]) # Added horizontal padding
            ),
            height=button_height, # Updated
            expand=True,
            visible=False, # Keep as is
        )
        
        button_row = Row(
            controls=[compare_button, translate_button],
            alignment="center",
            spacing=self.spacing["m"], # Updated
        )
        
        return Container( # This container's height is already set where it's used.
            content=button_row,
            animate=ft.Animation(duration=200, curve="easeInOut"), # Keep animation
            on_hover=lambda event: self._on_compare_button_hover(event, compare_button) # Keep hover
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
            
            # Process successful result
            comparison_data = result['result']
            # comparison_result is the list of structured dicts from file_processing_service
            comparison_result_list = comparison_data['comparison'] 
            source_dict_len = len(comparison_data['source_dict']) # Get length of source_dict for total keys
            
            # Stats are pre-calculated in file_processing_service by comparing dict keys directly
            stats = comparison_data['stats']
            total_keys = stats.get('total_keys', source_dict_len) # Fallback to len(source_dict)
            missing_keys = stats.get('missing_keys', 0)
            obsolete_keys = stats.get('obsolete_keys', 0)
            
            # Store line numbers for reference (if ResultsViewComponent needs them directly from App)
            # self.source_line_numbers = comparison_data['source_lines']
            # self.target_line_numbers = comparison_data['target_lines']
            
            # Update UI with results
            self.update_statistics(total_keys, missing_keys, obsolete_keys)
            
            # Build the comparison view using the structured list
            self.results_view.build_results_table(comparison_result_list)
            
            # Show completed status
            self.status_label.value = (
                f"Comparison complete: {total_keys} keys, "
                f"{missing_keys} missing, {obsolete_keys} obsolete"
            )

            # Save comparison to history (structured list)
            history_entry = {
                "timestamp": datetime.datetime.now().isoformat(),
                "source_file": os.path.basename(self.source_file_path),
                "target_file": os.path.basename(self.target_file_path),
                "diff": comparison_result_list # Store the structured list
            }
            history_manager.save_history(history_entry)
                
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
                                            size=self.TEXT_SIZE_DEFAULT, # Updated
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
                                                size=self.TEXT_SIZE_DEFAULT, # Updated
                                                font_family="Consolas",
                                            ),
                                            content_padding=self.spacing["xs"] # Added padding
                                        ),
                                    ],
                                    scroll=ft.ScrollMode.AUTO, # Keep scroll
                                    spacing=self.spacing["xs"], # Updated
                                ),
                                padding=self.spacing["s"], # Updated padding from 10 to 12 (s)
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
        Entry point for file comparison that queues the async operation in the existing event loop.
        """
        # Schedule the coroutine properly in Flet's event loop
        async def run_comparison():
            await self.compare_files_async(event)
            
        asyncio.create_task(run_comparison())
    
    def compare_directories(self, event):
        """
        Entry point for directory comparison that queues the async operation in the existing event loop.
        """
        # Schedule the coroutine properly in Flet's event loop
        async def run_comparison():
            await self.compare_directories_async(event)
            
        asyncio.create_task(run_comparison())
    
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
            # Calculate statistics from the structured comparison_result list
            missing_keys_count = sum(1 for item in comparison_result if item.get(LG_STATUS) == STATUS_MISSING_IN_TARGET)
            obsolete_keys_count = sum(1 for item in comparison_result if item.get(LG_STATUS) == STATUS_OBSOLETE_IN_TARGET)
            # total_keys is len(source_dict), which is already calculated and available
            
            self.update_statistics(len(source_dict), missing_keys_count, obsolete_keys_count)

            # The self.output_text is a TextField expecting string. 
            # ResultsViewComponent now handles its own display and copy.
            # If a raw text version is still desired for self.output_text (e.g., for simple copy), generate it.
            # For now, we'll clear it or set a generic message, as ResultsViewComponent is primary.
            self.output_text.value = "" # Or generate a string summary if needed for some reason.
            
            # Delegate the rendering to the results_view component
            self.results_view.build_results_table(comparison_result) # Pass the list of dicts
            
            self.status_label.value = f"Comparison complete. Source keys: {len(source_dict)}, Missing: {missing_keys_count}, Obsolete: {obsolete_keys_count}."

            history_entry = {
                "timestamp": datetime.datetime.now().isoformat(),
                "source_file": os.path.basename(self.source_file_path),
                "target_file": os.path.basename(self.target_file_path),
                "diff": comparison_result # Store the structured list
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

    def update_statistics(self, total_keys: int, missing_keys: int, obsolete_keys: int):
        """Update statistics panel with current comparison results"""
        # Delegate to the StatsPanelComponent
        if hasattr(self, 'stats_panel_component'):
            self.stats_panel_component.update_stats(total_keys, missing_keys, obsolete_keys)
        else:
            logging.warning("StatsPanelComponent not initialized when update_statistics was called")

    def toggle_section(self, e, column):
        """Toggle visibility of a namespace section"""
        column.visible = not column.visible
        e.control.icon = Icons.EXPAND_LESS if column.visible else Icons.EXPAND_MORE
        self.page.update()

    def toggle_expand_all(self, e):
        """Toggle expand/collapse state for all namespace sections"""
        self.expand_all = not self.expand_all
        
        # Update the button icon and tooltip
        if self.expand_all:
            self.expand_collapse_button.icon = Icons.UNFOLD_LESS
            self.expand_collapse_button.tooltip = "Collapse All"
        else:
            self.expand_collapse_button.icon = Icons.UNFOLD_MORE
            self.expand_collapse_button.tooltip = "Expand All"
        self.expand_collapse_button.update() # Update the button control
        
        # Update expansion state for all namespace headers and their content
        # This part seems to refer to self.results_column which might be in ResultsViewComponent
        # If self.results_column is part of this App class and directly managed here, this is fine.
        # Otherwise, this logic should be in ResultsViewComponent.
        # For now, assuming it's managed here as per original code structure.
        current_namespace = None
        for row in self.results_column.controls[1].controls:
            if len(row.controls) == 1 and isinstance(row.controls[0], Text) and row.controls[0].weight == "bold":
                current_namespace = row
                current_namespace.expanded = self.expand_all
            elif current_namespace:
                row.visible = self.expand_all
        
        self.page.update()

    def clear_text_field(self, text_field, clear_btn):
        # Clear the text field and hide the clear button
        text_field.value = ""
        clear_btn.visible = False
        text_field.update()
        clear_btn.update()

    def copy_results(self, e):
        """Copy results text to clipboard and show feedback"""
        # Delegate to the results_view component
        self.results_view.copy_results(e)

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
        # Use the properly imported module from GUI package
        from GUI import syntax_highlighter  # Move import here to ensure it's available
        return syntax_highlighter.highlight_line(line, change_type)

    # Update format_summary method
    def format_summary(self, added: int, removed: int) -> str:
        return f"--- Summary ---\nAdded: {added}\nRemoved: {removed}"

    def open_settings(self, e):
        """Open the settings dialog."""
        if hasattr(self, 'settings_dialog') and self.settings_dialog:
            self.settings_dialog.open = True
            self.page.update()
        elif hasattr(self, 'settings_dialog_component'):
            self.settings_dialog_component.open_dialog(e)

    def close_settings(self, e):
        """Close the settings dialog."""
        if hasattr(self, 'settings_dialog') and self.settings_dialog:
            self.settings_dialog.open = False
            self.page.update()
        elif hasattr(self, 'settings_dialog_component'):
            self.settings_dialog_component.close_dialog(e)

    def open_history_dialog(self, e):
        """Open a dialog showing past comparison reports."""
        if hasattr(self, 'history_dialog'):
            # If using HistoryDialogComponent class
            if hasattr(self.history_dialog, 'open_dialog'):
                # This will refresh history before opening the dialog
                self.history_dialog.open_dialog(e)
            # If we have direct access to the dialog property
            elif hasattr(self.history_dialog, 'dialog'):
                # Make sure to load history before opening the dialog
                if hasattr(self.history_dialog, '_load_history'):
                    self.history_dialog._load_history()
                self.history_dialog.dialog.open = True
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
            if HAS_DARKDETECT:
                system_theme = "dark" if darkdetect.isDark() else "light"
            else:
                system_theme = "dark"
            self.COLORS = self.THEMES[system_theme]
        else:
            self.COLORS = self.THEMES[theme_key]
            
        # Cache the colors
        self._cached_colors[theme_key] = self.COLORS

        # Update page theme colors
        self.page.bgcolor = self.COLORS["bg"]["primary"]
        # Theme font_family is now set during page initialization, keep color_scheme_seed if desired
        # self.page.theme = ft.Theme(color_scheme_seed=Colors.GREEN, font_family="Roboto") # Example
        # self.page.dark_theme = ft.Theme(color_scheme_seed=Colors.BLUE, font_family="Roboto") # Example
        # Keeping previous color_scheme_seed logic, but font is globally set
        current_page_theme = self.page.theme if self.page.theme else ft.Theme()
        current_page_dark_theme = self.page.dark_theme if self.page.dark_theme else ft.Theme()

        current_page_theme.color_scheme_seed = Colors.GREEN
        current_page_dark_theme.color_scheme_seed = Colors.BLUE
        
        self.page.theme = current_page_theme
        self.page.dark_theme = current_page_dark_theme

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

        # Update core UI elements with cached colors
        self.page.bgcolor = self.COLORS["bg"]["primary"]
        self.content.bgcolor = self.COLORS["bg"]["secondary"]
        
        # Update status label and progress indicators (core app UI, not components)
        self.status_label.color = self.COLORS["text"]["secondary"]
        self.loading_ring.color = self.COLORS["bg"]["accent"]
        
        # Update compare button (core app UI, not component)
        for button in self.compare_button.content.controls:
            if isinstance(button, ElevatedButton):
                button.style = ButtonStyle(
                    color=self.COLORS["text"]["primary"],
                    bgcolor=self.COLORS["bg"]["accent"],
                    shape=RoundedRectangleBorder(radius=8),
                )

        # Update settings and history buttons (core app UI)
        self.settings_button.icon_color = self.COLORS["text"]["secondary"]
        if hasattr(self, 'history_button'):
            self.history_button.icon_color = self.COLORS["text"]["secondary"]

        # Update main card container background color (core app container)
        self.main_card_container.bgcolor = self.COLORS["bg"]["secondary"]

        # Update snack bar colors
        if hasattr(self, 'page') and hasattr(self.page, 'snack_bar'):
            self.page.snack_bar.bgcolor = self.COLORS["bg"]["secondary"]

        # Delegate component updates to their respective update methods
        # This is better than directly manipulating their internal UI elements
        # as it respects encapsulation and allows components to handle their own updates
        
        # Update file input component
        if hasattr(self, 'file_input'):
            self.file_input.update_colors(self.COLORS)

        # Update results view component
        if hasattr(self, 'results_view'):
            self.results_view.update_colors(self.COLORS)
        
        # Update stats panel component
        if hasattr(self, 'stats_panel_component'):
            self.stats_panel_component.update_colors(self.COLORS)
            
        # Update settings dialog component
        if hasattr(self, 'settings_dialog_component'):
            self.settings_dialog_component.update_colors(self.COLORS)
            
        # Update history dialog component
        if hasattr(self, 'history_dialog') and hasattr(self.history_dialog, 'update_colors'):
            self.history_dialog.update_colors(self.COLORS)
            
        # Update tutorial component if it exists
        if hasattr(self, 'tutorial') and hasattr(self.tutorial, 'update_colors'):
            self.tutorial.update_colors(self.COLORS)

        logging.info("Theme updated to '%s'. Current COLORS: %s", theme_key, self.COLORS)

    def update_statistics(self, total_keys: int, missing_keys: int, obsolete_keys: int):
        """Update statistics panel with current comparison results"""
        # Delegate to the StatsPanelComponent
        if hasattr(self, 'stats_panel_component'):
            self.stats_panel_component.update_stats(total_keys, missing_keys, obsolete_keys)
        else:
            logging.warning("StatsPanelComponent not initialized when update_statistics was called")

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

    def highlight_line(line: str, change_type: str) -> str:
        """Simple syntax highlighting for comparison lines."""
        # No highlighting needed for GUI as we handle colors in the UI
        return line

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
                                    size=self.TEXT_SIZE_DEFAULT, # Updated
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
                                        size=self.TEXT_SIZE_DEFAULT, # Updated
                                        font_family="Consolas",
                                        weight=FontWeight.W_400,
                                    ),
                                    content_padding=self.spacing["xs"] # Added padding
                                ),
                            ],
                            scroll=ft.ScrollMode.AUTO, # Keep scroll
                            spacing=self.spacing["xs"], # Updated
                        ),
                        padding=self.spacing["s"], # Updated padding from 10 to 12 (s)
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
        if hasattr(self, 'history_dialog'):
            # If using HistoryDialogComponent class
            if hasattr(self.history_dialog, 'open_dialog'):
                # This will refresh history before opening the dialog
                self.history_dialog.open_dialog(e)
            # If we have direct access to the dialog property
            elif hasattr(self.history_dialog, 'dialog'):
                # Make sure to load history before opening the dialog
                if hasattr(self.history_dialog, '_load_history'):
                    self.history_dialog._load_history()
                self.history_dialog.dialog.open = True
                self.page.update()

    def save_config(self):
        """Save current configuration to disk."""
        ConfigManager.save(self.config)
        self.page.update()

    def _on_compare_button_hover(self, e, button):
        """Handle hover effect for compare button using theme colors."""
        if e.data == "true": # Hovering
            button.style.bgcolor = self.COLORS["bg"]["hover"]
        else: # Not hovering
            button.style.bgcolor = self.COLORS["bg"]["accent"]
        button.update()

    def _on_browse_hover(self, e, button):
        """Handle hover effect for browse button using theme colors."""
        # This method is likely for FileInputComponent's buttons.
        # It assumes the button also uses accent color as its base.
        if e.data == "true": # Hovering
            button.style.bgcolor = self.COLORS["bg"]["hover"]
        else: # Not hovering
            button.style.bgcolor = self.COLORS["bg"]["accent"]
        button.update()

    def handle_preview_toggle(self, e):
        """Handle toggling of file preview feature"""
        self.config["show_preview"] = e.control.value
        ConfigManager.save(self.config)
        
        # Update preview visibility based on setting and file selection
        self.preview_section.visible = e.control.value and (self.source_file_path or self.target_file_path)
        
        # If preview is now visible and we have files selected, update the previews
        if self.preview_section.visible:
            if self.source_file_path:
                self.update_file_preview(self.source_file_path, "source")
            if self.target_file_path:
                self.update_file_preview(self.target_file_path, "target")
        
        self.page.update()

    def handle_setting_change(self, e, setting_name):
        """Generic handler for updating any setting in the config"""
        self.config[setting_name] = e.control.value
        ConfigManager.save(self.config)
        
        # Apply changes that require immediate UI updates
        if setting_name == "show_preview":
            # Update preview visibility based on setting and file selection
            self.preview_section.visible = e.control.value and (self.source_file_path or self.target_file_path)
            # Update previews if now visible
            if self.preview_section.visible:
                if self.source_file_path:
                    self.update_file_preview(self.source_file_path, "source")
                if self.target_file_path:
                    self.update_file_preview(self.target_file_path, "target")
        
        self.page.update()

    def handle_theme_change(self, e):
        """Handle theme mode changes"""
        theme = e.control.value
        self.current_theme = theme
        
        # Update page theme mode based on new theme
        if theme == "system":
            if HAS_DARKDETECT:
                system_theme = "dark" if darkdetect.isDark() else "light"
            else:
                system_theme = "dark"
            self.page.theme_mode = ft.ThemeMode.SYSTEM
            self.COLORS = self.THEMES[system_theme]
        elif theme in ["dark", "amoled"]:
            self.page.theme_mode = ft.ThemeMode.DARK
            self.COLORS = self.THEMES[theme]
        else:
            self.page.theme_mode = ft.ThemeMode.LIGHT
            self.COLORS = self.THEMES[theme]

        # Cache the colors for this theme
        self._cached_colors[theme] = self.COLORS
        
        # Update config and save
        self.config["theme"] = theme
        ConfigManager.save(self.config)
        
        # Update UI with new theme colors
        self.update_theme_colors()
        self.page.update()

def main(page: ft.Page):
    App(page)

if __name__ == "__main__":
    ft.app(target=main)