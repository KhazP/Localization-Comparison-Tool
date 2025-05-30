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

import unittest # Add for mock_open if not already there

# UI Component Tests
@patch('GUI.flet_gui.App.validate_file', return_value=True) # Mock file validation
@patch('GUI.components.file_input.file_cache_service.count_lines_async') # Mock async line counting
def test_file_input_component(mock_count_lines, mock_validate_file, app, test_page):
    file_input = app.file_input
    
    # Initial state: Compare button should be disabled
    # The compare button is app.compare_button.content.controls[0]
    # The disabled state is on the ElevatedButton itself.
    assert app.compare_button.content.controls[0].disabled == True

    # Simulate selecting a source file
    # We need to mock the FilePickerResultEvent or call a handler that sets the path
    # Let's directly set path and call relevant app update logic for simplicity in test
    test_source_path = "dummy/path/source.json"
    
    # Simulate file_input.handle_file_picked for source
    # This requires mocking the event and its attributes.
    # A simpler way is to call the app's handler if file_input calls back to app,
    # or directly update file_input state and call its internal update logic.
    
    # Let's assume file_input.handle_file_picked updates app.source_file_path
    # and then calls app.update_compare_button() & app.file_input updates its label
    
    # Mocking the line count callback for source
    def source_line_count_callback(count, error):
        file_input.source_label.value = f"source.json (100B, {count} lines)"
        file_input.source_label.update()
        file_input.source_clear_button.visible = True
        file_input.source_clear_button.update()
        app.update_compare_button() # app's compare button update logic

    mock_count_lines.side_effect = lambda path, callback: callback(10, None) # Simulate 10 lines

    # Directly update path in file_input and app, then call its update logic
    file_input.source_file_path = test_source_path
    app.source_file_path = test_source_path # App also tracks this
    # Manually trigger parts of what handle_file_picked would do:
    source_line_count_callback(10, None) # This updates label and compare button
    
    assert "source.json" in file_input.source_label.value
    assert file_input.source_clear_button.visible == True
    assert app.compare_button.content.controls[0].disabled == True # Still disabled, target not selected

    # Simulate selecting a target file
    test_target_path = "dummy/path/target.json"
    def target_line_count_callback(count, error):
        file_input.target_label.value = f"target.json (100B, {count} lines)"
        file_input.target_label.update()
        file_input.target_clear_button.visible = True
        file_input.target_clear_button.update()
        app.update_compare_button()

    mock_count_lines.side_effect = lambda path, callback: callback(12, None) # Simulate 12 lines

    file_input.target_file_path = test_target_path
    app.target_file_path = test_target_path
    target_line_count_callback(12, None)

    assert "target.json" in file_input.target_label.value
    assert file_input.target_clear_button.visible == True
    assert app.compare_button.content.controls[0].disabled == False # Now enabled

    # Test clearing source file
    # Simulate click on source_clear_button (it calls _clear_file_selection)
    file_input._clear_file_selection("source")
    assert file_input.source_label.value == "No file selected"
    assert file_input.source_file_path == ""
    assert app.source_file_path == ""
    assert file_input.source_clear_button.visible == False
    assert app.compare_button.content.controls[0].disabled == True # Disabled again

    # Reselect source to enable compare button again for further tests if needed
    mock_count_lines.side_effect = lambda path, callback: callback(10, None)
    file_input.source_file_path = test_source_path
    app.source_file_path = test_source_path
    source_line_count_callback(10, None)
    assert app.compare_button.content.controls[0].disabled == False


