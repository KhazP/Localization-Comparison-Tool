import flet as ft
from utils import history_manager
import datetime
from services.comparison_service import ComparisonService # Import ComparisonService

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
            title=ft.Text("Comparison History", size=22, weight="bold"),
            content=self._create_content(),
            actions=[
                ft.TextButton(
                    "Close",
                    style=ft.ButtonStyle(
                        color=self.colors["text"]["secondary"],
                    ),
                    on_click=self._close_dialog
                )
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )

    def _create_confirm_clear_dialog(self):
        return ft.AlertDialog(
            modal=True,
            on_dismiss=lambda e: self._handle_clear_response(e, "no"),
            title=ft.Text("Clear History?"),
            content=ft.Container(
                content=ft.Column([
                    ft.Icon(
                        ft.icons.WARNING_ROUNDED,
                        color="#FFA000",
                        size=36,
                    ),
                    ft.Text(
                        "Are you sure you want to clear all comparison history?",
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
                    on_click=lambda e: self._handle_clear_response(e, "no"),
                ),
                ft.ElevatedButton(
                    "Clear",
                    style=ft.ButtonStyle(
                        color=ft.colors.WHITE,
                        bgcolor=ft.colors.RED_400,
                    ),
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
            spacing=10,
            padding=10,
            height=500,  # Increased height for better visibility
        )

        self.empty_state = ft.Column(
            controls=[
                ft.Container(
                    content=ft.Icon(
                        ft.icons.HISTORY,
                        size=64,
                        color=self.colors["text"]["secondary"],
                    ),
                    alignment=ft.alignment.center,
                    margin=ft.margin.only(top=40),
                ),
                ft.Container(
                    content=ft.Text(
                        "No comparison history found",
                        size=16,
                        weight="w500",
                        color=self.colors["text"]["secondary"],
                        text_align="center",
                    ),
                    alignment=ft.alignment.center,
                    margin=ft.margin.only(top=20, bottom=40),
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        )

        # Add clear history button with enhanced styling
        clear_button = ft.IconButton(
            icon=ft.icons.DELETE_OUTLINE,
            tooltip="Clear History",
            icon_color=self.colors["text"]["secondary"],
            on_click=self._clear_history,
        )

        # Add purge old entries button
        purge_button = ft.IconButton(
            icon=ft.icons.AUTO_DELETE,
            tooltip="Purge Old Entries (> 30 days)",
            icon_color=self.colors["text"]["secondary"],
            on_click=self._purge_old_entries,
        )

        return ft.Container(
            content=ft.Column([
                ft.Container(
                    content=ft.Text(
                        "View and manage your comparison history",
                        color=self.colors["text"]["secondary"],
                        size=14,
                    ),
                    margin=ft.margin.only(bottom=10),
                ),
                ft.Card(
                    content=ft.Container(
                        content=ft.Row(
                            controls=[
                                ft.Text(
                                    "History Entries",
                                    size=16,
                                    weight="w500",
                                    color=self.colors["text"]["primary"],
                                ),
                                ft.Row(
                                    controls=[
                                        clear_button,
                                        purge_button,
                                    ],
                                ),
                            ],
                            alignment="spaceBetween",
                            vertical_alignment=ft.CrossAxisAlignment.CENTER,
                        ),
                        padding=10,
                    ),
                    color=self.colors["bg"]["secondary"],
                ),
                ft.Container(
                    content=ft.Column(
                        controls=[self.history_list],
                        scroll=ft.ScrollMode.AUTO,
                    ),
                    expand=True,
                    margin=ft.margin.only(top=10),
                )
            ]),
            width=700,  # Wider dialog for better readability
            height=600,  # Taller dialog for more content
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
            # diff_text = entry.get("diff", "") # Old: diff was a string
            # New: diff_summary is a dict, diff_details is also a dict
            diff_summary = entry.get("diff_summary", {})
            added_count = diff_summary.get("missing_count", 0) # 'missing_in_target' from comparison perspective
            removed_count = diff_summary.get("obsolete_count", 0) # 'obsolete_in_target'

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
                                size=16,
                                weight="bold",
                                color=self.colors["text"]["primary"],
                            ),
                            ft.Container(expand=True),  # Spacer
                            ft.Column([
                                ft.Text(
                                    formatted_time,
                                    size=12,
                                    color=self.colors["text"]["secondary"],
                                    text_align="right",
                                ),
                                ft.Text(
                                    relative_time,
                                    size=11,
                                    italic=True,
                                    color=self.colors["text"]["secondary"],
                                    text_align="right",
                                ),
                            ], spacing=0, horizontal_alignment=ft.CrossAxisAlignment.END),
                        ], alignment="spaceBetween", vertical_alignment="start"),
                        
                        ft.Container(height=10),
                        
                        # Replace TextField with a summary
                        ft.Container(
                            content=ft.Row([
                                ft.Container(
                                    content=ft.Column([
                                        ft.Text(
                                            "Added", 
                                            size=12,
                                            color=self.colors["text"]["secondary"]
                                        ),
                                        ft.Text(
                                            f"{added_count}",
                                            size=18,
                                            weight="bold",
                                            color=self.colors["changes"]["added"]
                                        ),
                                    ], 
                                    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                    spacing=4
                                ),
                                    width=100,
                                    padding=10,
                                ),
                                ft.VerticalDivider(
                                    width=1,
                                    color=self.colors["border"]["default"],
                                ),
                                ft.Container(
                                    content=ft.Column([
                                        ft.Text(
                                            "Removed", 
                                            size=12,
                                            color=self.colors["text"]["secondary"]
                                        ),
                                        ft.Text(
                                            f"{removed_count}",
                                            size=18,
                                            weight="bold",
                                            color=self.colors["changes"]["removed"]
                                        ),
                                    ], 
                                    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                    spacing=4
                                ),
                                    width=100,
                                    padding=10,
                                ),
                                ft.Container(
                                    content=ft.Text(
                                        "Click 'View Details' to see full comparison",
                                        size=12,
                                        color=self.colors["text"]["secondary"],
                                        italic=True,
                                    ),
                                    expand=True,
                                    alignment=ft.alignment.center_right,
                                    padding=10,
                                ),
                            ], 
                            alignment="spaceBetween",
                            vertical_alignment=ft.CrossAxisAlignment.CENTER
                            ),
                            border=ft.border.all(color=self.colors["border"]["default"]),
                            border_radius=4,
                            padding=5,
                            bgcolor=self.colors["bg"]["input"],
                        ),
                        
                        ft.Container(height=5),
                        
                        ft.Row([
                            ft.OutlinedButton(
                                "Copy",
                                icon=ft.icons.COPY,
                                style=ft.ButtonStyle(
                                    color=self.colors["text"]["secondary"],
                                ),
                                # Pass the structured details to _copy_diff
                                on_click=lambda e, details=entry.get("diff_details"): self._copy_diff(details)
                            ),
                            ft.ElevatedButton(
                                "View Details",
                                icon=ft.icons.VISIBILITY,
                                style=ft.ButtonStyle(
                                    color=ft.colors.WHITE,
                                    bgcolor=self.colors["bg"]["accent"],
                                ),
                                # Pass the structured details to _show_details
                                on_click=lambda e, details=entry.get("diff_details"): self._show_details(details)
                            )
                        ], alignment="end", spacing=10)
                    ]),
                    padding=15,
                    animate=ft.animation.Animation(300, "easeOut"),
                ),
                elevation=2,
                margin=ft.margin.only(bottom=10),
                color=self.colors["bg"]["secondary"],
            )
            self.history_list.controls.append(history_card)

    def _entry_matches_search(self, entry: dict, search_text: str) -> bool:
        # This method could be removed as it's no longer used
        return False

    def _copy_diff(self, comparison_details: dict):
        """Copy formatted comparison details to clipboard."""
        if not comparison_details:
            self.app.show_snackbar("No details to copy.")
            return
        formatted_text = ComparisonService().format_comparison_as_text(comparison_details)
        self.page.set_clipboard(formatted_text)
        self.app.show_snackbar("Comparison details copied to clipboard")

    def _show_details(self, comparison_details: dict):
        """Show full diff details in a new dialog."""
        if not comparison_details:
            self.app.show_snackbar("No details to display.")
            return
        # Create details dialog on demand since it's content-dependent
        details_dialog = self._create_details_dialog(comparison_details)
        
        # Hide main dialog and show details
        self.dialog.open = False
        self.page.overlay.append(details_dialog)
        details_dialog.open = True
        self.page.update()

    def _create_details_dialog(self, comparison_details: dict): # Changed signature
        """Create the details dialog with the provided structured comparison details."""

        summary = comparison_details.get("summary", {})
        missing_in_target = comparison_details.get("missing_in_target", {}) # Added items from source perspective
        obsolete_in_target = comparison_details.get("obsolete_in_target", {}) # Removed items from source perspective
        
        # For raw diff text field
        full_diff_text = ComparisonService().format_comparison_as_text(comparison_details)

        # Create the dialog
        dialog = ft.AlertDialog(
            modal=False,  # changed from True
            on_dismiss=lambda e: close_handler(e),  # new
            title=ft.Row([
                ft.Icon(ft.icons.COMPARE_ARROWS, color=self.colors["bg"]["accent"]),
                ft.Text("Comparison Details", size=20, weight="bold"),
            ]),
            content=ft.Container(
                content=ft.Column([
                    # Stats row
                    ft.Container(
                        content=ft.Row([
                            ft.Container(
                                content=ft.Column([
                                    ft.Text(
                                        "Added Lines (Missing in Target)",
                                        size=14,
                                        color=self.colors["text"]["secondary"]
                                    ),
                                    ft.Text(
                                        f"{summary.get('missing_count', 0)}", # Use summary
                                        size=20,
                                        weight="bold",
                                        color=self.colors["changes"]["added"]
                                    ),
                                ], 
                                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                spacing=4
                            ),
                                width=150,
                                padding=10,
                            ),
                            ft.VerticalDivider(
                                width=1,
                                color=self.colors["border"]["default"],
                            ),
                            ft.Container(
                                content=ft.Column([
                                    ft.Text(
                                        "Removed Lines (Obsolete in Target)",
                                        size=14,
                                        color=self.colors["text"]["secondary"]
                                    ),
                                    ft.Text(
                                        f"{summary.get('obsolete_count', 0)}", # Use summary
                                        size=20,
                                        weight="bold",
                                        color=self.colors["changes"]["removed"]
                                    ),
                                ], 
                                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                                spacing=4
                            ),
                                width=150,
                                padding=10,
                            ),
                        ],
                        alignment="center",
                        ),
                        padding=10,
                        border=ft.border.all(color=self.colors["border"]["default"]),
                        border_radius=5,
                        margin=ft.margin.only(bottom=20),
                        bgcolor=self.colors["bg"]["secondary"],
                    ),
                    
                    # Split view with side-by-side comparison
                    ft.Container(
                        content=ft.Row([
                            # Left side - Added content
                            ft.Container(
                                content=ft.Column([
                                    ft.Container(
                                        content=ft.Row([
                                            ft.Icon(ft.icons.ADD_CIRCLE, color=self.colors["changes"]["added"], size=16),
                                            ft.Text(
                                                "Added Items",
                                                weight="bold",
                                                size=14,
                                                color=self.colors["changes"]["added"]
                                            ),
                                        ], spacing=5),
                                        padding=ft.padding.only(bottom=8),
                                    ),
                                    ft.Container(
                                        # Pass the dictionary of missing items
                                        content=self._create_diff_view(missing_in_target, "missing"),
                                        expand=True,
                                    ),
                                ]),
                                expand=True,
                                padding=10,
                                border=ft.border.all(color=self.colors["border"]["default"]),
                                border_radius=5,
                                bgcolor=self.colors["bg"]["input"],
                            ),
                            
                            # Divider
                            ft.Container(width=20),
                            
                            # Right side - Removed content
                            ft.Container(
                                content=ft.Column([
                                    ft.Container(
                                        content=ft.Row([
                                            ft.Icon(ft.icons.REMOVE_CIRCLE, color=self.colors["changes"]["removed"], size=16),
                                            ft.Text(
                                                "Removed Items",
                                                weight="bold",
                                                size=14,
                                                color=self.colors["changes"]["removed"]
                                            ),
                                        ], spacing=5),
                                        padding=ft.padding.only(bottom=8),
                                    ),
                                    ft.Container(
                                        # Pass the dictionary of obsolete items
                                        content=self._create_diff_view(obsolete_in_target, "obsolete"),
                                        expand=True,
                                    ),
                                ]),
                                expand=True,
                                padding=10,
                                border=ft.border.all(color=self.colors["border"]["default"]),
                                border_radius=5,
                                bgcolor=self.colors["bg"]["input"],
                            ),
                        ]),
                        expand=True,
                    ),
                    
                    # Raw diff section with toggle
                    ft.Container(
                        content=ft.Column([
                            ft.Container(
                                content=ft.Row([
                                    ft.Text(
                                        "Raw Diff Output",
                                        weight="bold",
                                        size=14,
                                    ),
                                    ft.IconButton(
                                        icon=ft.icons.ARROW_DROP_DOWN,
                                        on_click=lambda e: self._toggle_raw_diff(e),
                                    )
                                ], alignment="spaceBetween"),
                                padding=10,
                                bgcolor=self.colors["bg"]["secondary"],
                                border_radius=ft.border_radius.only(
                                    top_left=5, top_right=5, 
                                    bottom_left=5 if not hasattr(self, "_show_raw_diff") else 0,
                                    bottom_right=5 if not hasattr(self, "_show_raw_diff") else 0
                                ),
                            ),
                            ft.Container(
                                content=ft.TextField(
                                    value=full_diff_text, # Use formatted full diff
                                    multiline=True,
                                    read_only=True,
                                    min_lines=5,
                                    max_lines=10,
                                    text_style=ft.TextStyle(
                                        font_family="Consolas",
                                        size=12,
                                    ),
                                    border=ft.border.all(color=self.colors["border"]["default"]),
                                    bgcolor=self.colors["bg"]["input"],
                                    selection_color=self.colors["bg"]["accent"] + "40",
                                ),
                                visible=False if not hasattr(self, "_show_raw_diff") else self._show_raw_diff,
                                border_radius=ft.border_radius.only(bottom_left=5, bottom_right=5),
                            )
                        ]),
                        margin=ft.margin.only(top=10),
                        border=ft.border.all(color=self.colors["border"]["default"]),
                    ),
                ]),
                width=900,
                height=600,
                padding=20,
            ),
            actions=[],  # Initialize with empty actions
            actions_alignment=ft.MainAxisAlignment.END,
        )

        # Define a custom close handler that captures the dialog as a parameter
        def close_handler(e):
            self._close_details(dialog)
            
        # Define a custom copy and close handler
        def copy_close_handler(e):
            # Pass the full structured details for copying
            self._copy_and_close(comparison_details, dialog)
            
        # Now add the actions with properly bound handlers
        dialog.actions = [
            ft.TextButton(
                "Copy Formatted Diff", # Changed label
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

    def _create_diff_view(self, items: dict, diff_type: str): # Changed signature to accept dict
        """Create a scrollable view for diff content (missing or obsolete items)."""
        if not items:
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
        
        for key, value in sorted(items.items()):
            list_view.controls.append(
                ft.Container(
                    content=ft.Column([
                        ft.Text(
                            key,
                            weight=FontWeight.BOLD, # Corrected: FontWeight.BOLD
                            size=12,
                            color=self.colors["text"]["primary"],
                        ),
                        ft.Container(
                            content=ft.Text(
                                str(value)[:100] + ('...' if len(str(value)) > 100 else ''), # Show preview of value
                                size=12,
                                color=self.colors["text"]["secondary"],
                                tooltip=str(value), # Full value on hover
                            ),
                            margin=ft.margin.only(left=10),
                        ),
                    ], spacing=2, tight=True),
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

    def _copy_and_close(self, comparison_details: dict, dialog): # Changed signature
        """Copy formatted comparison text to clipboard and close the dialog."""
        if not comparison_details:
            self.app.show_snackbar("No details to copy.")
            self._close_details(dialog) # Still close dialog
            return
        formatted_text = ComparisonService().format_comparison_as_text(comparison_details)
        self.page.set_clipboard(formatted_text)
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