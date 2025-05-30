import flet as ft
from flet import (
    Container, Text, Icon, FilePicker, Column, Row, ElevatedButton, 
    Icons, Colors, ButtonStyle, RoundedRectangleBorder, padding, border, 
    FontWeight, TextStyle, FilePickerResultEvent
)
from pathlib import Path
import os
import logging
from utils.file_cache_service import file_cache_service

class FileInputComponent:
    def __init__(self, page: ft.Page, app_reference):
        self.page = page
        self.app = app_reference
        self.source_file_path = ""
        self.target_file_path = ""
        
        # Initialize UI elements
        self.source_label = Text("No file selected", color=self.app.COLORS["text"]["secondary"], expand=True)
        self.target_label = Text("No file selected", color=self.app.COLORS["text"]["secondary"], expand=True)
        self.source_icon = Icon(Icons.DESCRIPTION, color=self.app.COLORS["text"]["secondary"], size=20)
        self.target_icon = Icon(Icons.DESCRIPTION, color=self.app.COLORS["text"]["secondary"], size=20)
        
        # Initialize file pickers
        self.source_picker = FilePicker(
            on_result=lambda e: self.handle_file_picked(e, self.source_label, self.source_icon, None, "source")
        )
        self.target_picker = FilePicker(
            on_result=lambda e: self.handle_file_picked(e, self.target_label, self.target_icon, None, "target")
        )
        
        # Add pickers to page overlay
        self.page.overlay.extend([self.source_picker, self.target_picker])
        
        # Create file input containers
        self.source_file_container = self._create_file_input("Source File", is_source=True)
        self.target_file_container = self._create_file_input("Target File", is_source=False)

        # Store browse buttons to update them in update_colors
        self.source_browse_button = self.source_file_container.content.controls[1].content.controls[2].content
        self.target_browse_button = self.target_file_container.content.controls[1].content.controls[2].content
    
    def _create_file_input(self, label: str, is_source=True) -> Container:
        """Create a file input container with proper initialization"""
        browse_button = ElevatedButton(
            "Browse",
            icon=Icons.UPLOAD_FILE,
            tooltip=f"Select {label}",
            on_click=self.open_source_picker if is_source else self.open_target_picker,
            bgcolor=self.app.COLORS["bg"]["accent"],
            color=self.app.COLORS["text"]["primary"],
            height=40, # Increased height
            style=ButtonStyle(shape=RoundedRectangleBorder(radius=8))
        )
        
        return Container(
            content=Column(
                controls=[
                    Text(label, color=self.app.COLORS["text"]["primary"], size=14, weight=FontWeight.W_500), # Changed to primary
                    Container(
                        content=Row(
                            controls=[
                                self.source_icon if is_source else self.target_icon,
                                self.source_label if is_source else self.target_label,
                                Container(
                                    content=browse_button,
                                    animate=ft.Animation(duration=200, curve="easeInOut"),
                                    on_hover=lambda e, btn=browse_button: self._on_browse_hover(e, btn)
                                ),
                            ],
                            alignment="center",
                            spacing=8,
                        ),
                        border=border.all(2, self.app.COLORS["border"]["default"]),
                        border_radius=8,
                        bgcolor=self.app.COLORS["bg"]["input"],
                        padding=12,
                    ),
                ],
                spacing=8,
            )
        )
    
    def handle_file_picked(self, e: FilePickerResultEvent, field, icon, clear_btn, field_type):
        """
        Handle file selection using the FileCacheService for more efficient operations.
        """
        if e.files and len(e.files) > 0:
            file_path = e.files[0].path
            if self.app.validate_file(file_path):
                file_name = Path(file_path).name
                
                # Use the file cache service for better performance
                try:
                    # Start asynchronous file operations
                    def update_file_stats(line_count, error):
                        file_size = self.get_readable_file_size(os.path.getsize(file_path))
                        field.value = f"{file_name} ({file_size}, {line_count} lines)"
                        
                        if field_type == "source":
                            self.source_file_path = file_path
                            self.app.source_file_path = file_path
                        else:
                            self.target_file_path = file_path
                            self.app.target_file_path = file_path

                        # Update UI elements
                        icon.color = self.app.COLORS["text"]["accent"] # Use theme color
                        self.app.update_compare_button()
                        
                        # Update preview if enabled
                        if self.app.config["show_preview"]:
                            self.update_file_preview(file_path, field_type)
                            self.app.preview_section.visible = True
                            
                        self.page.update()
                    
                    # Use async line count to avoid freezing the UI
                    field.value = f"{file_name} (loading...)"
                    icon.color = self.app.COLORS["text"]["secondary"] # Use theme color for loading state
                    field.update()
                    icon.update()
                    
                    # Use the file cache service for async line counting
                    file_cache_service.count_lines_async(file_path, update_file_stats)
                    
                except Exception as e:
                    logging.error(f"Error processing file: {str(e)}")
                    field.value = ""
                    icon.color = "red"
                    field.update()
                    icon.update()
                    self.app.show_snackbar(f"Error processing file: {str(e)}")
            else:
                field.value = ""
                icon.color = "red"
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
    
    # Removed duplicate get_file_lines method - using file_cache_service directly
    
    def update_file_preview(self, file_path: str, field_type: str):
        """
        Update the preview text field with the first few lines of the file.
        Uses FileCacheService for optimized file reading.
        """
        try:
            # Use the file cache service's preview function
            preview_text = file_cache_service.preview_file(file_path)
            
            # Get the appropriate preview TextField
            # Fix index for target file - use index 1 instead of 2
            preview_field = self.app.preview_section.content.controls[0 if field_type == "source" else 1].content.controls[1].content
            preview_field.value = preview_text
            preview_field.update()
            
        except Exception as e:
            logging.error(f"Error reading preview: {str(e)}")
            # Fix index for target file - use index 1 instead of 2
            preview_field = self.app.preview_section.content.controls[0 if field_type == "source" else 1].content.controls[1].content
            preview_field.value = "Error reading file preview"
            preview_field.update()

    def open_source_picker(self, _):
        self.source_picker.pick_files()

    def open_target_picker(self, _):
        self.target_picker.pick_files()

    def _on_browse_hover(self, e, button):
        if e.data == "true":
            button.bgcolor = self.app.COLORS["bg"]["hover"] # Use theme hover color
        else:
            button.bgcolor = self.app.COLORS["bg"]["accent"]
        button.update()

    def update_colors(self, colors):
        """Update component colors when theme changes"""
        # Update labels
        if self.source_label:
            self.source_label.color = colors["text"]["secondary"]
        if self.target_label:
            self.target_label.color = colors["text"]["secondary"]

        # Update icons (only if not actively selected, otherwise handle_file_picked color takes precedence)
        if self.source_icon and self.source_file_path == "": # Only update if no file selected
            self.source_icon.color = colors["text"]["secondary"]
        elif self.source_icon and self.source_file_path != "": # If file selected, use accent
             self.source_icon.color = colors["text"]["accent"]

        if self.target_icon and self.target_file_path == "": # Only update if no file selected
            self.target_icon.color = colors["text"]["secondary"]
        elif self.target_icon and self.target_file_path != "": # If file selected, use accent
            self.target_icon.color = colors["text"]["accent"]
        
        # Update container colors and main labels
        for i, container_wrapper in enumerate([self.source_file_container, self.target_file_container]):
            if container_wrapper and container_wrapper.content and isinstance(container_wrapper.content, Column):
                file_input_col = container_wrapper.content
                if file_input_col.controls:
                    # Update main label ("Source File" / "Target File")
                    if len(file_input_col.controls) > 0 and isinstance(file_input_col.controls[0], Text):
                        file_input_col.controls[0].color = colors["text"]["primary"]
                    # Update inner container for file path display
                    if len(file_input_col.controls) > 1 and isinstance(file_input_col.controls[1], Container):
                        inner_container = file_input_col.controls[1]
                        inner_container.bgcolor = colors["bg"]["input"]
                        inner_container.border = border.all(2, colors["border"]["default"])

        # Update browse buttons using stored references
        if hasattr(self, 'source_browse_button') and self.source_browse_button:
            self.source_browse_button.bgcolor = colors["bg"]["accent"]
            self.source_browse_button.color = colors["text"]["primary"]

        if hasattr(self, 'target_browse_button') and self.target_browse_button:
            self.target_browse_button.bgcolor = colors["bg"]["accent"]
            self.target_browse_button.color = colors["text"]["primary"]
        
        # No need to call page.update() here as it will be handled by the main app
