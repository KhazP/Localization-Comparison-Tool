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
    
    def _create_file_input(self, label: str, is_source=True) -> Container:
        """Create a file input container with proper initialization"""
        browse_button = ElevatedButton(
            "Browse",
            icon=Icons.UPLOAD_FILE,
            tooltip=f"Select {label}",
            on_click=self.open_source_picker if is_source else self.open_target_picker,
            bgcolor=self.app.COLORS["bg"]["accent"],
            color=self.app.COLORS["text"]["primary"],
            height=36,
            style=ButtonStyle(shape=RoundedRectangleBorder(radius=8))
        )
        
        return Container(
            content=Column(
                controls=[
                    Text(label, color=self.app.COLORS["text"]["secondary"], size=14, weight=FontWeight.W_500),
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
                        icon.color = Colors.BLUE_400
                        self.app.update_compare_button()
                        
                        # Update preview if enabled
                        if self.app.config["show_preview"]:
                            self.update_file_preview(file_path, field_type)
                            self.app.preview_section.visible = True
                            
                        self.page.update()
                    
                    # Use async line count to avoid freezing the UI
                    field.value = f"{file_name} (loading...)"
                    icon.color = Colors.BLUE_200
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
    
    def get_file_lines(self, file_path):
        """
        Count number of lines in a file efficiently using FileCacheService.
        This method is synchronous but uses optimized line counting.
        """
        try:
            return file_cache_service.count_lines(file_path)
        except Exception as e:
            logging.error(f"Error counting lines in file {file_path}: {str(e)}")
            return 0
    
    def update_file_preview(self, file_path: str, field_type: str):
        """
        Update the preview text field with the first few lines of the file.
        Uses FileCacheService for optimized file reading.
        """
        try:
            # Use the file cache service's preview function
            preview_text = file_cache_service.preview_file(file_path)
            
            # Get the appropriate preview TextField
            preview_field = self.app.preview_section.content.controls[0 if field_type == "source" else 2].content.controls[1].content
            preview_field.value = preview_text
            preview_field.update()
            
        except Exception as e:
            logging.error(f"Error reading preview: {str(e)}")
            preview_field = self.app.preview_section.content.controls[0 if field_type == "source" else 2].content.controls[1].content
            preview_field.value = "Error reading file preview"
            preview_field.update()

    def open_source_picker(self, _):
        self.source_picker.pick_files()

    def open_target_picker(self, _):
        self.target_picker.pick_files()

    def _on_browse_hover(self, e, button):
        hover_color = "#60A5FA" if self.page.theme_mode == "dark" else "#E0E7FF"
        if e.data == "true":
            button.bgcolor = hover_color
        else:
            button.bgcolor = self.app.COLORS["bg"]["accent"]
        button.update()

    def update_colors(self, colors):
        """Update component colors when theme changes"""
        if self.source_label:
            self.source_label.color = colors["text"]["secondary"]
        if self.target_label:
            self.target_label.color = colors["text"]["secondary"]
        if self.source_icon:
            self.source_icon.color = colors["text"]["secondary"]
        if self.target_icon:
            self.target_icon.color = colors["text"]["secondary"]
        
        # Update container colors safely
        for container in [self.source_file_container, self.target_file_container]:
            if container and container.content and isinstance(container.content, Column):
                file_input_col = container.content
                if file_input_col.controls:
                    if len(file_input_col.controls) > 0:
                        file_input_col.controls[0].color = colors["text"]["secondary"]
                    if len(file_input_col.controls) > 1:
                        inner = file_input_col.controls[1]
                        if inner:
                            inner.bgcolor = colors["bg"]["input"]
                            inner.border = border.all(2, colors["border"]["default"])
        
        # No need to call page.update() here as it will be handled by the main app
