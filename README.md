# Machine Learning Club Companion

An offline-first Android learning companion for the [Machine Learning Club](https://machinelearning-club.github.io/) at Seven Hills International School.

**Status:** project setup / pre-release. The repository is being prepared for an Android internal-testing build; it is not yet a published app.

## Product

A carefully designed, classroom-friendly app for secondary-school students (roughly ages 14–18):

- **Learn** — a 15-week learning path, with learning goals and contextual links to the club's Course, Laboratory, Homework, and Advanced pages.
- **Explore** — interactive visual simulations of machine-learning algorithms (regression, perceptron, then decision trees, KNN and K-Means).
- **Practice** — short formative quizzes with immediate reasoning-based feedback, starting Week 1 and expanding to Weeks 2–15.
- **Progress** — a private, on-device record of lessons, practice, and experiments.

Design principle: *show first, explain clearly, let the student try, then consolidate*. No intrusive gamification, login requirement, backend, advertisement or student analytics in v1.

## Release priorities

| Stage | Deliverable | Target |
|---|---|---|
| M0 — Foundation | Flutter project, tests, content model, CI, app shell | 10–13 Nov 2026 |
| M1 — Visual polish | Material 3 visual system, responsive navigation, onboarding, refined states | 14–20 Nov |
| M2 — Learning MVP | Week 1 lesson, AI-method quiz, two working playgrounds, progress | 21–29 Nov |
| M3 — Quality | Accessibility, offline verification, instrumentation, Android 16 compatibility, QA | 30 Nov–6 Dec |
| M4 — Play readiness | Signed AAB, listing, privacy notice, data safety, internal test | 7–13 Dec |
| M5 — Buffer | Fix review/device issues, verify Play account status | 14–20 Dec |

**Critical:** The Play Developer account inactivity warning reportedly has a **21 December 2026** deadline. Google requires both account-contact verification and a qualifying app upload, and may accept internal/closed testing uploads. Follow the exact notice in the user's Play Console. See [PLAY_RELEASE.md](docs/PLAY_RELEASE.md).

## Documentation

- [Product specification and acceptance criteria](docs/PRODUCT_SPEC.md)
- [Design system and interaction patterns](docs/DESIGN_SYSTEM.md)
- [Technical architecture](docs/ARCHITECTURE.md)
- [Content and curriculum policy](docs/CONTENT.md)
- [Google Play delivery checklist](docs/PLAY_RELEASE.md)

## Technology

Flutter / Dart · Material 3 · Android first · offline bundled exercises · local-only progress. Optional external course links open the browser.

The primary course reference is maintained separately at https://machinelearning-club.github.io/. [spantiru/companion-lab](https://github.com/spantiru/companion-lab) is an academic learning reference **not** an app source repository, and is **not** copied into this project.

## Development status

The previous 0.1.0 source prototype is available as a separate project artifact from the planning discussion. Do not treat the Play release, signed AAB, tests, or a complete app as finished until tracked and verified in this repository.

## Contributing

Please open an issue for bugs, UI improvements, learning activities, or inaccessible interactions. Keep educational content pedagogically correct, original or appropriately licensed, and suitable for minors. Never commit release keys, student data, or credentials.
