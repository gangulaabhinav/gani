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
- `gani.xcodeproj/`: Xcode project and shared `gani` scheme.
- `scripts/`: iOS asset-generation tooling.

The app, unit-test, and UI-test targets use file-system-synchronized folders.
Files inside `gani/`, `ganiTests/`, and `ganiUITests/` are discovered automatically
by their respective targets, without individual entries in the project file.
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
