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
        self.app = app_reference # app_reference.COLORS is the M3 theme
        self.config = config
        self.colors = colors # This component's copy, will be updated by update_colors
        self.current_tab = 0
        
        # Define M3 roles for tab emphasis (can be adjusted)
        # Instead of hardcoded hex, use roles from the theme.
        # We'll use primary for current, secondary/tertiary for others if needed,
        # but M3 usually emphasizes selected tab with primary color and shape/indicator.
        # For now, the active tab will use 'primary', inactive 'onSurfaceVariant'.
        
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
            spacing=16,
            height=80,
        )
        
        # Create progress bar that shows position like onboarding
        self.progress_bar = ProgressBar(
            width=450,
            value=0.2,  # Will be updated based on tab
            bgcolor=ft.colors.with_opacity(0.2, self.colors.get("primaryContainer")), # M3 role
            color=self.colors.get("primary"), # M3 role for active part
            height=4,
            border_radius=BorderRadius(2, 2, 2, 2), # M3 progress indicators are often rounded
        )
        
        # Prepare main content container that will be dynamically updated
        self.content_container = Container(
            content=self.tabs_content[0],
            animate=Animation(300, AnimationCurve.EASE_IN_OUT),
            opacity=1,
        )
        
        # Create main dialog with onboarding-inspired styling
        self.dialog = ft.AlertDialog(
            # bgcolor for AlertDialog itself is usually not set, content provides background
            modal=True, # M3 dialogs are modal
            shape=RoundedRectangleBorder(radius=28), # M3 dialogs have large radius
            title_padding=padding.all(24), # M3 title padding
            content_padding=padding.symmetric(horizontal=24), # M3 content padding
            actions_padding=padding.all(24), # M3 actions padding
            content=Container( # This container will get the M3 surface color
                content=Column(
                    controls=[
                        self._create_header(),
                        Container(
                            content=Column([
                                self.settings_tabs,
                                self.progress_bar,
                            ]),
                            margin=padding.only(bottom=16), # Space before content
                        ),
                        Column( # This is self.content_container wrapper
                            controls=[self.content_container], # self.content_container holds the actual tab content
                            scroll=ft.ScrollMode.AUTO, # Scrolling for tab content
                            height=300, # Adjusted height, consider dynamic sizing
                            expand=False, # Let content define height if possible, or use fixed
                        ),
                        self._create_footer(),
                    ],
                    spacing=0, # Let containers manage their own padding/margin
                    tight=True,
                ),
                width=500, # Adjusted width
                bgcolor=self.colors.get("surfaceContainerHigh"), # M3 dialog background
                border_radius=BorderRadius(28,28,28,28), # Match dialog shape
                # No gradient or shadow here, AlertDialog provides elevation
            ),
            actions=[], # Actions are in the footer for this design
            actions_alignment="end",
            open=False,
            on_dismiss=lambda e: self.close_dialog(e)
        )

    def update_colors(self, colors: dict):
        """Update the component's colors based on the current M3 theme."""
        self.colors = colors # Update the component's color map
        
        # Update main dialog container background
        if isinstance(self.dialog.content, Container):
            self.dialog.content.bgcolor = self.colors.get("surfaceContainerHigh")

        # Update progress bar colors
        self.progress_bar.bgcolor = ft.colors.with_opacity(0.2, self.colors.get("primaryContainer"))
        self.progress_bar.color = self.colors.get("primary") # Active color
        
        # Update header (tab icon, title, close button)
        header_row = self.dialog.content.content.controls[0].content # This is the Row in _create_header
        
        # Header Tab Icon Container
        header_icon_container = header_row.controls[0]
        if isinstance(header_icon_container, Container):
             header_icon_container.content.color = self.colors.get("primary") # Active tab icon color
             header_icon_container.bgcolor = ft.colors.with_opacity(0.1, self.colors.get("primary"))

        # Header Title Text
        header_title_text = header_row.controls[1]
        if isinstance(header_title_text, Text):
            header_title_text.color = self.colors.get("onSurface")

        # Header Close Button
        header_close_button = header_row.controls[2]
        if isinstance(header_close_button, IconButton):
            header_close_button.icon_color = self.colors.get("onSurfaceVariant")

        # Update tab buttons (selected/unselected states)
        for i, button_container in enumerate(self.settings_tabs.controls):
            is_current = (i == self.current_tab)
            icon_button = button_container.content
            if isinstance(icon_button, IconButton):
                icon_button.icon_color = self.colors.get("primary") if is_current else self.colors.get("onSurfaceVariant")
            button_container.bgcolor = self.colors.get("primaryContainer") if is_current else self.colors.get("surfaceContainerLowest") # Example M3 selection
            # Update shadow or border if used for selection indication
            button_container.shadow = BoxShadow(
                spread_radius=0,
                blur_radius=8 if is_current else 0,
                color=ft.colors.with_opacity(0.2, self.colors.get("primary") if is_current else self.colors.get("shadow")),
                offset=Offset(0, 2),
            ) if is_current else None


        # Update all text colors and card backgrounds in content tabs
        for tab_content_container in self.tabs_content: # self.tabs_content holds Containers
            self._update_tab_colors(tab_content_container) # Pass the actual tab content
            
        # Update the footer buttons
        footer_row = self.dialog.content.content.controls[3] # This is the Row from _create_footer
        if isinstance(footer_row, Row):
            # "Reset to Default" TextButton
            reset_button = footer_row.controls[0]
            if isinstance(reset_button, TextButton):
                reset_button.style = ButtonStyle(color=self.colors.get("error")) # M3 error color for reset

            # "Previous" and "Next" TextButtons container
            nav_buttons_row = footer_row.controls[1]
            if isinstance(nav_buttons_row, Row):
                prev_button = nav_buttons_row.controls[0] # TextButton
                next_button_container = nav_buttons_row.controls[1] # Container holding TextButton

                if isinstance(prev_button, TextButton):
                     prev_button.style = ButtonStyle(color=self.colors.get("onSurfaceVariant"))
                     if prev_button.content and isinstance(prev_button.content, Row) and prev_button.content.controls:
                         prev_button.content.controls[0].color = self.colors.get("onSurfaceVariant") # Icon
                         prev_button.content.controls[1].color = self.colors.get("onSurfaceVariant") # Text

                if isinstance(next_button_container, Container) and isinstance(next_button_container.content, TextButton):
                    next_button = next_button_container.content
                    next_button.style = ButtonStyle(color=self.colors.get("primary")) # M3 primary for Next
                    if next_button.content and isinstance(next_button.content, Row) and next_button.content.controls:
                         next_button.content.controls[0].color = self.colors.get("primary") # Text
                         next_button.content.controls[1].color = self.colors.get("primary") # Icon

        # If dialog is open, update it.
        if self.dialog.open:
            self.page.update()


    def _update_tab_colors(self, tab_container: Container):
        """Helper method to update colors in a tab's content (Cards, Text, etc.)."""
        if not (tab_container and hasattr(tab_container, "content") and isinstance(tab_container.content, Column)):
            return

        for control in tab_container.content.controls: # These are usually Cards
            if isinstance(control, Card):
                control.color = self.colors.get("surfaceContainer") # M3 Card background
                if hasattr(control, "content") and isinstance(control.content, Container) and \
                   hasattr(control.content, "content") and isinstance(control.content.content, Column):

                    card_column = control.content.content
                    for item in card_column.controls:
                        if isinstance(item, Text):
                            # Heuristic for titles vs descriptions (improve if more specific types are used)
                            if item.weight == "bold" or item.size == 18: # Section Title
                                item.color = self.colors.get("primary") # M3 Primary for titles in cards
                            elif item.size == 14 and not item.weight: # Section Description
                                item.color = self.colors.get("onSurfaceVariant")
                            elif item.size == 12 and item.italic: # Hint/Meta text
                                item.color = self.colors.get("onSurfaceVariant")
                            else: # Other text (like labels for controls)
                                item.color = self.colors.get("onSurface")
                        elif isinstance(item, Checkbox):
                            item.fill_color = self.colors.get("primary")
                            item.check_color = self.colors.get("onPrimary")
                            if item.label_style: item.label_style.color = self.colors.get("onSurface")
                            else: item.label_style = TextStyle(color=self.colors.get("onSurface"))
                        elif isinstance(item, Slider):
                            item.active_color = self.colors.get("primary")
                            item.inactive_color = self.colors.get("surfaceVariant")
                        elif isinstance(item, ft.Dropdown):
                            # Flet Dropdown styling is limited. Apply to container if wrapped.
                            # For now, assume default Flet dropdown picks up page theme.
                            pass
                        elif isinstance(item, TextField):
                            item.text_style.color = self.colors.get("onSurface")
                            item.hint_style.color = self.colors.get("onSurfaceVariant")
                            item.border_color = self.colors.get("outline")
                            item.focused_border_color = self.colors.get("primary")
                            item.bgcolor = self.colors.get("surfaceContainerLowest") # Slightly different for fields on card
                        elif isinstance(item, Row): # For rows containing labels and controls
                             for row_item in item.controls:
                                 if isinstance(row_item, Text) and (row_item.weight == "bold" or "Language" in row_item.value): # Label in a row
                                     row_item.color = self.colors.get("onSurface")
                                 # Add styling for other controls in rows if necessary

    def _create_header(self):
        """Create animated header with active tab info and close button"""
        return Container(
            content=Row(
                controls=[
                    # Tab icon in colored circle
                    Container(
                        content=Icon( # Active Tab Icon
                            self._get_tab_icon(0), # Initial tab
                            size=24, # M3 standard icon size
                            color=self.colors.get("primary") # Active color
                        ),
                        padding=padding.all(8),
                        border_radius=BorderRadius(12,12,12,12), # Rounded
                        bgcolor=ft.colors.with_opacity(0.1, self.colors.get("primary")), # Subtle background
                    ),
                    Text( # Tab Title Text
                        self._get_tab_title(0), # Initial tab
                        size=20, # M3 Dialog Title
                        weight=FontWeight.NORMAL, # M3 Dialog titles are not always bold
                        color=self.colors.get("onSurface") # M3 color for titles
                    ),
                    IconButton( # Close Button
                        icon=Icons.CLOSE,
                        icon_color=self.colors.get("onSurfaceVariant"), # M3 for less prominent icons
                        tooltip="Close Settings",
                        on_click=self.close_dialog,
                    ),
                ],
                alignment="spaceBetween",
                vertical_alignment="center",
            ),
            margin=padding.only(bottom=10),
            animate=Animation(300, AnimationCurve.EASE_IN_OUT),
        )

    def _create_footer(self):
        """Create footer with action buttons"""
        return Row(
            controls=[
                TextButton(
                    "Reset to Default", # M3 TextButton
                    on_click=self.reset_settings,
                    style=ft.ButtonStyle(color=self.colors.get("error")) # Error color for destructive
                ),
                Row( # Container for Previous/Next
                    controls=[
                        TextButton( # Previous Button
                            content=Row(
                                controls=[
                                    Icon(Icons.ARROW_BACK, size=18, color=self.colors.get("onSurfaceVariant")),
                                    Text("Previous", size=14, color=self.colors.get("onSurfaceVariant")),
                                ],
                                spacing=4, tight=True
                            ),
                            on_click=self.previous_tab,
                            # style will be set by update_colors or use default TextButton M3 style
                        ),
                        TextButton( # Next Button
                            content=Row(
                                controls=[
                                    Text("Next", size=14, color=self.colors.get("primary")),
                                    Icon(Icons.ARROW_FORWARD, size=18, color=self.colors.get("primary")),
                                ],
                                spacing=4, tight=True
                            ),
                            on_click=self.next_tab,
                            # style will be set by update_colors or use default TextButton M3 style
                        ),
                    ],
                    spacing=8 # M3 spacing between buttons
                ),
            ],
            alignment="spaceBetween", # Pushes Reset left, Nav buttons right
        )

    def _create_tab_button(self, index):
        """Create an individual M3-style tab button."""
        is_current = index == self.current_tab
        
        # M3 uses primary color for selected tab icon and text, onSurfaceVariant for unselected.
        # Background is often higher surface elevation or primaryContainer for selected.
        icon_color = self.colors.get("primary") if is_current else self.colors.get("onSurfaceVariant")
        button_bgcolor = self.colors.get("primaryContainer") if is_current else self.colors.get("surfaceContainerLowest")
        icon_size = 24 # M3 standard size

        return Container(
            content=IconButton(
                icon=self._get_tab_icon(index),
                icon_color=icon_color,
                icon_size=icon_size,
                on_click=lambda e, i=index: self.switch_to_tab(i),
                tooltip=self._get_tab_title(index),
                style=ButtonStyle(shape=RoundedRectangleBorder(radius=12)), # Rounded shape for icon button
            ),
            border_radius=BorderRadius(12,12,12,12), # Pill shape or rounded rect
            bgcolor=button_bgcolor,
            width=56, # M3 typical touch target size
            height=56,
            animate=Animation(200, AnimationCurve.EASE_OUT), # Faster, M3 like animation
            padding=0, # IconButton itself has padding
            # M3 selection indicator is often a colored underline or different background/shape.
            # Here, bgcolor change and icon color change serve as indicators.
            # Shadow can be subtle for selected if desired:
            shadow=BoxShadow(
                 spread_radius=1, blur_radius=3, color=ft.colors.with_opacity(0.1, self.colors.get("shadow"))
            ) if is_current else None,
            scale=ft.transform.Scale(scale=1.05) if is_current else ft.transform.Scale(scale=1.0), # Slight scale for selection
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
                                        size=18, 
                                        weight=FontWeight.MEDIUM, # M3 Title Medium
                                        color=self.colors.get("primary"), # Use primary for section titles
                                    ),
                                    Text( # Description
                                        "Choose your preferred theme and visual settings.",
                                        size=14, # M3 Body Medium
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16), # M3 spacing
                                    # Theme selection buttons (simplified for M3)
                                    Row([
                                        self._create_theme_button("dark", Icons.DARK_MODE_OUTLINED, "Dark"),
                                        self._create_theme_button("light", Icons.LIGHT_MODE_OUTLINED, "Light"),
                                        self._create_theme_button("system", Icons.SETTINGS_SUGGEST_OUTLINED, "System"),
                                        self._create_theme_button("amoled", Icons.SMARTPHONE_OUTLINED, "AMOLED"),
                                    ], 
                                    alignment="spaceEvenly", spacing=8), # M3 spacing
                                    Container(height=16),
                                ],
                                spacing=8, # M3 spacing
                            ),
                            padding=16, # M3 padding
                            border_radius=BorderRadius(12,12,12,12), # M3 Card radius
                        ),
                        elevation=1, # M3 Cards have subtle elevation
                        color=self.colors.get("surfaceContainer"), # M3 Card background
                    ),
                    Container(height=16), # M3 spacing
                    Card( # User Interface Card
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Interface Behavior", 
                                        size=16,
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Configure how the application responds to your actions.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    Row( # Animation Speed Label
                                        controls=[
                                            Text(
                                                "Animation Speed:", # Label for slider
                                                size=14,
                                                color=self.colors.get("onSurface"),
                                            ),
                                        ], alignment="start"
                                    ),
                                    # Container(height=4), # Reduced spacing
                                    Row( # Slider for Animation Speed
                                        controls=[
                                            Icon(Icons.SPEED_OUTLINED, size=20, color=self.colors.get("onSurfaceVariant")),
                                            Slider(
                                                min=0, max=1000, divisions=10,
                                                value=self.config.get("animation_speed", 300),
                                                label="{value}ms",
                                                width=300, # Adjusted width
                                                active_color=self.colors.get("primary"),
                                                inactive_color=self.colors.get("surfaceVariant"),
                                                on_change=lambda e: self.handle_setting_change(e, "animation_speed"),
                                            ),
                                        ], spacing=8, vertical_alignment="center"
                                    ),
                                    # Container(height=8), # Reduced spacing
                                    Checkbox( # Confirm actions checkbox
                                        value=self.config.get("confirm_actions", True),
                                        label="Confirm destructive actions",
                                        fill_color=self.colors.get("primary"),
                                        check_color=self.colors.get("onPrimary"),
                                        label_style=TextStyle(color=self.colors.get("onSurface")),
                                        on_change=lambda e: self.handle_setting_change(e, "confirm_actions"),
                                    ),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                ],
                spacing=16, # M3 spacing between cards
                scroll=ft.ScrollMode.AUTO,
            ),
            padding=padding.all(10),
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
                                        size=18, 
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Configure how files are compared and displayed.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    self._create_settings_checkbox("show_preview", "Show File Preview", self.app.handle_preview_toggle),
                                    self._create_settings_checkbox("show_line_numbers", "Show Line Numbers"),
                                    self._create_settings_checkbox("auto_fill_missing", "Auto-Fill Missing Keys"),
                                    self._create_settings_checkbox("log_missing_strings", "Log Missing Strings"),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                    Container(height=16),
                    Card( # Advanced comparison options
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Advanced Comparison", 
                                        size=16,
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Configure detailed comparison behavior.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    self._create_settings_checkbox("ignore_whitespace", "Ignore Whitespace"),
                                    self._create_settings_checkbox("ignore_case", "Ignore Case"),
                                    self._create_settings_checkbox("group_by_namespace", "Group by Namespace"),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                ],
                spacing=16,
                scroll=ft.ScrollMode.AUTO,
            ),
            padding=padding.all(10),
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
                                        size=18, 
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Choose your preferred file format settings.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    Text("Default Format:", size=14, color=self.colors.get("onSurface")), # Label for dropdown
                                    # Container(height=4),
                                    ft.Dropdown( # M3 Dropdown/Menu style
                                        value=self.config.get("preferred_format", "auto"),
                                        # width=400, # Use expand or wrap in a Row for sizing
                                        options=[
                                            ft.dropdown.Option(key, text) for key, text in [
                                                ("auto", "Auto-Detect"), ("json", "JSON"), ("yaml", "YAML"),
                                                ("lang", ".lang"), ("xml", "XML"), ("properties", "Properties"),
                                                ("csv", "CSV"), ("resx", "RESX")
                                            ]
                                        ],
                                        on_change=lambda e: self.handle_setting_change(e, "preferred_format"),
                                        bgcolor=self.colors.get("surfaceContainerHighest"),
                                        border_color=self.colors.get("outline"),
                                        focused_border_color=self.colors.get("primary"),
                                        border_radius=8,
                                        content_padding=padding.symmetric(horizontal=12,vertical=8),
                                        text_style=TextStyle(color=self.colors.get("onSurface")),
                                        # TODO: Dropdown item styling if possible
                                    ),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                    Container(height=16),
                    Card( # Ignore patterns section
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Ignore Patterns", 
                                        size=16,
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Specify patterns to ignore when comparing files.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    TextField( # M3 TextField for ignore patterns
                                        value=",".join(self.config.get("ignore_patterns", [])),
                                        hint_text="Enter comma-separated patterns...",
                                        on_change=self.handle_ignore_patterns_change,
                                        multiline=True, min_lines=3, max_lines=5,
                                        text_style=TextStyle(color=self.colors.get("onSurface")),
                                        hint_style=TextStyle(color=self.colors.get("onSurfaceVariant")),
                                        border_color=self.colors.get("outline"),
                                        focused_border_color=self.colors.get("primary"),
                                        border_radius=8,
                                        bgcolor=self.colors.get("surfaceContainerLowest"),
                                        expand=True,
                                    ),
                                    # Container(height=8),
                                    Text(
                                        "Each pattern filters keys containing that pattern.",
                                        size=12,
                                        color=self.colors.get("onSurfaceVariant"),
                                        italic=True,
                                    ),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                ],
                spacing=16,
                scroll=ft.ScrollMode.AUTO,
            ),
            padding=padding.all(10),
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
                                        size=18, 
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Configure settings for automatic translation of missing strings.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    self._create_settings_checkbox("mt_enabled", "Enable Machine Translation", self.handle_mt_enabled_change),
                                    Text("Google Cloud API Key:", size=14, color=self.colors.get("onSurface")),
                                    TextField(
                                        value=self.config.get("mt_api_key", ""),
                                        password=True, can_reveal_password=True,
                                        hint_text="Enter your Google Cloud API key",
                                        on_change=lambda e: self.handle_setting_change(e, "mt_api_key"),
                                        text_style=TextStyle(color=self.colors.get("onSurface")),
                                        hint_style=TextStyle(color=self.colors.get("onSurfaceVariant")),
                                        border_color=self.colors.get("outline"),
                                        focused_border_color=self.colors.get("primary"),
                                        border_radius=8,
                                        bgcolor=self.colors.get("surfaceContainerLowest"),
                                    ),
                                    # Container(height=4),
                                    Text(
                                        "Billing must be enabled in Google Cloud for this feature.",
                                        size=12, color=self.colors.get("onSurfaceVariant"), italic=True,
                                    ),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                    Container(height=16),
                    Card( # Language settings
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Language Settings", 
                                        size=16,
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Set default languages for translation.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    Text("Source Language:", size=14, color=self.colors.get("onSurface")),
                                    self._create_language_dropdown("mt_source_lang", self.config.get("mt_source_lang", "en")),
                                    Container(height=8),
                                    Text("Target Language:", size=14, color=self.colors.get("onSurface")),
                                    self._create_language_dropdown("mt_target_lang", self.config.get("mt_target_lang", "fr")),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                ],
                spacing=16,
                scroll=ft.ScrollMode.AUTO,
            ),
            padding=padding.all(10),
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
                                        size=18, 
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Configure appearance settings for better visibility.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    self._create_settings_checkbox("high_contrast", "High Contrast Mode"), # This might require specific theme updates
                                    self._create_settings_checkbox("large_text", "Large Text"), # This would affect font sizes globally
                                    Text("Font Size Scaling:", size=14, color=self.colors.get("onSurface")),
                                    Row(
                                        controls=[
                                            Icon(Icons.FORMAT_SIZE_OUTLINED, size=20, color=self.colors.get("onSurfaceVariant")),
                                            Slider(
                                                min=1.0, max=2.0, divisions=10,
                                                value=self.config.get("font_size_scale", 1.0),
                                                label="{value}x", width=300,
                                                active_color=self.colors.get("primary"),
                                                inactive_color=self.colors.get("surfaceVariant"),
                                                on_change=lambda e: self.handle_setting_change(e, "font_size_scale"),
                                            ),
                                        ], spacing=8, vertical_alignment="center"
                                    ),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                    Container(height=16),
                    Card( # Interaction settings
                        content=Container(
                            content=Column(
                                controls=[
                                    Text(
                                        "Interaction Settings", 
                                        size=16,
                                        weight=FontWeight.MEDIUM,
                                        color=self.colors.get("primary"),
                                    ),
                                    Text(
                                        "Configure how you interact with the application.",
                                        size=14,
                                        color=self.colors.get("onSurfaceVariant"),
                                    ),
                                    Container(height=16),
                                    self._create_settings_checkbox("enable_keyboard_nav", "Enable Keyboard Navigation"),
                                    self._create_settings_checkbox("focus_highlight", "Show Focus Highlights"), # Requires Flet support for focus styling
                                    self._create_settings_checkbox("reduce_animations", "Reduce Animations"),
                                ], spacing=8
                            ),
                            padding=16,
                            border_radius=BorderRadius(12,12,12,12),
                        ),
                        elevation=1,
                        color=self.colors.get("surfaceContainer"),
                    ),
                ],
                spacing=16,
                scroll=ft.ScrollMode.AUTO,
            ),
            padding=padding.all(10),
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
        for i, button_container in enumerate(self.settings_tabs.controls): # button is a Container
            is_selected = (i == index)
            icon_button = button_container.content
            if isinstance(icon_button, IconButton):
                 icon_button.icon_color = self.colors.get("primary") if is_selected else self.colors.get("onSurfaceVariant")
            button_container.bgcolor = self.colors.get("primaryContainer") if is_selected else self.colors.get("surfaceContainerLowest")
            button_container.scale = ft.transform.Scale(scale=1.05) if is_selected else ft.transform.Scale(scale=1.0)
            button_container.shadow = BoxShadow(
                spread_radius=1, blur_radius=3, color=ft.colors.with_opacity(0.1, self.colors.get("shadow"))
            ) if is_selected else None

        # Update header with new tab info (icon and title)
        header_row = self.dialog.content.content.controls[0].content # This is the Row in _create_header
        header_icon_container = header_row.controls[0]
        if isinstance(header_icon_container, Container):
            header_icon_container.content.name = self._get_tab_icon(index) # Update icon name
            header_icon_container.content.color = self.colors.get("primary") # Active color for icon
            header_icon_container.bgcolor = ft.colors.with_opacity(0.1, self.colors.get("primary")) # Subtle bg for icon

        header_title_text = header_row.controls[1]
        if isinstance(header_title_text, Text):
            header_title_text.value = self._get_tab_title(index) # Update title text
            # Color for title already set in update_colors
        
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
        """Reset settings to defaults using ConfigManager and refresh UI with M3."""
        # Use ConfigManager's method to get default config to avoid issues with mutable defaults
        default_config = ConfigManager.get_default_config()
        self.config.clear()
        self.config.update(default_config)

        self.app.config = self.config # Update app's main config reference

        # Critical: Apply theme changes based on reset config
        self.app.current_theme_name = self.config.get("theme", "system") # Update app's theme name
        self.app.update_theme_colors() # This will apply M3 to the main app and its components
        self.update_colors(self.app.COLORS) # Update this dialog with the new M3 colors

        # Rebuild tabs content as settings values (and therefore control states/styles) have changed
        self._rebuild_and_switch_to_tab(self.current_tab) # Rebuilds tabs and switches

        self.app.show_snackbar("Settings reset to defaults.")
        
        # Dialog should remain open and reflect changes.
        if self.dialog.open: # Ensure page updates if dialog is open
             self.page.update()


    def handle_theme_change(self, e): # This method is called by App, not directly by user interaction here
        # This method is likely called by the main App when a theme change occurs elsewhere,
        # or if there was a dropdown for themes directly in settings (which was removed for buttons).
        # Its main job is to ensure this dialog reflects the new theme from the app.
        self.update_colors(self.app.COLORS)
        self._rebuild_and_switch_to_tab(self.current_tab)
        
    def quick_theme_change(self, theme_name):
        """Quick theme change from the theme buttons, ensuring dialog UI updates."""
        class MockEvent: # Mock Flet event object
            def __init__(self, value):
                self.control = type('obj', (object,), {'value': value}) # Simulate flet event structure

        # Call the app's theme change handler. This is expected to update self.app.COLORS
        self.app.handle_theme_change(MockEvent(theme_name))
        
        # Now, specifically update this dialog component with the new colors from the app
        self.update_colors(self.app.COLORS)
        
        # Re-render the current tab's content. This also updates theme button states.
        self._rebuild_and_switch_to_tab(self.current_tab)

    def _rebuild_and_switch_to_tab(self, index):
        """Rebuilds tab content (if necessary) and switches view, updating styles."""
        # Rebuild all tabs to ensure they pick up new theme for controls & settings values
        self.tabs_content = [
            self._create_general_tab(),
            self._create_comparison_tab(),
            self._create_file_format_tab(),
            self._create_translation_tab(),
            self._create_accessibility_tab()
        ]
        # Then switch, which will use the newly created tab content and update tab header styles
        self.switch_to_tab(index)

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
        # Avoid unnecessary processing if value hasn't changed (esp. for sliders)
        current_value = self.config.get(setting_name)
        new_value = e.control.value

        if current_value == new_value and setting_name not in ["font_size_scale"]: # Allow slider to re-trigger for visual feedback if needed
             # For most controls, if value is same, skip. Slider might be an exception if live update is desired.
            if not isinstance(e.control, ft.Slider): # Sliders might trigger change even if value is programmatically same
                 return

        self.config[setting_name] = new_value
        ConfigManager.save(self.config)
        
        # Apply changes that require immediate UI updates or app-level changes
        if setting_name in ["high_contrast", "large_text", "reduce_animations", "font_size_scale"]:
            # These settings might require a broader UI refresh.
            # The app's theme/accessibility update should handle main UI.
            if hasattr(self.app, "update_ui_for_accessibility_and_theme"):
                self.app.update_ui_for_accessibility_and_theme()
            elif hasattr(self.app, "update_theme_colors"): # Fallback
                self.app.update_theme_colors()
            
            self.update_colors(self.app.COLORS) # Update this dialog's own colors
            self._rebuild_and_switch_to_tab(self.current_tab) # Rebuild current tab to reflect new styles on controls

        elif setting_name == "enable_keyboard_nav" and hasattr(self.app, "update_keyboard_navigation"):
            self.app.update_keyboard_navigation()
            self.page.update() # Update page if only keyboard nav changed
        else:
            # For simple settings that don't require full rebuild, just update the page.
            # Most controls should visually update themselves if their 'value' changed.
            self.page.update()

    def handle_ignore_patterns_change(self, e):
        """Handle changes to ignore patterns text field"""
        # Keep this specialized handler for pattern processing
        patterns = [p.strip() for p in e.control.value.split(",") if p.strip()]
        self.config["ignore_patterns"] = patterns
        ConfigManager.save(self.config)
        self.page.update()
