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

`.github/workflows/ios.yml` builds, installs, launches, and runs both test targets
on an iPhone simulator for pushes, pull requests, and manual dispatches.
It prefers Xcode 27.1 when installed, otherwise logs and uses the `macos-26`
runner's default Xcode. The official runner image currently lists Xcode 26.6 as
its default, not 27.1; Xcode 27.1 execution is therefore not yet verified.
See the [runner's Xcode inventory](https://github.com/actions/runner-images/blob/main/images/macos/macos-26-Readme.md#xcode).

Building and simulator testing require macOS and Xcode; Linux cannot run them.
