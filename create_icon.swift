import Cocoa

// Create an app icon from SF Symbol
let size: CGFloat = 1024
let image = NSImage(size: NSSize(width: size, height: size))

image.lockFocus()

// Background gradient
let gradient = NSGradient(colors: [
    NSColor(red: 0.3, green: 0.5, blue: 0.9, alpha: 1.0),
    NSColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
])
gradient?.draw(in: NSRect(x: 0, y: 0, width: size, height: size), angle: 90)

// Draw rounded rect background
let rect = NSRect(x: 0, y: 0, width: size, height: size)
let path = NSBezierPath(roundedRect: rect, xRadius: size * 0.2, yRadius: size * 0.2)
path.addClip()

// Draw clipboard symbol
if let symbolImage = NSImage(systemSymbolName: "doc.on.clipboard.fill", accessibilityDescription: nil) {
    let config = NSImage.SymbolConfiguration(pointSize: size * 0.6, weight: .regular)
    let configuredImage = symbolImage.withSymbolConfiguration(config)

    let symbolSize = configuredImage?.size ?? NSSize(width: size * 0.6, height: size * 0.6)
    let x = (size - symbolSize.width) / 2
    let y = (size - symbolSize.height) / 2

    NSColor.white.set()
    configuredImage?.draw(in: NSRect(x: x, y: y, width: symbolSize.width, height: symbolSize.height))
}

image.unlockFocus()

// Save as icns file
if let tiffData = image.tiffRepresentation,
   let bitmapImage = NSBitmapImageRep(data: tiffData) {

    // Create iconset directory
    let iconsetPath = NSHomeDirectory() + "/ClipboardManager/AppIcon.iconset"
    try? FileManager.default.createDirectory(atPath: iconsetPath, withIntermediateDirectories: true)

    // Generate different sizes
    let sizes: [(Int, String)] = [
        (16, "16x16"),
        (32, "16x16@2x"),
        (32, "32x32"),
        (64, "32x32@2x"),
        (128, "128x128"),
        (256, "128x128@2x"),
        (256, "256x256"),
        (512, "256x256@2x"),
        (512, "512x512"),
        (1024, "512x512@2x")
    ]

    for (pixelSize, name) in sizes {
        let resizedImage = NSImage(size: NSSize(width: pixelSize, height: pixelSize))
        resizedImage.lockFocus()
        image.draw(in: NSRect(x: 0, y: 0, width: pixelSize, height: pixelSize))
        resizedImage.unlockFocus()

        if let resizedTiff = resizedImage.tiffRepresentation,
           let resizedBitmap = NSBitmapImageRep(data: resizedTiff),
           let pngData = resizedBitmap.representation(using: .png, properties: [:]) {
            let filename = iconsetPath + "/icon_\(name).png"
            try? pngData.write(to: URL(fileURLWithPath: filename))
        }
    }

    print("Icon created successfully at: \(iconsetPath)")
}
