import flet as ft
from flet import (
    Text, TextField, Container, Column, Row, IconButton,
    Icons, padding, TextStyle, FontWeight, ScrollMode,
    Icon, border, colors as ft_colors, alignment, ListView
)

class ResultsViewComponent:
    def __init__(self, page: ft.Page, app_reference, colors: dict):
        self.page = page
        self.app = app_reference # Provides access to COLORS, spacing, TEXT_SIZE constants
        self.colors = colors
        self.expand_all_values = True # For toggling all value cells
        
        # This will store the structured data for filtering and rebuilding
        self.original_result_data = [] 

        # Create UI elements
        # These seem to be legacy/for raw text copy-paste, keep them for now.
        self.output_text = self._create_output_text() 
        self.summary_text = self._create_summary_text()

        self.expand_collapse_button = self._create_expand_collapse_button()
        self.results_header = self._create_results_header()
        self.results_tabs = self._create_results_tabs() # For potential directory comparison

        self.search_field = TextField(
            hint_text="Search results (key, source value, target value)...",
            on_change=lambda e: self.filter_results(e.control.value),
            border=border.all(color=self.colors["border"]["default"]),
            content_padding=self.app.spacing["s"],
            text_style=TextStyle(size=self.app.TEXT_SIZE_DEFAULT, color=self.colors["text"]["primary"]),
            hint_style=TextStyle(size=self.app.TEXT_SIZE_DEFAULT, color=self.colors["text"]["secondary"]),
        )

        self.results_list_view = ListView(
            controls=[],
            spacing=self.app.spacing["xxs"],
            expand=True,
            auto_scroll=True,
        )

        self.results_column = Column(
            controls=[
                self.search_field,
                self.results_list_view
            ],
            spacing=self.app.spacing["s"],
            expand=True,
        )
        self.results_container = self._create_results_container()

    # --- Constants for structured data keys ---
    KEY_NAME = "key_name"
    STATUS = "status"
    SOURCE_VALUE = "source_value"
    TARGET_VALUE = "target_value"
    SOURCE_LINE = "source_line"
    TARGET_LINE = "target_line"
    NAMESPACE = "namespace" # Not used in current flat list display but available

    # --- Status types (ensure these match what logic.py will provide) ---
    STATUS_ADDED = "added"
    STATUS_REMOVED = "removed"
    STATUS_MODIFIED = "modified" 
    STATUS_UNTRANSLATED = "untranslated" # Example: target is empty, source has value
    STATUS_IDENTICAL = "identical" # Example: if showing identical values is an option

    MAX_VALUE_LENGTH = 70  # Max characters for value before truncating

    def _create_output_text(self): # Legacy or for copy-paste
        return TextField(
            value="", multiline=True, read_only=True, min_lines=5, max_lines=10, # Reduced lines
            text_style=TextStyle(color=self.colors["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT, font_family="Consolas"),
            border=None, bgcolor="transparent", expand=True, visible=False # Initially hidden
        )

    def _create_summary_text(self): # Legacy or for copy-paste
        return TextField(
            value="", read_only=True, multiline=True,
            text_style=TextStyle(color=self.colors["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT, font_family="Consolas"),
            border=None, bgcolor="transparent", expand=True, visible=False # Initially hidden
        )

    def _create_expand_collapse_button(self):
        return IconButton(
            icon=Icons.UNFOLD_LESS,
            icon_color=self.colors["text"]["secondary"],
            tooltip="Collapse/Expand All Values",
            on_click=self.toggle_expand_all_values_globally,
            icon_size=self.app.TEXT_SIZE_LARGE,
        )

    def _create_results_header(self):
        # This structure was defined in flet_gui.py, ensure consistency
        return Container(
            content=Row(
                controls=[
                    Text("Results", size=self.app.TEXT_SIZE_MEDIUM, weight=FontWeight.W_500, color=self.colors["text"]["secondary"]),
                    Row(
                        controls=[
                            self.expand_collapse_button,
                            IconButton(icon=Icons.COPY, icon_color=self.colors["text"]["secondary"], tooltip="Copy Results as Text", on_click=self.copy_results, icon_size=self.app.TEXT_SIZE_LARGE),
                        ],
                        spacing=self.app.spacing["xs"],
                    ),
                ],
                alignment="spaceBetween",
            ),
            padding=ft.padding.only(left=self.app.spacing["m"], right=self.app.spacing["m"], top=self.app.spacing["m"], bottom=self.app.spacing["xs"]),
        )

    def _create_results_tabs(self): # For potential directory comparison
        return ft.Tabs(selected_index=0, animation_duration=300, tabs=[], visible=False, expand=True)

    def _create_results_container(self):
        return Container(content=self.results_column, padding=self.app.spacing["xs"], expand=True)

    def _get_status_visuals(self, status: str):
        status_map = {
            self.STATUS_ADDED: {"icon": Icons.ADD_CIRCLE_OUTLINE, "color": self.colors["changes"].get("added", "green")},
            self.STATUS_REMOVED: {"icon": Icons.REMOVE_CIRCLE_OUTLINE, "color": self.colors["changes"].get("removed", "red")},
            self.STATUS_MODIFIED: {"icon": Icons.CHANGE_HISTORY, "color": self.colors["changes"].get("modified", "amber")},
            self.STATUS_UNTRANSLATED: {"icon": Icons.EDIT_OFF_OUTLINED, "color": self.colors["text"].get("secondary", "grey")},
            self.STATUS_IDENTICAL: {"icon": Icons.CHECK_CIRCLE_OUTLINE, "color": self.colors.get("changes",{}).get("identical", "blue")}, # Assuming you add 'identical' to themes
        }
        default_visual = {"icon": Icons.HELP_OUTLINE, "color": self.colors["text"].get("secondary", "grey")}
        return status_map.get(status, default_visual)

    def _toggle_value_expansion(self, text_control: ft.Text, button_control: ft.IconButton, full_value: str, is_expanded_state: list):
        is_expanded = is_expanded_state[0]
        if is_expanded:
            text_control.value = full_value[:self.MAX_VALUE_LENGTH] + "..." if len(full_value) > self.MAX_VALUE_LENGTH else full_value
            button_control.icon = Icons.EXPAND_MORE
            button_control.tooltip = "Expand value"
        else:
            text_control.value = full_value
            button_control.icon = Icons.EXPAND_LESS
            button_control.tooltip = "Collapse value"
        is_expanded_state[0] = not is_expanded 
        self.page.update()


    def _create_value_cell(self, value: str | None, data_key_for_search: str, initial_expanded: bool) -> ft.Control:
        if value is None:
            return ft.Text("-", italic=True, color=self.colors["text"]["disabled"], size=self.app.TEXT_SIZE_DEFAULT, font_family="Consolas")

        text_control = ft.Text(
            font_family="Consolas",
            size=self.app.TEXT_SIZE_DEFAULT,
            color=self.colors["text"]["primary"] 
        )
        text_control.data = data_key_for_search # For search to identify this field

        if len(value) > self.MAX_VALUE_LENGTH:
            # Store the expanded state for this cell, default to not expanded (matching expand_all_values = True meaning values are initially collapsed)
            is_expanded_state = [not initial_expanded] # List to pass by reference

            if initial_expanded: # If globally set to expand, show full
                 text_control.value = value
                 current_icon = Icons.EXPAND_LESS
                 tooltip = "Collapse value"
                 is_expanded_state[0] = True
            else: # Globally set to collapse, show truncated
                 text_control.value = value[:self.MAX_VALUE_LENGTH] + "..."
                 current_icon = Icons.EXPAND_MORE
                 tooltip = "Expand value"
                 is_expanded_state[0] = False

            expand_button = ft.IconButton(
                current_icon,
                icon_size=self.app.TEXT_SIZE_MEDIUM,
                tooltip=tooltip,
                on_click=lambda e_args: self._toggle_value_expansion(text_control, e_args.control, value, is_expanded_state)
            )
            return ft.Row([text_control, expand_button], spacing=self.app.spacing["xxs"], vertical_alignment=ft.CrossAxisAlignment.START, tight=True)
        else:
            text_control.value = value
            return text_control
            
    def create_result_row(self, diff_object: dict, index: int) -> ft.Container:
        status_visuals = self._get_status_visuals(diff_object.get(self.STATUS, ""))
        
        key_name_text = ft.Text(
            str(diff_object.get(self.KEY_NAME, "")), 
            font_family="Consolas", size=self.app.TEXT_SIZE_DEFAULT, 
            weight=FontWeight.BOLD, color=self.colors["text"]["primary"]
        )
        key_name_text.data = self.KEY_NAME 

        row_controls = [
            ft.Container(content=ft.Icon(name=status_visuals["icon"], color=status_visuals["color"], size=self.app.TEXT_SIZE_LARGE), width=self.app.spacing["xl"], alignment=alignment.center_left),
            ft.Container(content=key_name_text, expand=2, padding=padding.only(right=self.app.spacing["xs"])),
            ft.Container(content=self._create_value_cell(diff_object.get(self.SOURCE_VALUE), self.SOURCE_VALUE, self.expand_all_values), expand=3, padding=padding.only(right=self.app.spacing["xs"])),
            ft.Container(content=self._create_value_cell(diff_object.get(self.TARGET_VALUE), self.TARGET_VALUE, self.expand_all_values), expand=3),
        ]

        if self.app.config.get("show_line_numbers", False):
            s_line, t_line = diff_object.get(self.SOURCE_LINE), diff_object.get(self.TARGET_LINE)
            line_parts = [f"S:{s_line}" if s_line else "", f"T:{t_line}" if t_line else ""]
            line_text = " ".join(filter(None, line_parts))
            row_controls.append(ft.Container(content=ft.Text(line_text, size=self.app.TEXT_SIZE_SMALL, color=self.colors["text"]["secondary"]), width=self.app.spacing["xxl"] + self.app.spacing["s"], alignment=alignment.center_left, padding=padding.only(left=self.app.spacing["xs"])))
        
        alt_bg_color = ft_colors.with_opacity(0.02, self.colors["text"]["primary"])
        
        return ft.Container(
            content=ft.Row(controls=row_controls, spacing=self.app.spacing["xs"], vertical_alignment=ft.CrossAxisAlignment.START),
            padding=padding.symmetric(vertical=self.app.spacing["xs"], horizontal=self.app.spacing["xxs"]),
            border_radius=self.app.spacing["xxs"],
            bgcolor=alt_bg_color if index % 2 != 0 else None,
        )

    def build_results_table(self, comparison_results: list):
        self.results_list_view.controls.clear()
        self.original_result_data = [] 

        if not comparison_results or not isinstance(comparison_results, list):
            self.results_list_view.controls.append(
                ft.Text("No results or data in incorrect format.", color=self.colors["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT)
            )
        else:
            self.original_result_data = comparison_results
            for index, diff_object in enumerate(comparison_results):
                # Basic namespace display if present
                current_namespace = diff_object.get(self.NAMESPACE)
                if current_namespace and (index == 0 or current_namespace != comparison_results[index-1].get(self.NAMESPACE)):
                    ns_header = ft.Text(f"Namespace: {current_namespace}", weight=FontWeight.BOLD, size=self.app.TEXT_SIZE_MEDIUM, color=self.colors["text"]["accent"])
                    self.results_list_view.controls.append(ft.Container(ns_header, padding=padding.only(top=self.app.spacing["m"], bottom=self.app.spacing["xs"])))
                
                row_container = self.create_result_row(diff_object, index)
                self.results_list_view.controls.append(row_container)
        
        if not self.results_list_view.controls:
             self.results_list_view.controls.append(
                ft.Text("No comparison results to display.", color=self.colors["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT)
            )
        self.search_field.value = "" 
        self.results_list_view.update()
        if hasattr(self.page, 'update'): self.page.update()

    def filter_results(self, query: str):
        query = query.lower().strip()
        self.results_list_view.controls.clear()
        
        data_to_filter = self.original_result_data
        
        filtered_data = []
        if not query:
            filtered_data = data_to_filter
        else:
            for diff_object in data_to_filter:
                key_name = str(diff_object.get(self.KEY_NAME, "")).lower()
                source_val = str(diff_object.get(self.SOURCE_VALUE, "")).lower()
                target_val = str(diff_object.get(self.TARGET_VALUE, "")).lower()
                if query in key_name or query in source_val or query in target_val:
                    filtered_data.append(diff_object)
        
        if not filtered_data:
            self.results_list_view.controls.append(
                ft.Text(f"No results found for '{query}'.", color=self.colors["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT)
            )
        else:
            for index, diff_object in enumerate(filtered_data):
                # Re-add namespace headers if necessary during filtered view
                current_namespace = diff_object.get(self.NAMESPACE)
                if current_namespace and (index == 0 or current_namespace != filtered_data[index-1].get(self.NAMESPACE)):
                     ns_header = ft.Text(f"Namespace: {current_namespace}", weight=FontWeight.BOLD, size=self.app.TEXT_SIZE_MEDIUM, color=self.colors["text"]["accent"])
                     self.results_list_view.controls.append(ft.Container(ns_header, padding=padding.only(top=self.app.spacing["m"], bottom=self.app.spacing["xs"])))
                row_container = self.create_result_row(diff_object, index) # Pass index for alternating bg
                self.results_list_view.controls.append(row_container)

        self.results_list_view.update()
        if hasattr(self.page, 'update'): self.page.update()

    def toggle_expand_all_values_globally(self, e):
        self.expand_all_values = not self.expand_all_values
        self.expand_collapse_button.icon = Icons.UNFOLD_LESS if self.expand_all_values else Icons.UNFOLD_MORE
        self.expand_collapse_button.tooltip = "Collapse All Values" if self.expand_all_values else "Expand All Values"
        self.expand_collapse_button.update()
        
        # Rebuild the list with the new expansion state respected by _create_value_cell
        # This is simpler than trying to update each cell's internal state externally
        current_data = self.original_result_data
        if self.search_field.value: # If search is active, rebuild based on filtered view (which is not stored, so re-filter)
            # This is inefficient. A better way would be to store the currently displayed data.
            # For now, just rebuild all original data. User can re-apply search if needed.
            # Or, we can re-run filter_results to get the current set of diff_objects
            # For simplicity now, this global toggle will apply to the full list, search may need re-application by user.
            pass # Filtered list is not stored directly, this toggle will apply to initial render of cells

        self.results_list_view.controls.clear()
        if not current_data:
             self.results_list_view.controls.append(
                ft.Text("No results to display.", color=self.colors["text"]["secondary"], size=self.app.TEXT_SIZE_DEFAULT)
            )
        else:
            for index, diff_object in enumerate(current_data):
                current_namespace = diff_object.get(self.NAMESPACE)
                if current_namespace and (index == 0 or current_namespace != current_data[index-1].get(self.NAMESPACE)):
                    ns_header = ft.Text(f"Namespace: {current_namespace}", weight=FontWeight.BOLD, size=self.app.TEXT_SIZE_MEDIUM, color=self.colors["text"]["accent"])
                    self.results_list_view.controls.append(ft.Container(ns_header, padding=padding.only(top=self.app.spacing["m"], bottom=self.app.spacing["xs"])))
                row_container = self.create_result_row(diff_object, index)
                self.results_list_view.controls.append(row_container)
        
        self.results_list_view.update()
        self.page.update()


    def copy_results(self, e):
        if self.original_result_data:
            text_to_copy = []
            for item in self.original_result_data: # Copying original full data
                parts = [f"Status: {item.get(self.STATUS,'')}", f"Key: {item.get(self.KEY_NAME,'')}"]
                if item.get(self.SOURCE_VALUE) is not None: parts.append(f"Source: {item.get(self.SOURCE_VALUE,'')}")
                if item.get(self.TARGET_VALUE) is not None: parts.append(f"Target: {item.get(self.TARGET_VALUE,'')}")
                text_to_copy.append(" | ".join(parts))
            self.page.set_clipboard("\n".join(text_to_copy))
            if hasattr(self.app, 'show_snackbar'):
                self.app.show_snackbar("Structured results copied to clipboard.")
        elif self.output_text.value: 
            self.page.set_clipboard(self.output_text.value) # Fallback
            if hasattr(self.app, 'show_snackbar'):
                self.app.show_snackbar("Raw results copied to clipboard.")


    def update_colors(self, colors: dict):
        self.colors = colors
        # Update text styles and colors for legacy fields
        for text_field in [self.output_text, self.summary_text]:
            if hasattr(text_field, 'text_style') and text_field.text_style is not None:
                 text_field.text_style.color = colors["text"]["secondary"]
            else: # Fallback if text_style is None
                 text_field.color = colors["text"]["secondary"] 
        
        # Update header colors
        if self.results_header.content.controls: # Check if controls exist
            if isinstance(self.results_header.content.controls[0], Text):
                 self.results_header.content.controls[0].color = colors["text"]["secondary"]
        self.expand_collapse_button.icon_color = colors["text"]["secondary"]
        
        # Update search field
        if hasattr(self, 'search_field'):
            self.search_field.border = border.all(color=colors["border"]["default"])
            if self.search_field.text_style: self.search_field.text_style.color = colors["text"]["primary"]
            if self.search_field.hint_style: self.search_field.hint_style.color = colors["text"]["secondary"]

        # Rebuild rows to apply new colors correctly within each row's elements
        # This is simpler than trying to traverse and update every sub-control.
        if self.original_result_data: # Only if there's data to rebuild
            current_query = self.search_field.value
            if current_query:
                self.filter_results(current_query) # Re-filter to rebuild with new colors
            else:
                # Rebuild the full list with new colors
                self.results_list_view.controls.clear()
                for index, diff_object in enumerate(self.original_result_data):
                    current_namespace = diff_object.get(self.NAMESPACE)
                    if current_namespace and (index == 0 or current_namespace != self.original_result_data[index-1].get(self.NAMESPACE)):
                        ns_header = ft.Text(f"Namespace: {current_namespace}", weight=FontWeight.BOLD, size=self.app.TEXT_SIZE_MEDIUM, color=self.colors["text"]["accent"]) # Uses new self.colors
                        self.results_list_view.controls.append(ft.Container(ns_header, padding=padding.only(top=self.app.spacing["m"], bottom=self.app.spacing["xs"])))
                    row_container = self.create_result_row(diff_object, index) # This will use new self.colors
                    self.results_list_view.controls.append(row_container)
                self.results_list_view.update()

        if hasattr(self.page, 'update'): self.page.update()
