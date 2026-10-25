# gani

An app being developed to connect local buyers and sellers of idols for
festivals such as Ganesh and Durga.

## Current app

The current iOS prototype displays a bundled Ganesh illustration, a listing
price, a city-selection sheet, and a placeholder **Buy** button. It does not
place orders or collect payments. Buyer and seller marketplace features are not
yet implemented.

The illustration is original artwork bundled with the app. No image service,
network connection, or third-party app dependencies are required.

## Repository layout

- [`ios/`](ios/README.md): iOS app, Xcode project, tests, and asset tooling.
- `.github/`: shared contribution instructions and CI workflows.

Additional platforms can have their own top-level directories, setup guides,
and scoped instructions when they are introduced.

See the [iOS guide](ios/README.md) for Xcode setup, running the app, tests, and
asset generation.

## Contributor guidance

Repository-wide learning and permission boundaries are in [AGENTS.md](AGENTS.md)
and [.github/copilot-instructions.md](.github/copilot-instructions.md).
Platform-specific guidance belongs with its implementation; iOS guidance is in
[ios/AGENTS.md](ios/AGENTS.md).
