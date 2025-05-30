import flet as ft
from flet import (
    Card, Container, Row, Column, Text, VerticalDivider,
    padding, FontWeight, ResponsiveRow
)

class StatsPanelComponent:
    """Component for displaying translation statistics in the UI.
    
    This component shows total keys count, missing translations, obsolete translations,
    and overall translation percentage in a card layout with dividers.
    """

    def __init__(self, page: ft.Page, app_reference, colors: dict):
        """Initialize the stats panel component.
        
        Args:
            page: The Flet page instance
            app_reference: Reference to the main application instance
            colors: Dictionary containing theme colors
        """
        self.page = page
        self.app = app_reference
        self.colors = colors
        
        # Initialize stats text fields
        # Initialize stats text fields with M3 roles
        self.stats_text_total = Text(
            value="0",
            size=22, # M3 Headline Small/Title Large
            weight=FontWeight.BOLD,
            color=self.colors.get("onSurface"), # Prominent text on surface
        )
        self.stats_text_missing = Text(
            value="0",
            size=22,
            weight=FontWeight.BOLD,
            color=self.colors.get("error"), # Semantic color for missing/removed
        )
        self.stats_text_obsolete = Text( # "Obsolete" here means "missing in source", effectively "added in target unexpectedly"
            value="0",
            size=22,
            weight=FontWeight.BOLD,
            color=self.colors.get("tertiary"), # Using tertiary for this distinct stat
        )
        self.stats_text_percentage = Text(
            value="0%",
            size=22,
            weight=FontWeight.BOLD,
            color=self.colors.get("primary"), # Primary color for emphasis on percentage
        )
        
        # Create the stats panel
        self.panel = self._create_stats_panel()

    def _create_stats_panel(self):
        """Create the main stats panel card with all statistics sections.
        
        Returns:
            Card: A Flet Card containing the formatted statistics display
        """
        return Card(
            content=Container(
                content=ResponsiveRow(
                    controls=[
                        self._create_stat_container("Total Keys", self.stats_text_total, {"sm": 6, "md": 3, "lg": 3}),
                        self._create_stat_container("Missing in Target", self.stats_text_missing, {"sm": 6, "md": 3, "lg": 3}),
                        self._create_stat_container("Missing in Source", self.stats_text_obsolete, {"sm": 6, "md": 3, "lg": 3}),
                        self._create_stat_container("Translated %", self.stats_text_percentage, {"sm": 6, "md": 3, "lg": 3}),
                    ],
                    alignment="center", # M3 content often centered in cards
                    vertical_alignment=ft.CrossAxisAlignment.CENTER,
                ),
                bgcolor=self.colors.get("surfaceContainer"), # M3 surface role
                padding=padding.all(8), # Reduced padding inside card before stat containers
                border_radius=12, # M3 card radius
            ),
            elevation=1, # M3 standard elevation for cards like this
        )

    def _create_stat_container(self, label: str, stat_text: Text, col=None):
        """Create a container for a single statistic with M3 styling."""
        return Container(
            content=Column(
                controls=[
                    Text(label, size=12, color=self.colors.get("onSurfaceVariant"), weight=FontWeight.NORMAL), # M3 Body Small or Label Medium
                    stat_text, # Already styled
                ],
                horizontal_alignment=ft.CrossAxisAlignment.CENTER, # M3 center alignment
                spacing=4, # M3 spacing
            ),
            padding=padding.symmetric(vertical=12, horizontal=8), # M3 padding
            expand=True,
            col=col,
            # Add border for visual separation if needed, or rely on spacing
            # border=ft.border.only(right=ft.border.BorderSide(1, self.colors.get("outlineVariant")))
            # if not the last item, but ResponsiveRow handles spacing well.
        )

    def update_stats(self, total_keys: int, missing_keys: int, obsolete_keys: int):
        """Update all statistics displayed in the panel.
        
        Args:
            total_keys: Total number of translation keys
            missing_keys: Number of keys missing in target
            obsolete_keys: Number of keys present in target but missing in source
        """
        translated_keys = total_keys - missing_keys
        translation_percentage = (translated_keys / total_keys * 100) if total_keys else 0
        
        self.stats_text_total.value = str(total_keys)
        self.stats_text_missing.value = str(missing_keys)
        self.stats_text_obsolete.value = str(obsolete_keys)
        self.stats_text_percentage.value = f"{translation_percentage:.1f}%"
        
        self.page.update()

    def update_colors(self, colors: dict):
        """Update the component's colors when theme changes.
        
        Args:
            colors: Dictionary containing the new theme colors
        """
        self.colors = colors # Update the component's color map with new M3 theme

        # Update stat text colors
        self.stats_text_total.color = self.colors.get("onSurface")
        self.stats_text_missing.color = self.colors.get("error")
        self.stats_text_obsolete.color = self.colors.get("tertiary") # Or another distinct color like secondary
        self.stats_text_percentage.color = self.colors.get("primary")

        # Update panel background (Container within Card)
        if self.panel and isinstance(self.panel, ft.Card) and isinstance(self.panel.content, ft.Container):
            self.panel.content.bgcolor = self.colors.get("surfaceContainer")

        # Update labels in stat containers
        # Assuming the structure from _create_stat_container: Container -> Column -> Text (label)
        if self.panel and self.panel.content and self.panel.content.content and \
           isinstance(self.panel.content.content, ft.ResponsiveRow):
            for stat_container_wrapper in self.panel.content.content.controls:
                 if isinstance(stat_container_wrapper, ft.Container) and \
                    isinstance(stat_container_wrapper.content, ft.Column) and \
                    len(stat_container_wrapper.content.controls) > 0 and \
                    isinstance(stat_container_wrapper.content.controls[0], ft.Text):

                    label_text = stat_container_wrapper.content.controls[0]
                    label_text.color = self.colors.get("onSurfaceVariant")

        # No need to call self.page.update() directly, App class handles it.
