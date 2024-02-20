#!/bin/bash

# Define the directory where profile configurations are stored
CONFIG_DIR="$HOME/.vpn/carasent"

# Check for the profile argument
if [ -z "$1" ]; then
    echo "Usage: $0 <profile>"
    exit 1
fi

# Load the configuration for the specified profile
source "$CONFIG_DIR/$1.conf" 2>/dev/null

# Display the content stored in the variables
echo "Server: $SERVER"
echo "User: $USER"
echo "Pass: $PASS"

# Check if the profile exists
if [ -z "$SERVER" ] || [ -z "$USER" ] || [ -z "$PASS" ]; then
    echo "Invalid profile configuration: $1"
    exit 1
fi

# Run openconnect initially, providing only the password
# echo -n "$PASS" | openconnect --protocol=nc --no-dtls $SERVER -u $USER --passwd-on-stdin 


# Capture the process ID of the last background command
# OC_PID=$!

# Use expect with a here document to send OTP directly

# expect <<EOF
#   set timeout 10
#   spawn sleep 5
#   send -s SIGUSR2 $OC_PID
#   send "$OTP\n"
#   interact
# EOF
