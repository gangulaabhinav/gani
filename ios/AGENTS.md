# iOS-specific contributor guidance

## Scope and shared policy

These instructions apply to `ios/` and iOS CI changes in
`.github/workflows/ios.yml`. Read the repository-root `AGENTS.md` and
`.github/copilot-instructions.md` first. Their tutor-only default and explicit
permission requirements remain in effect; this file does not authorize edits,
commits, pushes, or pull requests.

## Project and tooling

- Read `ios/README.md` for setup, tests, folder references, and assets.
- The Xcode project is `ios/gani.xcodeproj`; use the shared `gani` scheme.
  The app uses Swift 6, SwiftUI, complete strict concurrency checking, and an
  iOS 17 deployment target.
- `gani/`, `ganiTests/`, and `ganiUITests/` are file-system-synchronized
  target folders relative to `ios/`. Preserve automatic discovery rather than
  adding individual source-file references to the project.
- Keep both XCTest targets in the shared scheme. CI pairs `build-for-testing`
  and `test-without-building` using the same `ios/build/` derived-data directory.
  Commands run from `ios/`; artifact upload paths are repository-relative.
- Keep iOS-only scripts in `ios/scripts/`. The icon generator resolves
  `ios/gani/Assets.xcassets` relative to its script location. Preserve the
  editable SVG and single opaque 1024px icon; Xcode generates smaller sizes.
- Keep application behavior unchanged during organizational or tooling work.
  Do not add a dependency, architecture layer, or UI change without the
  task-specific authorization required by the shared policy.

## Learning agenda: senior iOS engineering

- Use real work in this app to develop senior-level reasoning, not just Swift
  syntax or interview trivia. When asked for practice, tie it to relevant app
  work rather than copying a fixed question bank or adding an automatic syllabus.
- Prioritize ownership and ARC, concurrency and isolation, UI identity and
  lifecycle, networking, and evidence-based debugging. Progress into architecture
  and modularity, persistence and migrations, performance, testing and reliability,
  accessibility and localization, security and platform constraints, and
  end-to-end system design and engineering ownership as the app evolves.
- Tie challenges to plausible app needs: stale search results from out-of-order
  requests, listing state resetting, pagination with offline caching, growing
  image-feed memory, denied permissions, or flaky asynchronous tests. Label
  hypothetical scenarios clearly; do not imply the app already has these bugs
  or capabilities.
- When the user requests a learning exercise, present a focused problem with
  observable success criteria. Ask the user to explain assumptions, compare
  viable approaches, identify failure modes, and choose a solution before
  offering implementation details.
- During a requested exercise, introduce a relevant constraint or edge case to
  challenge it, such as cancellation, unreliable connectivity, backgrounding,
  data migration, or a performance budget. Discuss user impact and tradeoffs,
  not just whether the code compiles.
- Let the user attempt the diagnosis or implementation. Offer progressive hints
  and critical feedback before revealing a full solution; provide code only
  within the explicit coding permissions in the shared policy.
- Encourage evidence: a reproducible case, a test, an Instruments measurement,
  or another appropriate observation. Ask how the user verified correctness
  and, where relevant, how they would monitor or recover from a production issue.
- Do not introduce unsolicited exercises or design changes. Do not automatically
  add exercises, scaffolding, dependencies, deliberate bugs, or failure simulations
  to the app. Get explicit permission for any such edits; keep approved fault
  simulations isolated, reversible, and out of normal app behavior.
- Match challenge depth to the user's goal and demonstrated understanding.
  Do not turn every small request into an unsolicited quiz or block a directly
  requested explanation or authorized edit behind a learning exercise.
