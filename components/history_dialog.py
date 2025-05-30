import flet as ft
from utils import history_manager
import datetime

class HistoryDialogComponent:
    def __init__(self, page: ft.Page, app_reference):
        self.page = page
        self.app = app_reference
        self.colors = self.app.COLORS

        # Create all dialogs at initialization
        self.dialog = self._create_main_dialog()
        self.confirm_clear_dialog = self._create_confirm_clear_dialog()
        self.confirm_purge_dialog = self._create_confirm_purge_dialog()
        
        # Add all dialogs to page overlay
        self.page.overlay.extend([
            self.dialog,
            self.confirm_clear_dialog,
            self.confirm_purge_dialog
        ])

    def _create_main_dialog(self):
        return ft.AlertDialog(
            modal=False,
            on_dismiss=lambda e: self._close_dialog(e),
            title=ft.Text("Comparison History", size=self.app.TEXT_SIZE_XLARGE, weight="bold"), # Updated
            content=self._create_content(),
            actions=[
                ft.TextButton(
                    "Close",
                    style=ft.ButtonStyle(
                        color=self.colors["text"]["secondary"],
                        text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT) # Added
                    ),
                    on_click=self._close_dialog
                )
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )

    def _create_confirm_clear_dialog(self):
        button_style = ft.ButtonStyle(
            shape=ft.RoundedRectangleBorder(radius=self.app.spacing["xs"]),
            padding=ft.padding.symmetric(horizontal=self.app.spacing["m"])
        )
        return ft.AlertDialog(
            modal=True,
            on_dismiss=lambda e: self._handle_clear_response(e, "no"),
            title=ft.Text("Clear History?", size=self.app.TEXT_SIZE_LARGE, weight="bold"), # Updated
            content=ft.Container(
                content=ft.Column([
                    ft.Icon(
                        ft.icons.WARNING_ROUNDED,
                        color=self.colors["changes"].get("warning", ft_colors.AMBER_600), # Updated
                        size=self.app.TEXT_SIZE_HERO, # Updated
                    ),
                    ft.Text(
                        "Are you sure you want to clear all comparison history?",
                        text_align="center", size=self.app.TEXT_SIZE_DEFAULT # Updated
                    ),
                    ft.Text(
                        "This action cannot be undone.",
                        size=self.app.TEXT_SIZE_SMALL, # Updated
                        color=self.colors["text"]["secondary"],
                        text_align="center",
                    ),
                ], horizontal_alignment=ft.CrossAxisAlignment.CENTER, spacing=self.app.spacing["s"]), # Added spacing and alignment
                padding=self.app.BASE_UNIT * 5, # 20px Updated
                width=350, # Increased width
                alignment=ft.alignment.center,
            ),
            actions=[
                ft.TextButton(
                    "Cancel",
                    style=ft.ButtonStyle(color=self.colors["text"]["secondary"], text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT)), # Added text_style
                    on_click=lambda e: self._handle_clear_response(e, "no"),
                ),
                ft.ElevatedButton(
                    "Clear",
                    style=button_style.merge(ft.ButtonStyle(
                        color=self.colors.get("text",{}).get("on_error", ft_colors.WHITE), # Text on error color
                        bgcolor=self.colors["changes"].get("removed", ft_colors.RED_700), # Error/Removed color
                    )),
                    height=self.app.BASE_UNIT * 9, # 36px,
                    text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added text_style
                    on_click=lambda e: self._handle_clear_response(e, "yes"),
                ),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )

    def _create_confirm_purge_dialog(self):
        return ft.AlertDialog(
            modal=True,
            on_dismiss=lambda e: self._handle_purge_response(e, "no"),
            title=ft.Text("Purge Old Entries?"),
            content=ft.Container(
                content=ft.Column([
                    ft.Icon(
                        ft.icons.AUTO_DELETE,
                        color="#5C6BC0",
                        size=36,
                    ),
                    ft.Text(
                        "Purge history entries older than 30 days?",
                        text_align="center",
                    ),
                    ft.Text(
                        "This action cannot be undone.",
                        size=12,
                        color=self.colors["text"]["secondary"],
                        text_align="center",
                    ),
                ]),
                padding=20,
                width=300,
                alignment=ft.alignment.center,
            ),
            actions=[
                ft.TextButton(
                    "Cancel",
                    style=ft.ButtonStyle(color=self.colors["text"]["secondary"]),
                    on_click=lambda e: self._handle_purge_response(e, "no"),
                ),
                ft.ElevatedButton(
                    "Purge",
                    style=ft.ButtonStyle(
                        color=ft.colors.WHITE,
                        bgcolor="#5C6BC0",
                    ),
                    on_click=lambda e: self._handle_purge_response(e, "yes"),
                ),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )

    def _create_content(self):
        """Create the main content of the history dialog with improved styling."""
        self.history_list = ft.ListView(
            expand=True,
            spacing=self.app.spacing["s"], # Updated
            padding=self.app.spacing["s"], # Updated
            height=500, 
        )

        self.empty_state = ft.Column(
            controls=[
                ft.Container(
                    content=ft.Icon(
                        ft.icons.HISTORY,
                        size=self.app.spacing["xxl"] + self.app.spacing["m"], # 64px Updated
                        color=self.colors["text"]["secondary"],
                    ),
                    alignment=ft.alignment.center,
                    margin=ft.margin.only(top=self.app.spacing["xl"]), # Updated
                ),
                ft.Container(
                    content=ft.Text(
                        "No comparison history found",
                        size=self.app.TEXT_SIZE_MEDIUM, # Updated
                        weight="w500",
                        color=self.colors["text"]["secondary"],
                        text_align="center",
                    ),
                    alignment=ft.alignment.center,
                    margin=ft.margin.only(top=self.app.spacing["l"] - self.app.spacing["xxs"], bottom=self.app.spacing["xl"]), # 20px, 32px Updated
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        )

        clear_button = ft.IconButton(
            icon=ft.icons.DELETE_OUTLINE,
            tooltip="Clear History",
            icon_color=self.colors["text"]["secondary"],
            icon_size=self.app.TEXT_SIZE_LARGE, # Added
            on_click=self._clear_history,
        )

        purge_button = ft.IconButton(
            icon=ft.icons.AUTO_DELETE,
            tooltip="Purge Old Entries (> 30 days)",
            icon_color=self.colors["text"]["secondary"],
            icon_size=self.app.TEXT_SIZE_LARGE, # Added
            on_click=self._purge_old_entries,
        )

        return ft.Container(
            content=ft.Column([
                ft.Container(
                    content=ft.Text(
                        "View and manage your comparison history",
                        color=self.colors["text"]["secondary"],
                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                    ),
                    margin=ft.margin.only(bottom=self.app.spacing["s"]), # Updated
                ),
                ft.Card(
                    content=ft.Container(
                        content=ft.Row(
                            controls=[
                                ft.Text(
                                    "History Entries",
                                    size=self.app.TEXT_SIZE_MEDIUM, # Updated
                                    weight="w500",
                                    color=self.colors["text"]["primary"],
                                ),
                                ft.Row(
                                    controls=[clear_button, purge_button],
                                    spacing=self.app.spacing["xs"] # Added spacing for buttons
                                ),
                            ],
                            alignment="spaceBetween",
                            vertical_alignment=ft.CrossAxisAlignment.CENTER,
                        ),
                        padding=self.app.spacing["s"], # Updated
                    ),
                    color=self.colors["bg"]["secondary"], # Keep color
                ),
                ft.Container(
                    content=ft.Column(
                        controls=[self.history_list],
                        scroll=ft.ScrollMode.AUTO, # Keep scroll
                    ),
                    expand=True, # Keep expand
                    margin=ft.margin.only(top=self.app.spacing["s"]), # Updated
                )
            ]),
            width=700, 
            height=600, 
        )

    def _clear_history(self, e):
        """Clear all history entries."""
        self.dialog.open = False
        self.confirm_clear_dialog.open = True
        self.page.update()

    def _handle_clear_response(self, e, response):
        """Handle the response from the clear confirmation dialog"""
        self.confirm_clear_dialog.open = False
        if response == "yes":
            history_manager.clear_history()
            self._load_history()
            self.app.show_snackbar("History cleared")
        self.dialog.open = True
        self.page.update()

    def _purge_old_entries(self, e):
        """Purge entries older than 30 days."""
        self.dialog.open = False
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

    def _load_history(self, search_text=""):
        """Load and display history entries."""
        history = history_manager.load_history()
        self.history_list.controls.clear()

        if not history:
            self.history_list.controls.append(self.empty_state)
            return

        for entry in reversed(history):  # Show newest first
            # No longer filtering by search text since we removed the search bar

            # Parse timestamp with proper error handling
            try:
                timestamp = datetime.datetime.fromisoformat(entry["timestamp"])
                formatted_time = timestamp.strftime("%Y-%m-%d %H:%M:%S")
                # Calculate relative time
                now = datetime.datetime.now()
                diff = now - timestamp
                
                if diff.days > 30:
                    relative_time = f"{diff.days} days ago"
                elif diff.days > 0:
                    relative_time = f"{diff.days} day{'s' if diff.days > 1 else ''} ago"
                elif diff.seconds >= 3600:
                    hours = diff.seconds // 3600
                    relative_time = f"{hours} hour{'s' if hours > 1 else ''} ago"
                elif diff.seconds >= 60:
                    minutes = diff.seconds // 60
                    relative_time = f"{minutes} minute{'s' if minutes > 1 else ''} ago"
                else:
                    relative_time = "just now"
            except (ValueError, TypeError):
                formatted_time = "Unknown date"
                relative_time = ""

            # Calculate some stats from the diff for the summary
            diff_text = entry.get("diff", "")
            added_count = diff_text.count("\n+")
            removed_count = diff_text.count("\n-")

            # Create visually appealing card for history entry
            history_card = ft.Card(
                content=ft.Container(
                    content=ft.Column([
                        ft.Row([
                            ft.Icon(
                                ft.icons.COMPARE_ARROWS,
                                color=self.colors["bg"]["accent"],
                                size=20,
                            ),
                            ft.Text(
                                f"{entry['source_file']} → {entry['target_file']}",
                                size=self.app.TEXT_SIZE_MEDIUM, # Updated
                                weight="bold",
                                color=self.colors["text"]["primary"],
                            ),
                            ft.Container(expand=True), 
                            ft.Column([
                                ft.Text(
                                    formatted_time,
                                    size=self.app.TEXT_SIZE_SMALL, # Updated
                                    color=self.colors["text"]["secondary"],
                                    text_align="right",
                                ),
                                ft.Text(
                                    relative_time,
                                    size=self.app.TEXT_SIZE_XSMALL, # Updated
                                    italic=True,
                                    color=self.colors["text"]["secondary"],
                                    text_align="right",
                                ),
                            ], spacing=0, horizontal_alignment=ft.CrossAxisAlignment.END),
                        ], alignment="spaceBetween", vertical_alignment="start"),
                        
                        ft.Container(height=self.app.spacing["s"]), # Updated
                        
                        ft.Container(
                            content=ft.Row([
                                ft.Container(
                                    content=ft.Column([
                                        ft.Text(
                                            "Added", 
                                            size=self.app.TEXT_SIZE_SMALL, # Updated
                                            color=self.colors["text"]["secondary"]
                                        ),
                                        ft.Text(
                                            f"{added_count}",
                                            size=self.app.TEXT_SIZE_LARGE, # Updated
                                            weight="bold",
                                            color=self.colors["changes"]["added"]
                                        ),
                                    ], 
                                    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                    spacing=self.app.spacing["xxs"] # Updated
                                ),
                                    width=100, # Keep width
                                    padding=self.app.spacing["s"], # Updated
                                ),
                                ft.VerticalDivider(
                                    width=1, # Keep width
                                    color=self.colors["border"]["default"],
                                ),
                                ft.Container(
                                    content=ft.Column([
                                        ft.Text(
                                            "Removed", 
                                            size=self.app.TEXT_SIZE_SMALL, # Updated
                                            color=self.colors["text"]["secondary"]
                                        ),
                                        ft.Text(
                                            f"{removed_count}",
                                            size=self.app.TEXT_SIZE_LARGE, # Updated
                                            weight="bold",
                                            color=self.colors["changes"]["removed"]
                                        ),
                                    ], 
                                    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                    spacing=self.app.spacing["xxs"] # Updated
                                ),
                                    width=100, # Keep width
                                    padding=self.app.spacing["s"], # Updated
                                ),
                                ft.Container(
                                    content=ft.Text(
                                        "Click 'View Details' to see full comparison",
                                        size=self.app.TEXT_SIZE_SMALL, # Updated
                                        color=self.colors["text"]["secondary"],
                                        italic=True,
                                    ),
                                    expand=True,
                                    alignment=ft.alignment.center_right,
                                    padding=self.app.spacing["s"], # Updated
                                ),
                            ], 
                            alignment="spaceBetween",
                            vertical_alignment=ft.CrossAxisAlignment.CENTER
                            ),
                            border=ft.border.all(color=self.colors["border"]["default"]),
                            border_radius=self.app.spacing["xxs"], # Updated
                            padding=self.app.spacing["xxs"], # Updated
                            bgcolor=self.colors["bg"]["input"],
                        ),
                        
                        ft.Container(height=self.app.spacing["xxs"]), # Updated
                        
                        ft.Row([
                            ft.OutlinedButton(
                                "Copy",
                                icon=ft.icons.COPY,
                                style=ft.ButtonStyle(
                                    color=self.colors["text"]["secondary"],
                                    text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added
                                    shape=ft.RoundedRectangleBorder(radius=self.app.spacing["xs"]), # Added
                                    padding=ft.padding.symmetric(horizontal=self.app.spacing["m"]) # Added
                                ),
                                height=self.app.BASE_UNIT * 9, # 36px
                                on_click=lambda e, text=entry["diff"]: self._copy_diff(text)
                            ),
                            ft.ElevatedButton(
                                "View Details",
                                icon=ft.icons.VISIBILITY,
                                style=ft.ButtonStyle(
                                    color=self.colors.get("text",{}).get("on_accent", ft_colors.WHITE), # Use text on accent color
                                    bgcolor=self.colors["bg"]["accent"],
                                    shape=ft.RoundedRectangleBorder(radius=self.app.spacing["xs"]), # Added
                                    padding=ft.padding.symmetric(horizontal=self.app.spacing["m"]) # Added
                                ),
                                height=self.app.BASE_UNIT * 9, # 36px
                                text_style=ft.TextStyle(size=self.app.TEXT_SIZE_DEFAULT), # Added
                                on_click=lambda e, text=entry["diff"]: self._show_details(text)
                            )
                        ], alignment="end", spacing=self.app.spacing["s"]) # Updated
                    ]),
                    padding=self.app.spacing["m"] - self.app.spacing["xxs"], # 15px -> 16-2=14. Let's use 15 -> BASE_UNIT * 3.75. Or m (16)
                    animate=ft.animation.Animation(300, "easeOut"), # Keep animation
                ),
                elevation=2, # Keep elevation
                margin=ft.margin.only(bottom=self.app.spacing["s"]), # Updated
                color=self.colors["bg"]["secondary"], # Keep color
            )
            self.history_list.controls.append(history_card)

    def _entry_matches_search(self, entry: dict, search_text: str) -> bool:
        # This method could be removed as it's no longer used
        return False

    def _copy_diff(self, diff_text: str):
        """Copy diff text to clipboard."""
        self.page.set_clipboard(diff_text)
        self.app.show_snackbar("Diff copied to clipboard")

    def _show_details(self, diff_text: str):
        """Show full diff details in a new dialog."""
        # Create details dialog on demand since it's content-dependent
        details_dialog = self._create_details_dialog(diff_text)
        
        # Hide main dialog and show details
        self.dialog.open = False
        self.page.overlay.append(details_dialog)
        details_dialog.open = True
        self.page.update()

    def _create_details_dialog(self, diff_text: str):
        """Create the details dialog with the provided diff text."""
        # Process diff text into added/removed lines 
        added_lines = []
        removed_lines = []
        
        for line in diff_text.splitlines():
            if line.startswith("+"):
                added_lines.append(line[2:])  # Remove the "+ " prefix
            elif line.startswith("-"):
                removed_lines.append(line[2:])  # Remove the "- " prefix

        # Create the dialog
        dialog = ft.AlertDialog(
            modal=False,  # changed from True
            on_dismiss=lambda e: close_handler(e), 
            title=ft.Row([
                ft.Icon(ft.icons.COMPARE_ARROWS, color=self.colors["bg"]["accent"], size=self.app.TEXT_SIZE_XLARGE), # Added size
                ft.Text("Comparison Details", size=self.app.TEXT_SIZE_XLARGE, weight="bold"), # Updated
            ]),
            content=ft.Container(
                content=ft.Column([
                    ft.Container(
                        content=ft.Row([
                            ft.Container(
                                content=ft.Column([
                                    ft.Text(
                                        "Added Lines", 
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"]
                                    ),
                                    ft.Text(
                                        f"{len(added_lines)}",
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.colors["changes"]["added"]
                                    ),
                                ], 
                                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                spacing=self.app.spacing["xxs"] # Updated
                            ),
                                width=150, # Keep width
                                padding=self.app.spacing["s"], # Updated
                            ),
                            ft.VerticalDivider(width=1, color=self.colors["border"]["default"]),
                            ft.Container(
                                content=ft.Column([
                                    ft.Text(
                                        "Removed Lines", 
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                        color=self.colors["text"]["secondary"]
                                    ),
                                    ft.Text(
                                        f"{len(removed_lines)}",
                                        size=self.app.TEXT_SIZE_LARGE, # Updated
                                        weight="bold",
                                        color=self.colors["changes"]["removed"]
                                    ),
                                ], 
                                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                spacing=self.app.spacing["xxs"] # Updated
                            ),
                                width=150, # Keep width
                                padding=self.app.spacing["s"], # Updated
                            ),
                        ],
                        alignment="center",
                        ),
                        padding=self.app.spacing["s"], # Updated
                        border=ft.border.all(color=self.colors["border"]["default"]),
                        border_radius=self.app.spacing["xxs"], # Updated
                        margin=ft.margin.only(bottom=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                        bgcolor=self.colors["bg"]["secondary"],
                    ),
                    
                    ft.Container(
                        content=ft.Row([
                            ft.Container(
                                content=ft.Column([
                                    ft.Container(
                                        content=ft.Row([
                                            ft.Icon(ft.icons.ADD_CIRCLE, color=self.colors["changes"]["added"], size=self.app.TEXT_SIZE_MEDIUM), # Updated
                                            ft.Text(
                                                "Added Items",
                                                weight="bold",
                                                size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                                color=self.colors["changes"]["added"]
                                            ),
                                        ], spacing=self.app.spacing["xxs"]), # Updated
                                        padding=ft.padding.only(bottom=self.app.spacing["xs"]), # Updated
                                    ),
                                    ft.Container(
                                        content=self._create_diff_view(added_lines, "added"),
                                        expand=True,
                                    ),
                                ]),
                                expand=True,
                                padding=self.app.spacing["s"], # Updated
                                border=ft.border.all(color=self.colors["border"]["default"]),
                                border_radius=self.app.spacing["xxs"], # Updated
                                bgcolor=self.colors["bg"]["input"],
                            ),
                            
                            ft.Container(width=self.app.spacing["l"] - self.app.spacing["xxs"]), # 20px Updated
                            
                            ft.Container(
                                content=ft.Column([
                                    ft.Container(
                                        content=ft.Row([
                                            ft.Icon(ft.icons.REMOVE_CIRCLE, color=self.colors["changes"]["removed"], size=self.app.TEXT_SIZE_MEDIUM), # Updated
                                            ft.Text(
                                                "Removed Items",
                                                weight="bold",
                                                size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                                color=self.colors["changes"]["removed"]
                                            ),
                                        ], spacing=self.app.spacing["xxs"]), # Updated
                                        padding=ft.padding.only(bottom=self.app.spacing["xs"]), # Updated
                                    ),
                                    ft.Container(
                                        content=self._create_diff_view(removed_lines, "removed"),
                                        expand=True,
                                    ),
                                ]),
                                expand=True,
                                padding=self.app.spacing["s"], # Updated
                                border=ft.border.all(color=self.colors["border"]["default"]),
                                border_radius=self.app.spacing["xxs"], # Updated
                                bgcolor=self.colors["bg"]["input"],
                            ),
                        ]),
                        expand=True,
                    ),
                    
                    ft.Container(
                        content=ft.Column([
                            ft.Container(
                                content=ft.Row([
                                    ft.Text(
                                        "Raw Diff Output",
                                        weight="bold",
                                        size=self.app.TEXT_SIZE_DEFAULT, # Updated
                                    ),
                                    ft.IconButton(
                                        icon=ft.icons.ARROW_DROP_DOWN,
                                        icon_size=self.app.TEXT_SIZE_LARGE, # Added
                                        on_click=lambda e: self._toggle_raw_diff(e),
                                    )
                                ], alignment="spaceBetween"),
                                padding=self.app.spacing["s"], # Updated
                                bgcolor=self.colors["bg"]["secondary"],
                                border_radius=ft.border_radius.only(
                                    top_left=self.app.spacing["xxs"], top_right=self.app.spacing["xxs"], 
                                    bottom_left=self.app.spacing["xxs"] if not hasattr(self, "_show_raw_diff") or not self._show_raw_diff else 0,
                                    bottom_right=self.app.spacing["xxs"] if not hasattr(self, "_show_raw_diff") or not self._show_raw_diff else 0
                                ), # Updated
                            ),
                            ft.Container(
                                content=ft.TextField(
                                    value=diff_text,
                                    multiline=True, read_only=True, min_lines=5, max_lines=10,
                                    text_style=ft.TextStyle(font_family="Consolas", size=self.app.TEXT_SIZE_SMALL), # Updated
                                    border=ft.border.all(color=self.colors["border"]["default"]),
                                    bgcolor=self.colors["bg"]["input"],
                                    content_padding=self.app.spacing["xs"], # Added
                                    selection_color=self.colors["bg"]["accent"] + "40",
                                ),
                                visible=False if not hasattr(self, "_show_raw_diff") else self._show_raw_diff,
                                border_radius=ft.border_radius.only(bottom_left=self.app.spacing["xxs"], bottom_right=self.app.spacing["xxs"]), # Updated
                            )
                        ]),
                        margin=ft.margin.only(top=self.app.spacing["s"]), # Updated
                        border=ft.border.all(color=self.colors["border"]["default"]),
                    ),
                ]),
                width=900, height=600, # Keep dimensions
                padding=self.app.BASE_UNIT * 5, # 20px Updated
            ),
            actions=[], 
            actions_alignment=ft.MainAxisAlignment.END,
        )

        def close_handler(e):
            self._close_details(dialog)
            
        # Define a custom copy and close handler
        def copy_close_handler(e):
            self._copy_and_close(diff_text, dialog)
            
        # Now add the actions with properly bound handlers
        dialog.actions = [
            ft.TextButton(
                "Copy Raw Diff",
                icon=ft.icons.COPY,
                on_click=copy_close_handler
            ),
            ft.TextButton(
                "Close",
                style=ft.ButtonStyle(
                    color=self.colors["text"]["secondary"],
                ),
                on_click=close_handler
            ),
        ]
        
        return dialog

    def _toggle_raw_diff(self, e):
        """Toggle visibility of raw diff text."""
        # Update internal state to track visibility
        self._show_raw_diff = not getattr(self, "_show_raw_diff", False)
        # Update the icon right away
        e.control.icon = ft.icons.ARROW_DROP_UP if self._show_raw_diff else ft.icons.ARROW_DROP_DOWN
        
        # Find the dialog in the overlay that contains this button
        current_dialog = None
        for dlg in self.page.overlay:
            if isinstance(dlg, ft.AlertDialog) and dlg.open and dlg != self.dialog:
                current_dialog = dlg
                break
                
        if current_dialog and current_dialog.content:
            content_container = current_dialog.content
            main_column = content_container.content if hasattr(content_container, "content") else None
            
            if isinstance(main_column, ft.Column) and len(main_column.controls) > 2:
                raw_diff_section = main_column.controls[2]
                
                if isinstance(raw_diff_section, ft.Container) and isinstance(raw_diff_section.content, ft.Column):
                    controls = raw_diff_section.content.controls
                    if len(controls) > 1:
                        header = controls[0]
                        content = controls[1]
                        
                        # Update header border radius
                        if hasattr(header, "border_radius"):
                            header.border_radius = ft.border_radius.only(
                                top_left=5, top_right=5,
                                bottom_left=0 if self._show_raw_diff else 5,
                                bottom_right=0 if self._show_raw_diff else 5
                            )
                        
                        # Make sure the content container is visible and update its visibility
                        content.visible = self._show_raw_diff
                        content.update()
        
        # Update the UI
        self.page.update()

    def _create_diff_view(self, lines, diff_type):
        """Create a scrollable view for diff content with proper styling."""
        if not lines:
            return ft.Container(
                content=ft.Text(
                    "No items to display",
                    color=self.colors["text"]["secondary"],
                    italic=True,
                ),
                alignment=ft.alignment.center,
                expand=True,
            )
            
        list_view = ft.ListView(
            spacing=2,
            padding=10,
        )
        
        for line in lines:
            # Parse the line to separate key from value if possible
            if ":" in line:
                parts = line.split(":", 1)
                key = parts[0].strip()
                value = parts[1].strip() if len(parts) > 1 else ""
                
                list_view.controls.append(
                    ft.Container(
                        content=ft.Column([
                            ft.Text(
                                key,
                                weight="bold",
                                size=12,
                                color=self.colors["text"]["primary"],
                            ),
                            ft.Container(
                                content=ft.Text(
                                    value,
                                    size=12,
                                    color=self.colors["text"]["secondary"],
                                ),
                                margin=ft.margin.only(left=10),
                            ),
                        ], spacing=2, tight=True),
                        padding=ft.padding.only(top=5, bottom=5),
                        border=ft.border.only(bottom=ft.BorderSide(1, self.colors["border"]["default"])),
                    )
                )
            else:
                list_view.controls.append(
                    ft.Container(
                        content=ft.Text(
                            line,
                            size=12,
                        ),
                        padding=ft.padding.only(top=5, bottom=5),
                        border=ft.border.only(bottom=ft.BorderSide(1, self.colors["border"]["default"])),
                    )
                )
                
        return ft.Container(
            content=list_view,
            expand=True,
            bgcolor=self.colors["bg"]["input"],
            border_radius=5,
        )

    def _copy_and_close(self, text: str, dialog):
        """Copy text to clipboard and close the dialog."""
        self.page.set_clipboard(text)
        self.app.show_snackbar("Copied to clipboard")
        self._close_details(dialog)  # Use _close_details to properly restore main dialog

    def _close_details(self, dialog):
        """Close the details dialog and restore main history dialog."""
        dialog.open = False
        self.page.overlay.remove(dialog)
        self.dialog.open = True
        self.page.update()

    def _close_dialog(self, e):
        """Close the history dialog."""
        # First close the dialog
        self.dialog.open = False
        self.page.update()

        # Short delay to ensure clean state
        import threading
        def cleanup():
            self.page.dialog = None
            self.page.update()
        threading.Timer(0.1, cleanup).start()

    def open_dialog(self, e):
        """Open the history dialog."""
        # First ensure clean state
        self.dialog.open = False
        self.page.dialog = None
        self.page.update()

        # Load history and show dialog
        self._load_history()
        self.page.dialog = self.dialog
        self.dialog.open = True
        self.page.update()