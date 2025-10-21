#!/bin/bash

# Kill any existing instances
killall CommonPlace 2>/dev/null

# Wait a moment
sleep 1

# Launch the app
open ~/ClipboardManager/CommonPlace.app

echo "CommonPlace launched! Look for the clipboard icon in your menu bar."
