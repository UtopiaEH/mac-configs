#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Define the directory where profile configurations are stored
CONFIG_DIR="$HOME/.vpn/carasent"
PID_FILE="$HOME/.vpn/vpn.pid"
LOG_PATH="$HOME/.vpn/vpn_status.txt"


function checkProfile() {
  if [ -z "$1" ]; then
      echo "Usage: $0 <profile>"
      exit 1
  fi

   source "$CONFIG_DIR/$1.conf" 2>/dev/null

    if [ ! -f "$CONFIG_DIR/$1.conf" ]; then
        echo "Profile not found: $1"
        exit 1
  fi
}

function start() {

    # Check if process is running. Exit in this case.
    [ -f ${PID_FILE} ] && ps -p "$(<${PID_FILE})" &>/dev/null &&
      echo "Openconnect is already running." && exit 0

  # Load the configuration for the specified profile
  # shellcheck disable=SC1090

    echo "Connecting to $SERVER"
    # Run openconnect in the background

    echo "$PASS"
    echo "$SERVER"
    echo "$USER"

    openconnect --user=${USER} ${SERVER} --syslog --passwd-on-stdin <<< "${PASS}" --pid-file=${PID_FILE} > "$LOG_PATH" 2>&1

    # Capture the process ID of the last background command
#    OC_PID=$!
#
#    echo "PID: $OC_PID"
#
#    # Wait for user input for OTP
#    read -p "Enter OTP: " OTP
#
#    # Use expect to send OTP
#    /usr/bin/expect <<EOF
#    set timeout 10
#    spawn sleep 5
#    exec kill -SIGUSR2 $OC_PID
#    send "$OTP\n"
#    interact
#EOF
}


checkProfile "$1"

case "$2" in
  start)
    start
    ;;
#  stop)
#    stop
#    ;;
#  status)
#    status
#    ;;
#  restart)
#    stop && start
#    ;;
  *)
    echo "Usage: ${0##*/} (profile command)" && exit 0
    ;;
esac


#checkProfile "$1"

# shellcheck disable=SC2218
#connect "$SERVER" "$USER" "$PASS"
