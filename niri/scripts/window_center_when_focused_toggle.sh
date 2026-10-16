#!/usr/bin/env bash

# Ruta exacta a tu archivo de layout dentro de niri
LAYOUT_FILE="$HOME/.config/niri/config/layout.kdl"

# Verifica si el archivo existe
if [ ! -f "$LAYOUT_FILE" ]; then
    exit 1
fi

# Alterna entre "always" y "never"
if grep -q 'center-focused-column "always"' "$LAYOUT_FILE"; then
    sed -i 's/center-focused-column "always"/center-focused-column "never"/' "$LAYOUT_FILE"
else
    # Si estaba en "never" (o no estaba configurado explícitamente)
    if grep -q 'center-focused-column' "$LAYOUT_FILE"; then
        sed -i 's/center-focused-column "never"/center-focused-column "always"/' "$LAYOUT_FILE"
    else
        # Si la propiedad no existía en el archivo, la agrega dentro del bloque layout
        sed -i '/layout {/a \    center-focused-column "always"' "$LAYOUT_FILE"
    fi
fi

# Fuerza a Niri a recargar la configuración
niri msg action reload-config
