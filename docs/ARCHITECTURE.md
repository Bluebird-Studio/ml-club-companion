# Technical architecture

## Baseline

- Flutter stable / Dart with Material 3, Android-first and a minimum supported Android SDK determined after device testing.
- Android compile and target SDK **36** or later for new submissions in November 2026.
- No authentication, backend, advertisement, push notifications, student IDs or telemetry.
- Data bundled locally: versioned curriculum metadata, lesson content, quiz items and playground parameters.
- Local progress: on-device storage only. Prefer typed repository interface and migration/version policy over raw reads from widgets.
- External links to machinelearning-club.github.io and Colab deliberately open in the browser and require connectivity. App core remains offline.

## Proposed source layout

```text
lib/
  app/               # app root, theme, navigation and lifecycle
  core/              # design tokens, persistence abstractions and utilities
  features/
    learn/            # lesson catalogue and reading UI
    explore/          # regression, perceptron, future algorithms
    practice/         # quiz model, scoring, feedback
    progress/         # local progress, recently viewed
  content/            # 15-week curriculum manifest, quiz bank
test/                 # math, data, scoring, widget smoke tests
integration_test/     # Android navigation / offline smoke tests
.github/workflows/    # static analysis + tests; release signing only via secrets
docs/                 # spec, design system, Play release, content policy
```

## Domain model

`Week { id, title, sessionDate?, objectives[], summary, availability, links }`
`LearningUnit { id, weekId, kind, title, blocks[], version }`
`Quiz { id, weekId, questions[] }`
`Attempt { quizId, timestamp?, correctCount, totalCount, reviewed }`
`Progress { schemaVersion, visitedUnits[], completedUnitIds[], bestQuizScores{} }`

Never treat an unopened external resource as "completed" or rely on brittle website scraping.

## Simulation boundaries

Pure, deterministic Dart functions for algorithms, with widget controls as views. Cover edge cases in unit tests:
- Regression: sample prediction and MSE; empty samples; exact reset defaults.
- Perceptron: weighted sum, threshold and all four AND truth-table cases.
- Later: KNN tie behavior, K-Means empty cluster behavior and deterministic initialisation.

No hidden remote model serving. Keep in-class demos small and reproducible.

## Quality / deployment

CI on pushes and PRs: `flutter pub get`, `dart format --output=none --set-exit-if-changed .`, `flutter analyze`, `flutter test`, Android debug build when runner exists. A signed Play AAB is generated in a protected release workflow or locally; do **not** commit keystore, passwords or uploaded artifacts.

Before configuring CI: run the starter project through `flutter create` once using the agreed application ID, commit the Android runner and Gradle wrapper, lock and test dependency compatibility, and validate Flutter/Android SDK versions.

## Non-functional priorities

No permissions unless required by deliberate links; quick launch, responsive charts, layout on compact Android and tablets, screen-reader semantics, robust offline experience, dark mode, safe area handling, data retention under app updates, privacy-preserving defaults.
