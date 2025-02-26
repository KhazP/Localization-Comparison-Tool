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
        self.app = app_reference
        self.current_step = 0
        
        # Define tutorial steps with enhanced content and icons
        self.tutorial_steps = [
            {
                "title": "Welcome!",
                "content": "This tool helps you compare and analyze the differences between translation files.",
                "icon": icons.WAVING_HAND,
                "color": "#4CAF50"  # Green
            },
            {
                "title": "Select Files",
                "content": "Start by selecting your source and target translation files using the browse buttons.",
                "icon": icons.FOLDER_OPEN,
                "color": "#2196F3"  # Blue
            },
            {
                "title": "Compare Files",
                "content": "Click the Compare button to analyze differences between your files.",
                "icon": icons.COMPARE_ARROWS,
                "color": "#FF9800"  # Orange
            },
            {
                "title": "View Results",
                "content": "Results show missing translations (+), obsolete entries (-), and potential issues (~).",
                "icon": icons.LIST_ALT,
                "color": "#9C27B0"  # Purple
            },
            {
                "title": "Machine Translation",
                "content": "Automatically translate missing entries using Google Cloud Translation (configurable in Settings).",
                "icon": icons.TRANSLATE,
                "color": "#E91E63"  # Pink
            }
        ]
        
        # Create tutorial dialog with enhanced styling
        self.dialog = AlertDialog(
            modal=True,
            bgcolor=ft.colors.TRANSPARENT,  # Make the dialog background transparent
            content=Container(
                content=Column(
                    controls=[
                        self._create_header(),
                        self._create_content(),
                        self._create_navigation()
                    ],
                    spacing=20,
                ),
                padding=padding.all(24),
                width=450,  # Slightly wider for better readability
                border_radius=BorderRadius(12, 12, 12, 12),
                gradient=LinearGradient(
                    begin=alignment.top_center,
                    end=alignment.bottom_center,
                    colors=[self.app.COLORS["bg"]["secondary"], self.app.COLORS["bg"]["primary"]]
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
            open=False  # Initialize as closed
        )
        # Add dialog to page overlay immediately
        self.page.overlay.append(self.dialog)
        
    def _create_header(self):
        """Create the tutorial step header with icon and title."""
        return Container(
            content=Row(
                controls=[
                    Container(
                        content=Icon(
                            self.tutorial_steps[0]["icon"],
                            size=32,
                            color=self.tutorial_steps[0]["color"]  # Use the step-specific color
                        ),
                        padding=padding.all(12),
                        border_radius=BorderRadius(8, 8, 8, 8),
                        bgcolor=ft.colors.with_opacity(0.1, self.tutorial_steps[0]["color"]),
                    ),
                    Text(
                        self.tutorial_steps[0]["title"],
                        size=24,
                        weight="bold",
                        color=self.app.COLORS["text"]["primary"]
                    )
                ],
                alignment="center",
                spacing=16,
            ),
            margin=padding.only(bottom=10)
        )
        
    def _create_content(self):
        """Create the main content area for tutorial steps with illustrations."""
        return Container(
            content=Column(
                controls=[
                    Text(
                        self.tutorial_steps[0]["content"],
                        size=16,
                        color=self.app.COLORS["text"]["secondary"],
                        text_align="center"
                    ),
                    # Add illustration container that will be populated in update_step
                    Container(
                        content=Icon(
                            self.tutorial_steps[0]["icon"],
                            size=80,
                            color=self.tutorial_steps[0]["color"],
                            opacity=0.8
                        ),
                        alignment=ft.alignment.center,
                        height=120,
                        animate=animation.Animation(500, "decelerate")
                    )
                ],
                horizontal_alignment="center",
                spacing=24
            ),
            padding=padding.symmetric(vertical=20),
            animate=animation.Animation(300, "easeInOut")
        )
        
    def _create_navigation(self):
        """Create navigation controls with enhanced progress bar and buttons."""
        return Column(
            controls=[
                # Enhanced progress bar with step indicators
                Container(
                    content=Row(
                        [self._create_step_indicator(i) for i in range(len(self.tutorial_steps))],
                        alignment="center",
                        spacing=8
                    ),
                    margin=padding.only(bottom=10)
                ),
                # Animated progress bar 
                ProgressBar(
                    value=0,
                    bgcolor=ft.colors.with_opacity(0.2, self.app.COLORS["bg"]["accent"]),
                    color=self.app.COLORS["bg"]["accent"],
                    height=4,
                    border_radius=BorderRadius(2, 2, 2, 2),
                ),
                Row(
                    controls=[
                        TextButton(
                            "Skip Tutorial",
                            on_click=self.end_tutorial,
                            style=ft.ButtonStyle(
                                color=ft.colors.with_opacity(0.7, self.app.COLORS["text"]["secondary"])
                            )
                        ),
                        Row(
                            controls=[
                                TextButton(
                                    "Back",
                                    on_click=self.previous_step,
                                    disabled=True,
                                    style=ft.ButtonStyle(
                                        color=self.app.COLORS["text"]["secondary"]
                                    )
                                ),
                                Container(  # Create animated Next button
                                    content=TextButton(
                                        content=Row(
                                            controls=[
                                                Text("Next", size=16),
                                                Icon(icons.ARROW_FORWARD, size=16)
                                            ],
                                            spacing=5
                                        ),
                                        on_click=self.next_step,
                                        style=ft.ButtonStyle(
                                            color=self.app.COLORS["text"]["primary"],
                                        )
                                    ),
                                    animate=animation.Animation(300, "bounceOut"),
                                ),
                            ],
                            spacing=10
                        ),
                    ],
                    alignment="spaceBetween"
                )
            ],
            spacing=20
        )
    
    def _create_step_indicator(self, step_index):
        """Create an individual step indicator dot for the progress bar."""
        is_current = step_index == 0
        color = self.tutorial_steps[step_index]["color"] if is_current else self.app.COLORS["border"]["default"]
        
        return Container(
            width=12,
            height=12,
            border_radius=BorderRadius(6, 6, 6, 6),
            bgcolor=color,
            tooltip=f"Step {step_index + 1}",
            animate=animation.Animation(300, "easeInOut"),
            on_click=lambda e, i=step_index: self._jump_to_step(i) if i < self.current_step + 1 else None
        )
        
    def _jump_to_step(self, step_index):
        """Jump to a specific step when clicking on an active step indicator."""
        if step_index <= self.current_step:  # Only allow going back or staying on current step
            self.current_step = step_index
            self.update_step()
        
    def update_step(self):
        """Update the tutorial UI for the current step with animations."""
        step = self.tutorial_steps[self.current_step]
        
        # Update header with animated icon and title
        header_container = self.dialog.content.content.controls[0]
        icon_container = header_container.content.controls[0]
        icon_container.content.name = step["icon"]
        icon_container.content.color = step["color"]
        icon_container.bgcolor = ft.colors.with_opacity(0.1, step["color"])
        header_container.content.controls[1].value = step["title"]
        
        # Update content
        content_container = self.dialog.content.content.controls[1]
        content_container.content.controls[0].value = step["content"]
        
        # Update illustration
        illustration = content_container.content.controls[1].content
        illustration.name = step["icon"]
        illustration.color = step["color"]
        content_container.content.controls[1].key = f"illustration-{self.current_step}"  # Force a refresh
        
        # Update progress indicators
        navigation = self.dialog.content.content.controls[2]
        step_indicators = navigation.controls[0].content.controls
        
        for i, indicator in enumerate(step_indicators):
            if i < self.current_step:
                indicator.bgcolor = ft.colors.with_opacity(0.6, self.tutorial_steps[i]["color"])
                indicator.width = 10
                indicator.height = 10
            elif i == self.current_step:
                indicator.bgcolor = self.tutorial_steps[i]["color"]
                indicator.width = 14
                indicator.height = 14
            else:
                indicator.bgcolor = self.app.COLORS["border"]["default"]
                indicator.width = 10
                indicator.height = 10
        
        # Update progress bar
        progress_bar = navigation.controls[1]
        progress_bar.value = (self.current_step + 1) / len(self.tutorial_steps)
        
        # Update navigation buttons
        buttons_row = navigation.controls[2]
        back_button = buttons_row.controls[1].controls[0]
        back_button.disabled = self.current_step == 0
        
        next_button_container = buttons_row.controls[1].controls[1]
        
        if self.current_step == len(self.tutorial_steps) - 1:
            # Last step - show finish button
            next_button_container.content = TextButton(
                content=Row(
                    controls=[
                        Text("Finish", size=16),
                        Icon(icons.CHECK, size=16)
                    ],
                    spacing=5
                ),
                on_click=self.end_tutorial,
                style=ft.ButtonStyle(
                    color=self.app.COLORS["text"]["primary"],
                )
            )
        else:
            # Regular next button
            next_button_container.content = TextButton(
                content=Row(
                    controls=[
                        Text("Next", size=16),
                        Icon(icons.ARROW_FORWARD, size=16)
                    ],
                    spacing=5
                ),
                on_click=self.next_step,
                style=ft.ButtonStyle(
                    color=self.app.COLORS["text"]["primary"],
                )
            )

        # Apply pulse animation to the next/finish button container
        next_button_container.scale = 1.05
        self.page.update()
        next_button_container.scale = 1.0
        
        self.dialog.open = True
        self.page.update()
        
    def next_step(self, e=None):
        """Advance to the next tutorial step."""
        if self.current_step < len(self.tutorial_steps) - 1:
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
        
        # Set initial opacity for fade-in effect
        self.dialog.opacity = 0
        self.dialog.open = True
        self.page.update()
        
        # Use a timer instead of asyncio for the fade-in
        def fade_in():
            self.dialog.opacity = 1
            self.update_step()
            self.page.update()
        
        # Schedule the fade-in after a short delay
        threading.Timer(0.1, fade_in).start()
        
    def end_tutorial(self, e=None):
        """Complete the tutorial with fade-out animation and save progress."""
        # Fade out animation
        self.dialog.opacity = 0
        self.page.update()
        
        # Use a timer for cleanup after fade-out animation
        def cleanup():
            # Close dialog and save progress
            self.dialog.open = False
            self.app.config["tutorial_completed"] = True
            self.app.save_config()
            
            # Final page update
            self.page.update()
            
            # Show a success snackbar
            self.page.snack_bar = ft.SnackBar(
                content=Text("Tutorial completed! You can restart it anytime from the settings menu."),
                bgcolor=self.app.COLORS["bg"]["secondary"],
                action="OK"
            )
            self.page.snack_bar.open = True
            self.page.update()
        
        # Schedule the cleanup after a short delay
        threading.Timer(0.3, cleanup).start()