import flet as ft
import re
from flet import (
    Checkbox, Column, Container, FilePicker, FilePickerResultEvent, Icon, Page,
    Row, SnackBar, Text, TextField, border, border_radius, padding, ProgressRing,
    IconButton, Tooltip, Colors, Icons, ButtonStyle, RoundedRectangleBorder,
    TextStyle, FontWeight, ScrollMode, ResponsiveRow, Divider, Card, ClipBehavior,
    TextButton, Tabs, Tab
)
import os
import logic
import logging
from pathlib import Path
from core.constants import SUPPORTED_FORMATS, USER_MESSAGES, GOOGLE_CLOUD_LANGUAGES
from core.themes import THEMES
from components import (
    FileInputComponent, ResultsViewComponent, SettingsDialogComponent, StatsPanelComponent,
    OnboardingTutorial, HistoryDialogComponent
)
import asyncio
from utils.logger_service import logger_service
import datetime
from utils import history_manager
from core.config import ConfigManager
from utils.file_cache_service import file_cache_service
from utils.file_processing_service import file_processing_service

try:
    import darkdetect
    HAS_DARKDETECT = True
except ImportError:
    HAS_DARKDETECT = False
    logging.warning("darkdetect package not found. System theme detection will fall back to 'light'.")

logger = logger_service.get_logger()

