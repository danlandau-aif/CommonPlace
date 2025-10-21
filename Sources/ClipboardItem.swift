import Foundation
import AppKit

enum ClipboardItemType {
    case text
    case image
}

struct ClipboardItem: Identifiable {
    let id = UUID()
    let type: ClipboardItemType
    let timestamp: Date
    let content: Any

    var displayText: String {
        switch type {
        case .text:
            if let text = content as? String {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            return ""
        case .image:
            return "[Image]"
        }
    }

    var previewText: String {
        let text = displayText
        if text.count > 100 {
            return String(text.prefix(100)) + "..."
        }
        return text
    }

    var image: NSImage? {
        if type == .image, let img = content as? NSImage {
            return img
        }
        return nil
    }
}
