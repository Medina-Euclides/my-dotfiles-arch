#!/usr/bin/env bash

# Ruta de tu repositorio
REPO="$HOME/dotfiles"

# Lista de apps dentro de ~/.config que quieres respaldar
# (Agrega aquí más nombres en el futuro: "rofi" "zed" "fish", etc.)
APPS=("hypr" "waybar" "kitty" "wlogout")

echo "Sincronizando configuraciones..."

for app in "${APPS[@]}"; do
    if [ -d "$HOME/.config/$app" ]; then
        mkdir -p "$REPO/.config/$app"
        # -a: mantiene permisos y subcarpetas (como scripts/)
        # --delete: si borras un archivo en ~/.config, lo borra también del repo
        rsync -av --delete --exclude='*.log' --exclude='cache/' "$HOME/.config/$app/" "$REPO/.config/$app/"
        echo "  [OK] $app"
    fi
done

# Guarda la lista de paquetes instalados en tu Arch
pacman -Qqen > "$REPO/pkglist-pacman.txt"
pacman -Qqem > "$REPO/pkglist-aur.txt"
echo "  [OK] Listas de paquetes actualizadas"
