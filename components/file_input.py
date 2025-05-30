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
        
        # Initialize UI elements with M3 roles
        self.source_label = Text("No file selected", color=self.app.COLORS.get("onSurfaceVariant"), expand=True)
        self.target_label = Text("No file selected", color=self.app.COLORS.get("onSurfaceVariant"), expand=True)
        self.source_icon = Icon(Icons.DESCRIPTION, color=self.app.COLORS.get("onSurfaceVariant"), size=20)
        self.target_icon = Icon(Icons.DESCRIPTION, color=self.app.COLORS.get("onSurfaceVariant"), size=20)
        
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
        """Create a file input container with M3 styling"""
        # Use ft.OutlinedButton for "Browse"
        browse_button = ft.OutlinedButton(
            text="Browse",
            icon=Icons.UPLOAD_FILE,
            tooltip=f"Select {label}",
            on_click=self.open_source_picker if is_source else self.open_target_picker,
            style=ft.ButtonStyle(
                color=self.app.COLORS.get("primary"), # Text and icon color
                shape=ft.RoundedRectangleBorder(radius=8),
                side=ft.BorderSide(1, self.app.COLORS.get("outline")), # M3 outline
            ),
            height=40, # M3 standard height
        )
        
        # Store button for update_colors
        if is_source:
            self.source_browse_button = browse_button
        else:
            self.target_browse_button = browse_button

        return Container(
            content=Column(
                controls=[
                    Text(label, color=self.app.COLORS.get("onSurfaceVariant"), size=14, weight=FontWeight.W_500),
                    Container(
                        content=Row(
                            controls=[
                                self.source_icon if is_source else self.target_icon, # Already M3 styled
                                self.source_label if is_source else self.target_label, # Already M3 styled
                                Container(
                                    content=browse_button, # M3 styled button
                                    animate=ft.Animation(duration=200, curve="easeInOut"),
                                    on_hover=lambda e, btn=browse_button: self._on_browse_hover(e, btn)
                                ),
                            ],
                            alignment="center",
                            spacing=8, # M3 spacing
                        ),
                        border=ft.border.all(1, self.app.COLORS.get("outline")), # M3 border
                        border_radius=8, # M3 radius
                        bgcolor=self.app.COLORS.get("surfaceContainerHigh"), # M3 surface color
                        padding=12, # M3 padding
                    ),
                ],
                spacing=8, # M3 spacing
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
                        icon.color = self.app.COLORS.get("primary") # M3 primary for success/selection
                        self.app.update_compare_button()
                        
                        # Update preview if enabled
                        if self.app.config["show_preview"]:
                            self.update_file_preview(file_path, field_type)
                            self.app.preview_section.visible = True
                            
                        self.page.update()
                    
                    # Use async line count to avoid freezing the UI
                    field.value = f"{file_name} (loading...)"
                    icon.color = self.app.COLORS.get("secondary") # M3 secondary for in-progress
                    field.update()
                    icon.update()
                    
                    # Use the file cache service for async line counting
                    file_cache_service.count_lines_async(file_path, update_file_stats)
                    
                except Exception as e:
                    logging.error(f"Error processing file: {str(e)}")
                    field.value = ""
                    icon.color = self.app.COLORS.get("error") # M3 error color
                    field.update()
                    icon.update()
                    self.app.show_snackbar(f"Error processing file: {str(e)}")
            else:
                field.value = ""
                icon.color = self.app.COLORS.get("error") # M3 error color
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

    def _on_browse_hover(self, e, button: ft.OutlinedButton):
        """Handle hover effect for ft.OutlinedButton."""
        # M3 OutlinedButton hover: overlay of onSurface (8% opacity)
        # Text and icon color can also change to primary
        if e.data == "true": # Hovering
            button.style.overlay_color = ft.colors.with_opacity(0.08, self.app.COLORS.get("onSurface"))
            # Optionally, change text/icon to primary on hover:
            # button.style.color = self.app.COLORS.get("primary")
            # button.icon_color = self.app.COLORS.get("primary") # If icon property exists
        else: # Not hovering
            button.style.overlay_color = "transparent"
            # Restore original text/icon color if changed on hover:
            # button.style.color = self.app.COLORS.get("primary") # Assuming base is primary
        button.update()

    def update_colors(self, colors):
        """Update component colors when theme changes, using M3 roles."""
        # Labels and Icons
        self.source_label.color = colors.get("onSurfaceVariant")
        self.target_label.color = colors.get("onSurfaceVariant")
        self.source_icon.color = colors.get("onSurfaceVariant")
        self.target_icon.color = colors.get("onSurfaceVariant")
        
        # Update file input containers
        for i, container_wrapper in enumerate([self.source_file_container, self.target_file_container]):
            if container_wrapper and isinstance(container_wrapper, ft.Container) and \
               isinstance(container_wrapper.content, ft.Column):

                column_content = container_wrapper.content

                # Update label text (e.g., "Source File")
                if column_content.controls and isinstance(column_content.controls[0], ft.Text):
                    column_content.controls[0].color = colors.get("onSurfaceVariant")

                # Update bordered container
                if len(column_content.controls) > 1 and isinstance(column_content.controls[1], ft.Container):
                    bordered_container = column_content.controls[1]
                    bordered_container.bgcolor = colors.get("surfaceContainerHigh")
                    bordered_container.border = ft.border.all(1, colors.get("outline"))

                    # Update Browse button style within this container
                    # The browse button is nested inside another container in a Row
                    if isinstance(bordered_container.content, ft.Row) and \
                       len(bordered_container.content.controls) > 2 and \
                       isinstance(bordered_container.content.controls[2], ft.Container) and \
                       isinstance(bordered_container.content.controls[2].content, ft.OutlinedButton):

                        browse_button = bordered_container.content.controls[2].content
                        browse_button.style.color = colors.get("primary")
                        browse_button.style.side = ft.BorderSide(1, colors.get("outline"))
                        # Re-apply hover handler in case button instance changed or needs re-binding with new colors
                        # browse_button.on_hover = lambda e, btn=browse_button: self._on_browse_hover(e, btn)
                        # It's better if on_hover is set once and _on_browse_hover uses self.app.COLORS directly.

        # Update browse button styles directly if stored
        if hasattr(self, 'source_browse_button'):
            self.source_browse_button.style.color = colors.get("primary")
            self.source_browse_button.style.side = ft.BorderSide(1, colors.get("outline"))
        if hasattr(self, 'target_browse_button'):
            self.target_browse_button.style.color = colors.get("primary")
            self.target_browse_button.style.side = ft.BorderSide(1, colors.get("outline"))

        # self.page.update() # Handled by App class
