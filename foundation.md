# Project Foundation: Rent Calculator Pro

This document serves as the **Source of Truth** for all development standards, architectural patterns, and operational protocols for this project. Any agent or developer working on this codebase must adhere to these foundations to ensure consistency, reliability, and speed.

## 🛡️ "Analysis First" Approach
This is the mandatory quality gate for all code changes.
- **Pre-Commit Verification**: Run `flutter analyze` locally before every commit.
- **Zero-Warning Tolerance**: Fix all errors, warnings, and lints (including "Info" and "Deprecated" messages) before pushing to `main`.
- **Strict Typing**: Use explicit type annotations for all public APIs, route parameters, and animation builders.
- **Modern Syntax**: Prefer modern Dart/Flutter patterns (e.g., `withValues` instead of `withOpacity`).

## 🚀 CI/CD & Distribution
The project is automated through GitHub Actions (`.github/workflows/pipeline.yml`).
- **Web**: Automatic deployment to Firebase Hosting on push to `main`.
- **Mobile**: Automatic APK generation and distribution to testers via Firebase App Distribution on push to `main`.
- **Mobile Dependencies**: The `android/app/google-services.json` must be present for successful mobile builds. Do not commit sensitive keys to the repo.

## 📂 Git Protocols & Branching
- **Main Branch**: The primary stable branch is `main`.
- **PowerShell Compatibility**: Use individual commands (no `&&` separators) to ensure compatibility with Windows-based environments.
- **Atomic Commits**: Use descriptive, prefix-based commit messages:
  - `feat:` for new features
  - `fix:` for bug fixes or analysis cleanups
  - `style:` for UI/UX refinements
  - `chore:` for dependency or build updates

## 🎨 Architectural Standards
- **Navigation**: Use the global `AppDrawer` for primary navigation. Maintain a unified profile/badge header in the `AppBar`.
- **Routing**: Utilize `GoRouter` with custom transitions (fade/slide) defined in `lib/utils/app_router.dart` for a native mobile feel.
- **Theming**: Centralize all aesthetics in `lib/utils/app_theme.dart`. Use the predefined `AppTheme.primaryGradient` and `AppTheme.premiumShadow` for consistency.
- **Animations**: Use the `AnimateIn` wrapper for section entrance animations to maintain the "premium feel" across new screens.

## 📱 Mobile-First Design
- **Responsiveness**: Use `LayoutBuilder` or `MediaQuery` to ensure all screens adapt gracefully between mobile (narrow) and web (wide) views.
## 💡 Quick Reminders for the Agent (Foundation 1/2)
If you are an AI assistant starting this task, read these 5 rules to stay "Analysis First" and preserve the premium feel:

1.  **Stop & Check**: Before your first push, run `flutter analyze`. If there are any lints, fix them. **No exceptions.**
2.  **Powershell Safety**: This is a Windows environment. Never use `&&` in your `run_command` calls. Use `;` or separate the calls.
3.  **Mobile DNA**: Every button needs `HapticFeedback.lightImpact()`. It’s the difference between a simple app and a premium experience.
4.  **Entrance Polish**: Wrap new UI sections in the `AnimateIn` widget. We don't do "jumpy" UI here; we do fluid motion.
5.  **Distribution Guardian**: We distribute via Firebase App Distribution. If a push fails, use `gh run view --log-failed` to find the issue immediately.

---
*Last Updated: 2026-02-21*
