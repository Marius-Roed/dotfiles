#!/bin/bash

# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see these changes to the status bar immediately afet saving.
# If you do not see the changes, do "killall swaybar" and then $mod+Shift+c
# to reload the configuration.

date_formatted=$(date "+%a. %e/%m | Week %W  %H:%M:%S")

battery_status=$(upower -i /org/freedesktop/UPower/devices/DisplayDevice | grep percentage | awk '{print $2}')

storage_free=$(df -h | grep data-root | awk '{print $4}')
storage_percent=$(df -h | grep data-root | awk '{print $5}')

echo "Storage:$storage_free $storage_percent  |  Battery: $battery_status  |  $date_formatted"
