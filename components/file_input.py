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
        self.app = app_reference # Provides access to COLORS, spacing, TEXT_SIZE constants
        self.source_file_path = ""
        self.target_file_path = ""
        
        # Initialize UI elements
        self.source_label = Text("No file selected", color=self.app.COLORS["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT, expand=True)
        self.target_label = Text("No file selected", color=self.app.COLORS["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT, expand=True)
        self.source_icon = Icon(Icons.DESCRIPTION, color=self.app.COLORS["text"]["secondary"], size=self.app.TEXT_SIZE_LARGE)
        self.target_icon = Icon(Icons.DESCRIPTION, color=self.app.COLORS["text"]["secondary"], size=self.app.TEXT_SIZE_LARGE)

        # Clear buttons (initialized here, created in _create_file_input)
        self.source_clear_button = None
        self.target_clear_button = None
        
        # Initialize file pickers
        self.source_picker = FilePicker(
            on_result=lambda e: self.handle_file_picked(e, "source")
        )
        self.target_picker = FilePicker(
            on_result=lambda e: self.handle_file_picked(e, "target")
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
            style=ButtonStyle(
                bgcolor=self.app.COLORS["bg"]["accent"],
                color=self.app.COLORS["text"]["primary"],
                shape=RoundedRectangleBorder(radius=self.app.spacing["xs"]),
                padding=padding.symmetric(horizontal=self.app.spacing["m"]) 
            ),
            height=self.app.BASE_UNIT * 9, # 36px
        )
        
        return Container(
            content=Column(
                controls=[
                    Text(label, color=self.app.COLORS["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT, weight=FontWeight.W_500),
                    Container(
                        content=Row(
                            controls=[
                                self.source_icon if is_source else self.target_icon,
                                self.source_label if is_source else self.target_label,
                                self.source_clear_button if is_source else self.target_clear_button,
                                browse_button,
                            ],
                            alignment="center",
                            spacing=self.app.spacing["xs"],
                        ),
                        border=border.all(1, self.app.COLORS["border"]["default"]), # Changed to 1px border
                        border_radius=self.app.spacing["xs"],
                        bgcolor=self.app.COLORS["bg"]["input"],
                        padding=self.app.spacing["s"],
                    ),
                ],
                spacing=self.app.spacing["xs"],
            )
        )

    def _clear_file_selection(self, field_type: str):
        """Clears the selected file for the given field type."""
        label_to_update = None
        icon_to_update = None
        clear_button_to_hide = None
        preview_field_control = None

        if field_type == "source":
            self.source_file_path = ""
            self.app.source_file_path = "" # Update app's path
            label_to_update = self.source_label
            icon_to_update = self.source_icon
            clear_button_to_hide = self.source_clear_button
            if self.app.preview_section.content.controls:
                preview_field_control = self.app.preview_section.content.controls[0].content.controls[1].content
        else: # target
            self.target_file_path = ""
            self.app.target_file_path = "" # Update app's path
            label_to_update = self.target_label
            icon_to_update = self.target_icon
            clear_button_to_hide = self.target_clear_button
            if len(self.app.preview_section.content.controls) > 1:
                preview_field_control = self.app.preview_section.content.controls[1].content.controls[1].content
        
        if label_to_update:
            label_to_update.value = "No file selected"
            label_to_update.update()
        if icon_to_update:
            icon_to_update.color = self.app.COLORS["text"]["secondary"] # Reset icon color
            icon_to_update.update()
        if clear_button_to_hide:
            clear_button_to_hide.visible = False
            clear_button_to_hide.update()
        
        self.app.update_compare_button() # Update main compare button state

        # Clear preview if visible
        if self.app.config["show_preview"] and preview_field_control:
            preview_field_control.value = "No file selected"
            preview_field_control.update()
            # Hide entire preview section if both files are cleared
            if not self.source_file_path and not self.target_file_path:
                 self.app.preview_section.visible = False
                 self.app.preview_section.update()

        self.page.update()

    def handle_file_picked(self, e: FilePickerResultEvent, field_type: str):
        """
        Handle file selection using the FileCacheService for more efficient operations.
        """
        label_to_update = self.source_label if field_type == "source" else self.target_label
        icon_to_update = self.source_icon if field_type == "source" else self.target_icon
        clear_button_to_show = self.source_clear_button if field_type == "source" else self.target_clear_button

        if e.files and len(e.files) > 0:
            file_path = e.files[0].path
            if self.app.validate_file(file_path):
                file_name = Path(file_path).name
                
                try:
                    def update_file_stats(line_count, error):
                        if error:
                            logging.error(f"Error counting lines for {file_path}: {error}")
                            self.app.show_snackbar(f"Error reading {file_name}: {error}")
                            label_to_update.value = f"Error reading {file_name}"
                            icon_to_update.color = Colors.RED_ACCENT_700
                            if clear_button_to_show: clear_button_to_show.visible = True # Still show clear
                            label_to_update.update()
                            icon_to_update.update()
                            if clear_button_to_show: clear_button_to_show.update()
                            return

                        file_size = self.get_readable_file_size(os.path.getsize(file_path))
                        label_to_update.value = f"{file_name} ({file_size}, {line_count} lines)"
                        
                        if field_type == "source":
                            self.source_file_path = file_path
                            self.app.source_file_path = file_path
                        else:
                            self.target_file_path = file_path
                            self.app.target_file_path = file_path

                        icon_to_update.color = Colors.GREEN_ACCENT_700 # Use a success color
                        if clear_button_to_show: clear_button_to_show.visible = True
                        
                        self.app.update_compare_button()
                        
                        if self.app.config["show_preview"]:
                            self.update_file_preview(file_path, field_type)
                            self.app.preview_section.visible = True
                            self.app.preview_section.update()
                            
                        label_to_update.update()
                        icon_to_update.update()
                        if clear_button_to_show: clear_button_to_show.update()
                        self.page.update() # Ensure page updates after all individual updates
                    
                    label_to_update.value = f"{file_name} (loading...)"
                    icon_to_update.color = self.app.COLORS["bg"]["accent"] # Use accent color for loading
                    label_to_update.update()
                    icon_to_update.update()
                    
                    file_cache_service.count_lines_async(file_path, update_file_stats)
                    
                except Exception as ex:
                    logging.error(f"Error processing file {file_path}: {str(ex)}")
                    label_to_update.value = "Error processing file"
                    icon_to_update.color = Colors.RED_ACCENT_700
                    if clear_button_to_show: clear_button_to_show.visible = False # Don't show if error before stats
                    label_to_update.update()
                    icon_to_update.update()
                    if clear_button_to_show: clear_button_to_show.update()
                    self.app.show_snackbar(f"Error processing file: {str(ex)}")
            else: # File validation failed
                label_to_update.value = "Invalid file"
                icon_to_update.color = Colors.RED_ACCENT_700
                if clear_button_to_show: clear_button_to_show.visible = False
                label_to_update.update()
                icon_to_update.update()
                if clear_button_to_show: clear_button_to_show.update()
        else: # No file selected or dialog cancelled
            # Only clear if a file was previously selected for this field_type
            if (field_type == "source" and self.source_file_path) or \
               (field_type == "target" and self.target_file_path):
                 self._clear_file_selection(field_type) # Call clear if selection is cancelled
            # else: Do nothing if no file was selected and dialog was cancelled.

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
        """Handle hover effect for browse button using theme colors."""
        # This method might be redundant if ElevatedButton's style can handle hover state directly.
        # However, if called via on_hover=lambda e, btn=button: self._on_browse_hover(e, btn)
        # on a Container, this would work. For an ElevatedButton, it's better to use button.style.
        if hasattr(button, 'style') and isinstance(button.style, ButtonStyle):
            if e.data == "true": # Hovering
                button.style.bgcolor = self.app.COLORS["bg"]["hover"]
            else: # Not hovering
                button.style.bgcolor = self.app.COLORS["bg"]["accent"]
        else: # Fallback for other types of controls if this method is reused
            if e.data == "true":
                button.bgcolor = self.app.COLORS["bg"]["hover"]
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
