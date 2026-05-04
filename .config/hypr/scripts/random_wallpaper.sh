#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers"
INTERVAL=1800
killall hyprpaper
hyprpaper &
sleep 1

while true; do
  WALL=$(find "$DIR" -type f | shuf -n 1)
  hyprctl hyprpaper preload "$WALL"

  for MONITOR in $(hyprctl monitors -j | jq -r '.[] | .name'); do
    hyprctl hyprpaper wallpaper "$MONITOR,$WALL"
  done

  sleep 2
  hyprctl hyprpaper unload all

  sleep "$INTERVAL"
done
