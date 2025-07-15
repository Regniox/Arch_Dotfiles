#!/bin/bash

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

TIMESTAMP=$(date +%y%m%d_%H%M%S)

FILE="$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"

if [ "$1" == "full" ]; then
  MODE="Full Screenshot"
  grim - | tee "$FILE" | wl-copy
  notify-send "Screenshot: full screenshot to save $FILE and copy"
else
  MODE="Select Screenshot"
  grim -g "$(slurp)" - | tee "$FILE" | wl-copy
  notify-send "Screenshot: select screenshot to save $FILE and copy"
fi

exit 0
