#!/bin/bash

# Get the desired space number
target_space=$1

# Get the total number of currently available spaces
current_spaces=$(yabai -m query --spaces | jq '. | length')

# Check if the desired space already exists
if (( current_spaces < target_space )); then
  # Create the required number of spaces to reach the target space
  spaces_to_create=$(( target_space - current_spaces ))
  
  for ((i=0; i<spaces_to_create; i++)); do
    yabai -m space --create
  done
else
  # Get the window of the last open space. Will be "[]" if there
  # are no open windows.
  space_window=$(yabai -m query --spaces | jq '.[-1].windows')
  if [[ $space_window == "[]" ]]; then
    # Get an array of the current open spaces and reverse it.
    open_spaces=$(yabai -m query --spaces | jq 'reverse | .[].index')
    for cur_space in ${open_spaces[@]}; do
      open_windows=$(yabai -m query --spaces --space $cur_space | jq '.windows')
      if [[ $open_windows == "[]" && $cur_space > $target_space ]]; then
        yabai -m space --destroy $cur_space
      else
        break
      fi
    done
  fi
fi

# Once the space is created (or already existed), focus on it
yabai -m space --focus $target_space