class App:
    def __init__(self, page: ft.Page):
        self.page = page
        self._cached_colors = {}
        self.THEMES = THEMES
        self.config = ConfigManager.load() # Load initial config

        # Update self.config with any missing keys from a default structure
        # This ensures all expected keys are present after loading.
        default_config_structure = {
            "theme": "system",
            "auto_fill_missing": False, "log_missing_strings": False, "ignore_patterns": [],
            "preferred_format": "auto", "ignore_whitespace": False, "ignore_case": False,
            "compare_values": True, "group_by_namespace": True, "show_preview": False,
            "show_line_numbers": False, "mt_enabled": False, "mt_api_key": "",
            "mt_source_lang": "en", "mt_target_lang": "tr", "enable_keyboard_nav": True,
            "high_contrast": False, "large_text": False, "font_size_scale": 1.0,
            "tutorial_completed": False, "animation_speed": 300, "confirm_actions": True,
            "focus_highlight": True, "reduce_animations": False
            # Add any other keys that are expected by the application
        }
        # Merge loaded config into defaults, ensuring all keys exist
        temp_config = default_config_structure.copy()
        temp_config.update(self.config)
        self.config = temp_config

        self.current_theme_name = self.config.get("theme", "system")
        self.COLORS = self._get_current_colors()
        self._cached_colors[self.current_theme_name] = self.COLORS

        self.page.snack_bar = ft.SnackBar(content=ft.Text(""))

        # Initialize components early, they might be needed by other parts of __init__
        # Their internal styling will be updated by self.update_theme_colors() later
        self.settings_dialog_component = SettingsDialogComponent(page, self, self.config, self.COLORS)
        self.settings_dialog = self.settings_dialog_component.dialog
        self.file_input = FileInputComponent(page, self)
        self.results_view = ResultsViewComponent(page, self, self.COLORS)
        self.stats_panel_component = StatsPanelComponent(page, self, self.COLORS)
        self.tutorial = OnboardingTutorial(page, self)
        self.history_dialog = HistoryDialogComponent(page, self)

        page.overlay.append(self.settings_dialog) # Add settings dialog to overlay
        page.overlay.append(self.history_dialog.dialog) # Add history dialog to overlay
        # Note: FilePickers from FileInputComponent are added to overlay within that component.
        # Onboarding tutorial dialog is added to overlay when start_tutorial is called.

        # Define a base TextStyle for TextFields that will be mostly styled by update_theme_colors
        base_tf_style = TextStyle(
            size=13,
            font_family="Consolas",
            weight=FontWeight.NORMAL,
        )

        # Initialize TextFields (styling applied in update_theme_colors)
        self.output_text = self.results_view.output_text # Reference from ResultsView
        self.summary_text = self.results_view.summary_text # Reference from ResultsView
        
        self.source_text = TextField(
            value="Source file content will appear here", multiline=True, read_only=True,
            min_lines=5, text_style=base_tf_style.copy(), border=ft.InputBorder.NONE,
            bgcolor="transparent", expand=True,
        )
        self.target_text = TextField(
            value="Target file content will appear here", multiline=True, read_only=True,
            min_lines=5, text_style=base_tf_style.copy(), border=ft.InputBorder.NONE,
            bgcolor="transparent", expand=True,
        )

        self.status_label = Text("Ready", size=12, weight=FontWeight.NORMAL)
        self.loading_ring = ProgressRing(width=18, height=18, stroke_width=2, visible=False)

        self.ignore_pattern_field = TextField(
            hint_text="Enter regex patterns (comma-separated)",
            text_style=base_tf_style.copy(),
            border=ft.InputBorder.OUTLINE,
            border_radius=8,
            content_padding=padding.symmetric(horizontal=12, vertical=8),
            expand=True,
        )
        self.compare_button = self.create_compare_button()

        # File paths
        self.source_file_path = ""
        self.target_file_path = ""
        self.source_dir_path = ""
        self.target_dir_path = ""

        # Directory pickers (moved from FileInputComponent to App for broader use if needed)
        self.source_dir_picker = FilePicker(on_result=lambda e: self.handle_dir_picked(e, "source"))
        self.target_dir_picker = FilePicker(on_result=lambda e: self.handle_dir_picked(e, "target"))
        page.overlay.extend([self.source_dir_picker, self.target_dir_picker])
        
        # Initialize preview TextFields (will be part of self.preview_section)
        self.source_preview_tf = TextField(value="No file selected", multiline=True, read_only=True, min_lines=3, max_lines=5, text_style=TextStyle(font_family="Consolas", size=12))
        self.target_preview_tf = TextField(value="No file selected", multiline=True, read_only=True, min_lines=3, max_lines=5, text_style=TextStyle(font_family="Consolas", size=12))

        # Build UI Structure (placeholder for now, will be appended next)
        self._build_ui_structure()

        self.page.add(self.content)
        self.page.on_window_event = self.handle_window_event
        self.user_friendly_errors = USER_MESSAGES
        
        self._apply_page_theme_mode()
        self.update_theme_colors()

        self.page.on_load = lambda _: asyncio.create_task(self.post_init())

    def _get_current_colors(self):
        theme_name = self.current_theme_name
        if theme_name == "system":
            is_dark = HAS_DARKDETECT and darkdetect.isDark()
            return self.THEMES.get("dark" if is_dark else "light", self.THEMES["light"])
        return self.THEMES.get(theme_name, self.THEMES["light"])

    def _apply_page_theme_mode(self):
        if self.current_theme_name == "system":
            self.page.theme_mode = ft.ThemeMode.SYSTEM
        elif self.current_theme_name in ["dark", "amoled"]:
            self.page.theme_mode = ft.ThemeMode.DARK
        else:
            self.page.theme_mode = ft.ThemeMode.LIGHT
        
        # Ensure page.theme and page.dark_theme are initialized even if system theme changes
        # This helps Flet determine the initial theme correctly when mode is SYSTEM.
        current_actual_colors = self._get_current_colors() # Get colors for current actual mode (light/dark)
        
        if self.page.theme_mode == ft.ThemeMode.SYSTEM:
            is_system_dark = HAS_DARKDETECT and darkdetect.isDark()
            if is_system_dark:
                self.page.dark_theme = ft.Theme(color_scheme=self._build_flet_color_scheme(current_actual_colors))
                self.page.theme = ft.Theme(color_scheme=self._build_flet_color_scheme(self.THEMES.get("light", {})))
            else:
                self.page.theme = ft.Theme(color_scheme=self._build_flet_color_scheme(current_actual_colors))
                self.page.dark_theme = ft.Theme(color_scheme=self._build_flet_color_scheme(self.THEMES.get("dark", {})))
        elif self.page.theme_mode == ft.ThemeMode.DARK:
             self.page.dark_theme = ft.Theme(color_scheme=self._build_flet_color_scheme(current_actual_colors))
             self.page.theme = ft.Theme(color_scheme=self._build_flet_color_scheme(self.THEMES.get("light", {}))) # Provide a fallback light theme
        else: # LIGHT
             self.page.theme = ft.Theme(color_scheme=self._build_flet_color_scheme(current_actual_colors))
             self.page.dark_theme = ft.Theme(color_scheme=self._build_flet_color_scheme(self.THEMES.get("dark", {}))) # Provide a fallback dark theme


    def _build_flet_color_scheme(self, m3_colors: dict) -> ft.ColorScheme:
        return ft.ColorScheme(
            primary=m3_colors.get("primary"), on_primary=m3_colors.get("onPrimary"),
            primary_container=m3_colors.get("primaryContainer"), on_primary_container=m3_colors.get("onPrimaryContainer"),
            secondary=m3_colors.get("secondary"), on_secondary=m3_colors.get("onSecondary"),
            secondary_container=m3_colors.get("secondaryContainer"), on_secondary_container=m3_colors.get("onSecondaryContainer"),
            tertiary=m3_colors.get("tertiary"), on_tertiary=m3_colors.get("onTertiary"),
            tertiary_container=m3_colors.get("tertiaryContainer"), on_tertiary_container=m3_colors.get("onTertiaryContainer"),
            error=m3_colors.get("error"), on_error=m3_colors.get("onError"),
            error_container=m3_colors.get("errorContainer"), on_error_container=m3_colors.get("onErrorContainer"),
            background=m3_colors.get("background"), on_background=m3_colors.get("onBackground"),
            surface=m3_colors.get("surface"), on_surface=m3_colors.get("onSurface"),
            surface_variant=m3_colors.get("surfaceVariant"), on_surface_variant=m3_colors.get("onSurfaceVariant"),
            outline=m3_colors.get("outline"), outline_variant=m3_colors.get("outlineVariant"),
            shadow=m3_colors.get("shadow"), scrim=m3_colors.get("scrim"),
            inverse_surface=m3_colors.get("inverseSurface"), inverse_on_surface=m3_colors.get("inverseOnSurface"),
            inverse_primary=m3_colors.get("inversePrimary"),
        )

    def update_theme_colors(self):
        self.current_theme_name = self.config.get("theme", "system")
        self.COLORS = self._get_current_colors()
        self._cached_colors[self.current_theme_name] = self.COLORS
        self._apply_page_theme_mode() # This now also sets page.theme/dark_theme with ColorScheme

        # Update core UI elements
        self.page.bgcolor = self.COLORS.get("background")
        if hasattr(self, 'content'): self.content.bgcolor = self.COLORS.get("background")

        if hasattr(self, 'content') and self.content.content and len(self.content.content.controls) > 0: # Header title
            header_text_control = self.content.content.controls[0].content.controls[1]
            if isinstance(header_text_control, Text): header_text_control.color = self.COLORS.get("onSurface")

        if hasattr(self, 'main_card_container'): # Main content card
            self.main_card_container.bgcolor = self.COLORS.get("surfaceVariant")
            # Card holding results area (inside main_card_container)
            if self.main_card_container.content and len(self.main_card_container.content.controls) > 4:
                results_area_card_container = self.main_card_container.content.controls[4] # The Container wrapping the Card
                if results_area_card_container.content and isinstance(results_area_card_container.content, Card):
                     results_area_card_container.content.bgcolor = self.COLORS.get("surface")


        self.status_label.color = self.COLORS.get("onSurfaceVariant")
        self.loading_ring.color = self.COLORS.get("primary")

        if hasattr(self, 'compare_button') and self.compare_button.content:
            compare_btn, translate_btn = self.compare_button.content.controls
            if isinstance(compare_btn, ft.FilledButton):
                compare_btn.style.bgcolor = self.COLORS.get("primary"); compare_btn.style.color = self.COLORS.get("onPrimary")
                if compare_btn.content and len(compare_btn.content.controls) > 1: # Icon and Text
                    compare_btn.content.controls[0].color = self.COLORS.get("onPrimary")
                    compare_btn.content.controls[1].color = self.COLORS.get("onPrimary")
            if isinstance(translate_btn, ft.FilledTonalButton):
                translate_btn.style.bgcolor = self.COLORS.get("secondaryContainer"); translate_btn.style.color = self.COLORS.get("onSecondaryContainer")
                if translate_btn.content and len(translate_btn.content.controls) > 1: # Icon and Text
                    translate_btn.content.controls[0].color = self.COLORS.get("onSecondaryContainer")
                    translate_btn.content.controls[1].color = self.COLORS.get("onSecondaryContainer")

        self.settings_button.icon_color = self.COLORS.get("onSurface")
        if hasattr(self, 'history_button'): self.history_button.icon_color = self.COLORS.get("onSurface")

        if self.page.snack_bar:
            self.page.snack_bar.bgcolor = self.COLORS.get("inverseSurface")
            if self.page.snack_bar.content and isinstance(self.page.snack_bar.content, ft.Text):
                self.page.snack_bar.content.color = self.COLORS.get("inverseOnSurface")

        text_fields_app = [self.source_text, self.target_text, self.ignore_pattern_field, self.source_preview_tf, self.target_preview_tf]
        for tf in text_fields_app:
            if tf:
                tf.text_style.color = self.COLORS.get("onSurface")
                tf.border_color = self.COLORS.get("outline")
                tf.focused_border_color = self.COLORS.get("primary")
                tf.border_radius = 8 if tf != self.ignore_pattern_field else 4 # ignore_pattern_field is different style
                tf.border_width = 1
                tf.bgcolor = self.COLORS.get("surfaceContainerLowest") if tf != self.ignore_pattern_field else "transparent"
                if hasattr(tf, 'hint_style') and tf.hint_style: tf.hint_style.color = self.COLORS.get("onSurfaceVariant")
                elif not hasattr(tf, 'hint_style') and getattr(tf, 'hint_text', None): tf.hint_style = TextStyle(color=self.COLORS.get("onSurfaceVariant"))


        if hasattr(self, 'preview_section') and self.preview_section and self.preview_section.content:
            for col_container in self.preview_section.content.controls:
                if col_container.content and isinstance(col_container.content, Column):
                    title_text = col_container.content.controls[0]
                    tf_container = col_container.content.controls[1]
                    if isinstance(title_text, Text): title_text.color = self.COLORS.get("onSurfaceVariant")
                    if isinstance(tf_container, Container):
                        tf_container.bgcolor = self.COLORS.get("surfaceContainerLowest")
                        tf_container.border = border.all(1, self.COLORS.get("outline"))

        if hasattr(self, 'results_divider') and isinstance(self.results_divider, Divider):
            self.results_divider.color = self.COLORS.get("outlineVariant")

        for comp_attr in ['file_input', 'results_view', 'stats_panel_component', 'settings_dialog_component', 'tutorial', 'history_dialog']:
            component = getattr(self, comp_attr, None)
            if component:
                if hasattr(component, 'update_colors_for_dialog') and callable(getattr(component, 'update_colors_for_dialog')):
                    component.update_colors_for_dialog()
                elif hasattr(component, 'update_colors') and callable(getattr(component, 'update_colors')):
                    component.update_colors(self.COLORS)

        logging.info("App theme updated to '%s'.", self.current_theme_name)
        self.page.update()


    def _build_ui_structure(self):
        """Builds the main UI structure and assigns elements to instance attributes."""
        
        # Preview Section (using stored TextFields)
        self.preview_section = Container(
            visible=self.config.get("show_preview", False), # Initial visibility from config
            content=ResponsiveRow(
                controls=[
                    self._create_preview_column("Source File Preview", self.source_preview_tf),
                    self._create_preview_column("Target File Preview", self.target_preview_tf),
                ],
                spacing=16,
            ),
            margin=padding.only(top=8, bottom=8),
        )

        # Main Card content construction
        self.results_divider = Divider(height=1, color=self.COLORS.get("outlineVariant"))
        results_card_content_column = Column(
            expand=True, controls=[
                self.results_view.results_header, # Header from ResultsViewComponent
                self.results_divider,
                Container(
                    content=self.results_view.results_container, # Results content from ResultsViewComponent
                    expand=True, clip_behavior=ft.ClipBehavior.HARD_EDGE,
                    padding=padding.all(0) # ResultsViewComponent's container handles its own padding
                ),
                Container( # Footer for status
                    content=Row([self.loading_ring, self.status_label], spacing=8, vertical_alignment=ft.CrossAxisAlignment.CENTER),
                    padding=padding.all(12), # M3 typical padding for such areas
                ),
            ], spacing=0,
        )

        self.main_card_container = Container(
            expand=True,
            content=Column(
                expand=True, controls=[
                    Container(content=ResponsiveRow(controls=[
                        Container(content=self.file_input.source_file_container, col={"sm": 12, "md": 6}),
                        Container(content=self.file_input.target_file_container, col={"sm": 12, "md": 6}),
                    ], spacing=16)),
                    self.preview_section,
                    Container(content=self.compare_button, padding=padding.symmetric(vertical=8)),
                    Container(content=self.stats_panel_component.panel, padding=padding.only(bottom=8)),
                    Container(content=Card(content=results_card_content_column, elevation=1, color=self.COLORS.get("surface")), expand=True), # M3 Card for results
                ], spacing=16,
            ),
            padding=padding.all(16),
            border_radius=border_radius.all(12),
            bgcolor=self.COLORS.get("surfaceVariant") # Background for the main content area
        )

        self.history_button = IconButton(
            icon=Icons.HISTORY_ROUNDED, icon_color=self.COLORS.get("onSurface"), # Updated icon & color
            tooltip="Comparison History", on_click=self.open_history_dialog
        )
        self.settings_button = IconButton(
            icon=Icons.SETTINGS_OUTLINED, icon_color=self.COLORS.get("onSurface"), # Updated icon & color
            tooltip="Settings", on_click=self.open_settings
        )
        
        self.content = Container(
            expand=True, padding=padding.symmetric(horizontal=16, vertical=12),
            content=Column(
                expand=True, scroll=ScrollMode.ADAPTIVE, controls=[
                    Container(content=Row(controls=[
                        self.history_button,
                        Text("Localization Comparison Tool", style=ft.TextThemeStyle.TITLE_MEDIUM, color=self.COLORS.get("onSurface")),
                        self.settings_button,
                    ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN, vertical_alignment=ft.CrossAxisAlignment.CENTER),
                    padding=padding.only(bottom=12)),
                    self.main_card_container,
                ], spacing=16,
            ),
        )

    def _create_preview_column(self, title: str, text_field_instance: ft.TextField) -> Container:
        """Helper to create one column for the preview section using a passed TextField instance."""
        return Container(
            content=Column(
                controls=[
                    Text(title, style=ft.TextThemeStyle.TITLE_SMALL, color=self.COLORS.get("onSurfaceVariant")),
                    Container(
                        content=text_field_instance, # Use the passed TextField instance
                        border_radius=8, padding=8, expand=True,
                        border=ft.border.all(1, self.COLORS.get("outline")),
                        bgcolor=self.COLORS.get("surfaceContainerLowest")
                    )
                ],
                spacing=8, expand=True,
            ),
            col={"sm": 12, "md": 6}, expand=True, padding=padding.only(bottom=8)
        )

    def create_compare_button(self):
        compare_button = ft.FilledButton(
            content=Row([Icon(Icons.REFRESH_ROUNDED), Text("Compare Files", size=14, weight=ft.FontWeight.MEDIUM)],
                         alignment=ft.MainAxisAlignment.CENTER, spacing=8, vertical_alignment=ft.CrossAxisAlignment.CENTER),
            tooltip="Click to compare the source and target files", on_click=self.compare_files_gui,
            style=ButtonStyle(shape=RoundedRectangleBorder(radius=8)), height=40, expand=True,
        )
        translate_button = ft.FilledTonalButton(
            content=Row([Icon(Icons.TRANSLATE_ROUNDED), Text("Translate Missing", size=14, weight=ft.FontWeight.MEDIUM)],
                         alignment=ft.MainAxisAlignment.CENTER, spacing=8, vertical_alignment=ft.CrossAxisAlignment.CENTER),
            tooltip="Translate missing keys using Google Cloud Translate", on_click=self.translate_missing_keys,
            style=ButtonStyle(shape=RoundedRectangleBorder(radius=8)), height=40, expand=True, visible=False,
        )
        button_row = Row([compare_button, translate_button], alignment="center", spacing=8)
        return Container(content=button_row, on_hover=lambda e: self._on_compare_button_hover(e, button_row))


    async def post_init(self, e=None):
        self.force_refresh_ui()
        if not self.config.get("tutorial_completed", False):
            await asyncio.sleep(0.2) # Ensure UI is ready for tutorial
            if hasattr(self, 'tutorial') and self.tutorial:
                self.tutorial.start_tutorial()

    def force_refresh_ui(self):
        logger.info("Force UI refresh: applied theme '%s'", self.current_theme_name)
        self.page.update()

    def _on_compare_button_hover(self, e, button_row): # button_row is the Row widget
        compare_button = button_row.controls[0]
        translate_button = button_row.controls[1]
        is_hovering = e.data == "true"

        compare_base_bg = self.COLORS.get("primary")
        compare_hover_bg = self.COLORS.get("primaryContainer")
        compare_base_fg = self.COLORS.get("onPrimary")
        compare_hover_fg = self.COLORS.get("onPrimaryContainer") # Text color for primaryContainer

        tonal_base_bg = self.COLORS.get("secondaryContainer")
        tonal_hover_bg = self.COLORS.get("tertiaryContainer") # Using tertiary for distinct hover
        tonal_base_fg = self.COLORS.get("onSecondaryContainer")
        tonal_hover_fg = self.COLORS.get("onTertiaryContainer")


        if isinstance(compare_button, ft.FilledButton):
            current_compare_style = compare_button.style if compare_button.style else ButtonStyle()
            current_compare_style.bgcolor = compare_hover_bg if is_hovering else compare_base_bg
            current_compare_style.color = compare_hover_fg if is_hovering else compare_base_fg
            compare_button.style = current_compare_style
            # Also update icon/text color directly if not inheriting through style.color
            if compare_button.content and isinstance(compare_button.content, Row) and len(compare_button.content.controls) > 1:
                 compare_button.content.controls[0].color = compare_hover_fg if is_hovering else compare_base_fg # Icon
                 compare_button.content.controls[1].color = compare_hover_fg if is_hovering else compare_base_fg # Text

        if isinstance(translate_button, ft.FilledTonalButton):
            current_tonal_style = translate_button.style if translate_button.style else ButtonStyle()
            current_tonal_style.bgcolor = tonal_hover_bg if is_hovering else tonal_base_bg
            current_tonal_style.color = tonal_hover_fg if is_hovering else tonal_base_fg
            translate_button.style = current_tonal_style
            if translate_button.content and isinstance(translate_button.content, Row) and len(translate_button.content.controls) > 1:
                translate_button.content.controls[0].color = tonal_hover_fg if is_hovering else tonal_base_fg # Icon
                translate_button.content.controls[1].color = tonal_hover_fg if is_hovering else tonal_base_fg # Text

        compare_button.update()
        translate_button.update()

    def translate_missing_keys(self, event):
        if not self.config.get("mt_enabled") or not self.config.get("mt_api_key"):
            self.show_snackbar("Machine translation not enabled or API key missing in settings.")
            return

        def update_progress_ring(progress_value): # Renamed to avoid conflict
            self.loading_ring.visible = True
            self.status_label.value = f"Translating... {int(progress_value * 100)}%"
            if progress_value >= 1.0: self.loading_ring.value = None # Indeterminate for final phase
            else: self.loading_ring.value = progress_value
            self.page.update()

        try:
            with open(self.source_file_path, 'r', encoding='utf-8') as source_file:
                source_content = source_file.read()
            with open(self.target_file_path, 'r', encoding='utf-8') as target_file:
                target_content = target_file.read()

            ext_source = Path(self.source_file_path).suffix.lower()
            ext_target = Path(self.target_file_path).suffix.lower()

            source_dict_result = logic.parse_content_by_ext(source_content, ext_source)
            target_dict_result = logic.parse_content_by_ext(target_content, ext_target)

            source_dict = source_dict_result.get("translations", source_dict_result) if isinstance(source_dict_result, dict) else source_dict_result
            target_dict = target_dict_result.get("translations", target_dict_result) if isinstance(target_dict_result, dict) else target_dict_result


            self.loading_ring.visible = True
            self.status_label.value = "Preparing translation..."
            self.page.update()

            updated_target_dict, errors = logic.translate_missing_keys(
                source_dict, target_dict,
                self.config["mt_source_lang"], self.config["mt_target_lang"],
                self.config["mt_api_key"], update_progress_ring
            )

            if errors:
                error_msg = "\\n".join(errors[:3]) + ("..." if len(errors) > 3 else "")
                self.show_snackbar(f"Translation errors: {error_msg}")

            # Logic to save the updated_target_dict back to a file
            # For now, let's assume it's saved to a new file or overwrites target
            # This part needs a file picker for "Save As" functionality.
            output_content = logic.convert_dict_to_format(updated_target_dict, ext_target)

            # Example: Save to a new file (consider adding a FilePicker for save location)
            new_target_path = Path(self.target_file_path).parent / f"{Path(self.target_file_path).stem}_translated{ext_target}"
            with open(new_target_path, 'w', encoding='utf-8') as f:
                f.write(output_content)
            self.show_snackbar(f"Translated file saved to {new_target_path.name}")
            self.status_label.value = "Translation complete."

        except Exception as e:
            logging.error(f"Translation process error: {e}")
            self.show_snackbar(f"Translation error: {e}")
            self.status_label.value = "Translation failed."
        finally:
            self.loading_ring.visible = False
            self.loading_ring.value = None # Reset progress
            self.page.update()

    async def compare_files_async(self, event):
        self.loading_ring.visible = True; self.status_label.value = "Comparing files..."; self.page.update()
        def update_progress(val): self.loading_ring.value = val if val < 1.0 else None; self.page.update()
        try:
            task_id = file_processing_service.compare_files_async(self.source_file_path, self.target_file_path, self.config, update_progress)
            while not file_processing_service.is_task_complete(task_id): await asyncio.sleep(0.1)
            result = file_processing_service.get_task_status(task_id)
            if result['status'] == 'error': raise Exception(result['error'])
            
            data = result['result']
            self.source_line_numbers = data.get('source_lines',{}) # Store for ResultsView
            self.target_line_numbers = data.get('target_lines',{}) # Store for ResultsView
            self.update_statistics(data['stats']['total_keys'], data['stats']['missing_keys'], data['stats']['obsolete_keys'])
            self.results_view.build_results_table(data['comparison']) # Pass data to ResultsView
            self.status_label.value = f"Compared: {data['stats']['total_keys']} keys, {data['stats']['missing_keys']} missing, {data['stats']['obsolete_keys']} obsolete."
            history_manager.save_history({
                "timestamp": datetime.datetime.now().isoformat(), "source_file": os.path.basename(self.source_file_path),
                "target_file": os.path.basename(self.target_file_path), "diff": data['comparison']
            })
        except Exception as e: logging.error(f"Compare files error: {e}"); self.show_snackbar(f"Error: {e}"); self.status_label.value = "Comparison failed."
        finally: self.loading_ring.visible = False; self.loading_ring.value = None; self.page.update()

    async def compare_directories_async(self, event):
        self.loading_ring.visible = True; self.status_label.value = "Comparing directories..."; self.page.update()
        def update_progress(val): self.loading_ring.value = val if val < 1.0 else None; self.page.update()
        try:
            task_id = file_processing_service.compare_directories_async(self.source_dir_path, self.target_dir_path, self.config, update_progress)
            while not file_processing_service.is_task_complete(task_id): await asyncio.sleep(0.1)
            result = file_processing_service.get_task_status(task_id)
            if result['status'] == 'error': raise Exception(result['error'])
            
            data = result['result']
            if 'error' in data: self.show_snackbar(data['error']); return
            
            self.results_tabs.tabs.clear()
            for filename, file_data in data['file_results'].items():
                content_col = Column(scroll=ScrollMode.ADAPTIVE, spacing=8, expand=True)
                if 'error' in file_data:
                    content_col.controls.append(Text(f"Error: {file_data['error']}", color=self.COLORS.get("error")))
                else:
                    stats, comp_text = file_data['stats'], file_data['comparison']
                    content_col.controls.extend([
                        Text(f"Total: {stats['total_keys']} | Missing: {stats['missing_keys']} | Obsolete: {stats['obsolete_keys']}",
                             size=12, color=self.COLORS.get("onSurfaceVariant")),
                        TextField(value=comp_text, multiline=True, read_only=True, min_lines=10, expand=True,
                                  text_style=TextStyle(font_family="Consolas", size=12, color=self.COLORS.get("onSurface")),
                                  border=ft.InputBorder.OUTLINE, border_color=self.COLORS.get("outlineVariant"),
                                  bgcolor=self.COLORS.get("surface"))
                    ])
                self.results_tabs.tabs.append(Tab(text=filename, content=Container(content=content_col, padding=10, expand=True)))
            
            overall_stats = data['stats'] # This should be overall stats, ensure service provides it
            self.update_statistics(overall_stats.get('total_files_compared', len(data['file_results'])),
                                   overall_stats.get('total_missing_keys_all_files', 0),
                                   overall_stats.get('total_obsolete_keys_all_files', 0))
            self.results_tabs.visible = True
            self.results_view.results_container.content = self.results_tabs
            self.status_label.value = f"Compared {overall_stats.get('total_files_compared', len(data['file_results']))} files."
        except Exception as e: logging.error(f"Compare dirs error: {e}"); self.show_snackbar(f"Error: {e}"); self.status_label.value = "Dir comparison failed."
        finally: self.loading_ring.visible = False; self.loading_ring.value = None; self.page.update()

    def compare_files_gui(self, event): asyncio.create_task(self.compare_files_async(event))
    def compare_directories(self, event): asyncio.create_task(self.compare_directories_async(event))
    
    def get_readable_file_size(self, size_in_bytes):
        for unit in ['B', 'KB', 'MB', 'GB']:
            if size_in_bytes < 1024: return f"{size_in_bytes}{unit}" if unit == 'B' else f"{size_in_bytes:.1f}{unit}"
            size_in_bytes /= 1024
        return f"{size_in_bytes:.1f}TB"

    def clear_file(self, field, icon, clear_btn): # Likely unused in App, part of FileInputComponent logic
        if field: field.value = ""
        if icon: icon.color = self.COLORS.get("onSurfaceVariant")
        self.update_compare_button() # Assumes compare_button is an App attribute
        self.page.update()

    def validate_file(self, file_path: str) -> bool: # Used by FileInputComponent
        if not (file_path and file_path.strip() and os.path.isfile(file_path)):
            self.show_snackbar(self.user_friendly_errors.get("file_not_found", "File not found.")); return False
        if Path(file_path).suffix.lower() not in SUPPORTED_FORMATS:
            self.show_snackbar(self.user_friendly_errors.get("file_type", "Unsupported file type.")); return False
        return True

    def show_snackbar(self, message: str):
        if self.page.snack_bar:
            self.page.snack_bar.content = ft.Text(message, color=self.COLORS.get("inverseOnSurface"))
            self.page.snack_bar.bgcolor = self.COLORS.get("inverseSurface")
            self.page.snack_bar.open = True; self.page.update()

    def handle_source_selected(self, file_path: str): self.source_file_path = file_path; self.update_compare_button()
    def handle_target_selected(self, file_path: str): self.target_file_path = file_path; self.update_compare_button()
    def handle_source_cleared(self): self.source_file_path = ""; self.update_compare_button()
    def handle_target_cleared(self): self.target_file_path = ""; self.update_compare_button()

    def update_compare_button(self): # This is App's method for its compare button
        is_enabled = bool(self.source_file_path and self.target_file_path) or \
                     bool(self.source_dir_path and self.target_dir_path)
        
        compare_action_button = self.compare_button.content.controls[0] # The ft.FilledButton
        translate_action_button = self.compare_button.content.controls[1] # The ft.FilledTonalButton

        compare_action_button.disabled = not is_enabled
        # Only show translate if single files are selected and MT is enabled
        translate_action_button.visible = bool(self.source_file_path and self.target_file_path and self.config.get("mt_enabled"))

        self.page.update()

    def handle_window_event(self, e): pass # Placeholder
    def save_translated_file(self, result, updated_dict): pass # Placeholder

    def update_file_preview(self, file_path: str, preview_type: str):
        tf = self.source_preview_tf if preview_type == "source" else self.target_preview_tf
        if not tf: return
        try:
            # Use file_cache_service for optimized preview reading
            preview_content = file_cache_service.preview_file(file_path, lines=5)
            tf.value = preview_content if preview_content else "Empty file or could not read preview."
        except Exception as e:
            logging.error(f"Error reading preview for {file_path}: {e}")
            tf.value = "Error reading file preview."
        if tf: tf.update()


    def _on_browse_hover(self, e, button): # This is likely for FileInputComponent, keep minimal here
        pass

    def open_source_dir_picker(self, e): self.source_dir_picker.get_directory_path()
    def open_target_dir_picker(self, e): self.target_dir_picker.get_directory_path()

    def handle_dir_picked(self, e: FilePickerResultEvent, dir_type: str):
        if e.path:
            if dir_type == "source":
                self.source_dir_path = e.path
                if self.file_input: self.file_input.source_label.value = f"Dir: {Path(e.path).name}"
                self.source_file_path = "" # Clear single file path
                if self.file_input: self.file_input.source_file_path = ""
            else: # target
                self.target_dir_path = e.path
                if self.file_input: self.file_input.target_label.value = f"Dir: {Path(e.path).name}"
                self.target_file_path = "" # Clear single file path
                if self.file_input: self.file_input.target_file_path = ""
            self.update_compare_button()
            if self.file_input: self.file_input.page.update() # Update FileInput's display

    def open_settings(self, e): self.settings_dialog_component.open_dialog(e)
    def close_settings(self, e): self.settings_dialog_component.close_dialog(e)
    def open_history_dialog(self, e): self.history_dialog.open_dialog(e)

    def reset_colors(self, e): # Example: reset to a specific theme
        self.current_theme_name = "dark"
        self.config["theme"] = "dark"
        ConfigManager.save(self.config)
        self.update_theme_colors()

    def copy_results(self, e):
        if hasattr(self.results_view, 'copy_results'): self.results_view.copy_results(e)

    def toggle_section(self, e, column): # Delegate to ResultsView
        if hasattr(self.results_view, 'toggle_section'): self.results_view.toggle_section(e, column)

    def toggle_expand_all(self, e): # This App method might be for a general expand/collapse
        # This needs to be connected to the correct component that displays expandable content (e.g. ResultsView)
        if hasattr(self.results_view, 'toggle_expand_all_namespaces'): # Assuming ResultsView has this
             self.results_view.toggle_expand_all_namespaces(e)
        # Update App's own button if it's separate from component's internal button
        # self.expand_all = not self.expand_all
        # if hasattr(self, 'expand_collapse_button'):
        #     self.expand_collapse_button.icon = Icons.UNFOLD_LESS if self.expand_all else Icons.UNFOLD_MORE
        #     self.expand_collapse_button.update()


    def handle_preview_toggle(self, e): # Called by SettingsDialogComponent
        self.config["show_preview"] = e.control.value
        ConfigManager.save(self.config)
        self.preview_section.visible = e.control.value and (self.source_file_path or self.target_file_path or self.source_dir_path or self.target_dir_path)
        if self.preview_section.visible: # Re-populate previews if toggled on
            if self.source_file_path: self.update_file_preview(self.source_file_path, "source")
            elif self.source_dir_path: self.source_preview_tf.value = "Directory selected, no single file preview." # Or preview first file
            if self.target_file_path: self.update_file_preview(self.target_file_path, "target")
            elif self.target_dir_path: self.target_preview_tf.value = "Directory selected, no single file preview."
        self.page.update()

    def handle_setting_change(self, e, setting_name): # Called by SettingsDialogComponent
        self.config[setting_name] = e.control.value
        ConfigManager.save(self.config)
        # Some settings might require immediate UI updates beyond what SettingsDialog handles itself
        if setting_name == "show_preview": self.handle_preview_toggle(e)
        # Other settings might require calling update_theme_colors() or other specific methods
        self.page.update()

    def handle_theme_change(self, e): # Called by SettingsDialogComponent
        self.current_theme_name = e.control.value
        self.config["theme"] = self.current_theme_name
        ConfigManager.save(self.config)
        self.update_theme_colors() # This will update everything including components

    # Keyboard Navigation (basic stubs)
    def register_keyboard_navigation(self): self.page.on_keyboard_event = self.handle_keyboard_event
    def unregister_keyboard_navigation(self): self.page.on_keyboard_event = None
    def update_keyboard_navigation(self):
        if self.config.get("enable_keyboard_nav"): self.register_keyboard_navigation()
        else: self.unregister_keyboard_navigation()
    def handle_keyboard_event(self, e: ft.KeyboardEvent):
        # Basic example: Ctrl+O to open settings
        if e.key == "O" and e.ctrl: self.open_settings(e)
        # Add more keyboard shortcuts here

def main(page: ft.Page):
    # Initialize main application config and UI
    app_instance = App(page)

    # Apply user's preferred theme settings from config
    page.title = "Localization Comparison Tool"
    page.vertical_alignment = ft.MainAxisAlignment.START
    page.horizontal_alignment = ft.CrossAxisAlignment.STRETCH

    # Set initial page theme mode based on config (already handled by _apply_page_theme_mode in App.__init__)
    # page.theme_mode = app_instance.page.theme_mode # Ensure it's set on page object too.

    # Initial update for keyboard navigation
    app_instance.update_keyboard_navigation()

    page.update()

if __name__ == "__main__":
    ft.app(target=main)
