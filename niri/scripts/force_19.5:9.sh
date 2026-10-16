#!/usr/bin/env bash

windows_json=$(niri msg --json windows)

read -r window_id is_floating width height < <(echo "$windows_json" | jq -r '
  .[] | select(.is_focused == true) |
  "\(.id) \(.is_floating) \(.layout.window_size[0]) \(.layout.window_size[1])"
')

if [ -n "$window_id" ] && [ "$width" != "null" ] && [ "$height" != "null" ] && [ "$width" -gt 0 ] && [ "$height" -gt 0 ]; then

    # Proporción vertical (portrait) 9:19.5 -> Ancho / Alto = 18 / 39
    # ideal_width = (height * 18) / 39
    ideal_width=$(( (height * 18) / 39 ))

    if [ "$width" -gt "$ideal_width" ]; then
        # Si el ancho es mayor al ideal vertical, achicamos el ancho
        if [ "$is_floating" = "true" ]; then
            niri msg action set-window-width --id "$window_id" "$ideal_width"
        else
            niri msg action set-column-width "$ideal_width"
        fi
    elif [ "$width" -lt "$ideal_width" ]; then
        # Si el ancho es menor, ajustamos la altura correspondiente
        ideal_height=$(( (width * 39) / 18 ))
        niri msg action set-window-height --id "$window_id" "$ideal_height"
    fi
else
    echo "No se pudo obtener el tamaño de la ventana enfocada."
fi
