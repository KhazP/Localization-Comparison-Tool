import flet as ft
from flet import (
    Card, Container, Row, Column, Text, VerticalDivider,
    padding, FontWeight
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
        self.stats_text_total = Text(
            value="0",
            size=24,
            weight=FontWeight.BOLD,
            color=self.colors["text"]["primary"],
        )
        self.stats_text_missing = Text(
            value="0",
            size=24,
            weight=FontWeight.BOLD,
            color=self.colors["changes"]["removed"],
        )
        self.stats_text_obsolete = Text(
            value="0",
            size=24,
            weight=FontWeight.BOLD,
            color=self.colors["changes"]["added"],
        )
        self.stats_text_percentage = Text(
            value="0%",
            size=24,
            weight=FontWeight.BOLD,
            color="lightblue",
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
                content=Row(
                    controls=[
                        self._create_stat_container("Total Keys", self.stats_text_total),
                        VerticalDivider(color=self.colors["border"]["default"], width=1),
                        self._create_stat_container("Missing in Target", self.stats_text_missing),
                        VerticalDivider(color=self.colors["border"]["default"], width=1),
                        self._create_stat_container("Missing in Source", self.stats_text_obsolete),
                        VerticalDivider(color=self.colors["border"]["default"], width=1),
                        self._create_stat_container("Translated %", self.stats_text_percentage),
                    ],
                    alignment="center",
                ),
                bgcolor=self.colors["bg"]["secondary"],
                border_radius=8,
            ),
            elevation=1,
        )

    def _create_stat_container(self, label: str, stat_text: Text):
        """Create a container for a single statistic.
        
        Args:
            label: The label text for the statistic
            stat_text: The Text control displaying the statistic value
            
        Returns:
            Container: A formatted container with the statistic and its label
        """
        return Container(
            content=Column(
                controls=[
                    Text(label, size=14, color=self.colors["text"]["secondary"]),
                    stat_text,
                ],
                horizontal_alignment="center",
                spacing=4,
            ),
            padding=padding.all(16),
            expand=True,
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
        self.colors = colors
        self.stats_text_total.color = colors["text"]["primary"]
        self.stats_text_missing.color = colors["changes"]["removed"]
        self.stats_text_obsolete.color = colors["changes"]["added"]
        # No need to call page.update() as it will be handled by the main app
