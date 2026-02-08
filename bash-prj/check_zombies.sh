#!/bin/bash

echo "Checking for zombie processes..."
echo

# Get all zombie PIDs
zombie_pids=$(ps -eo pid,ppid,state,cmd | awk '$3 == "Z" {print $1}')

if [ -z "$zombie_pids" ]; then
    echo "No zombie processes found."
    exit 0
fi

echo "Zombie processes detected:"
echo "--------------------------------------------"

# Loop through each zombie PID and print details
for pid in $zombie_pids; do
    # Get zombie details
    zombie_info=$(ps -o pid=,ppid=,state=,cmd= -p "$pid")

    # Extract parent PID
    ppid=$(echo "$zombie_info" | awk '{print $2}')

    # Get parent process info
    parent_info=$(ps -o pid=,state=,cmd= -p "$ppid")

    echo "Zombie Process:"
    echo "  $zombie_info"
    echo
    echo "Parent Process:"
    echo "  $parent_info"
    echo "--------------------------------------------"
done

