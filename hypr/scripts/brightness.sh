#!/bin/bash

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)

# count 5% brightness
step=$((max_brightness * 5 / 100))

# if not para，echo now brightness
if [ $# -eq 0 ]; then
  percentage=$((brightness * 100 / max_brightness))
  echo "Now brightness: $brightness (${percentage}%, Max brightness: $max_brightness)"
  exit 0
fi

# handle
case "$1" in
up)
  new_brightness=$((brightness + step))
  if ((new_brightness > max_brightness)); then
    new_brightness=$max_brightness
  fi
  ;;

down)
  new_brightness=$((brightness - step))
  if ((new_brightness < 1)); then
    brightness=1
  fi
  ;;

*)
  echo "Usage: $0 [up|down]"
  echo "    up   - brightness UP"
  echo "    down - brightness DOWN"
  echo "Not para  - echo now brightness"
  exit 1
  ;;

esac

# set new brightness
if ! echo $new_brightness | sudo tee /sys/class/backlight/intel_backlight/brightness >/dev/null; then
  echo "ERROR: need ROOT" >&2
  exit 1
fi

current=$(cat /sys/class/backlight/intel_backlight/brightness)
percentage=$((current * 100 / max_brightness))
echo "Set brightness: $current (${percentage}%)"
