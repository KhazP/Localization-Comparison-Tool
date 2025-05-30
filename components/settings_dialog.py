import flet as ft
from flet import (
    Text, TextField, Container, Column, Row, IconButton, 
    Icons, padding, TextButton, Tab, Tabs, Checkbox, Slider,
    dropdown, Theme, Colors, ThemeMode, ButtonStyle, LinearGradient,
    Card, ElevatedButton, BorderRadius, Animation, AnimationCurve, 
    BoxShadow, alignment, Divider, Icon, Offset, ProgressBar
)
from typing import Dict, Any
from core.config import ConfigManager

class SettingsDialogComponent:
    def __init__(self, page: ft.Page, app_reference, config: Dict[str, Any], colors: dict):
        self.page = page
        self.app = app_reference
        self.config = config
        self.colors = colors
        self.current_tab = 0
        
        # Define tab colors for visual appeal - similar to onboarding step colors
        self.tab_colors = {
            0: "#4CAF50",  # Green for General
            1: "#2196F3",  # Blue for Comparison
            2: "#FF9800",  # Orange for File Format
            3: "#E91E63",  # Pink for Translation
            4: "#9C27B0",  # Purple for Accessibility
        }
        
        # Create all tabs
        self.tabs_content = [
            self._create_general_tab(),
            self._create_comparison_tab(),
            self._create_file_format_tab(),
            self._create_translation_tab(),
            self._create_accessibility_tab()
        ]
        
        # Create settings tabs navigation (icons only for cleaner look)
        self.settings_tabs = Row(
            controls=[self._create_tab_button(i) for i in range(len(self.tabs_content))],
            alignment="center",
            spacing=self.app.spacing["m"], # Updated
            height=self.app.spacing["xxl"] + self.app.spacing["xl"], # 80px Updated
        )
        
        # Create progress bar that shows position like onboarding
        self.progress_bar = ProgressBar(
            width=450, # Keep width or make it relative
            value=0.2,
            bgcolor=ft.colors.with_opacity(0.2, self.colors["bg"]["accent"]),
            color=self.tab_colors[0],
            height=self.app.spacing["xxs"], # Updated
            border_radius=BorderRadius.all(self.app.spacing["xxs"]/2), # Updated
        )
        
        # Prepare main content container that will be dynamically updated
        self.content_container = Container(
            content=self.tabs_content[0],
            animate=Animation(300, AnimationCurve.EASE_IN_OUT),
            opacity=1,
        )
        
        # Create main dialog with onboarding-inspired styling
        self.dialog = ft.AlertDialog(
            bgcolor=ft.colors.TRANSPARENT,
            content=Container(
                content=Column(
                    controls=[
                        # Header with icon, title and close button
                        self._create_header(),
                        
                        # Tab navigation and progress indicators
                        Container(
                            content=Column([
                                self.settings_tabs,
                                self.progress_bar,
                            ]),
                            margin=padding.only(top=self.app.spacing["s"], bottom=self.app.spacing["s"]), # Updated
                        ),
                        
                        # Dynamic content area - wrapped in a Column with scroll instead of Container
                        Column(
                            controls=[self.content_container],
                            expand=True, # Keep expand
                            scroll=ft.ScrollMode.AUTO, # Keep scroll
                            height=400,  # Keep Fixed height for scrolling
                        ),
                        
                        # Footer navigation buttons 
                        self._create_footer(),
                    ],
                    spacing=self.app.spacing["m"], # Updated
                ),
                width=550, # Keep width or make relative
                padding=padding.all(self.app.spacing["l"]), # Updated
                border_radius=BorderRadius.all(self.app.spacing["s"]), # Updated
                gradient=LinearGradient(
                    begin=alignment.top_center,
                    end=alignment.bottom_center,
                    colors=[
                        self.colors["bg"]["secondary"], 
                        self.colors["bg"]["primary"]
                    ]
                ),
                shadow=BoxShadow(
                    spread_radius=1,
                    blur_radius=15,
                    color=ft.colors.with_opacity(0.3, "#000000"),
                    offset=Offset(0, 4)
                )
            ),
            actions=[],
            actions_alignment="end",
            open=False,
            # Add on_dismiss for handling the dialog close
            on_dismiss=lambda e: self.close_dialog(e)
        )

    # Add the missing update_colors method
    def update_colors(self, colors: dict):
        """Update the component's colors based on the current theme."""
        self.colors = colors
        
        # Update dialog background gradient
        dialog_container = self.dialog.content
        dialog_container.gradient = LinearGradient(
            begin=alignment.top_center,
            end=alignment.bottom_center,
            colors=[
                self.colors["bg"]["secondary"], 
                self.colors["bg"]["primary"]
            ]
        )
        
        # Update progress bar colors
        self.progress_bar.bgcolor = ft.colors.with_opacity(0.2, self.colors["bg"]["accent"])
        
        # Update header text colors
        header = self.dialog.content.content.controls[0].content.controls
        header[1].color = self.colors["text"]["primary"]  # Tab title text
        header[2].icon_color = self.colors["text"]["secondary"]  # Close button
        
        # Update tab buttons
        for i, button in enumerate(self.settings_tabs.controls):
            is_current = i == self.current_tab
            color = self.tab_colors[i] if is_current else self.colors["text"]["secondary"]
            button.content.icon_color = color
        
        # Update all text colors in content tabs
        for tab in self.tabs_content:
            self._update_tab_colors(tab)
            
        # Update the footer buttons
        footer = self.dialog.content.content.controls[3]
        footer.controls[0].style.color = ft.colors.with_opacity(0.7, self.colors["text"]["secondary"])
        footer.controls[1].controls[0].style.color = self.colors["text"]["secondary"]
        footer.controls[1].controls[1].content.style.color = self.colors["text"]["primary"]

    def _update_tab_colors(self, tab):
        """Helper method to update colors in a tab container."""
        # This is a basic implementation that will need to be adjusted based on
        # the actual structure of your tabs
        if hasattr(tab, "content") and tab.content:
            if isinstance(tab.content, Column):
                for control in tab.content.controls:
                    if isinstance(control, Card):
                        control.color = self.colors["bg"]["secondary"]
                        if hasattr(control, "content") and hasattr(control.content, "content"):
                            if isinstance(control.content.content, Column):
                                for item in control.content.content.controls:
                                    if isinstance(item, Text):
                                        if item.weight == "bold" or item.size == 18:
                                            # Keep section titles in their tab color
                                            continue
                                        elif item.size == 14 and not item.weight:
                                            # Section descriptions
                                            item.color = self.colors["text"]["secondary"]
                                        else:
                                            # Other text
                                            item.color = self.colors["text"]["primary"]

    def _create_header(self):
        """Create animated header with active tab info and close button"""
        return Container(
            content=Row(
                controls=[
                    # Tab icon in colored circle
                    Container(
                        content=Icon(
                            self._get_tab_icon(0),
                            size=self.app.TEXT_SIZE_XXLARGE, # Updated
                            color=self.tab_colors[0]
                        ),
                        padding=padding.all(self.app.spacing["s"]), # Updated
                        border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        bgcolor=ft.colors.with_opacity(0.1, self.tab_colors[0]),
                    ),
                    # Tab title text
                    Text(
                        self._get_tab_title(0),
                        size=self.app.TEXT_SIZE_XLARGE, # Updated
                        weight="bold", # Keep weight
                        color=self.colors["text"]["primary"]
                    ),
                    # Close (X) button
                    IconButton(
                        icon=Icons.CLOSE,
                        icon_color=self.colors["text"]["secondary"],
                        tooltip="Close Settings",
                        on_click=self.close_dialog,
                        icon_size=self.app.TEXT_SIZE_LARGE # Explicitly set icon size
                    ),
                ],
                alignment="spaceBetween",
                vertical_alignment="center",
            ),
            margin=padding.only(bottom=self.app.spacing["s"]), # Updated
            animate=Animation(300, AnimationCurve.EASE_IN_OUT), # Keep animation
        )

    def _create_footer(self):
        """Create footer with action buttons"""
        button_text_size = self.app.TEXT_SIZE_DEFAULT # Was 16, now 14
        icon_size = self.app.TEXT_SIZE_MEDIUM # Was 16, now 16 (aligned)

        return Row(
            controls=[
                TextButton(
                    "Reset to Default",
                    on_click=self.reset_settings,
                    style=ft.ButtonStyle(
                        color=ft.colors.with_opacity(0.7, self.colors["text"]["secondary"]),
                        text_style=ft.TextStyle(size=button_text_size) # Added text style
                    )
                ),
                Row(
                    controls=[
                        TextButton(
                            content=Row(
                                controls=[
                                    Icon(Icons.ARROW_BACK, size=icon_size), # Updated
                                    Text("Previous", size=button_text_size), # Updated
                                ],
                                spacing=self.app.spacing["xxs"] # Updated
                            ),
                            on_click=self.previous_tab,
                            style=ButtonStyle(
                                color=self.colors["text"]["secondary"]
                            )
                        ),
                        Container(
                            content=TextButton(
                                content=Row(
                                    controls=[
                                        Text("Next", size=button_text_size), # Updated
                                        Icon(Icons.ARROW_FORWARD, size=icon_size) # Updated
                                    ],
                                    spacing=self.app.spacing["xxs"] # Updated
                                ),
                                on_click=self.next_tab,
                                style=ButtonStyle(
                                    color=self.colors["text"]["primary"],
                                )
                            ),
                            animate=Animation(300, AnimationCurve.BOUNCE_OUT), # Keep animation
                        ),
                    ],
                    spacing=self.app.spacing["s"] # Updated from 10 to 12
                ),
            ],
            alignment="spaceBetween" # Keep alignment
        )

    def _create_tab_button(self, index):
        """Create an individual tab button with indicator"""
        is_current = index == self.current_tab
        color = self.tab_colors[index] if is_current else self.colors["text"]["secondary"]
        bgcolor = ft.colors.with_opacity(0.1 if is_current else 0.05, color)
        icon_size_current = self.app.TEXT_SIZE_XLARGE # 22px (was 24)
        icon_size_default = self.app.TEXT_SIZE_LARGE # 18px (was 20)
        
        return Container(
            content=IconButton(
                icon=self._get_tab_icon(index),
                icon_color=color,
                icon_size=icon_size_current if is_current else icon_size_default, # Updated
                on_click=lambda e, i=index: self.switch_to_tab(i),
                tooltip=self._get_tab_title(index),
            ),
            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
            bgcolor=bgcolor,
            width=self.app.spacing["xl"] * 2, # 64px Updated
            height=self.app.spacing["xl"] * 2, # 64px Updated
            animate=Animation(300, AnimationCurve.EASE_IN_OUT), # Keep animation
            padding=self.app.spacing["xs"], # Updated
            shadow=BoxShadow(
                spread_radius=0,
                blur_radius=self.app.spacing["xs"] if is_current else 0, # Updated
                color=ft.colors.with_opacity(0.2, color if is_current else "#000000"),
                offset=Offset(0, 2),
            ),
            scale=1.1 if is_current else 1.0,
        )
    
    def _get_tab_icon(self, index):
        """Get icon for a specific tab"""
        icons = [
            Icons.SETTINGS,            # General
            Icons.COMPARE_ARROWS,      # Comparison
            Icons.FILE_PRESENT,        # File Format
            Icons.TRANSLATE,           # Translation
            Icons.ACCESSIBILITY_NEW,   # Accessibility
        ]
        return icons[index]
    
    def _get_tab_title(self, index):
        """Get title for a specific tab"""
        titles = [
            "General Settings", 
            "Comparison Settings", 
            "File Format Settings",
            "Translation Settings",
            "Accessibility Settings"
        ]
        return titles[index]

    def _create_general_tab(self) -> Container:
        return Container(
            content=Column(
                controls=[
                    # Card with animation for theme settings
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Visual Appearance",
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[0],
                                    ),
                                    Text(
                                        "Choose your preferred theme and visual settings",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    Row([
                                        Container(
                                            content=Column([
                                                Icon(Icons.DARK_MODE, size=self.app.TEXT_SIZE_XLARGE), # Updated
                                                Text("Dark", size=self.app.TEXT_SIZE_SMALL), # Updated
                                            ], 
                                            alignment="center",
                                            spacing=self.app.spacing["xxs"] # Updated
                                            ),
                                            width=self.app.BASE_UNIT * 18, # 72px Updated
                                            height=self.app.BASE_UNIT * 18, # 72px Updated
                                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                                            bgcolor=ft.colors.with_opacity(
                                                0.1 if self.app.current_theme == "dark" else 0.05, 
                                                self.tab_colors[0]
                                            ),
                                            border=ft.border.all(
                                                2 if self.app.current_theme == "dark" else 0, # Keep border width
                                                self.tab_colors[0]
                                            ),
                                            padding=self.app.spacing["s"], # Updated
                                            on_click=lambda e: self.quick_theme_change("dark"),
                                        ),
                                        Container(
                                            content=Column([
                                                Icon(Icons.LIGHT_MODE, size=self.app.TEXT_SIZE_XLARGE), # Updated
                                                Text("Light", size=self.app.TEXT_SIZE_SMALL), # Updated
                                            ], 
                                            alignment="center", 
                                            spacing=self.app.spacing["xxs"] # Updated
                                            ),
                                            width=self.app.BASE_UNIT * 18, # 72px Updated
                                            height=self.app.BASE_UNIT * 18, # 72px Updated
                                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                                            bgcolor=ft.colors.with_opacity(
                                                0.1 if self.app.current_theme == "light" else 0.05,
                                                self.tab_colors[0]
                                            ),
                                            border=ft.border.all(
                                                2 if self.app.current_theme == "light" else 0, 
                                                self.tab_colors[0]
                                            ),
                                            padding=self.app.spacing["s"], # Updated
                                            on_click=lambda e: self.quick_theme_change("light"),
                                        ),
                                        Container(
                                            content=Column([
                                                Icon(Icons.SETTINGS_SUGGEST, size=self.app.TEXT_SIZE_XLARGE), # Updated
                                                Text("System", size=self.app.TEXT_SIZE_SMALL), # Updated
                                            ], 
                                            alignment="center",
                                            spacing=self.app.spacing["xxs"] # Updated
                                            ),
                                            width=self.app.BASE_UNIT * 18, # 72px Updated
                                            height=self.app.BASE_UNIT * 18, # 72px Updated
                                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                                            bgcolor=ft.colors.with_opacity(
                                                0.1 if self.app.current_theme == "system" else 0.05,
                                                self.tab_colors[0]
                                            ),
                                            border=ft.border.all(
                                                2 if self.app.current_theme == "system" else 0, 
                                                self.tab_colors[0]
                                            ),
                                            padding=self.app.spacing["s"], # Updated
                                            on_click=lambda e: self.quick_theme_change("system"),
                                        ),
                                        Container(
                                            content=Column([
                                                Icon(Icons.NIGHTLIGHT_ROUND, size=self.app.TEXT_SIZE_XLARGE), # Updated
                                                Text("AMOLED", size=self.app.TEXT_SIZE_XSMALL), # Adjusted for length
                                            ], 
                                            alignment="center",
                                            spacing=self.app.spacing["xxs"] # Updated
                                            ),
                                            width=self.app.BASE_UNIT * 18, # 72px Updated
                                            height=self.app.BASE_UNIT * 18, # 72px Updated
                                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                                            bgcolor=ft.colors.with_opacity(
                                                0.1 if self.app.current_theme == "amoled" else 0.05,
                                                self.tab_colors[0]
                                            ),
                                            border=ft.border.all(
                                                2 if self.app.current_theme == "amoled" else 0, 
                                                self.tab_colors[0]
                                            ),
                                            padding=self.app.spacing["s"], # Updated
                                            on_click=lambda e: self.quick_theme_change("amoled"),
                                        ),
                                    ], 
                                    alignment="spaceEvenly" # Keep alignment
                                    ),
                                    Container(height=self.app.spacing["l"]), # 24px Updated
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                    
                    Container(height=self.app.spacing["m"]), # 16px Updated
                    
                    # User Interface Card
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Interface Behavior", 
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[0],
                                    ),
                                    Text(
                                        "Configure how the application responds to your actions",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    Row(
                                        controls=[
                                            Text(
                                                "Animation Speed",
                                                size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                                weight="bold", # Keep weight
                                            ),
                                        ]
                                    ),
                                    Container(height=self.app.spacing["xs"]), # 8px Updated
                                    Row(
                                        controls=[
                                            Icon(Icons.SPEED_OUTLINED, size=self.app.TEXT_SIZE_LARGE), # Updated
                                            Slider(
                                                min=0,
                                                max=1000,
                                                value=self.config.get("animation_speed", 300),
                                                divisions=10,
                                                width=350, # Keep width or make relative
                                                label="{value}ms",
                                                on_change=lambda e: self.handle_setting_change(e, "animation_speed"),
                                            ),
                                        ],
                                        spacing=self.app.spacing["s"], # Updated
                                    ),
                                    Container(height=self.app.spacing["m"]), # 16px Updated
                                    Row(
                                        controls=[
                                            Checkbox(
                                                value=self.config.get("confirm_actions", True),
                                                label="Confirm destructive actions",
                                                label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                                on_change=lambda e: self.handle_setting_change(e, "confirm_actions"),
                                            ),
                                        ],
                                    ),
                                ],
                                spacing=self.app.spacing["xs"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                ],
                spacing=self.app.spacing["xs"], # Updated
                scroll=ft.ScrollMode.AUTO, # Keep scroll
            ),
            padding=padding.all(self.app.spacing["s"]), # Updated
        )

    def _create_comparison_tab(self) -> Container:
        return Container(
            content=Column(
                controls=[
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Comparison Options",
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[1],
                                    ),
                                    Text(
                                        "Configure how files are compared and displayed",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    Checkbox(
                                        value=self.config.get("show_preview", True),
                                        label="Show File Preview",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=self.app.handle_preview_toggle,
                                    ),
                                    Checkbox(
                                        value=self.config.get("show_line_numbers", False),
                                        label="Show Line Numbers",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "show_line_numbers"),
                                    ),
                                    Checkbox(
                                        value=self.config.get("auto_fill_missing", False),
                                        label="Auto-Fill Missing Keys",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "auto_fill_missing"),
                                    ),
                                    Checkbox(
                                        value=self.config.get("log_missing_strings", False),
                                        label="Log Missing Strings",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "log_missing_strings"),
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                    
                    Container(height=self.app.spacing["m"]), # 16px Updated
                    
                    # Advanced comparison options
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Advanced Comparison", 
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[1],
                                    ),
                                    Text(
                                        "Configure detailed comparison behavior",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    Checkbox(
                                        value=self.config.get("ignore_whitespace", False),
                                        label="Ignore Whitespace",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "ignore_whitespace"),
                                    ),
                                    Checkbox(
                                        value=self.config.get("ignore_case", False),
                                        label="Ignore Case",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "ignore_case"),
                                    ),
                                    Checkbox(
                                        value=self.config.get("group_by_namespace", True),
                                        label="Group by Namespace",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "group_by_namespace"),
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                ],
                spacing=self.app.spacing["xs"], # Updated
                scroll=ft.ScrollMode.AUTO, # Keep scroll
            ),
            padding=padding.all(self.app.spacing["s"]), # Updated
        )

    def _create_file_format_tab(self) -> Container:
        return Container(
            content=Column(
                controls=[
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Format Preferences",
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[2],
                                    ),
                                    Text(
                                        "Choose your preferred file format settings",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    Text(
                                        "Default Format",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        weight="bold", # Keep weight
                                    ),
                                    Container(height=self.app.spacing["xs"]), # 8px Updated
                                    ft.Dropdown(
                                        value=self.config.get("preferred_format", "auto"),
                                        width=400, # Keep width or make relative
                                        options=[
                                            ft.dropdown.Option("auto", "Auto-Detect"),
                                            ft.dropdown.Option("json", "JSON"),
                                            ft.dropdown.Option("yaml", "YAML"),
                                            ft.dropdown.Option("lang", ".lang"),
                                            ft.dropdown.Option("xml", "XML"),
                                            ft.dropdown.Option("properties", "Properties"),
                                            ft.dropdown.Option("csv", "CSV"),
                                            ft.dropdown.Option("resx", "RESX"),
                                        ],
                                        text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added
                                        # hint_style for dropdown is not directly available, default label uses text_style
                                        # content_padding for dropdown can be set if needed
                                        on_change=lambda e: self.handle_setting_change(e, "preferred_format"),
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                    
                    Container(height=self.app.spacing["m"]), # 16px Updated
                    
                    # Ignore patterns section
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Ignore Patterns", 
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[2],
                                    ),
                                    Text(
                                        "Specify patterns to ignore when comparing files",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    TextField(
                                        value=",".join(self.config.get("ignore_patterns", [])),
                                        hint_text="Enter comma-separated patterns (e.g., temp_, debug_, test_)",
                                        text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added
                                        hint_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT, color=self.colors["text"]["secondary"]), # Added
                                        content_padding=self.app.spacing["xs"], # Added
                                        on_change=self.handle_ignore_patterns_change,
                                        multiline=True,
                                        min_lines=3,
                                        max_lines=5,
                                        border=ft.InputBorder.OUTLINE, # Keep border
                                        expand=True, # Keep expand
                                    ),
                                    Container(height=self.app.spacing["s"]), # 10px -> 12px Updated
                                    Text(
                                        "Each pattern will be used to filter out keys containing that pattern",
                                        size=self.app.TEXT_SIZE_SMALL, # Updated
                                        color=self.colors["text"]["secondary"],
                                        italic=True, # Keep italic
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                ],
                spacing=self.app.spacing["xs"], # Updated
                scroll=ft.ScrollMode.AUTO, # Keep scroll
            ),
            padding=padding.all(self.app.spacing["s"]), # Updated
        )

    def _create_translation_tab(self) -> Container:
        return Container(
            content=Column(
                controls=[
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Machine Translation",
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[3],
                                    ),
                                    Text(
                                        "Configure settings for automatic translation of missing strings",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    Checkbox(
                                        value=self.config.get("mt_enabled", False),
                                        label="Enable Machine Translation",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=self.handle_mt_enabled_change,
                                    ),
                                    
                                    Text(
                                        "Google Cloud API Key",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        weight="bold", # Keep weight
                                    ),
                                    Container(height=self.app.spacing["xs"]), # 8px Updated
                                    TextField(
                                        value=self.config.get("mt_api_key", ""),
                                        password=True,
                                        can_reveal_password=True,
                                        hint_text="Enter your Google Cloud API key",
                                        text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added
                                        hint_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT, color=self.colors["text"]["secondary"]), # Added
                                        content_padding=self.app.spacing["xs"], # Added
                                        on_change=lambda e: self.handle_setting_change(e, "mt_api_key"),
                                        border=ft.InputBorder.OUTLINE, # Keep border
                                    ),
                                    Container(height=self.app.spacing["xs"]), # 8px Updated
                                    Text(
                                        "You need a Google Cloud account with billing enabled to use this feature.",
                                        size=self.app.TEXT_SIZE_SMALL, # Updated
                                        color=self.colors["text"]["secondary"],
                                        italic=True, # Keep italic
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                    
                    Container(height=self.app.spacing["m"]), # 16px Updated
                    
                    # Language settings
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Language Settings", 
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[3],
                                    ),
                                    Text(
                                        "Set default languages for translation",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    Text(
                                        "Source Language",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        weight="bold", # Keep weight
                                    ),
                                    Container(height=self.app.spacing["xs"]), # 8px Updated
                                    ft.Dropdown(
                                        value=self.config.get("mt_source_lang", "en"),
                                        width=400, # Keep width or make relative
                                        options=[
                                            ft.dropdown.Option("en", "English"),
                                            ft.dropdown.Option("fr", "French"),
                                            ft.dropdown.Option("de", "German"),
                                            ft.dropdown.Option("es", "Spanish"),
                                            ft.dropdown.Option("it", "Italian"),
                                            ft.dropdown.Option("ja", "Japanese"),
                                            ft.dropdown.Option("ko", "Korean"),
                                            ft.dropdown.Option("pt", "Portuguese"),
                                            ft.dropdown.Option("ru", "Russian"),
                                            ft.dropdown.Option("zh", "Chinese"),
                                        ],
                                        text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added
                                        on_change=lambda e: self.handle_setting_change(e, "mt_source_lang"),
                                    ),
                                    
                                    Container(height=self.app.spacing["m"]), # 16px Updated
                                    
                                    Text(
                                        "Target Language",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        weight="bold", # Keep weight
                                    ),
                                    Container(height=self.app.spacing["xs"]), # 8px Updated
                                    ft.Dropdown(
                                        value=self.config.get("mt_target_lang", "fr"),
                                        width=400, # Keep width or make relative
                                        options=[
                                            ft.dropdown.Option("en", "English"),
                                            ft.dropdown.Option("fr", "French"),
                                            ft.dropdown.Option("de", "German"),
                                            ft.dropdown.Option("es", "Spanish"),
                                            ft.dropdown.Option("it", "Italian"),
                                            ft.dropdown.Option("ja", "Japanese"),
                                            ft.dropdown.Option("ko", "Korean"),
                                            ft.dropdown.Option("pt", "Portuguese"),
                                            ft.dropdown.Option("ru", "Russian"),
                                            ft.dropdown.Option("zh", "Chinese"),
                                        ],
                                        text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added
                                        on_change=lambda e: self.handle_setting_change(e, "mt_target_lang"),
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                ],
                spacing=self.app.spacing["xs"], # Updated
                scroll=ft.ScrollMode.AUTO, # Keep scroll
            ),
            padding=padding.all(self.app.spacing["s"]), # Updated
        )

    def _create_accessibility_tab(self) -> Container:
        return Container(
            content=Column(
                controls=[
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Visual Accessibility",
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[4],
                                    ),
                                    Text(
                                        "Configure appearance settings for better visibility",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    Checkbox(
                                        value=self.config.get("high_contrast", False),
                                        label="High Contrast Mode",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "high_contrast"),
                                    ),
                                    
                                    Checkbox(
                                        value=self.config.get("large_text", False),
                                        label="Large Text",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "large_text"),
                                    ),
                                    
                                    Text(
                                        "Font Size Scaling",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        weight="bold", # Keep weight
                                    ),
                                    Container(height=self.app.spacing["xs"]), # 8px Updated
                                    Row(
                                        controls=[
                                            Icon(Icons.FORMAT_SIZE, size=self.app.TEXT_SIZE_LARGE), # Updated
                                            Slider(
                                                min=1.0,
                                                max=2.0,
                                                divisions=10,
                                                value=self.config.get("font_size_scale", 1.0),
                                                label="{value}x", # Label style for slider is default
                                                width=350, # Keep width or make relative
                                                on_change=lambda e: self.handle_setting_change(e, "font_size_scale"),
                                            ),
                                        ],
                                        spacing=self.app.spacing["s"], # Updated
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                    
                    Container(height=self.app.spacing["m"]), # 16px Updated
                    
                    # Interaction settings
                    Card(
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Interaction Settings", 
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.tab_colors[4],
                                    ),
                                    Text(
                                        "Configure how you interact with the application",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"],
                                    ),
                                    Container(height=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                                    
                                    Checkbox(
                                        value=self.config.get("enable_keyboard_nav", True),
                                        label="Enable Keyboard Navigation",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "enable_keyboard_nav"),
                                    ),
                                    
                                    Checkbox(
                                        value=self.config.get("focus_highlight", True),
                                        label="Show Focus Highlights",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "focus_highlight"),
                                    ),
                                    
                                    Checkbox(
                                        value=self.config.get("reduce_animations", False),
                                        label="Reduce Animations",
                                        label_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Standardize label
                                        on_change=lambda e: self.handle_setting_change(e, "reduce_animations"),
                                    ),
                                ],
                                spacing=self.app.spacing["s"], # Updated
                            ),
                            padding=self.app.BASE_UNIT * 5, # 20px Updated
                            border_radius=BorderRadius.all(self.app.spacing["xs"]), # Updated
                        ),
                        elevation=0, # Keep elevation
                        color=self.colors["bg"]["secondary"], # Keep color
                    ),
                ],
                spacing=self.app.spacing["xs"], # Updated
                scroll=ft.ScrollMode.AUTO, # Keep scroll
            ),
            padding=padding.all(self.app.spacing["s"]), # Updated
        )

    def open_dialog(self, e):
        """Open dialog with animation"""
        # First set opacity to 0 for fade-in
        self.dialog.content.opacity = 0
        self.dialog.open = True
        self.page.update()
        
        # Then animate to full opacity
        def fade_in():
            self.dialog.content.opacity = 1
            self.page.update()
        
        # Short delay then fade in
        import threading
        threading.Timer(0.1, fade_in).start()

    def close_dialog(self, e):
        """Close dialog with animation"""
        # Prevent duplicate calls if dialog is already closed
        if not self.dialog.open:
            return
        self.dialog.content.opacity = 0
        self.page.update()
        
        # Close after animation completes
        def actual_close():
            self.dialog.open = False
            self.page.update()
        
        # Short delay then close
        import threading
        threading.Timer(0.3, actual_close).start()

    def switch_to_tab(self, index):
        """Switch to a specific settings tab with animation"""
        if index == self.current_tab:
            return
            
        # Store the new tab index
        old_tab = self.current_tab
        self.current_tab = index
        
        # Update the progress bar
        self.progress_bar.value = (index + 1) / len(self.tabs_content)
        self.progress_bar.color = self.tab_colors[index]
        
        # Fade out current content
        self.content_container.opacity = 0
        
        # Update tab buttons
        for i, button in enumerate(self.settings_tabs.controls):
            is_selected = i == index
            button.scale = 1.1 if is_selected else 1.0
            button.bgcolor = ft.colors.with_opacity(
                0.1 if is_selected else 0.05, 
                self.tab_colors[i] if is_selected else self.colors["text"]["secondary"]
            )
            button.content.icon_color = self.tab_colors[i] if is_selected else self.colors["text"]["secondary"]
            button.content.icon_size = 24 if is_selected else 20
            button.shadow = BoxShadow(
                spread_radius=0,
                blur_radius=8 if is_selected else 0,
                color=ft.colors.with_opacity(0.2, self.tab_colors[i] if is_selected else "#000000"),
                offset=Offset(0, 2),
            )
        
        # Update header with new tab info
        header = self.dialog.content.content.controls[0]
        icon_container = header.content.controls[0]
        icon_container.content.name = self._get_tab_icon(index)
        icon_container.content.color = self.tab_colors[index]
        icon_container.bgcolor = ft.colors.with_opacity(0.1, self.tab_colors[index])
        header.content.controls[1].value = self._get_tab_title(index)
        
        # Update the page to show changes
        self.page.update()
        
        # After a short delay, switch the content and fade back in
        def update_content():
            self.content_container.content = self.tabs_content[index]
            self.content_container.opacity = 1
            self.page.update()
            
        import threading
        threading.Timer(0.15, update_content).start()

    def next_tab(self, e=None):
        """Go to the next tab"""
        if self.current_tab < len(self.tabs_content) - 1:
            self.switch_to_tab(self.current_tab + 1)
            
    def previous_tab(self, e=None):
        """Go to the previous tab"""
        if self.current_tab > 0:
            self.switch_to_tab(self.current_tab - 1)

    def reset_settings(self, e):
        """Reset settings to defaults using ConfigManager"""
        # Reset config using ConfigManager
        self.config.update(ConfigManager.reset())
        
        # Update app reference config too
        self.app.config = self.config
        
        # Apply theme changes
        self.app.current_theme = self.config["theme"]
        self.app.update_theme_colors()
        
        # Show success message
        self.app.show_snackbar("Settings reset to defaults")
        
        # Close and reopen to refresh UI
        self.dialog.open = False
        self.page.update()
        
        # Reopen after brief delay
        import threading
        threading.Timer(0.5, lambda: self.open_dialog(None)).start()

    def handle_theme_change(self, e):
        self.app.handle_theme_change(e)
        
    def quick_theme_change(self, theme_name):
        """Quick theme change from the theme buttons"""
        class MockEvent:
            def __init__(self, value):
                self.control = type('obj', (object,), {'value': value})
        
        self.app.handle_theme_change(MockEvent(theme_name))
        
        # Update the button states
        self.switch_to_tab(self.current_tab)

    def handle_mt_enabled_change(self, e):
        """Handle machine translation toggle with validation"""
        # Keep this specialized handler for MT validation
        self.config["mt_enabled"] = e.control.value
        
        # Validate MT settings
        errors = ConfigManager.validate_required_fields(self.config)
        if "mt_api_key" in errors and self.config["mt_enabled"]:
            self.app.show_snackbar(errors["mt_api_key"])
            
        ConfigManager.save(self.config)
        self.page.update()

    def handle_setting_change(self, e, setting_name):
        """Generic handler for updating any setting in the config"""
        self.config[setting_name] = e.control.value
        ConfigManager.save(self.config)
        
        # Apply changes that require immediate UI updates
        if setting_name in ["high_contrast", "large_text", "reduce_animations"]:
            if hasattr(self.app, "update_all_text_sizes"):
                self.app.update_all_text_sizes()
            if hasattr(self.app, "update_theme_colors"):
                self.app.update_theme_colors()
        
        # Special handling for font_size_scale to avoid errors
        if setting_name == "font_size_scale":
            # Just save the setting but don't call update_all_text_sizes
            # App will use this value next time it needs to update text sizes
            pass
        
        if setting_name == "enable_keyboard_nav" and hasattr(self.app, "update_keyboard_navigation"):
            self.app.update_keyboard_navigation()
            
        self.page.update()

    def handle_ignore_patterns_change(self, e):
        """Handle changes to ignore patterns text field"""
        # Keep this specialized handler for pattern processing
        patterns = [p.strip() for p in e.control.value.split(",") if p.strip()]
        self.config["ignore_patterns"] = patterns
        ConfigManager.save(self.config)
        self.page.update()
