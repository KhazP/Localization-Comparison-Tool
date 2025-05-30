import flet as ft
from flet import (
    Container, Column, Row, Text, IconButton, ProgressBar,
    TextButton, AlertDialog, Icon, icons, padding, BorderRadius,
    animation, colors, BoxShadow, Offset, LinearGradient, alignment
)
from components.file_input import FileInputComponent
import asyncio
import threading
import time

class OnboardingTutorial:
    """Manages the onboarding tutorial experience for first-time users."""
    
    def __init__(self, page: ft.Page, app_reference):
        self.page = page
        self.app = app_reference # app_reference.COLORS is the M3 theme
        self.current_step = 0
        
        # Define tutorial steps with M3 color mapping (conceptual)
        # Actual colors will come from self.app.COLORS
        self.tutorial_steps_config = [
            {"title": "Welcome!", "content": "This tool helps you compare and analyze translation files.", "icon": icons.WAVING_HAND_OUTLINED, "color_role": "primary"},
            {"title": "Select Files", "content": "Start by selecting your source and target files using the browse buttons.", "icon": icons.FOLDER_OPEN_OUTLINED, "color_role": "secondary"},
            {"title": "Compare Files", "content": "Click the Compare button to analyze differences.", "icon": icons.COMPARE_ARROWS_ROUNDED, "color_role": "tertiary"},
            {"title": "View Results", "content": "Results show missing (+), obsolete (-), and changed (~) entries.", "icon": icons.LIST_ALT_OUTLINED, "color_role": "primary"},
            {"title": "Machine Translation", "content": "Auto-translate missing entries via Settings (Google Cloud).", "icon": icons.TRANSLATE_ROUNDED, "color_role": "secondary"}
        ]
        
        self.dialog = AlertDialog(
            modal=True,
            shape=RoundedRectangleBorder(radius=28), # M3 Dialog shape
            content=Container( # This container defines the dialog's appearance
                content=Column(
                    controls=[
                        self._create_header(), # Will be populated by update_step
                        self._create_content_area(), # Will be populated by update_step
                        self._create_navigation() # Will be populated by update_step
                    ],
                    spacing=16, # M3 spacing between sections
                    tight=True,
                ),
                padding=padding.all(24), # M3 dialog padding
                width=400, # Adjusted width
                border_radius=BorderRadius(28,28,28,28), # Match dialog shape
                # bgcolor will be set in update_colors
            ),
            actions_alignment="spaceBetween", # Skip/Back on left, Next/Finish on right
            open=False
        )
        self.page.overlay.append(self.dialog)
        self.update_colors(self.app.COLORS) # Apply initial M3 colors

    def update_colors(self, colors):
        self.app.COLORS = colors # Ensure app reference is updated if needed, though usually app owns this
        # Update dialog's main container background
        if isinstance(self.dialog.content, Container):
            self.dialog.content.bgcolor = self.app.COLORS.get("surfaceContainerHigh")
        
        # If dialog is open, force re-render of current step with new colors
        if self.dialog.open:
            self.update_step(force_render_controls=True)
        else: # Otherwise, ensure header, content, nav areas are ready for when it opens
             if hasattr(self, 'header_container'): self._update_header_style(self.app.COLORS)
             if hasattr(self, 'content_display_area'): self._update_content_area_style(self.app.COLORS)
             if hasattr(self, 'navigation_controls'): self._update_navigation_style(self.app.COLORS)


    def _get_step_m3_color(self, step_config):
        """Gets the actual M3 theme color based on the role defined in step_config."""
        return self.app.COLORS.get(step_config["color_role"], self.app.COLORS.get("primary"))

    def _create_header(self):
        """Creates the static structure for the tutorial step header."""
        self.header_icon_display = Icon(size=28) # Icon name and color set in update_step
        self.header_title_display = Text(size=22, weight=ft.FontWeight.BOLD) # Value and color set in update_step

        self.header_container = Container(
            content=Row(
                controls=[
                    Container( # Circle background for icon
                        content=self.header_icon_display,
                        padding=padding.all(10),
                        border_radius=BorderRadius(100,100,100,100), # Circular
                        # bgcolor set in update_step
                    ),
                    self.header_title_display,
                ],
                vertical_alignment=ft.CrossAxisAlignment.CENTER,
                spacing=12,
            ),
            padding=padding.only(bottom=8), # M3 spacing
        )
        return self.header_container

    def _update_header_style(self, current_colors, step_config=None):
        if step_config is None: step_config = self.tutorial_steps_config[self.current_step]
        step_m3_color = self._get_step_m3_color(step_config)

        self.header_icon_display.name = step_config["icon"]
        self.header_icon_display.color = step_m3_color
        self.header_title_display.value = step_config["title"]
        self.header_title_display.color = current_colors.get("onSurface")
        
        icon_bg_container = self.header_container.content.controls[0]
        if isinstance(icon_bg_container, Container):
            icon_bg_container.bgcolor = ft.colors.with_opacity(0.15, step_m3_color)


    def _create_content_area(self):
        """Creates the static structure for the tutorial step content."""
        self.content_text_display = Text(size=14, text_align="center", selectable=True) # Value and color set in update_step
        self.content_icon_display = Icon(size=64, opacity=0.9) # Name, color set in update_step

        self.content_display_area = Container(
            content=Column(
                controls=[
                    self.content_text_display,
                    Container( # Illustration container
                        content=self.content_icon_display,
                        alignment=ft.alignment.center,
                        height=100, # M3 illustration area
                        padding=padding.only(top=16)
                    )
                ],
                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                spacing=12, # M3 spacing
            ),
            padding=padding.symmetric(vertical=16), # M3 padding
            animate=animation.Animation(250, ft.AnimationCurve.EASE_IN_OUT) # M3 animation timing
        )
        return self.content_display_area

    def _update_content_area_style(self, current_colors, step_config=None):
        if step_config is None: step_config = self.tutorial_steps_config[self.current_step]
        step_m3_color = self._get_step_m3_color(step_config)

        self.content_text_display.value = step_config["content"]
        self.content_text_display.color = current_colors.get("onSurfaceVariant")
        self.content_icon_display.name = step_config["icon"]
        self.content_icon_display.color = step_m3_color
        
    def _create_navigation(self):
        """Creates the static structure for tutorial navigation."""
        self.step_indicator_row = Row(alignment="center", spacing=6) # Indicators populated in update_step
        self.progress_bar_display = ProgressBar(height=4, border_radius=BorderRadius(2,2,2,2)) # Value/colors in update_step

        self.skip_button = TextButton("Skip Tutorial", on_click=self.end_tutorial)
        self.back_button = TextButton("Back", on_click=self.previous_step, disabled=True)
        self.next_button_content_row = Row(controls=[Text("Next", size=14), Icon(icons.ARROW_FORWARD_IOS_ROUNDED, size=16)], spacing=4, tight=True, vertical_alignment=ft.CrossAxisAlignment.CENTER)
        self.next_button = ft.FilledButton(content=self.next_button_content_row, on_click=self.next_step) # M3 FilledButton

        self.navigation_controls = Column(
            controls=[
                Container(content=self.step_indicator_row, margin=padding.only(bottom=8)),
                self.progress_bar_display,
                Row(
                    controls=[
                        self.skip_button,
                        Row([self.back_button, self.next_button], spacing=8)
                    ],
                    alignment="spaceBetween"
                )
            ],
            spacing=12, # M3 spacing
        )
        return self.navigation_controls

    def _update_navigation_style(self, current_colors, step_config=None):
        if step_config is None: step_config = self.tutorial_steps_config[self.current_step]

        # Step Indicators
        self.step_indicator_row.controls.clear()
        for i in range(len(self.tutorial_steps_config)):
            self.step_indicator_row.controls.append(self._create_step_indicator(i, current_colors))

        # Progress Bar
        self.progress_bar_display.bgcolor = ft.colors.with_opacity(0.2, current_colors.get("primaryContainer"))
        self.progress_bar_display.color = current_colors.get("primary")
        self.progress_bar_display.value = (self.current_step + 1) / len(self.tutorial_steps_config)

        # Buttons
        self.skip_button.style = ButtonStyle(color=current_colors.get("onSurfaceVariant"))
        self.back_button.style = ButtonStyle(color=current_colors.get("onSurfaceVariant"))
        self.back_button.disabled = self.current_step == 0

        # Next/Finish Button
        is_last_step = self.current_step == len(self.tutorial_steps_config) - 1
        self.next_button_content_row.controls[0].value = "Finish" if is_last_step else "Next"
        self.next_button_content_row.controls[1].name = icons.CHECK_ROUNDED if is_last_step else icons.ARROW_FORWARD_IOS_ROUNDED
        self.next_button.on_click = self.end_tutorial if is_last_step else self.next_step
        self.next_button.style = ButtonStyle(bgcolor=current_colors.get("primary"), color=current_colors.get("onPrimary"))
        # Ensure icon and text inside FilledButton also get onPrimary color
        self.next_button_content_row.controls[0].color = current_colors.get("onPrimary")
        self.next_button_content_row.controls[1].color = current_colors.get("onPrimary")


    def _create_step_indicator(self, step_index, current_colors):
        """Creates an individual M3-style step indicator."""
        is_current = step_index == self.current_step
        step_config = self.tutorial_steps_config[step_index]
        indicator_color = self._get_step_m3_color(step_config) if is_current else current_colors.get("surfaceVariant")
        
        return Container(
            width=8 if not is_current else 12, # M3 active indicator can be larger
            height=8 if not is_current else 12,
            border_radius=BorderRadius(6,6,6,6),
            bgcolor=indicator_color,
            tooltip=f"Step {step_index + 1}: {step_config['title']}",
            animate=animation.Animation(200, ft.AnimationCurve.EASE_OUT),
            on_click=lambda e, i=step_index: self._jump_to_step(i)
        )
        
    def _jump_to_step(self, step_index):
        """Jump to a specific step (can only go back or current)."""
        """Jump to a specific step when clicking on an active step indicator."""
        if step_index <= self.current_step:  # Only allow going back or staying on current step
            self.current_step = step_index
            self.update_step()
        
    def update_step(self, force_render_controls=False):
        """Update the tutorial UI for the current step with M3 styling and animations."""
        if not hasattr(self, 'header_container') or force_render_controls: # Ensure controls are created
            # This path might be taken if update_colors is called before start_tutorial
            # or if a theme change happens while tutorial is not open.
            # Re-create parts of the dialog content if they don't exist.
            # This is a bit of a workaround for Flet's declarative nature when styles change.
            self.dialog.content.content.controls[0] = self._create_header()
            self.dialog.content.content.controls[1] = self._create_content_area()
            self.dialog.content.content.controls[2] = self._create_navigation()

        current_colors = self.app.COLORS # Use fresh colors
        step_config = self.tutorial_steps_config[self.current_step]

        self._update_header_style(current_colors, step_config)
        self._update_content_area_style(current_colors, step_config)
        self._update_navigation_style(current_colors, step_config)
        
        # Animate content change
        if hasattr(self, 'content_display_area'):
            self.content_display_area.opacity = 0
            self.page.update()
            self.content_display_area.opacity = 1

        self.dialog.open = True # Ensure dialog is open
        self.page.update()
        
    def next_step(self, e=None):
        """Advance to the next tutorial step."""
        if self.current_step < len(self.tutorial_steps_config) - 1:
            self.current_step += 1
            self.update_step()
        else:
            self.end_tutorial()
            
    def previous_step(self, e=None):
        """Go back to the previous tutorial step."""
        if self.current_step > 0:
            self.current_step -= 1
            self.update_step()
    
    def start_tutorial(self):
        """Begin the tutorial sequence with a fade-in animation."""
        self.current_step = 0
        
        self.current_step = 0
        self.update_colors(self.app.COLORS) # Apply current theme to dialog structure

        # Set initial opacity for fade-in effect
        self.dialog.content.opacity = 0 # Animate the content container
        self.dialog.open = True
        self.page.update() # Render dialog transparently first
        
        def fade_in_and_update_step():
            self.dialog.content.opacity = 1
            self.update_step() # Now populate and style the first step
            self.page.update() # Show content
        
        threading.Timer(0.05, fade_in_and_update_step).start() # Short delay for smoother transition
        
    def end_tutorial(self, e=None):
        """Complete the tutorial with fade-out animation and save progress."""
        self.dialog.content.opacity = 0
        self.page.update()
        
        def cleanup_and_close():
            self.dialog.open = False
            self.app.config["tutorial_completed"] = True # Persist completion
            self.app.save_config() # Save this change
            
            self.page.snack_bar = ft.SnackBar(
                content=Text("Tutorial completed! You can restart it from Settings.",
                             color=self.app.COLORS.get("inverseOnSurface")),
                bgcolor=self.app.COLORS.get("inverseSurface"), # M3 SnackBar colors
                action="OK",
                action_color=self.app.COLORS.get("inversePrimary")
            )
            self.page.snack_bar.open = True
            self.page.update()
        
        threading.Timer(0.3, cleanup_and_close).start() # Wait for fade out