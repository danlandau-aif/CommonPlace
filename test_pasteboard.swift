import Cocoa

let pasteboard = NSPasteboard.general
let types = pasteboard.types ?? []

print("=== Pasteboard Types ===")
for type in types {
    print("  - \(type.rawValue)")
}

print("\n=== String Content ===")
if let string = pasteboard.string(forType: .string) {
    print("String: \(string)")
    print("Length: \(string.count)")
}

print("\n=== Special Checks ===")
if let source = pasteboard.string(forType: NSPasteboard.PasteboardType("org.nspasteboard.source")) {
    print("Source: \(source)")
}

if let source = pasteboard.string(forType: NSPasteboard.PasteboardType("org.nspasteboard.ConcealedType")) {
    print("Concealed: \(source)")
}
