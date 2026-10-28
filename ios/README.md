# gani for iOS

The iOS prototype uses Swift 6, SwiftUI, strict concurrency checking, and the
selected Xcode's latest SDK. It displays a sample listing and a fixed-city
picker. The Buy button is a no-op placeholder; no orders or payments are made.

## Requirements

- A Mac with Xcode 16 or later and an iOS simulator.
- iOS 17 or later on the simulator or device.

## Layout and Xcode folder references

- `gani/`: application source and bundled asset catalog.
- `ganiTests/`: XCTest unit tests.
- `ganiUITests/`: XCTest UI tests.
- `Shared/`: accessibility identifiers compiled into both the app and UI tests.
- `gani.xcodeproj/`: Xcode project and shared `gani` scheme.
- `scripts/`: iOS asset-generation tooling.

The app, unit-test, and UI-test targets use file-system-synchronized folders.
Files inside `gani/`, `ganiTests/`, and `ganiUITests/` are discovered automatically
by their respective targets, without individual entries in the project file.
`Shared/` is also file-system-synchronized and belongs to both the app and
UI-test targets. Its enum can remain internal because each target compiles the
same source; UI tests do not import the app executable.
These paths are relative to this `ios/` directory. Moving the project and its
three sibling folders together preserves their relative references.

Keep platform documentation, scripts, and agent instructions outside those
three target folders so Xcode does not discover them as target content.

## Run the app

1. From the repository root, open `ios/gani.xcodeproj` in Xcode.
2. Select the shared **gani** scheme and an iPhone or iPad simulator.
3. Run the app with **Product > Run**.

For a physical device, choose your own signing team in **Signing & Capabilities**.

## Tests

With the **gani** scheme and an iOS simulator selected, use **Product > Test**.
Unit tests cover item details and Indian rupee formatting. UI tests check the
listing and image, then verify that the placeholder Buy button leaves the
listing visible. They also check the initial None selection, selecting Hyderabad
and restoring it after an app relaunch, and clearing the selection across
another relaunch.

The fresh-install test requires an empty app sandbox: use a new simulator or
uninstall the app before running the suite. Relaunching or rebuilding an
already-installed app does not clear UserDefaults. The persistence test sets its
own starting selection through the UI and clears it before finishing; it does
not reinstall the app between launches. No app-side reset hooks are used.

For command-line tests, start at the repository root and select an available
simulator name shown by `xcrun simctl list devices available`:

```sh
cd ios
xcodebuild test \
  -project gani.xcodeproj -scheme gani \
  -destination 'platform=iOS Simulator,name=<available simulator name>' \
  -derivedDataPath build \
  CODE_SIGNING_ALLOWED=NO
```

The placeholder simulator name must be replaced before running the command.

The repository's [iOS workflow](../.github/workflows/ios.yml) runs commands
from `ios/`, builds for testing, and runs both test targets against the same
derived-data directory. Results are uploaded from `ios/TestResults/`.

### Launch performance in CI

`LaunchPerformanceTests.testLaunchPerformance()` uses XCTest's app-launch metric.
CI selects the `macos-26` arm64 runner, requires
Xcode 26.6 build 17F113 on macOS 26, and creates a fresh iPhone 17 Pro simulator
with iOS 26.5. Missing versions fail explicitly rather than selecting a different
toolchain or device. Test execution is serial and uses the scheme's existing
Debug configuration; these measurements are not a Release-device benchmark.

The runner label does not freeze the image version or reserve identical physical
hardware. The workflow logs the actual host, OS, and Xcode, and uploads
`LaunchMetrics.json` and `TestRun.json` alongside the result bundles so that
measurements and baseline selection can be checked.
The workflow fails if the launch test does not produce repeated measurements or
if XCTest does not apply the committed CI baseline and its configured tolerances.
Two collection attempts on the macOS 27 / Xcode 27.1 preview environment produced
no app-launch samples despite reporting passing tests, so that environment is
not used for this baseline.

XCTest's shared baseline files are stored under
`gani.xcodeproj/xcshareddata/xcbaselines/`. Baselines compare repeated launch
measurements with an expected average and regression/variability tolerances;
they are not an absolute ten-second launch limit. Recollect and verify the CI
baseline whenever the selected toolchain, simulator, or runner hardware changes.

The CI baseline was collected in
[run 40644095505](https://github.com/gangulaabhinav/gani/actions/runs/40644095505):
five samples averaged 3.062435 seconds with 8.72% relative standard deviation.
The configured variability allowance is 15%, slightly above that observed spread;
the permitted average regression remains 10%. The separate local baseline is
preserved. These are initial hosted-runner observations, not a guarantee of
identical timing between jobs. Each workflow summary reports the measurements
and confirms which baseline was actually applied.

## Assets and app icon

Bundled images live in `gani/Assets.xcassets/`. The editable logo is
`GaniLogo.imageset/gani-logo.svg`; the app icon is a single opaque 1024px PNG
in `AppIcon.appiconset/`. Xcode generates the required platform sizes.

From the repository root, regenerate the icon with:

```sh
swift ios/scripts/generate-app-icons.swift
```

The script resolves assets relative to its own location, not the shell's
working directory. It uses macOS frameworks and needs no third-party packages.
See the [asset tooling guide](scripts/README.md) for artwork details and
historical alternatives.

## Contributor guidance

Read [AGENTS.md](AGENTS.md) for iOS-specific guidance in addition to the
repository-wide instructions.
