import flet as ft
from flet import (
    Text, TextField, Container, Column, Row, IconButton, 
    Icons, padding, TextStyle, FontWeight, ScrollMode,
    Icon, border
)

class ResultsViewComponent:
    def __init__(self, page: ft.Page, app_reference, colors: dict):
        self.page = page
        self.app = app_reference # Assuming app_reference.COLORS gives M3 theme
        self.colors = colors # This will be updated by update_colors with M3 theme
        self.expand_all = True
        self.original_result_rows = []

        # Create UI elements - initial styling will be M3 via self.colors (once updated)
        # or directly using self.app.COLORS if available during init.
        # For safety, make them use self.colors and ensure update_colors is called early.
        self.output_text = self._create_output_text()
        self.summary_text = self._create_summary_text()
        self.expand_collapse_button = self._create_expand_collapse_button()
        self.results_header = self._create_results_header() # Contains expand_collapse_button
        self.results_tabs = self._create_results_tabs()

        # Initialize search field
        self.search_field = TextField(
            hint_text="Search results...",
            on_change=lambda e: self.filter_results(e.control.value),
            text_style=TextStyle(color=self.colors.get("onSurface")),
            hint_style=TextStyle(color=self.colors.get("onSurfaceVariant")),
            border_color=self.colors.get("outline"),
            focused_border_color=self.colors.get("primary"),
            border_radius=8, # M3 like radius
            border_width=1,
            content_padding=padding.symmetric(horizontal=12, vertical=8), # M3 like padding
            bgcolor=self.colors.get("surfaceContainerHigh"),
        )

        # Initialize results content
        self.results_content = Column(  # Results container
            controls=[],
            scroll=ScrollMode.AUTO,
            spacing=2,
            expand=True,
        )

        # Initialize results column with search field
        self.results_column = Column(
            controls=[
                self.search_field,
                self.results_content
            ],
            spacing=10,
            scroll=ScrollMode.AUTO,
            expand=True,  # Make sure the column expands
        )

        # Create the results container after initializing the column
        self.results_container = self._create_results_container()

    def _create_output_text(self):
        return TextField(
            value="Comparison results will appear here",
            multiline=True,
            read_only=True,
            min_lines=20,
            max_lines=None,
            text_style=TextStyle(
                color=self.colors.get("onSurfaceVariant"), # M3 role
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=ft.InputBorder.NONE, # M3 text fields can be borderless on some surfaces
            bgcolor=self.colors.get("surface"), # M3 surface
            expand=True,
        )

    def _create_summary_text(self):
        return TextField(
            value="Summary will appear here",
            read_only=True,
            multiline=True,
            text_style=TextStyle(
                color=self.colors.get("onSurfaceVariant"), # M3 role
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=ft.InputBorder.NONE,
            bgcolor=self.colors.get("surface"), # M3 surface
            expand=True,
        )

    def _create_expand_collapse_button(self):
        return IconButton(
            icon=Icons.UNFOLD_LESS,
            icon_color=self.colors.get("onSurfaceVariant"), # M3 role
            tooltip="Collapse All",
            on_click=self.toggle_expand_all,
        )

    def _create_results_header(self):
        # This header is part of the ResultsViewComponent
        return Container(
            content=Row(
                controls=[
                    Text(
                        "Results", # Title for this section
                        size=16, # M3 Title Medium
                        weight=FontWeight.W_500,
                        color=self.colors.get("onSurfaceVariant"), # M3 role
                    ),
                    Row( # Buttons on the right
                        controls=[
                            self.expand_collapse_button, # Already created with M3 style
                            IconButton(
                                icon=Icons.COPY,
                                icon_color=self.colors.get("onSurfaceVariant"), # M3 role
                                tooltip="Copy comparison results",
                                on_click=self.copy_results,
                            ),
                        ],
                        spacing=0, # M3 icon buttons can be close
                    ),
                ],
                alignment="spaceBetween", # Pushes title left, buttons right
            ),
            padding=padding.symmetric(horizontal=16, vertical=8), # M3 padding
        )

    def _create_results_tabs(self):
        return ft.Tabs(
            selected_index=0,
            animation_duration=300,
            tabs=[],
            visible=False,
            expand=True,
        )

    def _create_results_container(self):
        # Start with the results column visible
        return Container(
            content=self.results_column,
            padding=padding.all(8),  # Reduce padding to give more space for content
            expand=True,
        )

    def build_results_table(self, comparison_result: str):
        """Initialize the results table with search field and content"""
        if not comparison_result:
            self.results_content.controls = [
                Text("No comparison results to display", color=self.colors.get("onSurfaceVariant"))
            ]
            # No need to self.page.update() here, caller should handle it or it's part of a larger update
            return

        lines = comparison_result.splitlines()
        sorted_lines = sorted(lines, key=lambda l: {'-': 0, '~': 1, '+': 2}.get(l[0] if l else '', 3))
        result_rows = []
        
        if hasattr(self.app, 'config') and self.app.config.get("group_by_namespace", True):
            groups = self.group_keys_by_namespace(sorted_lines)
            for namespace, group_lines in groups.items():
                header = Row(controls=[Text(f"Namespace: {namespace}", weight="bold")])
                result_rows.append(header)
                for line in group_lines:
                    key = line.split(" ", 1)[-1].split(":", 1)[0].strip() if " " in line else ""
                    line_number = self.app.source_line_numbers.get(key, None) if hasattr(self.app, "show_line_numbers") and getattr(self.app, "show_line_numbers", False) else None
                    row = self.create_result_row(line, line_number=line_number)
                    result_rows.append(row)
        else:
            for line in sorted_lines:
                if not line.strip():  # Skip empty lines
                    continue
                key = line.split(" ", 1)[-1].split(":", 1)[0].strip() if " " in line else ""
                line_number = self.app.source_line_numbers.get(key, None) if hasattr(self.app, "show_line_numbers") and getattr(self.app, "show_line_numbers", False) else None
                row = self.create_result_row(line, line_number=line_number)
                result_rows.append(row)

        self.original_result_rows = result_rows

        # Clear the results content and add the new rows
        self.results_content.controls.clear()
        self.results_content.controls.extend(result_rows)
        
        # Make sure the results column is visible and contains our content
        self.results_container.content = self.results_column
        
        # Clear any search filtering
        self.search_field.value = ""
        
        # Update the UI
        self.page.update()

    def create_result_row(self, line: str, line_number: int = None) -> Row:
        if not line:
            return Row(controls=[]) # Should ideally not happen if input is clean
            
        icon_widget = Icon()
        if line.startswith("+"):
            icon_widget.name = Icons.ADD_CIRCLE_OUTLINE
            icon_widget.color = self.colors.get("tertiary") # Or a specific "success" color
        elif line.startswith("-"):
            icon_widget.name = Icons.REMOVE_CIRCLE_OUTLINE
            icon_widget.color = self.colors.get("error")
        elif line.startswith("~"):
            icon_widget.name = Icons.WARNING_AMBER_ROUNDED
            icon_widget.color = self.colors.get("secondary") # Or a specific "warning" color
        else: # Neutral or no change
            icon_widget.name = Icons.INFO_OUTLINE # Or a more neutral icon
            icon_widget.color = self.colors.get("onSurfaceVariant")

        line_num_display = f"[L:{line_number}] " if line_number is not None else ""

        text_content = Text(
            f"{line_num_display}{line}",
            color=self.colors.get("onSurface"),
            font_family="Consolas", # Keep monospace for alignment
            size=13 # Slightly smaller for dense info
        )

        return Row(
            controls=[icon_widget, text_content],
            spacing=8,
            vertical_alignment=ft.CrossAxisAlignment.START # Align icon with first line of text
        )

    def group_keys_by_namespace(self, lines: list[str]) -> dict:
        groups = {}
        for line in lines:
            try:
                indicator, rest = line.split(" ", 1)
                key_part = rest.split(":", 1)[0].strip()
            except ValueError:
                key_part = "General"
            namespace = key_part.split(".")[0] if "." in key_part else "General"
            groups.setdefault(namespace, []).append(line)
        return groups

    def filter_results(self, query: str):
        query = query.lower()
        filtered_rows = []
        current_namespace = None
        namespace_has_matches = False
        namespace_content = []
        
        for row in self.original_result_rows:
            if len(row.controls) == 1 and isinstance(row.controls[0], Text) and row.controls[0].weight == "bold":
                if current_namespace and namespace_has_matches:
                    filtered_rows.append(current_namespace)
                    filtered_rows.extend(namespace_content)
                current_namespace = row
                namespace_content = []
                namespace_has_matches = False
                continue
            
            if len(row.controls) > 1 and isinstance(row.controls[1], Text):
                text = row.controls[1].value.lower()
                if query in text:
                    if current_namespace:
                        namespace_content.append(row)
                        namespace_has_matches = True
                    else:
                        filtered_rows.append(row)
        
        if current_namespace and namespace_has_matches:
            filtered_rows.append(current_namespace)
            filtered_rows.extend(namespace_content)
        
        self.results_content.controls = filtered_rows
        self.page.update()

    def toggle_expand_all(self, e):
        self.expand_all = not self.expand_all
        # Update visibility of sections based on expand_all state
        for row in self.original_result_rows:
            if len(row.controls) == 1 and isinstance(row.controls[0], Text) and row.controls[0].weight == "bold":
                row.visible = self.expand_all
        self.page.update()

    def copy_results(self, e):
        self.page.set_clipboard(self.output_text.value)
        if hasattr(self.app, 'show_snackbar'):
            self.app.show_snackbar("Results copied to clipboard")

    def update_colors(self, colors: dict):
        """Update component colors when theme changes"""
        self.colors = colors # The new M3 theme colors from App
        
        # Update TextFields (output_text, summary_text)
        for tf in [self.output_text, self.summary_text]:
            if tf:
                tf.text_style.color = self.colors.get("onSurfaceVariant")
                tf.bgcolor = self.colors.get("surface")
                # tf.border = ft.InputBorder.NONE # Keep as initially set or update if needed

        # Update Results Header (Text and IconButtons)
        if self.results_header and self.results_header.content and isinstance(self.results_header.content, Row):
            # "Results" Text
            results_text = self.results_header.content.controls[0]
            if isinstance(results_text, Text):
                results_text.color = self.colors.get("onSurfaceVariant")

            # Buttons Row
            buttons_row = self.results_header.content.controls[1]
            if isinstance(buttons_row, Row):
                for btn_control in buttons_row.controls:
                    if isinstance(btn_control, IconButton):
                        btn_control.icon_color = self.colors.get("onSurfaceVariant")
        
        # Update Search Field
        if self.search_field:
            self.search_field.text_style.color = self.colors.get("onSurface")
            self.search_field.hint_style.color = self.colors.get("onSurfaceVariant")
            self.search_field.border_color = self.colors.get("outline")
            self.search_field.focused_border_color = self.colors.get("primary")
            self.search_field.bgcolor = self.colors.get("surfaceContainerHigh")

        # Update Results Container (background)
        if self.results_container:
            self.results_container.bgcolor = self.colors.get("surface") # Or transparent if Card provides surface

        # Update dynamically created result rows (icons and text)
        # This requires re-styling existing rows if they are already in self.results_content.controls
        # or ensuring new rows created by build_results_table use new colors.
        # The create_result_row method will now use self.colors which are updated.
        # If rows are stored in self.original_result_rows, we can update them:
        for row in self.original_result_rows:
            if row.controls and len(row.controls) > 0:
                icon_widget = row.controls[0]
                if isinstance(icon_widget, Icon):
                    # Re-apply color based on icon type logic in create_result_row
                    line_text_widget = row.controls[1] if len(row.controls) > 1 else None
                    line_text_value = line_text_widget.value if line_text_widget and isinstance(line_text_widget, Text) else ""

                    if line_text_value.startswith("+"): # Assuming line still has +/-
                        icon_widget.color = self.colors.get("tertiary")
                    elif line_text_value.startswith("-"):
                        icon_widget.color = self.colors.get("error")
                    elif line_text_value.startswith("~"):
                        icon_widget.color = self.colors.get("secondary")
                    else:
                        icon_widget.color = self.colors.get("onSurfaceVariant")

                text_widget = row.controls[1] if len(row.controls) > 1 else None
                if isinstance(text_widget, Text):
                    text_widget.color = self.colors.get("onSurface")
        
        # If results are currently displayed, trigger a re-render of those specific controls
        # This is simpler if build_results_table is called again after colors change,
        # but for now, let's try to update existing controls.
        if self.results_content:
            self.results_content.update()

        # self.page.update() # Should be handled by the main App class after all components update
