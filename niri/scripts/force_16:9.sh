#!/usr/bin/env bash

windows_json=$(niri msg --json windows)

# Extraer ID, ancho y alto de la ventana enfocada sin importar su estado de flotación
read -r window_id width height < <(echo "$windows_json" | jq -r '
  .[] | select(.is_focused == true) |
  "\(.id) \(.layout.window_size[0]) \(.layout.window_size[1])"
')

if [ -n "$window_id" ] && [ "$width" != "null" ] && [ "$height" != "null" ] && [ "$width" -gt 0 ] && [ "$height" -gt 0 ]; then
    # Calcular el ancho ideal basado en el alto actual para una proporción 16:9
    ideal_width=$(( (height * 16) / 9 ))

    if [ "$width" -gt "$ideal_width" ]; then
        # En tiling, el ancho se controla ajustando el ancho de la columna en píxeles
        niri msg action set-column-width "$ideal_width"
    elif [ "$width" -lt "$ideal_width" ]; then
        # Si el ancho es menor, ajustamos la altura de la ventana
        ideal_height=$(( (width * 9) / 16 ))
        niri msg action set-window-height --id "$window_id" "$ideal_height"
    fi
else
    echo "No se pudo obtener el tamaño de la ventana enfocada."
fi
