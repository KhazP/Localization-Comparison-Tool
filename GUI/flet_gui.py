import flet as ft
from flet import (
    Checkbox,
    Column,
    Container,
    ElevatedButton,
    FilePicker,
    FilePickerResultEvent,
    Icon,
    Page,
    Row,
    SnackBar,
    Text,
    TextField,
    border,
    border_radius,
    padding,
    ProgressRing,
    IconButton,
    Tooltip,
    AnimatedSwitcher,
    Colors,  # Add this import
    Icons,   # Add this import
    ButtonStyle,
    RoundedRectangleBorder,
    TextStyle,
    FontWeight,
    ScrollMode,
    ResponsiveRow,
    Divider,
    Card,
    ClipBehavior,
    VerticalDivider  # Added missing import
)
import os
import logic
from pathlib import Path

class App:
    def __init__(self, page: ft.Page):
        self.page = page
        # Theme colors (unchanged)
        self.THEMES = {
            "dark": {
                "bg": {
                    "primary": "#111827",
                    "secondary": "#1F2937",
                    "input": "#374151",
                    "accent": "#3B82F6",
                },
                "text": {
                    "primary": "#F9FAFB",
                    "secondary": "#9CA3AF",
                    "accent": "#60A5FA",
                },
                "border": {
                    "default": "#4B5563",
                    "accent": "#3B82F6",
                }
            },
            "light": {
                "bg": {
                    "primary": "#FFFFFF",
                    "secondary": "#F3F4F6",
                    "input": "#F9FAFB",
                    "accent": "#3B82F6",
                },
                "text": {
                    "primary": "#111827",
                    "secondary": "#374151",
                    "accent": "#2563EB",
                    "muted": "#6B7280",
                },
                "border": {
                    "default": "#E5E7EB",
                    "accent": "#3B82F6",
                }
            }
        }

        # Use dark theme colors
        self.COLORS = self.THEMES["dark"]

        # Define COLORS completely with change colors
        self.COLORS = {
            "bg": {
                "primary": "#111827",
                "secondary": "#1F2937",
                "input": "#374151",
                "accent": "#3B82F6",
            },
            "text": {
                "primary": "#F9FAFB",
                "secondary": "#9CA3AF",
                "accent": "#60A5FA",
            },
            "border": {
                "default": "#4B5563",
                "accent": "#3B82F6",
            },
            "changes": {  # New block to define change colors
                "added": "#4ADE80",    # green
                "removed": "#F87171",  # red
                "modified": "#60A5FA", # blue
            }
        }

        # Add theme toggle button
        self.theme_toggle = IconButton(
            icon=Icons.LIGHT_MODE,
            icon_color=self.COLORS["text"]["secondary"],
            tooltip="Toggle theme",
            on_click=self.toggle_theme
        )
        
        # Initialize file paths
        self.source_file_path = ""
        self.target_file_path = ""
        
        # Then initialize UI elements
        self.output_text = TextField(
            value="Comparison results will appear here",
            multiline=True,
            read_only=True,
            min_lines=20,  # Increased minimum lines
            max_lines=None,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",  # Make background transparent
            expand=True,
        )
        self.source_text = TextField(
            value="Source file content will appear here",
            multiline=True,
            read_only=True,
            min_lines=20,
            max_lines=None,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )
        self.target_text = TextField(
            value="Target file content will appear here",
            multiline=True,
            read_only=True,
            min_lines=20,
            max_lines=None,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )
        # New summary text field for comparison summary
        self.summary_text = TextField(
            value="Summary will appear here",
            read_only=True,
            multiline=True,
            text_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )
        self.status_label = Text(
            value="Ready",
            color=self.COLORS["text"]["secondary"],
            size=14,
        )
        self.loading_ring = ProgressRing(
            width=20,
            height=20,
            stroke_width=2,
            color=self.COLORS["bg"]["accent"],
            visible=False,
        )
        # Initialize checkboxes and button
        self.ignore_case_checkbox = self.create_checkbox("Ignore Case")
        self.ignore_whitespace_checkbox = self.create_checkbox("Ignore Whitespace")
        self.only_missing_checkbox = self.create_checkbox("Only Missing Keys", value=True)
        self.compare_button = self.create_compare_button()
        
        self.source_label = Text("No file selected", color=self.COLORS["text"]["secondary"], expand=True)
        self.target_label = Text("No file selected", color=self.COLORS["text"]["secondary"], expand=True)
        self.source_icon = Icon(Icons.DESCRIPTION, color=self.COLORS["text"]["secondary"], size=20)
        self.target_icon = Icon(Icons.DESCRIPTION, color=self.COLORS["text"]["secondary"], size=20)
        
        self.source_picker = FilePicker(on_result=lambda e: self.handle_file_picked(e, self.source_label, self.source_icon, None, "source"))
        self.target_picker = FilePicker(on_result=lambda e: self.handle_file_picked(e, self.target_label, self.target_icon, None, "target"))
        
        page.overlay.extend([self.source_picker, self.target_picker])
        # Page setup
        page.title = "Localization Comparison Tool"
        page.theme_mode = "dark"
        page.padding = 0  # We'll handle padding in the main container
        page.bgcolor = "#111827"  # Matches Tailwind's gray-900
        page.snack_bar = SnackBar(
            content=Text(""),
            bgcolor="#374151",  # Tailwind gray-700
        )
        
        # Create modern file input
        def create_file_input(label: str, is_source=True):
            # Create a Browse button and wrap it in an AnimatedContainer for hover effects.
            browse_button = ElevatedButton(
                "Browse",
                icon=Icons.UPLOAD,
                on_click=self.open_source_picker if is_source else self.open_target_picker,
                bgcolor=self.COLORS["bg"]["accent"],
                color=self.COLORS["text"]["primary"],
                height=36,
                style=ButtonStyle(shape=RoundedRectangleBorder(radius=8)),
            )
            # Wrap in a container to enable hover state transition.
            hover_button = Container(
                content=browse_button,
                animate=ft.Animation(duration=200, curve="easeInOut"),
                on_hover=lambda e, btn=browse_button: self._on_browse_hover(e, btn)
            )
            return Container(
                content=Column(
                    controls=[
                        Text(label, color=self.COLORS["text"]["secondary"], size=14, weight=FontWeight.W_500),
                        Container(
                            content=Row(
                                controls=[
                                    self.source_icon if is_source else self.target_icon,
                                    self.source_label if is_source else self.target_label,
                                    hover_button,
                                ],
                                alignment="center",
                                spacing=8,
                            ),
                            border=border.all(2, self.COLORS["border"]["default"]),
                            border_radius=8,
                            bgcolor=self.COLORS["bg"]["input"],
                            padding=12,
                        ),
                    ],
                    spacing=8,
                )
            )

        # Main content area with vertical scrolling
        self.content = Container(
            expand=True,
            height=page.height,
            padding=32,
            content=Column(
                expand=True,
                scroll=ScrollMode.AUTO,
                controls=[
                    # Header (fixed height)
                    Container(
                        content=Column(
                            controls=[
                                Row(
                                    controls=[
                                        Text(
                                            "Localization Comparison Tool",
                                            size=32,
                                            weight="bold",
                                            text_align="center",
                                            expand=True,
                                        ),
                                        self.theme_toggle,
                                    ],
                                    alignment="spaceBetween",
                                ),
                                Text(
                                    "Compare and analyze your localization files with ease",
                                    size=16,
                                    color=self.COLORS["text"]["secondary"],
                                    text_align="center",
                                ),
                            ],
                            horizontal_alignment="center",
                            spacing=8,
                        ),
                        padding=padding.only(bottom=24),
                        height=100,  # Fixed height for header
                    ),
                    # Main card with scrollable content (updated layout)
                    Container(
                        expand=True,
                        content=Column(
                            expand=True,
                            controls=[
                                # File inputs (fixed height remains)
                                Container(
                                    content=ResponsiveRow(
                                        controls=[
                                            Container(
                                                content=create_file_input("Source File", is_source=True),
                                                col={"sm": 12, "md": 6},
                                            ),
                                            Container(
                                                content=create_file_input("Target File", is_source=False),
                                                col={"sm": 12, "md": 6},
                                            ),
                                        ],
                                    ),
                                    height=120,
                                ),
                                # Options (fixed height)
                                Container(
                                    content=Column(
                                        controls=[
                                            Text(
                                                "Comparison Options",
                                                size=16,
                                                weight="w500",
                                                color=self.COLORS["text"]["secondary"],
                                            ),
                                            Row(
                                                controls=[
                                                    self.ignore_case_checkbox,
                                                    self.ignore_whitespace_checkbox,
                                                    self.only_missing_checkbox,
                                                ],
                                                spacing=32,
                                            ),
                                        ],
                                        spacing=16,
                                    ),
                                    padding=padding.symmetric(vertical=24),
                                    height=100,
                                ),
                                # Compare button (fixed height)
                                Container(
                                    content=self.compare_button,
                                    height=50,
                                ),
                                # Results area using dynamic sizing
                                Container(
                                    content=Card(
                                        content=Column(
                                            expand=True,
                                            controls=[
                                                # Results header (unchanged)
                                                Container(
                                                    content=Row(
                                                        controls=[
                                                            Text(
                                                                "Results",
                                                                size=16,
                                                                weight="w500",
                                                                color=self.COLORS["text"]["secondary"],
                                                            ),
                                                            IconButton(
                                                                icon=Icons.COPY,
                                                                icon_color=self.COLORS["text"]["secondary"],
                                                                tooltip="Copy results",
                                                                on_click=self.copy_results,
                                                            ),
                                                        ],
                                                        alignment="spaceBetween",
                                                    ),
                                                    padding=padding.only(left=16, right=16, top=16),
                                                ),
                                                Divider(
                                                    color=self.COLORS["border"]["default"],
                                                    height=1,
                                                ),
                                                # Removed: Split view container of source_text and target_text
                                                # NEW: Container for output summary only
                                                Container(
                                                    content=self.summary_text,
                                                    padding=padding.all(16),
                                                    expand=True,
                                                ),
                                                # Status indicators in footer (unchanged)
                                                Container(
                                                    content=Row(
                                                        controls=[
                                                            self.loading_ring,
                                                            self.status_label,
                                                        ],
                                                        spacing=8,
                                                        vertical_alignment="center",
                                                    ),
                                                    padding=padding.only(left=16, right=16, top=8, bottom=16),
                                                    expand=True,
                                                ),
                                            ],
                                            spacing=32,
                                        ),
                                        elevation=1,
                                    ),
                                    expand=True,
                                ),
                            ],
                            spacing=24,
                        ),
                        bgcolor=self.COLORS["bg"]["secondary"],
                        padding=24,
                        border_radius=12,
                    ),
                ],
                spacing=32,
            ),
        )
        page.add(self.content)
        self.page.on_window_event = self.handle_window_event

    def create_checkbox(self, label: str, value: bool = False):
        return Checkbox(
            label=label,
            value=value,
            fill_color=self.COLORS["bg"]["accent"],
            check_color=self.COLORS["text"]["primary"],
            label_style=TextStyle(
                color=self.COLORS["text"]["secondary"],
                size=14,
            ),
        )

    def create_compare_button(self):
        compare_btn = ElevatedButton(
            content=Row(
                controls=[
                    Icon(Icons.REFRESH),
                    Text("Compare Files", size=16),
                ],
                alignment="center",
                spacing=8,
            ),
            on_click=self.compare_files_gui,
            style=ButtonStyle(
                color=self.COLORS["text"]["primary"],
                bgcolor=self.COLORS["bg"]["accent"],
                shape=RoundedRectangleBorder(radius=8),
            ),
            height=48,
            expand=True,
        )
        return Container(
            content=compare_btn,
            animate=ft.Animation(duration=200, curve="easeInOut"),
            on_hover=lambda e, btn=compare_btn: self._on_compare_button_hover(e, btn)
        )

    def _on_browse_hover(self, e, button):
        hover_color = "#60A5FA" if self.page.theme_mode == "dark" else "#E0E7FF"
        button.bgcolor = hover_color if e.data else self.COLORS["bg"]["accent"]
        button.update()

    def _on_compare_button_hover(self, e, button):
        hover_color = "#60A5FA" if self.page.theme_mode == "dark" else "#E0E7FF"
        button.bgcolor = hover_color if e.data else self.COLORS["bg"]["accent"]
        button.update()

    def get_file_lines(self, file_path):
        """Count number of lines in a file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                return sum(1 for line in f)
        except:
            return 0

    def handle_file_picked(self, e: FilePickerResultEvent, field, icon, clear_btn, field_type):
        if e.files and len(e.files) > 0:
            file_path = e.files[0].path
            if self.validate_file(file_path):
                file_name = Path(file_path).name
                file_size = self.get_readable_file_size(os.path.getsize(file_path))
                line_count = self.get_file_lines(file_path)
                field.value = f"{file_name} ({file_size}, {line_count} lines)"
                # File type indicator logic
                ext = Path(file_path).suffix.lower()
                if ext == ".csv":
                    # ...set icon for CSV...
                    pass
                elif ext in [".lang", ".txt"]:
                    # ...set icon for lang/txt...
                    pass
                else:
                    # ...set a default icon...
                    pass
                if field_type == "source":
                    self.source_file_path = file_path
                else:
                    self.target_file_path = file_path
                icon.color = Colors.BLUE_400
                self.update_compare_button()
                self.page.update()

    def get_readable_file_size(self, size_in_bytes):
        """Convert file size in bytes to human readable format"""
        for unit in ['B', 'KB', 'MB', 'GB']:
            if size_in_bytes < 1024:
                if unit == 'B':
                    return f"{size_in_bytes} {unit}"
                return f"{size_in_bytes:.1f} {unit}"
            size_in_bytes /= 1024
        return f"{size_in_bytes:.1f} TB"

    def clear_file(self, field, icon, clear_btn):
        field.value = ""
        icon.color = Colors.GREY_400
        if field == self.source_field:
            self.source_file_path = ""
        else:
            self.target_file_path = ""
        self.update_compare_button()
        self.page.update()

    def validate_file(self, file_path: str) -> bool:
        try:
            path = Path(file_path)
            if not path.exists() or not path.is_file():
                raise ValueError("File does not exist or is not a valid file")
            if path.suffix.lower()[1:] not in ["csv", "lang", "txt"]:
                raise ValueError("Invalid file type")
            if path.stat().st_size == 0:
                raise ValueError("File is empty")
            with open(file_path, 'r', encoding='utf-8') as f:
                f.read(1024)
            return True
        except Exception as e:
            self.show_snackbar(f"Error: {str(e)}")
            return False

    def handle_source_selected(self, file_path: str):
        self.source_file_path = file_path
        self.update_compare_button()

    def handle_target_selected(self, file_path: str):
        self.target_file_path = file_path
        self.update_compare_button()

    def handle_source_cleared(self):
        self.source_file_path = ""
        self.update_compare_button()

    def handle_target_cleared(self):
        self.target_file_path = ""
        self.update_compare_button()

    def update_compare_button(self):
        """Enable/disable compare button based on file selection"""
        self.compare_button.disabled = not (self.source_file_path and self.target_file_path)
        self.page.update()

    def show_snackbar(self, message):
        self.page.snack_bar.content = Text(message)
        self.page.snack_bar.open = True
        self.page.update()

    def compare_files_gui(self, e):
        self.loading_ring.visible = True
        self.status_label.value = "Comparing files..."
        self.page.update()

        try:
            with open(self.source_file_path, 'r', encoding='utf-8') as f:
                source_content = f.read()
            with open(self.target_file_path, 'r', encoding='utf-8') as f:
                target_content = f.read()
            
            # Determine parser based on file extension
            ext_source = Path(self.source_file_path).suffix.lower()
            ext_target = Path(self.target_file_path).suffix.lower()
            
            if ext_source in [".lang", ".txt"]:
                source_dict = logic.read_lang_file(source_content)
                source_result = logic.ParsingResult(success=bool(source_dict), translations=source_dict,
                                                    error=None if source_dict else "Empty or invalid file",
                                                    details="Parsed using read_lang_file")
            else:
                source_result = logic.read_csv_file(source_content)
            
            if ext_target in [".lang", ".txt"]:
                target_dict = logic.read_lang_file(target_content)
                target_result = logic.ParsingResult(success=bool(target_dict), translations=target_dict,
                                                    error=None if target_dict else "Empty or invalid file",
                                                    details="Parsed using read_lang_file")
            else:
                target_result = logic.read_csv_file(target_content)
            
            if not source_result:
                error_msg = f"Source file error: {source_result.error}"
                if source_result.details:
                    error_msg += f"\n{source_result.details}"
                self.show_snackbar(error_msg)
                self.status_label.value = "Error: Source file parsing failed"
                return
            if not target_result:
                error_msg = f"Target file error: {target_result.error}"
                if target_result.details:
                    error_msg += f"\n{target_result.details}"
                self.show_snackbar(error_msg)
                self.status_label.value = "Error: Target file parsing failed"
                return

            comparison_result = logic.compare_translations(source_result.translations,
                                                           target_result.translations,
                                                           ignore_case=self.ignore_case_checkbox.value,
                                                           ignore_whitespace=self.ignore_whitespace_checkbox.value,
                                                           is_gui=True,
                                                           compare_values=True)
            print("Comparison result:")
            print(comparison_result)
            
            # Update the output fields in a nested try to isolate errors here
            try:
                self.output_text.value = comparison_result
                self.summary_text.value = comparison_result  # adjust as needed
                self.status_label.value = "Comparison successful"
            except Exception as update_error:
                self.show_snackbar(f"Update error: {str(update_error)}")
                self.status_label.value = "Partial success: update failed"
        except Exception as e:
            self.show_snackbar(f"Error: {str(e)}")
            self.status_label.value = "Comparison failed"
        finally:
            self.loading_ring.visible = False
            self.page.update()

    def clear_text_field(self, text_field, clear_btn):
        # Clear the text field and hide the clear button
        text_field.value = ""
        clear_btn.visible = False
        text_field.update()
        clear_btn.update()

    def copy_results(self, e):
        """Copy results text to clipboard and show feedback"""
        self.page.set_clipboard(self.output_text.value)
        self.show_snackbar("Results copied to clipboard")

    def toggle_theme(self, e):
        # Toggle between dark and light themes
        if self.page.theme_mode == "dark":
            self.page.theme_mode = "light"
            self.theme_toggle.icon = Icons.DARK_MODE
        else:
            self.page.theme_mode = "dark"
            self.theme_toggle.icon = Icons.LIGHT_MODE
        self.page.update()

    def open_source_picker(self, e):
        self.source_picker.pick_files()

    def open_target_picker(self, e):
        self.target_picker.pick_files()

    def handle_window_event(self, e):
        # Add window event handling as needed
        pass

    # New method: format_comparison_line
    def format_comparison_line(self, key: str, value: str, change_type: str, max_key_length: int):
        # Build a basic formatted line with a change indicator and aligned key.
        # For indicator: use first letter of change_type (e.g., "+" for added, "-" for removed, "M" for modified)
        if change_type == "added":
            indicator = "+ "
        elif change_type == "removed":
            indicator = "- "
        elif change_type == "modified":
            indicator = "M "
        else:
            indicator = "  "
        line = f"{indicator}{key.ljust(max_key_length)} : {value}"
        # Delegate syntax highlighting to our helper module.
        import syntax_highlighter
        return syntax_highlighter.highlight_line(line, change_type)

    # New method: format_summary
    def format_summary(self, added: int, removed: int, modified: int) -> str:
        return f"--- Summary ---\nAdded: {added}\nRemoved: {removed}\nModified: {modified}"

def main(page: Page):
    my_app = App(page)
    page.update()

if __name__ == "__main__":
    ft.app(target=main)