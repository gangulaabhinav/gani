# App logo and icon generation

## Single-source app icon

The editable artwork is the single-path trunk in
`gani/Assets.xcassets/GaniLogo.imageset/gani-logo.svg`. The exported app icon
is `gani/Assets.xcassets/AppIcon.appiconset/AppIcon-1024.png`: one opaque
1024 x 1024 sRGB PNG with a black mark on white, without baked-in rounded
corners.

`AppIcon` uses the asset catalog's iOS **Single Size** configuration.
Xcode generates the required iPhone, iPad, and App Store sizes from that one
PNG. Both Debug and Release select `AppIcon`. There are no custom dark or
tinted images; iOS supplies its automatically generated appearance treatments.
This does not provide an authored, layered Liquid Glass icon.

The SVG remains available to SwiftUI as `Image("GaniLogo")`. The sample
listing illustration is unchanged.

## Regenerate

Run from the repository root on a Mac with Xcode:

```sh
swift scripts/generate-app-icons.swift
```

The script uses macOS frameworks with no third-party dependencies. It renders
only the 1024px PNG from the SVG, checks its dimensions and absence of an alpha
channel, and writes the single-source asset-catalog entry. It does not generate
the smaller sizes; Xcode does that during the build.

## Previous alternatives

The earlier multi-size PNGs, generator, and Icon Composer sample were saved
in the local Git stash named `logo-backup-before-single-size-icon` before
being removed from the working tree. They are not part of the current app.
Stashes are local and are not included when pushing the branch.

To inspect that backup:

```sh
git stash list
git stash show --include-untracked --stat b2ede6f801038d5ec2a94f76d7c44f13208847e5
```

The untracked files are in that stash's third parent. For example, to recover
only the Icon Composer sample without replacing the active app icon:

```sh
git restore --source=b2ede6f801038d5ec2a94f76d7c44f13208847e5^3 --worktree -- scripts/samples/Gani.icon
```

Reference: [Configuring your app icon using an asset catalog](https://developer.apple.com/documentation/xcode/configuring-your-app-icon).
