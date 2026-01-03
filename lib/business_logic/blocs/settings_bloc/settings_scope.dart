/// Represents the scope of settings being edited.
///
/// When editing settings, users can choose to modify:
/// - Global defaults (affect all projects)
/// - Current project overrides (affect only the active project)
enum SettingsScope {
  /// Editing global defaults that apply to all projects.
  global,

  /// Editing settings for the current project only.
  /// Project settings override global defaults.
  project,
}
