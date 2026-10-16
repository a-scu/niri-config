#!/bin/bash

# Do 'move-to-monitor-up' if we're on row 1 of workspace 1
CURR_WS_IDX=$(niri msg -j workspaces | jq '.[] | select(.is_focused == true)' | jq .idx)
if [ "$CURR_WS_IDX" -ne 1 ]; then
  # Here we're not on workspace 1, so just move up normally
  niri msg action move-window-up-or-to-workspace-up
else
  WIN_ROW_IDX=$(niri msg -j focused-window | jq .layout | jq .pos_in_scrolling_layout | jq '.[1]')
  if [ "$WIN_ROW_IDX" -eq 1 ]; then
    # Here we're on workspace 1, row 1, so move to monitor up
    niri msg action move-window-to-monitor-up
  else
    # Here we're on workspace 1, but not row 1, so just move up the column
    niri msg action move-window-up
  fi
fi
