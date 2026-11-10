# Google Play release runbook

**Reported inactivity deadline:** 21 December 2026. Verify it in the account's own warning.

## Account and publication gates

1. Check Play Console **Developer account → Account details**: verify both contact email and phone number; save.
2. Confirm immutable Android **applicationId** *before* first upload (current proposal: `com.dbxdrgsl.ml_club_companion`). The repository owner and Play account are independent.
3. Generate and commit Android runner, confirm Android 16 **target API 36** and compatible compile SDK as required for new mobile apps after 31 August 2026.
4. `flutter doctor`, `flutter analyze`, `flutter test`, real Android launch in airplane mode, SDK/permission inspection.
5. Prepare private upload signing keystore and secure backup; release signing credentials **never enter Git**.
6. Build signed `.aab`, verify versionCode/versionName/package and test installation.
7. Prepare accurate store listing: title, short/long descriptions, 512px icon, feature graphic, screenshots depicting real shipped UI, support details, privacy-policy URL, content rating, ads and Data safety.
8. Declare **target age groups honestly**. As this is designed for secondary-school students, applicable child-audience/Families policy obligations must be reviewed instead of simply marking "18+".
9. Upload to internal or closed testing; invite testers, install via Play and verify basic flows.
10. Confirm Play's inactivity checklist has cleared **both** verification and app-upload requirements before the notice's deadline.

## Official references

- Inactive developer accounts: https://support.google.com/googleplay/android-developer/answer/11605267
- Target API policy: https://support.google.com/googleplay/android-developer/answer/11926878
- Target audience & Families rules: https://support.google.com/googleplay/android-developer/answer/9867159
- Flutter Android deployment: https://docs.flutter.dev/deployment/android

## Store copy — initial draft

**Name:** Machine Learning Club Companion

**Short description:** Learn machine learning through interactive lessons, quizzes and visual experiments.

**Description:** Explore a fifteen-week machine learning journey designed for curious students. Understand how AI works, adjust model parameters in live visual experiments, practise with meaningful feedback, and keep your learning progress on your own device. Core lessons and experiments work offline; optional extended course resources open in your browser. No ads or sign-in.

**Privacy:** No app accounts, ads or collected student profiles in initial release. Audit plugins and actual device traffic before completing Play's Data safety questionnaire. Publish a real privacy policy with developer contact; do not assume a draft alone is sufficient.

## Stop-ship conditions

Do not claim compliance or publish if the AAB cannot be installed, the target API is incorrect, Play claims differ from app behavior, requested permissions are unexplained, the screen is unusable with large text, or the release key is insecure.
