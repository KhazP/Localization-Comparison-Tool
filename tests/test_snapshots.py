import pytest
import flet as ft
from unittest.mock import Mock, patch
from pathlib import Path
import os
import asyncio
from tests.snapshot_helpers import SnapshotComparator, format_component

# Import the components we want to test
from GUI.flet_gui import App
from components.file_input import FileInputComponent
from components.results_view import ResultsViewComponent
from components.stats_panel import StatsPanelComponent

# Directory for storing snapshots
SNAPSHOT_DIR = Path("tests/snapshots")
SNAPSHOT_DIR.mkdir(exist_ok=True, parents=True)

class TestSnapshots:
    @pytest.fixture
    def update_snapshots(self):
        return os.environ.get('UPDATE_SNAPSHOTS', '').lower() == 'true'

    @pytest.fixture
    def snapshot_comparator(self, update_snapshots):
        return SnapshotComparator(str(SNAPSHOT_DIR))

    @pytest.fixture
    def test_page(self):
        # Create a mock Page with all required attributes
        page = Mock(spec=ft.Page)
        page.window_width = 1024
        page.window_height = 768
        page.conn = Mock()
        page.session_id = "test_session"
        page.loop = asyncio.get_event_loop()
        
        # Mock the send_commands method to return empty results list
        page.send_commands = Mock(return_value={"results": []})
        
        # Mock client_storage through the connection
        mock_storage = Mock()
        mock_storage.get.return_value = None
        page.conn.client_storage = mock_storage
        
        # Set up the overlay as a list for FilePicker controls
        page.overlay = []
        return page

    @pytest.fixture
    def mock_app(self, test_page):
        """Create a mock app with all required attributes"""
        app = Mock()
        app.COLORS = {
            "text": {"primary": "#000000", "secondary": "#666666"},
            "bg": {"accent": "#007BFF", "input": "#FFFFFF", "secondary": "#F8F9FA", "card": "#FFFFFF"},
            "border": {"default": "#CCCCCC"},
            "changes": {"added": "#4CAF50", "removed": "#F44336"}
        }
        app.page = test_page
        app.config = {
            "show_preview": False,
            "show_line_numbers": True
        }
        app.source_line_numbers = {}
        app.validate_file = Mock(return_value=True)
        app.update_compare_button = Mock()
        app.preview_section = Mock(visible=False)
        return app

    @pytest.fixture
    def test_config(self):
        """Common test configuration"""
        return {
            "theme": "light",
            "auto_fill_missing": False,
            "log_missing_strings": False,
            "ignore_patterns": [],
            "preferred_format": "auto",
            "ignore_whitespace": False,
            "ignore_case": False,
            "compare_values": True,
            "group_by_namespace": True,
            "show_preview": True,
            "show_line_numbers": True,
            "mt_enabled": False,
            "mt_api_key": "",
            "mt_source_lang": "en",
            "mt_target_lang": "es"
        }

    # Update all test methods to use the mocked page
    def test_file_input_component_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test file input component matches snapshot"""
        component = FileInputComponent(mock_app)  # Remove page parameter
        component_dict = format_component(component.source_file_container)
        mismatch = snapshot_comparator.compare(component_dict, "file_input_component", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_stats_panel_component_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test stats panel component matches snapshot"""
        component = StatsPanelComponent(mock_app, mock_app.COLORS)  # Remove page parameter
        component_dict = format_component(component.panel)
        mismatch = snapshot_comparator.compare(component_dict, "stats_panel_component", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_results_view_empty_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test results view component in empty state matches snapshot"""
        component = ResultsViewComponent(mock_app, mock_app.COLORS)  # Remove page parameter
        component_dict = format_component(component.results_container)
        mismatch = snapshot_comparator.compare(component_dict, "results_view_empty", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_app_initial_state_snapshot(self, test_page, snapshot_comparator, update_snapshots):
        """Test app initial state matches snapshot"""
        with patch('GUI.flet_gui.ConfigManager.load') as mock_load:
            mock_load.return_value = self.test_config()
            app = App(test_page)
            
            if hasattr(app, "main_content_area") and app.main_content_area:
                component_dict = format_component(app.main_content_area)
                mismatch = snapshot_comparator.compare(component_dict, "app_main_content_initial", update=update_snapshots)
                assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_results_view_with_data_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test results view component with comparison data matches snapshot"""
        component = ResultsViewComponent(mock_app, mock_app.COLORS)  # Remove page parameter
        sample_comparison = """+ key1: Value 1
- key2: Old Value
  key3: Unchanged Value"""
        
        component.build_results_table(sample_comparison)
        component_dict = format_component(component.results_container)
        mismatch = snapshot_comparator.compare(component_dict, "results_view_with_data", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_stats_panel_with_data_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test stats panel component with statistics matches snapshot"""
        component = StatsPanelComponent(mock_app, mock_app.COLORS)  # Remove page parameter
        component.update_stats(total_keys=100, missing_keys=20, obsolete_keys=10)
        component_dict = format_component(component.panel)
        mismatch = snapshot_comparator.compare(component_dict, "stats_panel_with_data", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_file_input_selected_state_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test file input component with selected file matches snapshot"""
        component = FileInputComponent(mock_app)  # Remove page parameter
        
        # Simulate file selection
        component.handle_file_picked(
            Mock(files=[Mock(path="test.json", name="test.json")]),
            component.source_label,
            component.source_icon,
            None,
            "source"
        )
        
        component_dict = format_component(component.source_file_container)
        mismatch = snapshot_comparator.compare(component_dict, "file_input_selected", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_app_comparison_state_snapshot(self, test_page, snapshot_comparator, update_snapshots):
        """Test app state after file comparison matches snapshot"""
        with patch('GUI.flet_gui.ConfigManager.load') as mock_load:
            mock_load.return_value = self.test_config()
            app = App(test_page)
            
            # Mock the app's comparison state
            app.source_file_path = "test1.json"
            app.target_file_path = "test2.json"
            if hasattr(app, "stats_panel"):
                app.stats_panel.update_stats(100, 20, 10)
            if hasattr(app, "results_view"):
                app.results_view.build_results_table("""+ added_key: New Value
- removed_key: Old Value
  unchanged_key: Same Value""")
            
            if hasattr(app, "main_content_area") and app.main_content_area:
                component_dict = format_component(app.main_content_area)
                mismatch = snapshot_comparator.compare(component_dict, "app_comparison_state", update=update_snapshots)
                assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_results_view_error_state_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test results view component in error state matches snapshot"""
        component = ResultsViewComponent(mock_app, mock_app.COLORS)  # Remove page parameter
        component.output_text.value = "Error: Failed to process file: Invalid format"
        component.summary_text.value = "An error occurred during comparison"
        
        component_dict = format_component(component.results_container)
        mismatch = snapshot_comparator.compare(component_dict, "results_view_error", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_app_dark_theme_snapshot(self, test_page, snapshot_comparator, update_snapshots):
        """Test app appearance with dark theme"""
        config = self.test_config()
        config["theme"] = "dark"
        
        with patch('GUI.flet_gui.ConfigManager.load') as mock_load:
            mock_load.return_value = config
            app = App(test_page)
            
            if hasattr(app, "main_content_area") and app.main_content_area:
                component_dict = format_component(app.main_content_area)
                mismatch = snapshot_comparator.compare(component_dict, "app_dark_theme", update=update_snapshots)
                assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_results_view_filtered_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test results view with filter applied"""
        component = ResultsViewComponent(mock_app, mock_app.COLORS)  # Remove page parameter
        
        sample_data = """+ new.key1: New Value 1
+ new.key2: New Value 2
- old.key1: Old Value 1
- old.key2: Old Value 2
  unchanged.key1: Same Value 1
  unchanged.key2: Same Value 2"""
        
        component.build_results_table(sample_data)
        component.filter_results("new")  # Filter to show only new keys
            
        component_dict = format_component(component.results_container)
        mismatch = snapshot_comparator.compare(component_dict, "results_view_filtered", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_stats_panel_zero_state_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test stats panel with zero statistics"""
        component = StatsPanelComponent(mock_app, mock_app.COLORS)  # Remove page parameter
        component.update_stats(total_keys=0, missing_keys=0, obsolete_keys=0)
        component_dict = format_component(component.panel)
        mismatch = snapshot_comparator.compare(component_dict, "stats_panel_zero", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"

    def test_file_input_error_state_snapshot(self, test_page, snapshot_comparator, update_snapshots, mock_app):
        """Test file input component with error state"""
        component = FileInputComponent(mock_app)  # Remove page parameter
        
        # Mock os.path.getsize to avoid file system access
        with patch('os.path.getsize') as mock_getsize:
            mock_getsize.return_value = 1024  # 1KB file size
            component.handle_file_picked(
                Mock(files=[Mock(path="invalid.json", name="invalid.json")]),
                component.source_label,
                component.source_icon,
                None,
                "source"
            )
        
        component_dict = format_component(component.source_file_container)
        mismatch = snapshot_comparator.compare(component_dict, "file_input_error", update=update_snapshots)
        assert not mismatch, f"Snapshot mismatch:\n{mismatch.diff if mismatch else ''}"