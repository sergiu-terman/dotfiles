#!/bin/bash

declare -A devices

# Function to show usage
usage() {
  echo "Usage: $0 [con|dicc] [alias]"
  echo "Available aliases:"
  for alias in "${!devices[@]}"; do
    echo "  - $alias"
  done
}

populate_devices() {
  while read -r line; do
    # Extract the MAC address and alias from the line
    if [[ $line =~ Device\ ([[:xdigit:]:]{17})\ (.+) ]]; then
      mac_address="${BASH_REMATCH[1]}"
      alias="${BASH_REMATCH[2]}"
      devices["$alias"]="$mac_address"
    fi
  done < <(bluetoothctl devices)
}

populate_devices

# Check if the correct number of arguments is provided
if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

# Extract command and alias from arguments
command=$1
alias=$2

# Check if the alias is valid
if [[ ! -v devices[$alias] ]]; then
  echo "Error: Unknown alias '$alias'"
  usage
  exit 1
fi

# Get the MAC address of the device
mac_address=${devices[$alias]}

# Execute the command
case $command in
  con)
    echo "Connecting to $alias ($mac_address)..."
    echo -e "connect $mac_address\nexit" | bluetoothctl
    ;;
  disc)
    echo "Disconnecting from $alias ($mac_address)..."
    echo -e "disconnect $mac_address\nexit" | bluetoothctl
    ;;
  *)
    echo "Error: Unknown command '$command'"
    usage
    exit 1
    ;;
esac

