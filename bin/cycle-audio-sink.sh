#!/bin/bash

# Get list of sinks
sinks=($(pactl list short sinks | awk '{print $1}'))

# Get current default sink
current_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')
current_index=$(pactl list short sinks | grep "$current_sink" | awk '{print $1}')

# Find the next sink index
for i in "${!sinks[@]}"; do
  if [ "${sinks[$i]}" == "$current_index" ]; then
    next_index=$(( (i + 1) % ${#sinks[@]} ))
    break
  fi
done

# Set the next sink as the default
pactl set-default-sink "${sinks[$next_index]}"

# Move all current sink inputs to the new sink
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
  pactl move-sink-input "$input" "${sinks[$next_index]}"
done
