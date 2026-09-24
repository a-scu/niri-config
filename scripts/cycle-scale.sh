#!/usr/bin/env bash

# Obtener la escala actual del monitor DP-1 usando jq
CURRENT=$(niri msg --json outputs | jq -r '."DP-1".logical.scale // 1.0')

# Ciclar entre 1, 1.5 y 1.75
case "$CURRENT" in
    "1"|"1.0")
        NEXT="1.5"
        ;;
    "1.5")
        NEXT="2"
        ;;
    *)
        NEXT="1"
        ;;
esac

niri msg output DP-1 scale "$NEXT"
# niri msg output DP-2 scale "$NEXT"
