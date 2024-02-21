#!/bin/bash

# Check if lsof command is available
if ! command -v lsof > /dev/null 2>&1; then
    echo "lsof command not found. Please install lsof."
    exit 1
fi

# Get the list of ports starting with 30 or 70 and having 4 digits
PORTS=$(lsof -i -P -n | grep -E ":3[07][0-9]{2}" | awk '{print $9}' | cut -d ':' -f 2 | sort -u)

if [ -z "$PORTS" ]; then
    echo "No processes found using ports starting with 30 or 70 and having 4 digits"
else
    # Get the process ID(s) for each port and kill them
    for PORT in $PORTS; do
        PIDS=$(lsof -i -P -n | grep -E ":$PORT" | awk '{print $2}')
        if [ -n "$PIDS" ]; then
            kill -9 $PIDS
            echo "Killed processes using port $PORT"
        fi
    done
fi
