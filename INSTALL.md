# CommonPlace - Installation Guide

**A smart clipboard manager for macOS that lives in your menu bar.**

---

## What is CommonPlace?

CommonPlace is a lightweight clipboard manager that:
- 📋 Stores your last 15 copied items (text and images)
- 🔒 Smart 1Password detection - automatically removes passwords when 1Password clears them
- 🗑️ Individual item deletion with hover actions
- 🚫 Filters out file paths automatically
- 💾 All data stored locally in memory (nothing sent to any server)
- 🎯 Clean, native macOS interface

---

## System Requirements

- macOS 13.0 (Ventura) or later
- Apple Silicon (M1/M2/M3) or Intel Mac

---

## Installation Instructions

### Step 1: Extract the App

1. Unzip the `CommonPlace.zip` file
2. You'll see `CommonPlace.app`

### Step 2: Move to Applications (Recommended)

Drag `CommonPlace.app` to your `/Applications` folder.

### Step 3: First Launch

1. **Double-click** `CommonPlace.app` to launch it
2. You may see a security warning: *"CommonPlace cannot be opened because it is from an unidentified developer"*

   **To bypass this warning:**
   - Right-click (or Control-click) on `CommonPlace.app`
   - Select **"Open"** from the menu
   - Click **"Open"** in the dialog that appears
   - This only needs to be done once!

   **Alternative method:**
   - Go to **System Settings** → **Privacy & Security**
   - Scroll down and click **"Open Anyway"** next to the CommonPlace message
   - Click **"Open"** to confirm

3. Once launched, look for the **clipboard icon** in your menu bar (top-right corner)

---

## How to Use

### Viewing Clipboard History

1. Click the **clipboard icon** in your menu bar
2. Your recent clipboard items appear in a dropdown
3. The most recent item is at the top

### Copying an Item Again

- Click any item to copy it back to your clipboard
- Or hover over an item and click the **blue copy icon**

### Deleting an Item

1. Hover over any item
2. Click the **red trash icon** that appears
3. The item is immediately removed from history

### Clearing All History

- Click the **trash icon** in the header
- All clipboard history is cleared

### Quitting the App

- Click **"Quit"** at the bottom of the dropdown
- Or right-click the menu bar icon and select **"Quit"**

---

## Auto-Start on Login (Optional but Recommended)

To have CommonPlace start automatically when you log in:

1. Open **System Settings**
2. Go to **General** → **Login Items** (or **Users & Groups** → **Login Items** on older macOS)
3. Click the **"+"** button
4. Navigate to `/Applications` and select **CommonPlace.app**
5. Click **"Add"**

CommonPlace will now start automatically every time you log in!

---

## Features Explained

### Smart 1Password Detection

CommonPlace intelligently detects when items are copied from 1Password:

- When you copy a password/credential from 1Password (desktop app or browser extension)
- 1Password automatically clears your clipboard after ~90 seconds for security
- CommonPlace detects this auto-clear behavior
- The item is automatically removed from your history
- Your sensitive credentials never stay in the clipboard history!

### File Path Filtering

CommonPlace automatically ignores:
- File paths
- File URLs
- Copied files from Finder

Only actual content (text and images) is saved.

---

## Privacy & Security

- ✅ All clipboard data is stored **locally in memory only**
- ✅ Nothing is ever sent to any external server
- ✅ History is cleared when you quit the app
- ✅ Works completely offline
- ✅ No tracking, no analytics, no data collection

---

## Troubleshooting

### The menu bar icon doesn't appear

- Make sure the app is running (check Activity Monitor for "CommonPlace")
- Try quitting and relaunching the app
- Check that you're running macOS 13.0 or later

### Images aren't showing up

- Make sure you're copying actual images (not just image files)
- Try taking a screenshot (Cmd+Shift+4) and copying it
- Images from web pages and other apps should work fine

### "App is damaged" error

This usually happens if the app was modified during download. Try:
1. Delete the app
2. Re-download and extract the ZIP file
3. Follow the "First Launch" instructions above carefully

### Security warning keeps appearing

- Make sure you right-clicked and selected "Open" (not just double-clicked)
- Or use System Settings → Privacy & Security → "Open Anyway"

---

## Uninstalling

To remove CommonPlace:

1. Quit the app (click the menu bar icon → Quit)
2. Remove from Login Items (System Settings → General → Login Items)
3. Delete `CommonPlace.app` from your Applications folder
4. That's it! No other files or settings remain.

---

## Support & Feedback

If you encounter any issues or have suggestions, please reach out to your IT team or the person who shared this app with you.

---

## Version Information

**Version:** 1.0
**Build Date:** 2024
**macOS Requirement:** 13.0+

---

Enjoy your new clipboard manager! 📋✨
