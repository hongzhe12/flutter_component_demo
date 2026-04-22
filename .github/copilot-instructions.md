# Copilot Instructions for flutter_component_demo

## Teaching-first goal
- This repo is for **Flutter component learning**, not production architecture drills.
- Prefer “teach while coding”: explain what changed, why it changed, and what concept it demonstrates.
- Keep changes small so learners can map cause → effect quickly.

## Big picture (what to understand first)
- Core UI path is in [lib/main.dart](../lib/main.dart): `main()` → `MyApp` → `HomePage` → `MyCustomCard`.
- No service layer, no routing table, no state-management package yet.
- Most tasks should stay in one file unless a widget is reused.

## How agents should implement changes
- Use step-by-step progression: layout first, then style, then interaction.
- Prefer stateless examples before introducing stateful patterns.
- When introducing a new widget, keep it near usage first, then extract only if reuse is clear.
- Keep naming explicit and beginner-friendly (for example, `HomePage`, `MyCustomCard`).

## Repo-specific coding conventions
- Use `const` wherever possible (already common in [lib/main.dart](../lib/main.dart)).
- Keep comments and UI text Chinese-friendly; this project already uses Chinese instructional comments.
- Prefer plain Material widgets over adding packages for simple UI goals.
- Keep diffs focused on learning intent; avoid unrelated refactors.

## Dependencies and boundaries
- Runtime deps are minimal in [pubspec.yaml](../pubspec.yaml): Flutter SDK + `cupertino_icons`.
- Lints come from [analysis_options.yaml](../analysis_options.yaml) (`flutter_lints`).
- Platform folders exist, but app logic is currently platform-agnostic Dart UI.

## Required workflow for each task
- 1) `flutter pub get` (if dependencies changed)
- 2) `flutter analyze`
- 3) `flutter test`
- 4) `flutter run -d windows` for manual visual check

## Testing reality (important for learners)
- [test/widget_test.dart](../test/widget_test.dart) is still default counter test and currently mismatched with [lib/main.dart](../lib/main.dart).
- For UI updates, rewrite test assertions to current texts/widgets (e.g. `'自定义组件演示'`, `'我是自定义组件！'`).
- Favor simple widget-find assertions over complex test scaffolding in this learning repo.

## When to add files
- Add files under `lib/` only when a widget is reused or `main.dart` becomes hard to read.
- Preserve entry contract (`main()` + `MyApp`) so examples and imports stay stable.
