#!/bin/bash

# Input file
dir_place="/sys/class/backlight/intel_backlight"
current_brightness_file="$dir_place/brightness"
current_brightness=$(<"$current_brightness_file")
max_brightness=$(<"$dir_place/max_brightness")
constant=$((max_brightness / 10))


# Check if correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 up|down"
    exit 1
fi

# Determine whether to add or subtract the constant value
operation="$1"

# Validate the operation parameter
if [ "$operation" != "up" ] && [ "$operation" != "down" ]; then
    echo "Error: Invalid operation. Specify 'up' or 'down'."
    exit 1
fi

# Calculate the result based on the operation
if [ "$operation" == "up" ]; then
    # If operation is 'up', ensure result does not exceed the constant value
    result=$((current_brightness + constant))
    if [ "$result" -gt "$max_brightness" ]; then
        result="$max_brightness"
    fi
elif [ "$operation" == "down" ]; then
    # If operation is 'down', ensure result does not go below zero
    result=$((current_brightness - constant))
    if [ "$result" -lt 0 ]; then
        result=0
    fi
fi

# Write the result to the output file
echo "$result" > "$current_brightness_file"
