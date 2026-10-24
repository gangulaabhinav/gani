import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

func require(_ condition: Bool, _ message: String) throws {
    if !condition {
        throw NSError(
            domain: "GaniIconGeneration",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: message]
        )
    }
}

let root = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent().deletingLastPathComponent()
let assets = root.appendingPathComponent("gani/Assets.xcassets")
let source = assets.appendingPathComponent("GaniLogo.imageset/gani-logo.svg")
let output = assets.appendingPathComponent("AppIcon.appiconset")
let document = try XMLDocument(contentsOf: source)
let elements = try document.nodes(forXPath: "/*[local-name()='svg']/*[local-name()='path']")
try require(elements.count == 1, "The logo master must contain exactly one path.")
guard let element = elements.first as? XMLElement,
      let pathData = element.attribute(forName: "d")?.stringValue,
      let fill = element.attribute(forName: "fill")?.stringValue,
      fill.hasPrefix("#"), fill.count == 7,
      let rgb = UInt32(fill.dropFirst(), radix: 16) else {
    throw NSError(
        domain: "GaniIconGeneration",
        code: 1,
        userInfo: [NSLocalizedDescriptionKey: "Expected a path with a six-digit hex fill."]
    )
}

let scanner = Scanner(string: pathData)
let path = CGMutablePath()
func point() throws -> CGPoint {
    guard let x = scanner.scanDouble(), let y = scanner.scanDouble() else {
        throw NSError(
            domain: "GaniIconGeneration",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Invalid coordinate in the SVG path."]
        )
    }
    return CGPoint(x: x, y: y)
}

// The master deliberately uses only absolute moves, cubic curves, and a close.
while !scanner.isAtEnd {
    switch scanner.scanCharacters(from: .letters) {
    case "M":
        path.move(to: try point())
    case "C":
        let first = try point()
        let second = try point()
        path.addCurve(to: try point(), control1: first, control2: second)
    case "Z":
        path.closeSubpath()
    default:
        try require(false, "Unsupported SVG command; use absolute M, C, and Z commands.")
    }
}
let bounds = path.boundingBoxOfPath
try require(bounds.width > 0 && bounds.height > 0, "The logo path must not be empty.")
guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
    fatalError("Could not create the sRGB color space.")
}
try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)

let pixels = 1024
guard let context = CGContext(
    data: nil, width: pixels, height: pixels, bitsPerComponent: 8,
    bytesPerRow: pixels * 4, space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
) else {
    fatalError("Could not create a \(pixels)px bitmap.")
}
let size = CGFloat(pixels)
context.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
context.fill(CGRect(x: 0, y: 0, width: size, height: size))
// Center the actual outline; let iOS apply the icon's rounded-corner mask.
let scale = size * 0.68 / max(bounds.width, bounds.height)
context.translateBy(x: size / 2, y: size / 2)
context.scaleBy(x: scale, y: -scale)
context.translateBy(x: -bounds.midX, y: -bounds.midY)
context.setFillColor(
    red: CGFloat((rgb >> 16) & 255) / 255,
    green: CGFloat((rgb >> 8) & 255) / 255,
    blue: CGFloat(rgb & 255) / 255,
    alpha: 1
)
context.addPath(path)
context.fillPath()
let url = output.appendingPathComponent("AppIcon-\(pixels).png")
guard let image = context.makeImage(),
      let destination = CGImageDestinationCreateWithURL(
          url as CFURL, UTType.png.identifier as CFString, 1, nil
      ) else {
    fatalError("Could not create \(url.lastPathComponent).")
}
CGImageDestinationAddImage(destination, image, nil)
try require(CGImageDestinationFinalize(destination), "Failed to write \(url.path).")
guard let checkSource = CGImageSourceCreateWithURL(url as CFURL, nil),
      let check = CGImageSourceCreateImageAtIndex(checkSource, 0, nil) else {
    fatalError("Could not read back \(url.lastPathComponent).")
}
try require(
    check.width == pixels && check.height == pixels
        && [.none, .noneSkipFirst, .noneSkipLast].contains(check.alphaInfo),
    "\(url.lastPathComponent) must be square, correctly sized, and have no alpha channel."
)

let contents: [String: Any] = [
    "images": [[
        "filename": url.lastPathComponent,
        "idiom": "universal",
        "platform": "ios",
        "size": "1024x1024"
    ]],
    "info": ["author": "xcode", "version": 1]
]
let json = try JSONSerialization.data(withJSONObject: contents, options: [.prettyPrinted, .sortedKeys])
try (json + Data("\n".utf8)).write(
    to: output.appendingPathComponent("Contents.json"), options: .atomic
)
print("Generated one opaque 1024px icon. Xcode generates the iPhone, iPad, and App Store variants.")
