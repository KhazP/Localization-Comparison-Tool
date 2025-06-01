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

    def _create_section_header(self, title: str) -> Row:
        """Helper to create a consistent section header Text control wrapped in a Row."""
        primary_color = self.colors.get("text", {}).get("primary", "white")
        return Row(controls=[
            Text(title, weight=FontWeight.BOLD, color=primary_color, size=14)
        ])

    def build_results_table(self, comparison_details: dict):
        """Builds the results display from structured comparison data."""
        self.results_content.controls.clear()
        self.original_result_rows = []
        result_rows_for_display = []

        if not comparison_details or not comparison_details.get("summary"):
            self.results_content.controls = [
                Text("No comparison data available.", color=self.colors.get("text", {}).get("secondary", "grey"))
            ]
            if self.page: self.page.update()
            return

        # Order of sections: Mismatches, Missing, Obsolete, Differences
        placeholder_mismatches = comparison_details.get("placeholder_mismatches", {})
        if placeholder_mismatches:
            result_rows_for_display.append(self._create_section_header("--- Placeholder Mismatches ---"))
            for key, data in sorted(placeholder_mismatches.items()):
                text_content = f"{key}: Target '{data.get('target_value', '')[:50]}...' ({data.get('message', 'No message')})"
                result_rows_for_display.append(self.create_result_row(text_content, "placeholder_mismatch", key))
        
        missing_in_target = comparison_details.get("missing_in_target", {})
        if missing_in_target:
            result_rows_for_display.append(self._create_section_header("--- Missing in Target (Source Value Shown) ---"))
            for key, value in sorted(missing_in_target.items()):
                text_content = f"{key}: '{str(value)[:50]}...'"
                result_rows_for_display.append(self.create_result_row(text_content, "missing", key))

        obsolete_in_target = comparison_details.get("obsolete_in_target", {})
        if obsolete_in_target:
            result_rows_for_display.append(self._create_section_header("--- Obsolete in Target (Target Value Shown) ---"))
            for key, value in sorted(obsolete_in_target.items()):
                text_content = f"{key}: '{str(value)[:50]}...'"
                result_rows_for_display.append(self.create_result_row(text_content, "obsolete", key))

        value_differences = comparison_details.get("value_differences", {})
        if value_differences:
            result_rows_for_display.append(self._create_section_header("--- Value Differences (Common Keys) ---"))
            for key, data in sorted(value_differences.items()):
                text_content = (f"{key}: "
                                f"Src: '{data.get('source_value', '')[:30]}...' "
                                f"Tgt: '{data.get('target_value', '')[:30]}...'")
                result_rows_for_display.append(self.create_result_row(text_content, "diff", key))
        
        if not result_rows_for_display:
             result_rows_for_display.append(Text("No differences found.", color=self.colors.get("text",{}).get("secondary","grey")))

        self.original_result_rows = result_rows_for_display
        self.results_content.controls.extend(result_rows_for_display)
        
        self.results_container.content = self.results_column
        self.search_field.value = ""
        if self.page: self.page.update()

    def create_result_row(self, text_content: str, change_type: str, key: str) -> Row:
        icon_widget = Icon(Icons.ERROR_OUTLINE, color="grey")
        text_color = self.colors.get("text", {}).get("secondary", "grey")

        diff_colors = self.colors.get("diff", {})
        icon_color_map = {
            "missing": diff_colors.get("added", "green"),
            "obsolete": diff_colors.get("removed", "red"),
            "placeholder_mismatch": diff_colors.get("mismatch", "yellow"),
            "diff": diff_colors.get("changed", "blue")
        }
        
        icon_type_map = {
            "missing": Icons.ADD_CIRCLE_OUTLINE,
            "obsolete": Icons.REMOVE_CIRCLE_OUTLINE,
            "placeholder_mismatch": Icons.WARNING_AMBER_ROUNDED,
            "diff": Icons.SWAP_HORIZ
        }

        icon_widget = Icon(icon_type_map.get(change_type, Icons.ERROR_OUTLINE),
                           color=icon_color_map.get(change_type, "grey"))
        text_color = icon_color_map.get(change_type, text_color)

        line_num_display_text = ""
        if self.app.config.get("show_line_numbers", False) and key:
            num = None
            if hasattr(self.app, 'source_line_numbers') and self.app.source_line_numbers:
                num = self.app.source_line_numbers.get(key)
            elif hasattr(self.app, 'target_line_numbers') and self.app.target_line_numbers and change_type == "obsolete":
                num = self.app.target_line_numbers.get(key)
            
            if num is not None:
                line_num_display_text = f"[L:{num}] "

        return Row(
            controls=[
                icon_widget,
                Text(f"{line_num_display_text}{text_content}",
                     color=text_color,
                     overflow="ellipsis",
                     tooltip=f"{line_num_display_text}{text_content}")
            ],
            spacing=8
        )

    def group_keys_by_namespace(self, items: list, item_type: str = None) -> dict:
        # This method needs to be adapted for structured data.
        # For now, it's a placeholder and not actively used by the refactored build_results_table.
        # If called, it will just return a general group.
        # To properly implement, it would need to iterate `items` which could be dicts of dicts,
        # extract keys, and then group based on the key string.
        # Example structure of items (e.g., for missing_in_target): { "key1": "value1", "key2.sub": "value2" }

        grouped_items = {}
        if isinstance(items, dict): # Assuming items is one of the sections like missing_in_target
            for key, data_or_value in items.items():
                namespace = key.split('.')[0] if '.' in key else "General"
                if namespace not in grouped_items:
                    grouped_items[namespace] = {}
                grouped_items[namespace][key] = data_or_value
            return grouped_items
        elif isinstance(items, list): # If it's a list of Row controls (less likely for initial grouping)
             return {"General": items} # Fallback for list input
        return {"General": items if items else {}}


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
