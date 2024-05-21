#!/bin/bash

# Function to start WiFi
start_wifi() {
  nmcli radio wifi on
}

# Function to stop WiFi
stop_wifi() {
  nmcli radio wifi off
}

# Function to list WiFi networks
list_networks() {
  nmcli device wifi list
}

# Function to connect to a WiFi network
connect_to_network() {
  local ssid="$1"
  local password="$2"

  if [ -z "$password" ]; then
    nmcli device wifi connect "$ssid"
  else
    nmcli device wifi connect "$ssid" password "$password"
  fi
}

# Function to disconnect from a WiFi network
disconnect_from_network() {
  local ssid="$1"

  nmcli device disconnect "$ssid"
}

# Function to forget a WiFi network
forget_network() {
  local ssid="$1"

  nmcli connection delete id "$ssid"
}

# Main function
main() {
  case "$1" in
    start)
      start_wifi
      ;;
    stop)
      stop_wifi
      ;;
    list)
      list_networks
      ;;
    con)
      if [ $# -lt 2 ]; then
        echo "Usage: $0 connect <SSID> [<password>]"
        exit 1
      fi
      connect_to_network "$2" "$3"
      ;;
    disc)
      if [ $# -lt 2 ]; then
        echo "Usage: $0 disconnect <SSID>"
        exit 1
      fi
      disconnect_from_network "$2"
      ;;
    forget)
      if [ $# -lt 2 ]; then
        echo "Usage: $0 forget <SSID>"
        exit 1
      fi
      forget_network "$2"
      ;;
    *)
      echo "Usage: $0 {start|stop|list|connect|disconnect|forget}"
      exit 1
      ;;
  esac
}

# Run main function with arguments passed to the script
main "$@"
