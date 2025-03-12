import flet as ft
from flet import (
    Text, TextField, Container, Column, Row, IconButton, 
    Icons, padding, TextStyle, FontWeight, ScrollMode,
    Icon, border
)

class ResultsViewComponent:
    def __init__(self, page: ft.Page, app_reference, colors: dict):
        self.page = page
        self.app = app_reference
        self.colors = colors
        self.expand_all = True
        self.original_result_rows = []

        # Create UI elements
        self.output_text = self._create_output_text()
        self.summary_text = self._create_summary_text()
        self.expand_collapse_button = self._create_expand_collapse_button()
        self.results_header = self._create_results_header()
        self.results_tabs = self._create_results_tabs()

        # Initialize search field
        self.search_field = TextField(
            hint_text="Search results...",
            on_change=lambda e: self.filter_results(e.control.value),
            border=border.all(color=colors["border"]["default"]),
            content_padding=padding.all(10),
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
                color=self.colors["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )

    def _create_summary_text(self):
        return TextField(
            value="Summary will appear here",
            read_only=True,
            multiline=True,
            text_style=TextStyle(
                color=self.colors["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            ),
            border=None,
            cursor_color="transparent",
            bgcolor="transparent",
            expand=True,
        )

    def _create_expand_collapse_button(self):
        return IconButton(
            icon=Icons.UNFOLD_LESS,
            icon_color=self.colors["text"]["secondary"],
            tooltip="Collapse All",
            on_click=self.toggle_expand_all,
        )

    def _create_results_header(self):
        return Container(
            content=Row(
                controls=[
                    Text(
                        "Results",
                        size=16,
                        weight="w500",
                        color=self.colors["text"]["secondary"],
                    ),
                    Row(
                        controls=[
                            self.expand_collapse_button,
                            IconButton(
                                icon=Icons.COPY,
                                icon_color=self.colors["text"]["secondary"],
                                tooltip="Copy comparison results",
                                on_click=self.copy_results,
                            ),
                        ],
                        spacing=8,
                    ),
                ],
                alignment="spaceBetween",
            ),
            padding=padding.only(left=16, right=16, top=16),
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
                Text("No comparison results to display", color=self.colors["text"]["secondary"])
            ]
            self.page.update()
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
            return Row(controls=[])
            
        if line.startswith("+"):
            icon = Icon(Icons.ADD, color="green")
        elif line.startswith("-"):
            icon = Icon(Icons.REMOVE, color="red")
        elif line.startswith("~"):
            icon = Icon(Icons.WARNING, color="yellow")
        else:
            icon = Icon(Icons.HELP, color="grey")
        line_num_display = f"[Line {line_number}] " if line_number is not None else ""
        return Row(
            controls=[
                icon,
                Text(f"{line_num_display}{line}", color=self.colors["text"]["secondary"])
            ],
            spacing=8
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
        self.colors = colors
        
        # Update text styles and colors
        for text_field in [self.output_text, self.summary_text]:
            text_field.text_style = TextStyle(
                color=colors["text"]["secondary"],
                size=14,
                font_family="Consolas",
                weight=FontWeight.W_400,
            )
        
        # Update header colors
        self.results_header.content.controls[0].color = colors["text"]["secondary"]
        self.expand_collapse_button.icon_color = colors["text"]["secondary"]
        
        # Update borders and backgrounds
        self.results_container.bgcolor = "transparent"

        # Safely update search field and results
        if hasattr(self, 'search_field'):
            self.search_field.border = border.all(color=colors["border"]["default"])
        
        # Update result rows text colors
        for row in self.original_result_rows:
            if len(row.controls) > 1 and isinstance(row.controls[1], Text):
                row.controls[1].color = colors["text"]["secondary"]
        
        self.page.update()
