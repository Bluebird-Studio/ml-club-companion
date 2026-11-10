# Product specification — Machine Learning Club Companion

**Product type:** educational Android app for a 15-week, one-hour-per-week secondary-school ML club.
**Principle:** a polished companion to classes, not a duplicate web course and not a university ML textbook.
**Audience:** secondary-school learners with mixed coding experience; teacher demonstration on a projector and students practising on phones.
**First release:** offline-first, single-player, no accounts or backend.

## User outcomes

After a short session, the student should be able to: (1) identify what a model does, (2) manipulate one meaningful variable, (3) interpret the visible result, and (4) answer a retrieval question and receive actionable feedback.

## Four navigation destinations

1. **Learn**: week-by-week journey, objective cards, 3–7 minute concept walkthroughs, real-world application, links to Course / Lab / Homework / Advanced. A week is not marked "complete" merely for tapping it.
2. **Explore**: focused algorithm playgrounds. User can reset to a known example, vary parameters through labelled controls, see the prediction update immediately, and learn *why* it changed.
3. **Practice**: short, clear quizzes; one item per screen; no trick wording; hints and explanations; retry with corrections. Week 1 = identify AI methods across seven real-world scenarios.
4. **Progress**: recently visited material, completed practice, locally persisted best scores, optional reset/export in a later release. No leaderboard or public profile.

## Core journeys

**Student:** Open app → a "Continue learning" card shows Week 1 → read two-minute concept summary → test the AI-method matching activity → inspect mistakes with explanations → optionally open the detailed web lesson.

**Explorer:** Open Explore → Linear regression → adjust slope and intercept → see line and error on the same chart → reset → explain what made the error change.

**Teacher:** Open app → select an experiment → present in landscape with readable labels → demonstrate a parameter change without data connectivity or login.

## Release scope

**Must have (first Play test build):** working Flutter Android project; launch without account; polished home/navigation; correct 15-week metadata; one complete Week 1 activity; regression and perceptron simulations; progress persistence; accessible readable states; offline app core; tests; signed AAB.

**Should have (polished v1):** lesson illustrations, concise animations with reduced-motion alternatives, notebook links opening externally, a content-search affordance, visualised mistake review, quality empty/loading/error states, teacher demo mode.

**Later:** KNN, K-Means, trees, model evaluation, broader quizzes, selected offline coding activities, optional import/export of progress. No backend or school roster without a separately reviewed privacy and child-safety design.

## Quality bar / definition of done

- Pixel-consistent padding, type hierarchy, icons, cards and spacing; no clipped controls on small phones or landscape.
- Every interactive control has labels, expected value range, visible effect, and reset behavior.
- Contrast >= 4.5:1 for normal text; 48dp minimum interactive touch regions; semantic labels for controls and charts; scalable text; respect reduced motion.
- Every learning interaction has a clear objective, correct answer / metric, contextual feedback, and teacher-appropriate wording.
- No fake progress, placeholder scores masquerading as saved work, or fake online capability.
- Works with airplane mode enabled, except deliberate links to the external website/Colab.
- Unit tests for pure math, curriculum structure, scoring and persistence; widget smoke tests for navigation; Android integration smoke test before Play upload.
- Cold launch, animation smoothness, and resource use manually checked on one low/midrange Android device and emulator.
- No ads, unnecessary permissions, personal data collection, or secrets.
- Release signed AAB, privacy policy, accurate Data safety and Target audience declarations, functioning Play testing install.

## Risks to address early

**Scope creep:** limit pre-deadline release to Week 1 and two excellent demos, not fifteen incomplete interactive lessons.

**Content mismatch:** website is canonical, but bundled app data is versioned. Date/title changes require content review and update.

**Device readiness:** no successful Flutter build has yet been verified. Set up Android SDK and CI before design polish.

**Minor audience:** content is intended for school pupils; store age declarations must match actual audience. Avoid tracking and networked community features.
