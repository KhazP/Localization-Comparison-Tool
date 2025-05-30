import pytest
import flet as ft
from unittest.mock import Mock, patch, AsyncMock
from GUI.flet_gui import App
import asyncio

# Fixtures
@pytest.fixture
def test_page(event_loop): # Add event_loop fixture for asyncio compatibility
    # Create a mock Page with all required attributes
    page = Mock(spec=ft.Page)
    page.window_width = 1024
    page.window_height = 768
    page.conn = Mock()
    page.client_ip = "127.0.0.1" # Add missing client_ip
    page.client_user_agent = "pytest" # Add missing client_user_agent
    page.session_id = "test_session"
    page.loop = event_loop # Use the provided event loop
    page.overlay = []
    page.dialog = None # Add dialog attribute
    page.views = [] # Add views for navigation (if used)
    page.route = "/" # Add default route
    page.pubsub = Mock() # Add pubsub
    page.platform = "windows" # Add platform
    page.platform_details = Mock(windows=True, macos=False, linux=False)
    page.web = False # Add web attribute
    page.theme = None # Will be set by App
    page.dark_theme = None # Will be set by App
    page.theme_mode = ft.ThemeMode.LIGHT # Default, App will change it

    # Mock methods that App might call on page
    page.update = AsyncMock()
    page.add = AsyncMock()
    page.go_async = AsyncMock()
    page.launch_url_async = AsyncMock()
    page.show_snack_bar = Mock() # If app calls page.show_snack_bar directly
    page.close_dialog_async = AsyncMock()
    page.show_dialog_async = AsyncMock()

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
    # Import THEMES to check against actual color values
    from core.themes import THEMES as AppThemes

    mock_event = Mock()
    mock_event.control.value = "dark" # Simulate dropdown or similar control
    app.handle_theme_change(mock_event) # Pass the mock event

    assert app.current_theme_name == "dark"
    # Check if a key M3 color role in app.COLORS matches the expected value from the "dark" theme
    assert app.COLORS.get("primary") == AppThemes["dark"]["primary"]
    # Check if the page's dark_theme ColorScheme was updated (if applicable)
    assert app.page.dark_theme.color_scheme.primary == AppThemes["dark"]["primary"]
    # Check a UI element that should have changed color
    assert app.settings_button.icon_color == app.COLORS.get("onSurface")


def test_comparison_workflow(app, test_page):
    with patch('GUI.flet_gui.file_processing_service') as mock_service:
        # Mock comparison results
        mock_service.compare_files_async.return_value = "task_1"
        # Simulate a more complete stats structure if your app uses it
        mock_service.get_task_status.return_value = {
            'status': 'completed',
            'result': {
                'comparison': "Comparison result text",
                'source_dict': {"key1": "val1", "key2": "val2", "key3": "val3"},
                'target_dict': {"key1": "val1", "key2": "val2_changed", "key4": "val4"},
                'source_lines': {}, # Add if needed
                'target_lines': {}, # Add if needed
                'stats': { # Ensure all keys accessed by update_statistics are here
                    'total_keys': 3,    # Usually from source_dict
                    'missing_keys': 1,  # key3 is in source but not target
                    'obsolete_keys': 1  # key4 is in target but not source
                }
            }
        }
        
        # Simulate file selection (assuming these paths are set on app for comparison logic)
        app.source_file_path = "dummy_source.json"
        app.target_file_path = "dummy_target.json"
        app.update_compare_button() # Enable compare button
        
        # Trigger comparison - check if button is enabled first
        assert not app.compare_button.content.controls[0].disabled
        app.compare_files_gui(None) # Simulate button click
        
        # Verify results displayed (accessing through stats_panel_component)
        assert app.stats_panel_component.stats_text_total.value == "3"
        assert app.stats_panel_component.stats_text_missing.value == "1"
        assert app.stats_panel_component.stats_text_obsolete.value == "1"
        # Check percentage if it's directly set and simple, e.g. "66.7%" or similar
        # For 3 total, 1 missing -> 2 translated. (2/3)*100 = 66.66...%
        assert "%" in app.stats_panel_component.stats_text_percentage.value

        assert not app.loading_ring.visible
        assert "Compared" in app.status_label.value # Check for a part of the completion message


