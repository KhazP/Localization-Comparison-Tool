import pytest
import flet as ft
from unittest.mock import Mock, patch, AsyncMock
from GUI.flet_gui import App
import asyncio

# Fixtures
@pytest.fixture
def test_page():
    # Create a mock Page with all required attributes
    page = Mock(spec=ft.Page)
    page.window_width = 1024
    page.window_height = 768
    page.conn = Mock()
    page.session_id = "test_session"
    page.loop = asyncio.get_event_loop()
    page.overlay = []  # Add overlay attribute as a list
    return page

@pytest.fixture
def app(test_page):
    with patch('GUI.flet_gui.ConfigManager.load') as mock_load:
        mock_load.return_value = {
            "theme": "light",
            "auto_fill_missing": False,
            "log_missing_strings": False,
            "ignore_patterns": [],
            "preferred_format": "auto",
            "ignore_whitespace": False,
            "ignore_case": False,
            "compare_values": True,
            "group_by_namespace": True,
            "show_preview": False,
            "show_line_numbers": False,
            "mt_enabled": False,
            "mt_api_key": "",
            "mt_source_lang": "en",
            "mt_target_lang": "es"
        }
        return App(test_page)

# UI Component Tests
def test_file_input_component(app, test_page):
    # Test file input initialization
    assert app.file_input is not None
    assert app.source_file_container is not None
    assert app.target_file_container is not None

def test_settings_dialog(app, test_page):
    # Test settings dialog functionality
    assert app.settings_dialog is not None
    assert not app.settings_dialog.open
    
    # Open settings
    app.open_settings(None)
    assert app.settings_dialog.open
    
    # Test theme change
    app.handle_theme_change(Mock(control=Mock(value="dark")))
    assert app.current_theme == "dark"

def test_comparison_workflow(app, test_page):
    with patch('GUI.flet_gui.file_processing_service') as mock_service:
        # Mock comparison results
        mock_service.compare_files_async.return_value = "task_1"
        mock_service.get_task_status.return_value = {
            'status': 'completed',
            'result': {
                'comparison': "Comparison result",
                'stats': {
                    'total_keys': 3,
                    'missing_keys': 1,
                    'obsolete_keys': 1
                }
            }
        }
        
        # Simulate file selection
        app.source_file_path = "test_source.lang"
        app.target_file_path = "test_target.lang"
        
        # Trigger comparison
        app.compare_files_gui(None)
        
        # Verify results displayed
        assert app.stats_text_total.value != "0"
        assert not app.loading_ring.visible

@pytest.mark.asyncio
async def test_async_file_processing(app, test_page):
    with patch('GUI.flet_gui.file_processing_service') as mock_service:
        mock_service.compare_files_async.return_value = "task_1"
        mock_service.get_task_status.return_value = {
            'status': 'completed',
            'result': {'comparison': "Test result"}
        }
        
        # Simulate async file processing
        await app.compare_files_async(None)
        assert not app.loading_ring.visible
        assert app.status_label.value == "Ready"

def test_error_handling(app, test_page):
    # Test invalid file selection
    event = Mock()
    event.files = [Mock(path="invalid.txt")]
    app.handle_file_picked(event, app.source_label, app.source_icon, "source")
    assert "No file selected" in app.source_label.value

    # Test unsupported format error
    assert not app.validate_file("test.unsupported")
    assert "Unsupported file type" in app.status_label.value