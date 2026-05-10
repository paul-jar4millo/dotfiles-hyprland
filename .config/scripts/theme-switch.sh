#!/usr/bin/env bash
# Furina — Ousia ⇄ Pneuma
set -euo pipefail

CONFIG="$HOME/.config"
THEMES="$CONFIG/themes"
STATE="$HOME/.cache/furina-theme"
WPDIR="$HOME/Pictures/wallpapers"

CURRENT=$(cat "$STATE" 2>/dev/null || echo "ousia")

if [[ "${1:-}" == "ousia" || "${1:-}" == "pneuma" ]]; then
    NEW="$1"
elif [[ "$CURRENT" == "ousia" ]]; then NEW="pneuma"
else NEW="ousia"
fi

[[ "$CURRENT" == "$NEW" && "${2:-}" != "--force" ]] && exit 0

# Symlinks
ln -sf "$THEMES/$NEW/hypr-colors.conf" "$CONFIG/hypr/hyprland/colors.conf"
ln -sf "$THEMES/$NEW/kitty-theme.conf" "$CONFIG/kitty/current-theme.conf"
ln -sf "$THEMES/$NEW/furina.theme"     "$CONFIG/btop/themes/furina.theme"
ln -sf "$THEMES/$NEW/theme.fish"       "$CONFIG/fish/conf.d/theme.fish"

# --- PRIORITY 1: Instant UI Feedback ---
# Update Quickshell Bar
qs ipc call theme setTheme "$NEW" 2>/dev/null || true &
# Update Hyprland Borders/Colors
hyprctl reload 2>/dev/null || true &
# Update state file immediately
echo "$NEW" > "$STATE"

# --- PRIORITY 2: Terminal Apps ---
killall -USR1 kitty 2>/dev/null || true
killall -USR1 fish 2>/dev/null || true

# --- PRIORITY 3: Slow Background Tasks ---
# Wallpaper
WP="$WPDIR/$NEW.jpg"; [[ -f "$WP" ]] || WP="$WPDIR/$NEW.png"
if [[ -f "$WP" ]]; then
    (
        pgrep -x awww-daemon >/dev/null || { awww-daemon --format xrgb & sleep 0.5; }
        if [[ "$NEW" == "ousia" ]]; then
            awww img "$WP" --transition-pos 0.5,0.5 --transition-duration 1 --transition-fps 60 --transition-bezier 0.22,0.68,0.0,1.0
        else
            awww img "$WP" --transition-pos 0.5,0.5 --transition-duration 1 --transition-fps 60 --transition-bezier 0.05,0.9,0.1,1.0
        fi
    ) &>/dev/null &
fi

# GTK Settings (D-Bus is slow)
if command -v gsettings &>/dev/null; then
    (
        if [[ "$NEW" == "ousia" ]]; then
            gsettings set org.gnome.desktop.interface color-scheme prefer-dark
            gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
        else
            gsettings set org.gnome.desktop.interface color-scheme prefer-light
            gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3
        fi
    ) &>/dev/null &
fi
