# Public browser preview

The same Flutter/Dart app runs as a web build on GitHub Pages.

**Intended URL:** https://bluebird-studio.github.io/ml-club-companion/

Deployment workflow: `.github/workflows/web-preview.yml`. Every push to `main` builds the web runner, runs the analyzer/tests, compiles Flutter web with a repository subpath base href, and deploys the result to the `github-pages` environment.

The browser preview supports Learn, regression/perceptron playgrounds, Week 1 quiz and local progress. Browser storage is local to each user; no backend or shared school account is involved.

## Local test
```bash
flutter create --platforms=web --org com.dbxdrgsl --project-name ml_club_companion .
flutter pub get
flutter run -d chrome
```

## Limitations
- External course links require internet.
- Local progress is device/browser-specific; private/incognito storage can be cleared.
- Flutter web preview does **not** meet Android Play account upload requirements. A signed Android app bundle and a qualifying Play Console upload are a separate release gate.
- Google Play policies require a distinct Android QA and release process.
