# CommonPlace

> A smart, privacy-focused clipboard manager for macOS that lives in your menu bar.

![macOS](https://img.shields.io/badge/macOS-13.0+-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ Features

- 📋 **Stores 15 most recent items** - Never lose that thing you copied 10 minutes ago
- 🖼️ **Text & Images** - Handles both text snippets and images seamlessly
- 🔒 **Smart Password Manager Detection** - Follows password manager's lead and automatically deletes passwords copied from password managers
- 🗑️ **Individual Item Deletion** - Hover and delete specific items you don't want
- 🚫 **Auto-filters File Paths** - Only captures actual content, not file references
- 🎯 **Native macOS UI** - Clean SwiftUI interface that feels right at home
- 🔐 **100% Private** - All data stored locally in memory, nothing sent to any server
- ⚡ **Lightweight** - Minimal resource usage, lives quietly in your menu bar

## 🎬 How It Works

1. Click the clipboard icon in your menu bar
2. See your recent clipboard history
3. Click any item to copy it again
4. Hover to see delete/copy buttons
5. That's it!

### Smart Password Manager Integration

CommonPlace follows your password manager's lead - when it automatically clears your clipboard (typically after ~90 seconds for security), CommonPlace detects this and removes those items from history too. Your passwords and sensitive data are automatically protected.

## 🚀 Installation

### Option 1: Download Pre-built App (Easy)

1. **[Download CommonPlace v1.0 from Google Drive](https://drive.google.com/drive/folders/1yAO0cFg-Nwyq6bPWFI4sHbo-Ev-KoG15)** 📥
2. Extract the ZIP and read the included `INSTALL.md` guide
3. Move `CommonPlace.app` to your Applications folder
4. Right-click → Open (first time only, to bypass security warning)
5. Look for the clipboard icon in your menu bar!

### Option 2: Build from Source (Recommended)

```bash
# Clone the repository
git clone https://github.com/danlandau-aif/CommonPlace.git
cd CommonPlace

# Build the app
swift build -c release

# Create app bundle
mkdir -p CommonPlace.app/Contents/MacOS
cp .build/release/CommonPlace CommonPlace.app/Contents/MacOS/
chmod +x CommonPlace.app/Contents/MacOS/CommonPlace

# Copy Info.plist (if you have one in the repo)
# Then open the app
open CommonPlace.app
```

## 💻 Requirements

- macOS 13.0 (Ventura) or later
- Swift 5.9+ (for building from source)

## 🔧 Usage

### Basic Operations

- **View History**: Click the menu bar icon
- **Copy Item**: Click any item in the list
- **Delete Item**: Hover over item → click red trash icon
- **Clear All**: Click trash icon in header

### Auto-Start on Login

1. System Settings → General → Login Items
2. Click "+" and add CommonPlace.app
3. Done! It'll start automatically

## 🛡️ Privacy & Security

**Your data never leaves your Mac.**

- ✅ All clipboard data stored in memory only
- ✅ No network connections
- ✅ No data collection or analytics
- ✅ No cloud uploads
- ✅ History cleared when app quits
- ✅ Open source - verify the code yourself!

## 🏗️ Technical Details

Built with:
- **Swift 5.9** - Modern, safe, fast
- **SwiftUI** - Native macOS interface
- **Swift Package Manager** - Simple dependency management
- **NSPasteboard** - macOS clipboard API
- **Combine** - Reactive data flow

## 📝 Development

### Project Structure

```
CommonPlace/
├── Sources/
│   ├── main.swift              # App entry point
│   ├── AppDelegate.swift       # App lifecycle & menu bar
│   ├── ClipboardMonitor.swift  # Clipboard monitoring logic
│   ├── ClipboardItem.swift     # Data model
│   └── ContentView.swift       # SwiftUI interface
├── Package.swift               # Swift package definition
└── README.md                   # This file
```

### Building

```bash
# Debug build
swift build

# Release build
swift build -c release

# Run directly
swift run
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

- 🐛 Report bugs
- 💡 Suggest features
- 🔧 Submit pull requests
- 📖 Improve documentation

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with love for the macOS community
- Inspired by the need for a simple, private clipboard manager
- Thanks to everyone who provided feedback and testing!

## 📬 Support

Questions or issues? Feel free to:
- [Open an issue on GitHub](https://github.com/danlandau-aif/CommonPlace/issues)
- [Connect with me on LinkedIn](https://www.linkedin.com/in/danlandau/)

---

**Made with ❤️ for privacy-conscious Mac users**