def test_settings_dialog(app, test_page):
    settings_dialog_component = app.settings_dialog_component
    settings_dialog = settings_dialog_component.dialog # Get the actual dialog object

    assert settings_dialog is not None
    assert not settings_dialog.open
    
    # Open settings
    # Need to ensure that page.update() is called if open_settings relies on it.
    # The mock_page's update can be checked or called.
    app.open_settings(None) # Simulates clicking the settings icon button
    test_page.update.assert_called() # Check if page update was triggered
    assert settings_dialog.open
    
    # Test Tab Switching
    assert settings_dialog_component.current_tab == 0 # Initial tab
    general_tab_content_initial = settings_dialog_component.tabs_content[0]
    assert settings_dialog_component.content_container.content == general_tab_content_initial

    # Simulate switching to the "Comparison" tab (index 1)
    settings_dialog_component.switch_to_tab(1)
    # switch_to_tab calls self.page.update() internally.

    assert settings_dialog_component.current_tab == 1
    comparison_tab_content = settings_dialog_component.tabs_content[1]
    assert settings_dialog_component.content_container.content == comparison_tab_content
    
    # Test theme change via UI interaction (simplified by calling quick_theme_change)
    # Switch back to General tab (index 0) first
    settings_dialog_component.switch_to_tab(0)

    # Mock ConfigManager.save that might be called during theme change
    with patch('GUI.settings_dialog.ConfigManager.save') as mock_save_config:
        # Call the method that the UI click on a theme button would trigger
        settings_dialog_component.quick_theme_change("dark")
        mock_save_config.assert_called() # Ensure config save was attempted

    # quick_theme_change calls app.handle_theme_change, which calls app.update_theme_colors,
    # which calls self.page.update().
    
    assert app.current_theme == "dark"
    # Check a color that should have been updated by update_theme_colors
    assert app.page.bgcolor == app.THEMES["dark"]["bg"]["primary"] 

    # Close settings
    settings_dialog_component.close_dialog(None) 
    # close_dialog calls self.page.update()
    assert not settings_dialog.open

def test_comparison_workflow(app, test_page):
    with patch('GUI.flet_gui.file_processing_service') as mock_service:
        # Mock comparison results - NEW STRUCTURED DATA
        mock_comparison_list = [
            {"key": "key.missing", "status": "missing_in_target", "source_value": "SourceVal1", "target_value": None, "details": "Missing"},
            {"key": "key.obsolete", "status": "obsolete_in_target", "source_value": None, "target_value": "TargetVal2", "details": "Obsolete"},
            {"key": "key.changed", "status": "value_changed", "source_value": "SourceVal3", "target_value": "TargetVal3Changed", "details": "Value changed"},
            {"key": "key.identical", "status": "identical", "source_value": "SameVal", "target_value": "SameVal", "details": "Identical"},
        ]
        mock_source_dict = {
            "key.missing": "SourceVal1", 
            "key.changed": "SourceVal3",
            "key.identical": "SameVal"
        }
        mock_target_dict = {
            "key.obsolete": "TargetVal2",
            "key.changed": "TargetVal3Changed",
            "key.identical": "SameVal"
        }

        mock_service.compare_files_async.return_value = "task_1" # Keep task_id simple
        
        # This mock now needs to be for the ASYNC version if compare_files_gui calls compare_files_async
        # If compare_files_gui is purely synchronous and calls logic.py directly, this test needs restructuring.
        # Assuming compare_files_gui internally might call the async version or a synchronous equivalent.
        # For this test, let's assume compare_files_gui will use the file_processing_service for consistency.
        # If not, we'd patch 'GUI.flet_gui.logic.compare_translations' for a direct sync call.

        # Let's refine: compare_files_gui is synchronous and calls logic.compare_translations directly.
        # So, we patch 'GUI.flet_gui.logic.compare_translations' for this specific test.
        # The async test will use the service mock.

    # Create a new test for the synchronous path with direct logic mock
    with patch('GUI.flet_gui.logic.compare_translations') as mock_compare_logic, \
         patch('GUI.flet_gui.logic.parse_content_by_ext', side_effect=[mock_source_dict, mock_target_dict]): # Mock parsing too
        
        mock_compare_logic.return_value = mock_comparison_list
        
        app.source_file_path = "test_source.lang"
        app.target_file_path = "test_target.lang"
        
        # Mock open for reading file content if parse_content_by_ext isn't fully mocked for content
        with patch('builtins.open', new_callable=unittest.mock.mock_open, read_data="key=value") as mock_file:
            app.compare_files_gui(None) # Event object is not used by the method

        # Verify stats panel (accessing through component)
        assert app.stats_panel_component.stats_text_total.value == str(len(mock_source_dict))
        assert app.stats_panel_component.stats_text_missing.value == "1" # key.missing
        assert app.stats_panel_component.stats_text_obsolete.value == "1" # key.obsolete
        
        # Verify results view
        assert app.results_view.results_list_view.controls is not None
        # Check if number of rows matches the number of items + potential namespace headers
        # For this flat mock_comparison_list, it should be 4 rows.
        assert len(app.results_view.results_list_view.controls) == len(mock_comparison_list)
        
        # Check content of one row (e.g., the first one - missing key)
        first_row_controls = app.results_view.results_list_view.controls[0].content.controls
        assert isinstance(first_row_controls[0].content, ft.Icon) # Status icon
        assert first_row_controls[0].content.name == ft.icons.ADD_CIRCLE_OUTLINE # missing_in_target is like 'added' to target from source's view
        
        key_text_container = first_row_controls[1].content
        assert key_text_container.value == "key.missing"
        
        source_value_container = first_row_controls[2].content # This is a Row if value is long, or Text
        if isinstance(source_value_container, ft.Row): # Value with expand button
            assert source_value_container.controls[0].value == "SourceVal1"
        else: # Direct Text
            assert source_value_container.value == "SourceVal1"

        assert not app.loading_ring.visible

