/// Settings widgets barrel file
library;

// Hide SettingsDropdown from settings_widgets since settings_shared has a better themed version
export 'settings_widgets.dart' hide SettingsDropdown;
export 'settings_constants.dart';
export 'settings_shared.dart';
export 'add_ignore_pattern_dialog.dart';
export 'general_settings_card.dart';
export 'comparison_settings_card.dart';
export 'appearance_settings_card.dart';
export 'file_handling_settings_card.dart';
export 'ai_services_settings_card.dart';

export 'system_integrations_card.dart';
export 'developer_settings_card.dart';
export 'about_settings_card.dart';
export 'live_logic_preview_card.dart';
