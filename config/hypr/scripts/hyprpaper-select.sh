#!/bin/bash

interval=60
directory=~/Pictures/wallpapers
monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

while true; do
  if [ -d "$directory" ]; then
      random_background=$(ls $directory/*.* | shuf -n 1)

      hyprctl hyprpaper unload all
      hyprctl hyprpaper preload $random_background
      hyprctl hyprpaper wallpaper "$monitor, $random_background"
      sleep $interval
  fi
done
