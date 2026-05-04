#!/bin/bash

# Variables
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr_theme_state"
THEME_LIGHT="Adwaita"
THEME_DARK="Adwaita-Dark"

# QT config files
QT_CONFIGS=(
  "$HOME/.config/qt5ct/qt5ct.conf"
  "$HOME/.config/qt6ct/qt6ct.conf"
)
# Make the config directory
mkdir -p "$(dirname "$STATE_FILE")"

# Read the config file set_qt_theme
CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "light")

# Change name function
set_qt_theme() {
  local old_theme=$1
  local new_theme=$2
  for conf in "${QT_CONFIGS[@]}"; do
    if [ -f "$conf" ]; then
      sed -i "s/style=$old_theme/style=$new_theme/g" "$conf"
    fi
  done
}

if [ "$CURRENT_STATE" == "light" ]; then
  # Dark theme
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  set_qt_theme "$THEME_LIGHT" "$THEME_DARK"
  echo "dark" >"$STATE_FILE"
  notify-send "Alignment Changed" "Pneuma (Dark Mode)" -i weather-clear-night
else
  # Light theme
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

  set_qt_theme "$THEME_DARK" "$THEME_LIGHT"

  echo "light" >"$STATE_FILE"
  notify-send "Alignment Changed" "Ousia (Light Mode)" -i weather-clear
fi