@pytest.mark.asyncio
async def test_async_file_processing(app, test_page):
    with patch('GUI.flet_gui.file_processing_service') as mock_service:
        mock_service.compare_files_async.return_value = "task_1"
        mock_service.get_task_status.return_value = {
            'status': 'completed',
            'result': { # Provide a more complete result structure matching comparison_workflow
                'comparison': "Async test result",
                'source_dict': {"a": "1"}, 'target_dict': {"a": "1"},
                'source_lines': {}, 'target_lines': {},
                'stats': {'total_keys': 1, 'missing_keys': 0, 'obsolete_keys': 0}
            }
        }
        app.source_file_path = "dummy_source.json" # Needed for compare_files_async
        app.target_file_path = "dummy_target.json" # Needed for compare_files_async

        # Simulate async file processing
        # Check initial state of loading ring and status label colors (set by update_theme_colors)
        initial_loading_ring_color = app.COLORS.get("primary")
        initial_status_label_color = app.COLORS.get("onSurfaceVariant")

        app.loading_ring.color = initial_loading_ring_color # Ensure it's set before test
        app.status_label.color = initial_status_label_color # Ensure it's set

        await app.compare_files_async(None) # This will update status_label and loading_ring

        assert not app.loading_ring.visible
        # Status label value is updated by compare_files_async upon completion
        assert "Compared: 1 keys, 0 missing, 0 obsolete." in app.status_label.value
        # Ensure colors are still consistent with the theme after operations
        assert app.loading_ring.color == initial_loading_ring_color
        assert app.status_label.color == initial_status_label_color

def test_error_handling(app, test_page):
    # Test invalid file selection
    # This test needs to be adapted as handle_file_picked is now in FileInputComponent
    # We are testing App's reaction or how it uses FileInputComponent
    # For simplicity, let's assume we want to test the validation logic directly if possible,
    # or the snackbar message if App.show_snackbar is called.

    # Mock FilePickerResultEvent for FileInputComponent's handle_file_picked
    mock_file = Mock()
    mock_file.path = "invalid.txt" # An actual file might be needed for validate_file to pass os.path.isfile
    mock_event_data = Mock(spec=ft.FilePickerResultEvent)
    mock_event_data.files = [mock_file]
    mock_event_data.path = None # Path is used for directory picking

    # Patch os.path.isfile to control validation outcome for non-existent files
    with patch('os.path.isfile', return_value=False):
        # Call the method on the component instance
        app.file_input.handle_file_picked(mock_event_data,
                                          app.file_input.source_label,
                                          app.file_input.source_icon,
                                          None, # clear_btn not always used
                                          "source")
    # Check if the label on FileInputComponent was updated to indicate failure or no selection
    assert "No file selected" in app.file_input.source_label.value
    # Check if a snackbar message was shown (App.show_snackbar is called by FileInputComponent)
    # This requires App.show_snackbar to be callable or a mock to check calls.
    # For now, assume it updates status_label or similar if snackbar isn't directly testable here.


    # Test unsupported format error (app.validate_file is called by FileInputComponent)
    # To test App's reaction, we'd check if a snackbar message appears.
    # Temporarily make a file that validate_file can check extension of
    with patch('os.path.isfile', return_value=True): # Assume file exists for this part
        app.file_input.source_file_path = "test.unsupported" # Set path directly for validate_file
        assert not app.validate_file("test.unsupported") # validate_file is on App, used by FileInputComponent

    # After validate_file returns False, FileInputComponent should show an error.
    # Assuming show_snackbar is called by App.validate_file or by FileInputComponent using App.show_snackbar
    # We need to check the snackbar. For simplicity, if it updates status_label:
    # However, show_validation_error updates the snackbar.
    # We need to check the arguments to page.show_snack_bar or page.snack_bar.content
    # Let's assume show_snackbar updates a visible text element for testing if snackbar is hard to check
    # For now, this assertion is difficult without better access to snackbar content.
    # A simple check:
    app.show_validation_error("file_type") # Manually call to see if snackbar gets updated
    assert app.page.snack_bar.content.value == "Error: Unsupported file type. Please select a valid format."
    app.page.snack_bar.open = False # Reset for next assertion

    # Test file not found error (via validate_file)
    with patch('os.path.isfile', return_value=False):
        assert not app.validate_file("non_existent_file.json")
    app.show_validation_error("file_not_found")
    assert app.page.snack_bar.content.value == "Error: File not found. Please select a valid file."