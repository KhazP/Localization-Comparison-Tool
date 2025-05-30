import flet as ft
from utils import history_manager
import datetime

class HistoryDialogComponent:
    def __init__(self, page: ft.Page, app_reference):
        self.page = page
        self.app = app_reference
        self.colors = self.app.COLORS # Initial colors from app

        # Create all dialogs at initialization
        # These will be created using M3 styled methods shortly
        self.dialog = self._create_main_dialog()
        self.confirm_clear_dialog = self._create_confirm_clear_dialog()
        self.confirm_purge_dialog = self._create_confirm_purge_dialog()
        
        self.page.overlay.extend([
            self.dialog,
            self.confirm_clear_dialog,
            self.confirm_purge_dialog
        ])

    def update_colors(self, colors: dict):
        """Update component colors based on the provided M3 theme dictionary."""
        self.colors = colors

        # Update Main Dialog
        if self.dialog:
            self.dialog.bgcolor = self.colors.get("surfaceContainerHigh")
            if isinstance(self.dialog.title, ft.Text):
                self.dialog.title.color = self.colors.get("onSurface")
            if self.dialog.actions and self.dialog.actions[0] and isinstance(self.dialog.actions[0], ft.TextButton):
                 self.dialog.actions[0].style.color = self.colors.get("primary") # Close button

            if self.dialog.content and isinstance(self.dialog.content, ft.Container) and \
               isinstance(self.dialog.content.content, ft.Column):
                main_content_column = self.dialog.content.content
                if len(main_content_column.controls) > 0 and isinstance(main_content_column.controls[0].content, ft.Text): # "View and manage..." text
                     main_content_column.controls[0].content.color = self.colors.get("onSurfaceVariant")

                if len(main_content_column.controls) > 1:
                    history_card_header = main_content_column.controls[1]
                    if isinstance(history_card_header, ft.Card):
                        history_card_header.bgcolor = self.colors.get("surfaceContainer")
                        if history_card_header.content and isinstance(history_card_header.content.content, ft.Row) and \
                           isinstance(history_card_header.content.content.controls[0], ft.Text): # "History Entries" text
                             history_card_header.content.content.controls[0].color = self.colors.get("onSurface")

                        buttons_row = history_card_header.content.content.controls[1] # Row of IconButtons
                        if isinstance(buttons_row, ft.Row):
                            if buttons_row.controls and isinstance(buttons_row.controls[0], ft.IconButton):
                                buttons_row.controls[0].icon_color = self.colors.get("onSurfaceVariant") # Clear
                            if len(buttons_row.controls) > 1 and isinstance(buttons_row.controls[1], ft.IconButton):
                                buttons_row.controls[1].icon_color = self.colors.get("onSurfaceVariant") # Purge

                # Empty state styling
                if hasattr(self, 'empty_state') and self.empty_state and self.empty_state.controls:
                    if isinstance(self.empty_state.controls[0].content, ft.Icon):
                        self.empty_state.controls[0].content.color = self.colors.get("onSurfaceVariant")
                    if isinstance(self.empty_state.controls[1].content, ft.Text):
                         self.empty_state.controls[1].content.color = self.colors.get("onSurfaceVariant")

        # Update Confirm Clear Dialog
        if self.confirm_clear_dialog:
            self.confirm_clear_dialog.bgcolor = self.colors.get("surfaceContainerHigh")
            if isinstance(self.confirm_clear_dialog.title, ft.Text):
                self.confirm_clear_dialog.title.color = self.colors.get("onSurface")
            if self.confirm_clear_dialog.content and isinstance(self.confirm_clear_dialog.content.content, ft.Column):
                cc_content_col = self.confirm_clear_dialog.content.content
                cc_content_col.controls[0].color = self.colors.get("error")
                cc_content_col.controls[1].color = self.colors.get("onSurfaceVariant")
                cc_content_col.controls[2].color = self.colors.get("onSurfaceVariant")
            if self.confirm_clear_dialog.actions:
                if isinstance(self.confirm_clear_dialog.actions[0], ft.TextButton):
                    self.confirm_clear_dialog.actions[0].style.color = self.colors.get("primary")
                if isinstance(self.confirm_clear_dialog.actions[1], ft.FilledButton):
                    self.confirm_clear_dialog.actions[1].style.bgcolor = self.colors.get("error")
                    self.confirm_clear_dialog.actions[1].style.color = self.colors.get("onError")

        # Update Confirm Purge Dialog
        if self.confirm_purge_dialog:
            self.confirm_purge_dialog.bgcolor = self.colors.get("surfaceContainerHigh")
            if isinstance(self.confirm_purge_dialog.title, ft.Text):
                self.confirm_purge_dialog.title.color = self.colors.get("onSurface")
            if self.confirm_purge_dialog.content and isinstance(self.confirm_purge_dialog.content.content, ft.Column):
                cp_content_col = self.confirm_purge_dialog.content.content
                cp_content_col.controls[0].color = self.colors.get("secondary")
                cp_content_col.controls[1].color = self.colors.get("onSurfaceVariant")
                cp_content_col.controls[2].color = self.colors.get("onSurfaceVariant")
            if self.confirm_purge_dialog.actions:
                if isinstance(self.confirm_purge_dialog.actions[0], ft.TextButton):
                     self.confirm_purge_dialog.actions[0].style.color = self.colors.get("primary")
                if isinstance(self.confirm_purge_dialog.actions[1], ft.FilledButton):
                    self.confirm_purge_dialog.actions[1].style.bgcolor = self.colors.get("primary")
                    self.confirm_purge_dialog.actions[1].style.color = self.colors.get("onPrimary")

        self._load_history()

        if self.dialog.open or \
           (self.confirm_clear_dialog and self.confirm_clear_dialog.open) or \
           (self.confirm_purge_dialog and self.confirm_purge_dialog.open):
            self.page.update()

    # --- Add other methods one by one ---


    def _create_main_dialog(self):
        return ft.AlertDialog(
            modal=True,
            shape=ft.RoundedRectangleBorder(radius=28),
            bgcolor=self.colors.get("surfaceContainerHigh"),
            on_dismiss=lambda e: self._close_dialog(e),
            title=ft.Text("Comparison History", size=24, weight=ft.FontWeight.NORMAL, color=self.colors.get("onSurface")),
            title_padding=ft.padding.all(24),
            content=self._create_content(), # Content will be styled by this method
            content_padding=ft.padding.symmetric(horizontal=24),
            actions=[
                ft.TextButton(
                    "Close",
                    style=ft.ButtonStyle(color=self.colors.get("primary")),
                    on_click=self._close_dialog
                )
            ],
            actions_alignment=ft.MainAxisAlignment.END,
            actions_padding=ft.padding.only(left=24, right=24, bottom=24, top=12),
        )

    def _create_confirm_clear_dialog(self):
        return ft.AlertDialog(
            modal=True,
            shape=ft.RoundedRectangleBorder(radius=28),
            bgcolor=self.colors.get("surfaceContainerHigh"),
            title_padding=ft.padding.all(24),
            content_padding=ft.padding.all(24),
            actions_padding=ft.padding.only(left=24, right=24, bottom=24, top=12),
            on_dismiss=lambda e: self._handle_clear_response(e, "no"),
            title=ft.Text("Clear History?", color=self.colors.get("onSurface")),
            content=ft.Container(
                content=ft.Column([
                    ft.Icon(
                        ft.icons.WARNING_AMBER_ROUNDED,
                        color=self.colors.get("error"),
                        size=36,
                    ),
                    ft.Text(
                        "Are you sure you want to clear all comparison history?",
                        text_align="center", color=self.colors.get("onSurfaceVariant"),
                    ),
                    ft.Text(
                        "This action cannot be undone.",
                        size=12, color=self.colors.get("onSurfaceVariant"),
                        text_align="center",
                    ),
                ], horizontal_alignment=ft.CrossAxisAlignment.CENTER, spacing=8),
                padding=0, width=300, alignment=ft.alignment.center,
            ),
            actions=[
                ft.TextButton(
                    "Cancel",
                    style=ft.ButtonStyle(color=self.colors.get("primary")),
                    on_click=lambda e: self._handle_clear_response(e, "no"),
                ),
                ft.FilledButton(
                    "Clear",
                    style=ft.ButtonStyle(
                        color=self.colors.get("onError"),
                        bgcolor=self.colors.get("error"),
                    ),
                    on_click=lambda e: self._handle_clear_response(e, "yes"),
                ),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )

    def _create_confirm_purge_dialog(self):
        return ft.AlertDialog(
            modal=True,
            shape=ft.RoundedRectangleBorder(radius=28),
            bgcolor=self.colors.get("surfaceContainerHigh"),
            title_padding=ft.padding.all(24),
            content_padding=ft.padding.all(24),
            actions_padding=ft.padding.only(left=24, right=24, bottom=24, top=12),
            on_dismiss=lambda e: self._handle_purge_response(e, "no"),
            title=ft.Text("Purge Old Entries?", color=self.colors.get("onSurface")),
            content=ft.Container(
                content=ft.Column([
                    ft.Icon(
                        ft.icons.AUTO_DELETE_OUTLINED,
                        color=self.colors.get("secondary"),
                        size=36,
                    ),
                    ft.Text(
                        "Purge history entries older than 30 days?",
                        text_align="center", color=self.colors.get("onSurfaceVariant"),
                    ),
                    ft.Text(
                        "This action cannot be undone.",
                        size=12, color=self.colors.get("onSurfaceVariant"),
                        text_align="center",
                    ),
                ], horizontal_alignment=ft.CrossAxisAlignment.CENTER, spacing=8),
                padding=0, width=300, alignment=ft.alignment.center,
            ),
            actions=[
                ft.TextButton(
                    "Cancel",
                    style=ft.ButtonStyle(color=self.colors.get("primary")),
                    on_click=lambda e: self._handle_purge_response(e, "no"),
                ),
                ft.FilledButton(
                    "Purge",
                    style=ft.ButtonStyle(
                        color=self.colors.get("onPrimary"),
                        bgcolor=self.colors.get("primary"),
                    ),
                    on_click=lambda e: self._handle_purge_response(e, "yes"),
                ),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )


    def _create_content(self):
        self.history_list = ft.ListView(
            expand=True,
            spacing=8,
            padding=ft.padding.symmetric(vertical=8),
        )

        self.empty_state = ft.Column(
            controls=[
                ft.Icon(
                    ft.icons.HISTORY_ROUNDED,
                    size=48,
                    color=self.colors.get("onSurfaceVariant"),
                ),
                ft.Text(
                    "No comparison history found",
                    size=16,
                    weight=ft.FontWeight.NORMAL,
                    color=self.colors.get("onSurfaceVariant"),
                    text_align="center",
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            alignment=ft.MainAxisAlignment.CENTER,
            spacing=16,
            expand=True,
        )

        clear_button = ft.IconButton(
            icon=ft.icons.DELETE_SWEEP_OUTLINED,
            tooltip="Clear All History",
            icon_color=self.colors.get("onSurfaceVariant"),
            on_click=self._clear_history,
        )

        purge_button = ft.IconButton(
            icon=ft.icons.AUTO_DELETE_OUTLINED,
            tooltip="Purge Old Entries (> 30 days)",
            icon_color=self.colors.get("onSurfaceVariant"),
            on_click=self._purge_old_entries,
        )

        return ft.Container(
            content=ft.Column([
                ft.Text(
                    "View and manage your past comparison reports.",
                    color=self.colors.get("onSurfaceVariant"),
                    size=14, # M3 BodyMedium
                ),
                ft.Container(
                    content=ft.Row(
                        controls=[
                            ft.Text(
                                "History Entries",
                                size=16,
                                weight=ft.FontWeight.MEDIUM, # M3 TitleSmall
                                color=self.colors.get("onSurface"),
                            ),
                            ft.Row(
                                controls=[clear_button, purge_button],
                                spacing=0,
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
                        vertical_alignment=ft.CrossAxisAlignment.CENTER,
                    ),
                    padding=ft.padding.symmetric(vertical=8),
                ),
                ft.Divider(height=1, color=self.colors.get("outlineVariant")),
                ft.Container(
                    content=self.history_list,
                    expand=True,
                    bgcolor=self.colors.get("surface"),
                )
            ], spacing=8),
            width=600,
            height=400,
            padding=0,
        )

    def _load_history(self, search_text=""): # search_text not used currently
        self.colors = self.app.COLORS # Ensure fresh colors
        history = history_manager.load_history()
        self.history_list.controls.clear()

        if not history:
            if hasattr(self, 'empty_state') and self.empty_state and self.empty_state.controls: # Ensure empty_state is initialized
                if isinstance(self.empty_state.controls[0].content, ft.Icon):
                    self.empty_state.controls[0].content.color = self.colors.get("onSurfaceVariant")
                if isinstance(self.empty_state.controls[1].content, ft.Text):
                     self.empty_state.controls[1].content.color = self.colors.get("onSurfaceVariant")
            self.history_list.controls.append(self.empty_state)
            if self.dialog.open: self.page.update()
            return

        for entry in reversed(history):
            try:
                timestamp = datetime.datetime.fromisoformat(entry["timestamp"])
                formatted_time = timestamp.strftime("%Y-%m-%d %H:%M")
                now = datetime.datetime.now()
                diff = now - timestamp
                if diff.days > 0: relative_time = f"{diff.days}d ago"
                elif diff.seconds >= 3600: relative_time = f"{diff.seconds // 3600}h ago"
                elif diff.seconds >= 60: relative_time = f"{diff.seconds // 60}m ago"
                else: relative_time = "just now"
            except (ValueError, TypeError):
                formatted_time, relative_time = "Unknown date", ""

            diff_text = entry.get("diff", "")
            added_count = diff_text.count("\n+")
            removed_count = diff_text.count("\n-")

            history_card = ft.Card(
                content=ft.Container(
                    content=ft.Column([
                        ft.Row([
                            ft.Icon(ft.icons.COMPARE_ARROWS_ROUNDED, color=self.colors.get("primary"), size=20),
                            ft.Text(f"{entry['source_file']} → {entry['target_file']}", size=16, weight=ft.FontWeight.MEDIUM, color=self.colors.get("onSurface"), expand=True, overflow=ft.TextOverflow.ELLIPSIS, max_lines=1),
                            ft.Column([
                                ft.Text(formatted_time, size=12, color=self.colors.get("onSurfaceVariant"), text_align="right"),
                                ft.Text(relative_time, size=11, italic=True, color=self.colors.get("onSurfaceVariant"), text_align="right"),
                            ], spacing=0, horizontal_alignment=ft.CrossAxisAlignment.END),
                        ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN, vertical_alignment=ft.CrossAxisAlignment.START, spacing=8),
                        
                        ft.Container(height=8),
                        ft.Container(
                            content=ft.Row([
                                ft.Container(ft.Column([ft.Text("Added", size=12, color=self.colors.get("onSurfaceVariant")), ft.Text(f"{added_count}", size=18, weight=ft.FontWeight.BOLD, color=self.colors.get("tertiary"))], horizontal_alignment=ft.CrossAxisAlignment.CENTER, spacing=2), width=70, padding=4),
                                ft.VerticalDivider(width=1, color=self.colors.get("outlineVariant")),
                                ft.Container(ft.Column([ft.Text("Removed", size=12, color=self.colors.get("onSurfaceVariant")), ft.Text(f"{removed_count}", size=18, weight=ft.FontWeight.BOLD, color=self.colors.get("error"))], horizontal_alignment=ft.CrossAxisAlignment.CENTER, spacing=2), width=70, padding=4),
                                ft.Container(content=ft.Text("Click 'View Details' for full comparison.", size=12, color=self.colors.get("onSurfaceVariant"), italic=True), expand=True, alignment=ft.alignment.center_right, padding=4),
                            ], alignment=ft.MainAxisAlignment.START, vertical_alignment=ft.CrossAxisAlignment.CENTER, spacing=4),
                            border=ft.border.all(1, self.colors.get("outlineVariant")), border_radius=8, padding=ft.padding.symmetric(horizontal=8, vertical=4), bgcolor=self.colors.get("surfaceContainerLow"),
                        ),
                        ft.Container(height=8),
                        ft.Row([
                            ft.TextButton("Copy", icon=ft.icons.COPY_OUTLINED, style=ft.ButtonStyle(color=self.colors.get("primary")), on_click=lambda e, text=entry["diff"]: self._copy_diff(text)),
                            ft.FilledButton("View Details", icon=ft.icons.VISIBILITY_OUTLINED, style=ft.ButtonStyle(color=self.colors.get("onPrimary"), bgcolor=self.colors.get("primary")), on_click=lambda e, text=entry["diff"]: self._show_details(text))
                        ], alignment=ft.MainAxisAlignment.END, spacing=8)
                    ]),
                    padding=16,
                ),
                elevation=1, margin=ft.margin.only(bottom=8), bgcolor=self.colors.get("surfaceContainerHigh"),
            )
            self.history_list.controls.append(history_card)
        if self.dialog.open: self.page.update()

    def _create_details_dialog(self, diff_text: str):
        added_lines = [line[2:] for line in diff_text.splitlines() if line.startswith("+ ")]
        removed_lines = [line[2:] for line in diff_text.splitlines() if line.startswith("- ")]

        dialog = ft.AlertDialog(
            modal=True, shape=ft.RoundedRectangleBorder(radius=28), bgcolor=self.colors.get("surfaceContainerHigh"),
            title_padding=ft.padding.all(24), content_padding=0, actions_padding=ft.padding.all(24),
            title=ft.Row([ft.Icon(ft.icons.INFO_OUTLINED, color=self.colors.get("secondary")), ft.Text("Comparison Details", size=24, weight=ft.FontWeight.NORMAL, color=self.colors.get("onSurface"))], spacing=8),
            content=ft.Container(
                content=ft.Column([
                    ft.Container(
                        content=ft.Row([
                            ft.Container(ft.Column([ft.Text("Added Lines", size=12, color=self.colors.get("onSurfaceVariant")), ft.Text(f"{len(added_lines)}", size=20, weight=ft.FontWeight.MEDIUM, color=self.colors.get("tertiary"))], horizontal_alignment=ft.CrossAxisAlignment.CENTER, spacing=2), padding=8),
                            ft.VerticalDivider(width=1, color=self.colors.get("outlineVariant")),
                            ft.Container(ft.Column([ft.Text("Removed Lines", size=12, color=self.colors.get("onSurfaceVariant")), ft.Text(f"{len(removed_lines)}", size=20, weight=ft.FontWeight.MEDIUM, color=self.colors.get("error"))], horizontal_alignment=ft.CrossAxisAlignment.CENTER, spacing=2), padding=8),
                        ], alignment=ft.MainAxisAlignment.SPACE_EVENLY, vertical_alignment=ft.CrossAxisAlignment.CENTER),
                        padding=8, border=ft.border.all(1, self.colors.get("outlineVariant")), border_radius=8, bgcolor=self.colors.get("surfaceContainerLow"), margin=ft.margin.only(left=24, right=24, bottom=12),
                    ),
                    ft.Container(
                        content=ft.Row([
                            ft.Container(ft.Column([ft.Row([ft.Icon(ft.icons.ADD_CIRCLE_OUTLINE, color=self.colors.get("tertiary"), size=18), ft.Text("Added Items", weight=ft.FontWeight.MEDIUM, size=14, color=self.colors.get("tertiary"))], spacing=4, vertical_alignment=ft.CrossAxisAlignment.CENTER), ft.Divider(height=1, color=self.colors.get("outlineVariant"), margin=ft.margin.symmetric(vertical=4)), self._create_diff_view(added_lines, "added")], spacing=4), expand=1, padding=8, border=ft.border.all(1, self.colors.get("outlineVariant")), border_radius=8, bgcolor=self.colors.get("surface")),
                            ft.Container(width=8),
                            ft.Container(ft.Column([ft.Row([ft.Icon(ft.icons.REMOVE_CIRCLE_OUTLINE, color=self.colors.get("error"), size=18), ft.Text("Removed Items", weight=ft.FontWeight.MEDIUM, size=14, color=self.colors.get("error"))], spacing=4, vertical_alignment=ft.CrossAxisAlignment.CENTER), ft.Divider(height=1, color=self.colors.get("outlineVariant"), margin=ft.margin.symmetric(vertical=4)), self._create_diff_view(removed_lines, "removed")], spacing=4), expand=1, padding=8, border=ft.border.all(1, self.colors.get("outlineVariant")), border_radius=8, bgcolor=self.colors.get("surface")),
                        ]), expand=True, padding=ft.padding.symmetric(horizontal=24)
                    ),
                    ft.Container(
                        content=ft.Column([
                            ft.Container(
                                content=ft.Row([ft.Text("Raw Diff Output", weight=ft.FontWeight.MEDIUM, size=14, color=self.colors.get("onSurfaceVariant")), ft.IconButton(icon=ft.icons.ARROW_DROP_DOWN, icon_size=20, on_click=lambda e: self._toggle_raw_diff(e, dialog), icon_color=self.colors.get("onSurfaceVariant"))], alignment=ft.MainAxisAlignment.SPACE_BETWEEN, vertical_alignment=ft.CrossAxisAlignment.CENTER),
                                on_click=lambda e: self._toggle_raw_diff(e, dialog, is_header_click=True), padding=ft.padding.symmetric(horizontal=12, vertical=8), bgcolor=self.colors.get("surfaceContainer"), border_radius=ft.border_radius.all(8),
                            ),
                            ft.Container(
                                content=ft.TextField(value=diff_text, multiline=True, read_only=True, min_lines=3, max_lines=8, text_style=ft.TextStyle(font_family="Consolas", size=12, color=self.colors.get("onSurface")), border=ft.InputBorder.NONE, bgcolor=self.colors.get("surfaceContainerLowest"), content_padding=8),
                                visible=False, border_radius=ft.border_radius.all(8), margin=ft.margin.only(top=4)
                            )
                        ]), margin=ft.margin.only(left=24, right=24, top=12),
                    ),
                ], spacing=8),
                width=800, height=550, padding=ft.padding.only(bottom=24)
            ),
            actions_alignment=ft.MainAxisAlignment.END,
        )
        def close_handler(e): self._close_details(dialog)
        def copy_close_handler(e): self._copy_and_close(diff_text, dialog)
        dialog.on_dismiss = close_handler
        dialog.actions = [
            ft.TextButton("Copy Raw Diff", icon=ft.icons.COPY_OUTLINED, style=ft.ButtonStyle(color=self.colors.get("primary")), on_click=copy_close_handler),
            ft.TextButton("Close", style=ft.ButtonStyle(color=self.colors.get("primary")), on_click=close_handler),
        ]
        return dialog

    def _create_diff_view(self, lines, diff_type): # diff_type not used for styling anymore here
        if not lines:
            return ft.Container(content=ft.Text("No items to display.", color=self.colors.get("onSurfaceVariant"), italic=True), alignment=ft.alignment.center, expand=True)
            
        list_view = ft.ListView(spacing=0, padding=ft.padding.symmetric(horizontal=8))
        
        for line_text in lines:
            text_color = self.colors.get("onSurface")
            list_view.controls.append(
                ft.Text(line_text, font_family="Consolas", size=12, color=text_color, overflow=ft.TextOverflow.ELLIPSIS)
            )
        return list_view


    def _clear_history(self, e):
        """Clear all history entries."""
        self.dialog.open = False # Close main dialog first
        self.confirm_clear_dialog.open = True
        self.page.update()

    def _handle_clear_response(self, e, response):
        """Handle the response from the clear confirmation dialog"""
        self.confirm_clear_dialog.open = False
        if response == "yes":
            history_manager.clear_history()
            self._load_history() # This will refresh the list, potentially showing empty state
            self.app.show_snackbar("History cleared")
        # Reopen main dialog only if an action wasn't "yes" or to show updated list
        self.dialog.open = True
        self.page.update()

    def _purge_old_entries(self, e):
        """Purge entries older than 30 days."""
        self.dialog.open = False # Close main dialog first
        self.confirm_purge_dialog.open = True
        self.page.update()

    def _handle_purge_response(self, e, response):
        """Handle the response from the purge confirmation dialog"""
        self.confirm_purge_dialog.open = False
        if response == "yes":
            history_manager.purge_old_entries(30)
            self._load_history()
            self.app.show_snackbar("Old entries purged")
        self.dialog.open = True
        self.page.update()

    def _copy_diff(self, diff_text: str):
        """Copy diff text to clipboard."""
        self.page.set_clipboard(diff_text)
        self.app.show_snackbar("Diff copied to clipboard")

    def _show_details(self, diff_text: str):
        """Show full diff details in a new dialog."""
        # Ensure app colors are current before creating dialog
        self.colors = self.app.COLORS
        details_dialog = self._create_details_dialog(diff_text)
        
        self.dialog.open = False # Close main history dialog
        self.page.overlay.append(details_dialog) # Add new dialog to overlay
        details_dialog.open = True
        self.page.update()

    def _toggle_raw_diff(self, e, dialog_instance, is_header_click=False):
        # If the main toggle area (header container) is clicked, the actual icon button is the child of Row's second control
        icon_button_to_toggle = e.control
        if is_header_click and isinstance(e.control, ft.Container) and \
           isinstance(e.control.content, ft.Row) and len(e.control.content.controls) > 1 and \
           isinstance(e.control.content.controls[1], ft.IconButton):
            icon_button_to_toggle = e.control.content.controls[1]

        # Find the TextField container for raw diff. It's assumed to be the last control in the Column
        # that is inside the second Container of the main Column of the dialog's content.
        # This structure is: Dialog -> Content(Container) -> Content(Column) -> RawDiffSection(Container) -> Content(Column) -> RawDiffTextFieldContainer(Container)
        try:
            raw_diff_text_container = dialog_instance.content.content.controls[2].content.controls[1]
            raw_diff_header_container = dialog_instance.content.content.controls[2].content.controls[0]

            if isinstance(raw_diff_text_container, ft.Container):
                 raw_diff_text_container.visible = not raw_diff_text_container.visible
                 if isinstance(icon_button_to_toggle, ft.IconButton):
                    icon_button_to_toggle.icon = ft.icons.ARROW_DROP_UP if raw_diff_text_container.visible else ft.icons.ARROW_DROP_DOWN

            if isinstance(raw_diff_header_container, ft.Container):
                 raw_diff_header_container.border_radius = ft.border_radius.only(
                    top_left=8, top_right=8,
                    bottom_left=0 if raw_diff_text_container.visible else 8,
                    bottom_right=0 if raw_diff_text_container.visible else 8
                 )
        except (AttributeError, IndexError, TypeError) as err:
            print(f"Error accessing controls in _toggle_raw_diff: {err}")
            # Fallback or error handling if structure is not as expected

        self.page.update()

    def _copy_and_close(self, text: str, dialog):
        """Copy text to clipboard and close the dialog."""
        self.page.set_clipboard(text)
        self.app.show_snackbar("Copied to clipboard")
        self._close_details(dialog)

    def _close_details(self, dialog_instance):
        """Close the details dialog and restore main history dialog."""
        dialog_instance.open = False
        if dialog_instance in self.page.overlay: # Remove only if it's actually there
            self.page.overlay.remove(dialog_instance)

        # Re-open the main history dialog if it's not already trying to open
        if not self.dialog.open:
            self.open_dialog(None)
        else: # If main dialog thinks it's open, just ensure page is updated.
            self.page.update()


    def _close_dialog(self, e):
        """Close the main history dialog."""
        if self.dialog.open:
            self.dialog.open = False
            self.page.update()

    def open_dialog(self, e):
        """Open the history dialog, ensuring it uses current theme colors."""
        self.colors = self.app.COLORS # Ensure component colors are up-to-date

        # Re-style persistent elements of dialogs if they were already created
        # This is a bit redundant if update_colors is called by App, but good for direct open_dialog calls
        self.update_colors(self.colors) # This will also call _load_history

        self.dialog.open = True
        self.page.update()
