#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC POWER')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON = "100"
  ;;
  [6-8][0-9]) ICON = "89"
  ;;
  [3-5][0-9]) ICON = "59"
  ;;
  [1-2][0-9]) ICON = "29"
  ;;
  *) ICON = "00"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON = "CHARGING"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
