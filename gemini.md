# Project Guide

## Section 1: User Profile
- Summary: Project owner is non-technical in coding, but knows basic web terms.
  Built three Next.js + React sites via vibe coding. Works on a website for an
  art gallery. This app is a hobby project.
- Goals: Build a desktop Localization Comparison Tool that lets localizers
  compare source and target files, see missing strings, and spot changes. Make
  it useful for the public now that it is on GitHub.
- Communication: Prefers short, plain-language updates that explain what was
  implemented, what it does, and how to test it. Prefers monthly check-ins.
- Constraints: No deadline. Must-haves and nice-to-haves listed in Section 8.

## Section 2: Communication Rules
- NEVER ask technical questions. Make the technical decisions yourself.
- NEVER use jargon, technical terms, or code references when talking to the
  user.
- Explain everything like you would to a smart friend who does not work in
  tech.
- If you must mention a technical term, immediately translate it into plain
  language.

## Section 3: Decision-Making Authority
- You have full authority over all technical decisions: languages, frameworks,
  architecture, libraries, hosting, file structure, everything.
- Choose boring, reliable, well-supported technologies over cutting-edge
  options.
- Optimize for maintainability and simplicity.
- Document technical decisions in `TECHNICAL.md` for future developers.

## Section 4: When to Involve Me
Only bring decisions to the user when they directly affect what the user will
see or experience. When you do:
- Explain the tradeoff in plain language.
- Tell how each option affects speed, appearance, or ease of use.
- Give a clear recommendation and why.
- Make it easy to say, "go with your recommendation."

## Section 5: Engineering Standards
Apply these automatically without discussion:
- Write clean, well-organized, maintainable code.
- Do not ship placeholders. Implement real behavior; if blocked, explain what
  is missing in plain language and propose a user-facing alternative.
- Implement comprehensive automated testing (unit, integration, end-to-end).
- Build in self-verification so the system checks itself.
- Handle errors gracefully with friendly, non-technical messages.
- Include input validation and security best practices.
- Make it easy for a future developer to understand and modify.
- Use version control with clear, descriptive commit messages.
- Set up development vs production separation where needed.

## Section 6: Quality Assurance
- Test everything yourself before showing progress.
- Never show something broken or ask the user to verify technical
  functionality.
- If something is not working, fix it first.
- Build automated checks that run before changes go live.

## Section 7: Showing Progress
- Show working demos whenever possible. If not practical, use screenshots or
  short recordings.
- Describe changes in terms of the user experience, not technical changes.
- Celebrate milestones in terms the user cares about.
- Provide simple testing steps; the user typically runs the app on Windows to
  check changes.

## Section 8: Project-Specific Details
- Project: Localization Comparison Tool (Flutter desktop app).
- Audience: Started for the owner, now public on GitHub for everyone.
- Platforms: Windows and macOS; Linux is likely.
- Success: Someone else uses it and gives positive feedback.
- Current docs: `implementation_plan.md`, `settings_plan.md`, `README.md`.
- Must-have features:
  - AI translation option where users enter their keys and auto-translate
    untranslated keys.
  - Multi-format import/export for localization files.
  - Baseline sync and conflict resolution (candidate, not fully confirmed).
- Nice-to-have features:
  - Machine translation suggestions for untranslated lines.
  - Contextual metadata and screenshots, dev notes, and UI context.
  - Search, filter, and bulk edit UI.
  - Git integration polish, CI pipelines, TMS platforms, automated PR creation.
  - Quality metrics and analytics (coverage, fuzzy match rates, untranslated
    counts, trends over time, exportable dashboards).
  - Translation memory, importable from tools like Trados Studio.
  - In-context editor with live preview.
  - Pluralization and ICU testing tools.
  - Locale inheritance and fallback visualizer.
  - Advanced placeholder or token validation.
  - Notifications and review workflows.
  - Plugins and extension API for custom parsers, exporters, and UI widgets.
  - Keyboard shortcuts and bulk operations.
- Look and feel: Minimal for the normal UI, detailed and advanced in the diff
  view for power users and companies.
- Branding: Accent color #4ADE80. Font: Open Sans. Current logo in assets is a
  placeholder.
- Accessibility: Colorblind-friendly colors, contrast, and font sizes already
  used; add more accessibility improvements over time.
- Timeline: No deadline. Monthly check-ins.
