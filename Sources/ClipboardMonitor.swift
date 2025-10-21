import Cocoa
import Foundation

class ClipboardMonitor: ObservableObject {
    @Published var history: [ClipboardItem] = []
    private var timer: Timer?
    private var lastChangeCount: Int = 0
    private let maxHistorySize = 15
    private let pasteboard = NSPasteboard.general

    // Track items that might be from 1Password (to detect auto-clear)
    private var trackedItems: [(item: ClipboardItem, addedAt: Date)] = []
    private var lastClipboardContent: String?

    func start() {
        lastChangeCount = pasteboard.changeCount

        // Check clipboard every 0.5 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkClipboard()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func checkClipboard() {
        let currentChangeCount = pasteboard.changeCount

        // Only process if clipboard has changed
        guard currentChangeCount != lastChangeCount else { return }
        lastChangeCount = currentChangeCount

        // Debug: Print all pasteboard types
        let types = pasteboard.types ?? []
        print("Clipboard changed. Types: \(types.map { $0.rawValue })")

        // Get current clipboard content
        let currentContent = pasteboard.string(forType: .string)
        let hasImage = getImageFromPasteboard() != nil

        // Check if clipboard was cleared (empty or nil) - potential 1Password auto-clear
        // Only check if there's no image either
        if (currentContent == nil || currentContent?.isEmpty == true) && !hasImage {
            print("Clipboard cleared - checking if it was 1Password auto-clear...")
            checkForAutoClear()
            lastClipboardContent = nil
            return
        }

        // Check if content is from 1Password by looking at the pasteboard types and source
        if isFrom1Password() {
            print("Clipboard content from 1Password detected, skipping...")
            return
        }

        // Try to get text first
        if let string = currentContent, !string.isEmpty {
            // Skip if this is a file path (simple check)
            if isFilePath(string) {
                print("File path detected, skipping...")
                return
            }

            // Check if this text is already the most recent item
            if let lastItem = history.first,
               lastItem.type == .text,
               let lastText = lastItem.content as? String,
               lastText == string {
                return
            }

            let item = ClipboardItem(
                type: .text,
                timestamp: Date(),
                content: string
            )
            addToHistory(item)

            // Track this item for potential 1Password auto-clear detection
            lastClipboardContent = string
            trackedItems.append((item: item, addedAt: Date()))
        }
        // Try to get image
        else if let image = getImageFromPasteboard() {
            // Check if this image is already the most recent item
            if let lastItem = history.first,
               lastItem.type == .image,
               let lastImage = lastItem.content as? NSImage,
               imagesAreEqual(lastImage, image) {
                return
            }

            let item = ClipboardItem(
                type: .image,
                timestamp: Date(),
                content: image
            )
            addToHistory(item)
            lastClipboardContent = nil
        }

        // Clean up old tracked items (older than 150 seconds)
        cleanupTrackedItems()
    }

    private func checkForAutoClear() {
        let now = Date()

        // Check if any tracked items were cleared within the 1Password auto-clear window (60-150 seconds)
        for tracked in trackedItems {
            let timeSinceAdded = now.timeIntervalSince(tracked.addedAt)

            // 1Password clears after ~90 seconds, give a range of 60-150 seconds
            if timeSinceAdded >= 60 && timeSinceAdded <= 150 {
                // This looks like 1Password auto-clear behavior
                print("Detected 1Password auto-clear pattern for item added \(Int(timeSinceAdded)) seconds ago")
                print("Removing item from history: \(tracked.item.previewText)")

                DispatchQueue.main.async { [weak self] in
                    self?.history.removeAll { $0.id == tracked.item.id }
                }
            }
        }

        // Clear tracked items after detection
        trackedItems.removeAll()
    }

    private func cleanupTrackedItems() {
        let now = Date()
        // Remove tracked items older than 150 seconds (beyond 1Password's auto-clear window)
        trackedItems.removeAll { now.timeIntervalSince($0.addedAt) > 150 }
    }

    private func addToHistory(_ item: ClipboardItem) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.history.insert(item, at: 0)

            // Keep only the latest 15 items
            if self.history.count > self.maxHistorySize {
                self.history.removeLast()
            }
        }
    }

    private func getImageFromPasteboard() -> NSImage? {
        // Check for TIFF image data
        if let imageData = pasteboard.data(forType: .tiff),
           let image = NSImage(data: imageData) {
            return image
        }

        // Check for PNG image data
        if let imageData = pasteboard.data(forType: .png),
           let image = NSImage(data: imageData) {
            return image
        }

        return nil
    }

    private func isFrom1Password() -> Bool {
        // 1Password adds a specific pasteboard type when copying
        // Check for common 1Password identifiers
        let types = pasteboard.types ?? []

        // Check for 1Password specific types
        for type in types {
            let typeString = type.rawValue.lowercased()
            if typeString.contains("1password") ||
               typeString.contains("com.agilebits") ||
               typeString.contains("onepassword") {
                print("1Password detected via pasteboard type: \(typeString)")
                return true
            }
        }

        // Additional check: 1Password often sets a specific metadata
        if let string = pasteboard.string(forType: NSPasteboard.PasteboardType("org.nspasteboard.source")) {
            if string.contains("1Password") || string.contains("AgileBits") {
                print("1Password detected via source metadata")
                return true
            }
        }

        // Check for concealed pasteboard types (1Password uses this for sensitive data)
        if types.contains(where: { $0.rawValue == "org.nspasteboard.ConcealedType" }) {
            print("1Password detected via concealed type")
            return true
        }

        return false
    }

    private func isFilePath(_ string: String) -> Bool {
        // Check if string looks like a file path
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)

        // Check if it's a file URL
        if trimmed.hasPrefix("file://") {
            return true
        }

        // Check if pasteboard contains file URLs
        if let urls = pasteboard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL] {
            if !urls.isEmpty {
                return true
            }
        }

        return false
    }

    private func imagesAreEqual(_ img1: NSImage, _ img2: NSImage) -> Bool {
        guard let data1 = img1.tiffRepresentation,
              let data2 = img2.tiffRepresentation else {
            return false
        }
        return data1 == data2
    }

    func copyToClipboard(_ item: ClipboardItem) {
        pasteboard.clearContents()

        switch item.type {
        case .text:
            if let text = item.content as? String {
                pasteboard.setString(text, forType: .string)
            }
        case .image:
            if let image = item.content as? NSImage {
                pasteboard.writeObjects([image])
            }
        }

        // Update lastChangeCount to prevent re-adding the same item
        lastChangeCount = pasteboard.changeCount
    }

    func clearHistory() {
        DispatchQueue.main.async { [weak self] in
            self?.history.removeAll()
        }
    }

    func deleteItem(_ item: ClipboardItem) {
        DispatchQueue.main.async { [weak self] in
            self?.history.removeAll { $0.id == item.id }
        }
    }
}
