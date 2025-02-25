import flet as ft
from flet import (
    Text, TextField, Container, Column, Row, IconButton, 
    Icons, padding, TextButton, Tab, Tabs, Checkbox, Slider,
    dropdown, Theme, Colors, ThemeMode, ButtonStyle
)
from typing import Dict, Any
from core.config import ConfigManager

class SettingsDialogComponent:
    def __init__(self, page: ft.Page, app_reference, config: Dict[str, Any], colors: dict):
        self.page = page
        self.app = app_reference
        self.config = config
        self.colors = colors
        
        # Create all tabs
        general_tab = self._create_general_tab()
        comparison_tab = self._create_comparison_tab()
        file_format_tab = self._create_file_format_tab()
        translation_tab = self._create_translation_tab()
        accessibility_tab = self._create_accessibility_tab()
        
        # Create settings tabs
        self.settings_tabs = Tabs(
            selected_index=0,
            animation_duration=300,
            tabs=[
                general_tab,
                comparison_tab,
                file_format_tab,
                translation_tab,
                accessibility_tab
            ],
            expand=1,
        )
        
        # Create main dialog
        self.dialog = ft.AlertDialog(
            title=Text("Settings", size=20),
            content=Container(
                content=Column(
                    controls=[self.settings_tabs],
                    scroll=ft.ScrollMode.AUTO,
                ),
                width=500,
                height=400,
            ),
            actions=[
                TextButton("Reset to Default", on_click=self.reset_settings),
                TextButton("Close", on_click=self.close_dialog),
            ],
        )

    def _create_general_tab(self) -> Tab:
        return Tab(
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
                                        value=self.app.current_theme,
                                        options=[
                                            dropdown.Option("system", "System Default"),
                                            dropdown.Option("dark", "Dark Theme"),
                                            # ...add other theme options...
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
        )

    def _create_comparison_tab(self) -> Tab:
        # Similar to general tab but with comparison settings
        # ...implementation...
        pass

    def _create_file_format_tab(self) -> Tab:
        # Similar pattern for file format settings
        # ...implementation...
        pass

    def _create_translation_tab(self) -> Tab:
        # Similar pattern for translation settings
        # ...implementation...
        pass

    def _create_accessibility_tab(self) -> Tab:
        # Similar pattern for accessibility settings
        # ...implementation...
        pass

    def open_dialog(self, e):
        self.dialog.open = True
        self.page.update()

    def close_dialog(self, e):
        self.dialog.open = False
        self.page.update()

    def reset_settings(self, e):
        """Reset settings to defaults using ConfigManager"""
        # Reset config using ConfigManager
        self.config.update(ConfigManager.reset())
        
        # Update app reference config too
        self.app.config = self.config
        
        # Update UI controls to match reset values
        # ...update UI controls...
        
        # Apply theme changes
        self.app.current_theme = self.config["theme"]
        self.app.update_theme_colors()
        self.app.page.update()
        
        self.app.show_snackbar("Settings reset to defaults")

    def handle_theme_change(self, e):
        self.app.handle_theme_change(e)

    def handle_auto_fill_change(self, e):
        self.config["auto_fill_missing"] = e.control.value
        self.app.save_config()
        self.page.update()

    def handle_mt_enabled_change(self, e):
        """Handle machine translation toggle"""
        self.config["mt_enabled"] = e.control.value
        
        # Validate MT settings
        errors = ConfigManager.validate_required_fields(self.config)
        if "mt_api_key" in errors and self.config["mt_enabled"]:
            self.app.show_snackbar(errors["mt_api_key"])
            
        ConfigManager.save(self.config)
        self.page.update()
    
    # Add all other handler methods...
    # ...rest of handler methods...
