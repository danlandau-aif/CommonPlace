import SwiftUI

struct ContentView: View {
    @ObservedObject var clipboardMonitor: ClipboardMonitor
    @State private var hoveredItemId: UUID?

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("CommonPlace")
                    .font(.headline)
                    .padding(.leading, 12)

                Spacer()

                Button(action: {
                    clipboardMonitor.clearHistory()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
                .help("Clear history")
                .padding(.trailing, 12)
            }
            .padding(.vertical, 10)
            .background(Color(NSColor.controlBackgroundColor))

            Divider()

            // Clipboard history list
            if clipboardMonitor.history.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "doc.on.clipboard")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    Text("No clipboard history yet")
                        .foregroundColor(.secondary)
                    Text("Copy something to get started")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 1) {
                        ForEach(clipboardMonitor.history) { item in
                            ClipboardItemRow(
                                item: item,
                                isHovered: hoveredItemId == item.id,
                                onCopy: {
                                    clipboardMonitor.copyToClipboard(item)
                                },
                                onDelete: {
                                    clipboardMonitor.deleteItem(item)
                                }
                            )
                            .onHover { hovering in
                                hoveredItemId = hovering ? item.id : nil
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            Divider()

            // Footer
            HStack {
                Text("\(clipboardMonitor.history.count) of 15 items")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(NSColor.controlBackgroundColor))
        }
        .frame(width: 400, height: 500)
    }
}

struct ClipboardItemRow: View {
    let item: ClipboardItem
    let isHovered: Bool
    let onCopy: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon
            Image(systemName: item.type == .text ? "doc.text" : "photo")
                .foregroundColor(.secondary)
                .frame(width: 20)
                .padding(.top, 2)

            // Content
            VStack(alignment: .leading, spacing: 4) {
                if item.type == .image, let image = item.image {
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300, maxHeight: 150)
                        .cornerRadius(6)
                } else {
                    Text(item.previewText)
                        .font(.system(.body, design: .default))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }

                Text(formatTimestamp(item.timestamp))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .onTapGesture {
                onCopy()
            }

            Spacer()

            // Action buttons (visible on hover)
            if isHovered {
                HStack(spacing: 8) {
                    Button(action: onCopy) {
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(.accentColor)
                            .font(.caption)
                    }
                    .buttonStyle(.plain)
                    .help("Copy to clipboard")

                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    .buttonStyle(.plain)
                    .help("Delete")
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(isHovered ? Color.accentColor.opacity(0.1) : Color.clear)
        .contentShape(Rectangle())
    }

    private func formatTimestamp(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