@pytest.mark.asyncio
async def test_async_file_processing(app, test_page):
    # Same mock data as above
    mock_comparison_list = [
        {"key": "key.missing", "status": "missing_in_target", "source_value": "SourceVal1", "target_value": None, "details": "Missing"},
        {"key": "key.obsolete", "status": "obsolete_in_target", "source_value": None, "target_value": "TargetVal2", "details": "Obsolete"},
    ]
    mock_source_dict = {"key.missing": "SourceVal1"}
    mock_target_dict = {"key.obsolete": "TargetVal2"}

    with patch('GUI.flet_gui.file_processing_service', new_callable=AsyncMock) as mock_service:
        # Configure the async mock for compare_files_async
        mock_service.compare_files_async.return_value = "task_1" 
        
        # Configure the async mock for get_task_status
        # Note: get_task_status itself is not async, but it's called by an async method.
        # The service instance needs to be an AsyncMock if its methods are to be awaited directly by app.
        # However, app.compare_files_async uses await asyncio.sleep for polling, not await on service methods directly.
        # So, a standard Mock for the service instance, but its methods return appropriate values.
        # Let's re-patch file_processing_service with a synchronous Mock for this test structure.
        
        # Re-patching with a synchronous Mock for file_processing_service instance
      with patch('GUI.flet_gui.file_processing_service') as mock_sync_service:
        mock_sync_service.compare_files_async.return_value = "task_1"
        mock_sync_service.get_task_status.return_value = {
            'status': 'completed',
            'result': {
                'comparison': mock_comparison_list,
                'source_dict': mock_source_dict,
                'target_dict': mock_target_dict,
                'stats': {
                    'total_keys': len(mock_source_dict),
                    'missing_keys': 1,
                    'obsolete_keys': 1
                },
                'source_lines': {}, 
                'target_lines': {}
            }
        }
        mock_sync_service.is_task_complete.return_value = True # Ensure polling loop finishes quickly

        app.source_file_path = "test_source.lang" # Needed for the async task
        app.target_file_path = "test_target.lang" # Needed for the async task

        await app.compare_files_async(None) # Event object is not used

        assert not app.loading_ring.visible
        # Status label will be updated by the results, e.g., "Comparison complete..."
        assert "Comparison complete" in app.status_label.value 
        
        # Verify stats panel
        assert app.stats_panel_component.stats_text_total.value == str(len(mock_source_dict))
        assert app.stats_panel_component.stats_text_missing.value == "1"
        assert app.stats_panel_component.stats_text_obsolete.value == "1"

        # Verify results view
        assert len(app.results_view.results_list_view.controls) == len(mock_comparison_list)


