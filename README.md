# gani

An iOS app being developed to connect local buyers and sellers of idols for
festivals such as Ganesh and Durga.

## Current app

The app is currently a SwiftUI sample displaying a bundled Ganesh illustration,
a listing price, and a **Buy** button. Tapping Buy shows a demo notice; it does not
place an order or collect payment. Buyer and seller marketplace features are
not yet implemented.

The illustration is original artwork bundled with the app. No image service,
network connection, or third-party app dependencies are required.

## Requirements

- A Mac with Xcode 16 or later and an iOS simulator.
- iOS 17 or later on the simulator or device.

The project uses Swift 6, SwiftUI, strict concurrency checking, and the selected
Xcode's latest SDK.

The app, unit-test, and UI-test targets use file-system-synchronized folders.
Files inside `gani/`, `ganiTests/`, and `ganiUITests/` are discovered automatically
by their respective targets, without individual entries in the project file.

## Run the app

1. Open `gani.xcodeproj` in Xcode.
2. Select the shared **gani** scheme and an iPhone or iPad simulator.
3. Run the app with **Product > Run** (⌘R).

For a physical device, choose your own signing team in **Signing & Capabilities**.

## Tests

With the **gani** scheme and an iOS simulator selected, use **Product > Test**
(⌘U). Unit tests cover the sample listing and rupee formatting. UI tests check
the listing and image, then exercise the Buy button and demo-notice dismissal.
