#!/bin/bash

TARGET_DIR="/home/scu/projects/fitlog"

if ! pgrep -af "kitty" | grep -q "$TARGET_DIR"; then
    kitty --app-id "kitty-fitlog" --working-directory "$TARGET_DIR" sh -c "npm start" &
fi

if ! pgrep -x "scrcpy" > /dev/null; then
    scrcpy &
fi

# google-chrome-stable --new-window --class="chrome-fitlog" &
brave-origin-nightly --new-window --class="brave-fitlog" &

(cd "$TARGET_DIR" && antigravity .) &