def test_error_handling(app, test_page):
    # Test invalid file selection
    event = Mock()
    event.files = [Mock(path="invalid.txt")]
    app.handle_file_picked(event, app.source_label, app.source_icon, "source")
    assert "No file selected" in app.source_label.value

    # Test unsupported format error
    assert not app.validate_file("test.unsupported")
    assert "Unsupported file type" in app.status_label.value

# Test for ResultsViewComponent search functionality
def test_results_view_search(app, test_page):
    # 1. Setup: Populate results view with mock data (similar to test_comparison_workflow)
    mock_comparison_list = [
        {"key": "common.key.apple", "status": "identical", "source_value": "Apple", "target_value": "Apple", "details": ""},
        {"key": "common.key.banana", "status": "value_changed", "source_value": "Banana", "target_value": "Sweet Banana", "details": ""},
        {"key": "unique.entry.source", "status": "missing_in_target", "source_value": "Only in source", "target_value": None, "details": ""},
    ]
    mock_source_dict = {item["key"]: item["source_value"] for item in mock_comparison_list if item["source_value"] is not None}
    
    # For this test, we directly populate ResultsViewComponent.
    # We don't need to mock the full comparison pipeline if we're unit-testing ResultsView's filter.
    app.results_view.original_result_data = mock_comparison_list
    # Initial build of all items
    for i, item_data in enumerate(mock_comparison_list):
        app.results_view.results_list_view.controls.append(
            app.results_view.create_result_row(item_data, i)
        )
    app.results_view.results_list_view.update()


    # 2. Test Search for "apple" (should find 1 item)
    search_term_apple = "apple"
    app.results_view.search_field.value = search_term_apple
    app.results_view.filter_results(search_term_apple) # Trigger filtering

    assert len(app.results_view.results_list_view.controls) == 1
    # Verify the content of the found row (optional, but good for confidence)
    # Assuming create_result_row structure: Container -> Row -> [StatusContainer, KeyContainer, SourceContainer, TargetContainer]
    # Key is in controls[1].content (which is a Text control)
    first_result_row_key_text = app.results_view.results_list_view.controls[0].content.controls[1].content
    assert search_term_apple in first_result_row_key_text.value.lower()

    # 3. Test Search for "banana" (should find 1 item - in value)
    search_term_banana = "banana"
    app.results_view.search_field.value = search_term_banana
    app.results_view.filter_results(search_term_banana)
    assert len(app.results_view.results_list_view.controls) == 1
    # Check key or value
    banana_row_key_text = app.results_view.results_list_view.controls[0].content.controls[1].content
    banana_row_source_val_text_control = app.results_view.results_list_view.controls[0].content.controls[2].content
    # _create_value_cell returns Text or Row(Text, IconButton)
    banana_row_source_val = banana_row_source_val_text_control.value if isinstance(banana_row_source_val_text_control, ft.Text) else banana_row_source_val_text_control.controls[0].value
    
    assert search_term_banana in banana_row_key_text.value.lower() or search_term_banana in banana_row_source_val.lower()


    # 4. Test Search for "common.key" (should find 2 items)
    search_term_common = "common.key"
    app.results_view.search_field.value = search_term_common
    app.results_view.filter_results(search_term_common)
    assert len(app.results_view.results_list_view.controls) == 2

    # 5. Test Search for "nonexistent" (should find 0 items, show "No results" message)
    search_term_none = "nonexistent"
    app.results_view.search_field.value = search_term_none
    app.results_view.filter_results(search_term_none)
    assert len(app.results_view.results_list_view.controls) == 1 # The "No results found" Text
    assert isinstance(app.results_view.results_list_view.controls[0], ft.Text)
    assert "No results found" in app.results_view.results_list_view.controls[0].value
    
    # 6. Test Empty Search (should show all items)
    app.results_view.search_field.value = ""
    app.results_view.filter_results("")
    assert len(app.results_view.results_list_view.controls) == len(mock_comparison_list)