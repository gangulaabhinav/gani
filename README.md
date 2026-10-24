# gani
Application that primary revolves around idols during festivals like Ganesh and Durga locally to connect buyers and sellers and they also to work on during the later phases of the festivals

## Sample iOS app

Open `gani.xcodeproj` in Xcode, select the shared **gani** scheme and an iPhone
or iPad simulator, then Run (⌘R). The SwiftUI sample displays a bundled Ganesh
illustration, a price, and a **Buy** button below the image. Buy shows a demo
notice; it does not place an order or collect payment. The illustration is
original artwork included with the app, so no image service or download is needed.

The project uses Swift 6, strict concurrency checking, the selected Xcode's latest
SDK, and an iOS 17 minimum deployment target. No third-party app dependencies are
required. For a physical device, choose your own signing team in Signing & Capabilities.

### Build, launch, and test

On a Mac with Xcode selected (`sudo xcode-select -s /Applications/Xcode.app`):

```sh
xcodebuild -list -project gani.xcodeproj
xcrun simctl list devices available
# Replace SIMULATOR_UDID below with an available iPhone simulator's identifier.
xcrun simctl boot SIMULATOR_UDID # Skip if already booted.
xcrun simctl bootstatus SIMULATOR_UDID -b
xcodebuild build-for-testing -project gani.xcodeproj -scheme gani \
  -destination 'platform=iOS Simulator,id=SIMULATOR_UDID' \
  -derivedDataPath build CODE_SIGNING_ALLOWED=NO
xcrun simctl install SIMULATOR_UDID build/Build/Products/Debug-iphonesimulator/gani.app
xcrun simctl launch SIMULATOR_UDID com.gangulaabhinav.gani
xcodebuild test-without-building -project gani.xcodeproj -scheme gani \
  -destination 'platform=iOS Simulator,id=SIMULATOR_UDID' \
  -derivedDataPath build CODE_SIGNING_ALLOWED=NO
```

You can also run tests in Xcode with ⌘U. Unit tests cover the sample listing and
rupee formatting; UI tests launch the app, check the image/listing, and exercise
Buy and dismissal of the demo notice.

### Automation and Xcode 27.1

`.github/workflows/ios.yml` runs for pull requests targeting `main`, pushes to
`main`, and manual dispatches. Feature-branch pushes do not trigger duplicate
runs, and newer commits cancel superseded runs on the same PR or branch.

One job exposes the **Build, unit tests, UI tests** PR check with three steps:
build the app and both test targets once using `build-for-testing`, run
`ganiTests`, then run `ganiUITests` using `test-without-building`. Both test
steps reuse the same derived data and selected simulator, avoiding duplicate
compilation, artifact transfers between runners, and multiple runner setups.
UI tests launch the app themselves, so no separate install/launch step is needed.
UI tests still run if unit tests fail; either test failure fails the overall check.
If the build fails, both test steps are skipped. The `ios-test-results` artifact
contains separate `.xcresult` bundles for the two suites, retained for seven days.
This gives one combined PR check, not three independently required checks.
The repository's active `main` ruleset requires this GitHub Actions check to
pass and the PR branch to be up to date before merging, with no bypass exceptions.
Pull requests are required, but reviewer approvals are not. Auto-merge is enabled
for eligible PRs when requested, and source branches are automatically deleted
after merging.

It prefers Xcode 27.1 when installed, otherwise logs and uses the `macos-26`
runner's default Xcode. The official runner image currently lists Xcode 26.6 as
its default, not 27.1; Xcode 27.1 execution is therefore not yet verified.
See the [runner's Xcode inventory](https://github.com/actions/runner-images/blob/main/images/macos/macos-26-Readme.md#xcode).

Building and simulator testing require macOS and Xcode; Linux cannot run them.
