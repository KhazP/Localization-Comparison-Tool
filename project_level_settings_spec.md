# Project-Level Settings Specification

> Feature specification based on user interview conducted 2026-01-01.

---

## Executive Summary

Allow users to create **Projects** that override global settings on a per-project basis. A project stores its identity and custom settings in a `.localizer/` folder within the project directory (similar to how Git uses `.git/`). Users can customize AI prompts, translation memory selection, and other settings for different contexts (e.g., "Cyberpunk Game" vs "Medical App").

---

## Core Concepts

### What is a Project?

| Aspect | Decision |
|--------|----------|
| **Creation** | Explicit — user clicks "Create Project" button (not automatic) |
| **Identity** | Stored in `.localizer/project.json` marker file |
| **Scope** | User chooses the project root folder (to accommodate different folder structures) |
| **Reconnection** | If folder is moved, app reconnects based on `.localizer/` folder presence |
| **Concurrency** | One project open at a time (no multi-project tabs) |

### Project Marker File

Location: `<project_root>/.localizer/project.json`

**Stored Data:**
- Project ID (UUID)
- Project name (user-defined, shown everywhere in UI)
- Creation date
- Last opened date
- Selected Translation Memory reference(s)
- Project-specific settings overrides

---

## Settings Inheritance Model

### Override Behavior

- **Explicit overrides stay locked** — if you set AI temperature to 0.8 in a project, it stays at 0.8 even if the global default changes from 0.5 to 0.7
- This matches standard behavior in most applications (IDE settings, browser profiles, etc.)

### Which Settings Are Project-Overridable?

| Setting | Overridable? | Rationale |
|---------|--------------|-----------|
| System Context / Instructions | ✅ Yes | Different tone/style per project |
| AI Service Provider | ✅ Yes | May use different API for different clients |
| AI Model | ✅ Yes | GPT-4 for complex content, lighter model for simple |
| Translation Strategy | ❌ Global only | Rarely changes per project |
| Temperature | ❌ Global only | Technical parameter |
| Max Tokens | ❌ Global only | Technical parameter |
| API Keys | ❌ Global only | Security — never stored in project files |

### Visual Indicators

**Every setting shows its state:**
- "Inherited" label (using global default)
- "Custom" label (project override active)

### Reset Options

Standard three-level reset:
1. **Per-setting** — reset individual setting to global
2. **Per-section** — reset all AI settings to global
3. **Whole project** — clear all overrides, use 100% global

---

## Translation Memory (Trados-Style)

- Translation Memory remains **global** (not duplicated per project)
- When opening a project, user **selects which TM(s)** to use for that project
- Selected TM references stored in project file
- Multiple TMs can be selected (checked in order: project-selected TMs first)

---

## Project-Specific Features

### Glossary / Terminology

Each project can have its own glossary:
- Terms that should never be translated (e.g., "NetRunner")
- Preferred translations for specific terms
- Affects AI translation suggestions

### History & Dashboard

- History view gets a **toggle**: "This Project" vs "All Projects"
- Dashboard/Quality metrics support the same toggle
- "All Projects" view shows:
  - Combined totals
  - Breakdown by project (expandable)

---

## Project Sharing

### Export Project (Zip)

"Export Project" button creates a shareable archive containing:

| Included | Item |
|----------|------|
| ✅ | Translation files |
| ✅ | Project settings (`.localizer/` folder) |
| ✅ | Project-specific translation memory |
| ✅ | History/session data |
| ❌ | API keys (security — never included) |

### Import Project

When opening a shared project:
1. App shows **review prompt**: "This project has custom settings"
2. User can review settings before applying
3. Settings remain quarantined (using global defaults) until approved
4. Sensitive settings (if accidentally included) are flagged and ignored

---

## UI Design

### Navigation

**New sidebar item: "Projects"** (positioned above "Compare")
- Dedicated Projects view/page
- Recent projects list with quick access
- Project creation and management

### Recent Projects List

Shown on Home and Projects page:
- Project name
- Last opened date
- Preview stats: "12 translation files, 3 languages"

### Settings Page

**Scope Selector** at the top of Settings:
```
[ Global Defaults ] [ Current Project: "Cyberpunk 2077" ]
```

- When "Global Defaults" selected: editing affects all projects
- When project selected: editing creates overrides for that project only
- Each setting shows "Inherited" or "Custom" indicator

### Conflict Warnings

If a project setting becomes invalid (e.g., project uses GPT-4 but OpenAI key removed):
- **Dismissable warning banner** appears
- Explains the issue in plain language
- Suggests: enter API key or switch to different service
- Project continues to work (falls back gracefully)

### Files Without a Project

When opening files without creating a project:
- Project settings UI is visible but **greyed out/disabled**
- Clear prompt: "Create a project to customize settings for this folder"

---

## Implementation Phases

### Phase 1: Foundation
- [x] Define Project data model
- [x] Create `.localizer/project.json` schema
- [x] Implement project creation flow ("Create Project" button)
- [x] User selects project root folder
- [x] Basic project identity (name, dates)
- [x] Project reconnection when folder moved

### Phase 2: Settings Override System
- [x] Add scope selector to Settings UI
- [x] Implement inheritance logic in SettingsBloc
- [x] Visual indicators (Inherited/Custom labels)
- [x] Per-setting, per-section, whole-project reset buttons
- [x] Override storage in project file

### Phase 3: History & Dashboard Integration
- [x] Add project filter toggle to History view
- [x] Add project filter toggle to Dashboard
- [x] "All Projects" breakdown view
- [x] Project-specific statistics tracking

### Phase 4: Export/Import & Sharing
- [x] Export project as zip
- [x] Include TM and history in export
- [x] Import project with review prompt
- [x] Quarantine untrusted settings

### Phase 5: Advanced Features
- [x] Projects sidebar navigation item
- [x] Recent projects list on Home
- [x] Project-specific glossary/terminology
- [x] TM selection per project (Trados-style)

---

## Edge Cases

| Scenario | Behavior |
|----------|----------|
| User deletes `.localizer/` folder | Treated as new project (loses overrides) |
| Same files opened from different folder | Different project (tracked by folder, not files) |
| Project folder renamed | Project persists (tracked by internal ID in `.localizer/`) |
| Invalid project settings | Warning shown, falls back to global |
| Opening files without project | Settings UI greyed out, prompt to create project |

---

## Non-Goals (Out of Scope)

- Multiple projects open simultaneously
- Nested projects (project within project)
- Automatic project creation
- Storing API keys in project files
- Real-time collaboration between users

---

## Success Criteria

1. User can create a project and see it persist across app restarts
2. Project-specific AI system context produces different translation suggestions
3. Settings changes in one project don't affect other projects
4. Exported project can be imported by another user successfully
5. History/Dashboard filtering works correctly per-project

---

## Open Questions

None remaining — all decisions captured above.
