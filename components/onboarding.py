import flet as ft
from flet import (
    Container, Column, Row, Text, IconButton, ProgressBar,
    TextButton, AlertDialog, Icon, icons, padding, BorderRadius,
    animation, colors
)
from components.file_input import FileInputComponent

class OnboardingTutorial:
    """Manages the onboarding tutorial experience for first-time users."""
    
    def __init__(self, page: ft.Page, app_reference):
        self.page = page
        self.app = app_reference
        self.current_step = 0
        
        # Define tutorial steps
        self.tutorial_steps = [
            {
                "title": "Welcome!",
                "content": "This tool helps you compare and analyze the differences between translation files.",
                "target": None,
                "icon": icons.WAVING_HAND
            },
            {
                "title": "Select Files",
                "content": "Start by selecting your source and target translation files using the browse buttons.",
                "target": "file_input",
                "icon": icons.FOLDER_OPEN
            },
            {
                "title": "Compare Files",
                "content": "Click the Compare button to analyze differences between your files.",
                "target": "compare_button",
                "icon": icons.COMPARE_ARROWS
            },
            {
                "title": "View Results",
                "content": "Results show missing translations (+), obsolete entries (-), and potential issues (~).",
                "target": "results_area",
                "icon": icons.LIST_ALT
            },
            {
                "title": "Machine Translation",
                "content": "Automatically translate missing entries using Google Cloud Translation (configurable in Settings).",
                "target": "translate_button",
                "icon": icons.TRANSLATE
            }
        ]
        
        # Create tutorial dialog
        self.dialog = AlertDialog(
            modal=True,
            content=Container(
                content=Column(
                    controls=[
                        self._create_header(),
                        self._create_content(),
                        self._create_navigation()
                    ],
                    spacing=20,
                ),
                padding=padding.all(20),
                width=400,
            ),
            actions=[],
            actions_alignment="end",
            open=False  # Initialize as closed
        )
        # Add dialog to page overlay immediately
        self.page.overlay.append(self.dialog)
        
    def _create_header(self):
        """Create the tutorial step header with icon and title."""
        return Row(
            controls=[
                Icon(
                    self.tutorial_steps[0]["icon"],
                    size=24,
                    color=self.app.COLORS["text"]["primary"]
                ),
                Text(
                    self.tutorial_steps[0]["title"],
                    size=20,
                    weight="bold",
                    color=self.app.COLORS["text"]["primary"]
                )
            ],
            alignment="center",
            spacing=10
        )
        
    def _create_content(self):
        """Create the main content area for tutorial steps."""
        return Container(
            content=Text(
                self.tutorial_steps[0]["content"],
                size=16,
                color=self.app.COLORS["text"]["secondary"],
                text_align="center"
            ),
            padding=padding.symmetric(vertical=10)
        )
        
    def _create_navigation(self):
        """Create navigation controls (progress bar, buttons)."""
        return Column(
            controls=[
                ProgressBar(
                    value=0,
                    bgcolor=self.app.COLORS["border"]["default"],
                    color=self.app.COLORS["bg"]["accent"],
                    height=4,
                ),
                Row(
                    controls=[
                        TextButton(
                            "Skip Tutorial",
                            on_click=self.end_tutorial
                        ),
                        Row(
                            controls=[
                                TextButton(
                                    "Back",
                                    on_click=self.previous_step,
                                    disabled=True
                                ),
                                TextButton(
                                    "Next",
                                    on_click=self.next_step
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
        
    def update_step(self):
        """Update the tutorial UI for the current step."""
        step = self.tutorial_steps[self.current_step]
        
        # Update header
        header = self.dialog.content.content.controls[0]
        header.controls[0].name = step["icon"]
        header.controls[1].value = step["title"]
        
        # Update content
        content = self.dialog.content.content.controls[1].content
        content.value = step["content"]
        
        # Update progress and navigation
        navigation = self.dialog.content.content.controls[2]
        progress = navigation.controls[0]
        progress.value = (self.current_step + 1) / len(self.tutorial_steps)
        
        buttons = navigation.controls[1].controls[1]
        buttons.controls[0].disabled = self.current_step == 0
        buttons.controls[1].text = "Finish" if self.current_step == len(self.tutorial_steps) - 1 else "Next"
        
        # Highlight target element if specified
        self.highlight_target(step["target"])
        
        self.dialog.update()
        
    def highlight_target(self, target_id):
        """Add visual highlight to the target element."""
        # Safely remove any existing highlight first
        if hasattr(self, "_highlight"):
            try:
                if self._highlight in self.page.overlay:
                    self.page.overlay.remove(self._highlight)
                delattr(self, "_highlight")
            except ValueError:
                pass

        if not target_id:
            return
            
        # Find target element and create highlight overlay
        target = getattr(self.app, target_id, None)
        if target:
            # Handle different types of targets
            if isinstance(target, FileInputComponent):
                # Use the source_file_container for FileInputComponent
                target_control = target.source_file_container
            else:
                target_control = target

            # Default dimensions
            width = 400
            height = 100
                
            # Get actual dimensions if available
            if hasattr(target_control, 'width') and target_control.width is not None:
                width = target_control.width + 10
            if hasattr(target_control, 'height') and target_control.height is not None:
                height = target_control.height + 10
            
            # Create highlight container around target element with default dimensions
            self._highlight = Container(
                left=20,  # Default padding
                top=120,  # Approximate header height + padding
                width=width,
                height=height,
                border=ft.border.all(2, self.app.COLORS["bg"]["accent"]),
                border_radius=BorderRadius(10, 10, 10, 10),  # Updated: provide all corner radii
                animate=animation.Animation(300, "easeOut")
            )
            
            # Position adjustments based on target
            if target_id == "file_input":
                self._highlight.top = 160
                self._highlight.width = 800  # Wider for file input
                self._highlight.height = 120
            elif target_id == "compare_button":
                self._highlight.top = 280
                self._highlight.width = 160
                self._highlight.height = 50
            elif target_id == "results_area":
                self._highlight.top = 340
                self._highlight.width = 800
                self._highlight.height = 200
            elif target_id == "translate_button":
                self._highlight.left = 220
                self._highlight.top = 280
                self._highlight.width = 160
                self._highlight.height = 50
            
            self.page.overlay.append(self._highlight)
                
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
        """Begin the tutorial sequence."""
        self.current_step = 0
        self.dialog.open = True  # Just open the dialog
        self.update_step()
        self.page.update()
        
    def end_tutorial(self, e=None):
        """Complete the tutorial and save progress."""
        # Safely remove highlight if it exists
        if hasattr(self, "_highlight"):
            try:
                if self._highlight in self.page.overlay:
                    self.page.overlay.remove(self._highlight)
                delattr(self, "_highlight")  # Clean up the reference
            except ValueError:
                # Ignore if highlight was already removed
                pass

        # Close dialog and save progress
        self.dialog.open = False
        self.app.config["tutorial_completed"] = True
        self.app.save_config()
        self.page.update()
