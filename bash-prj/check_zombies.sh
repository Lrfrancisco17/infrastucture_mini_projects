#!/bin/bash

echo "Checking for zombie processes..."
echo

# Get all zombie PIDs
zombie_pids=$(ps -eo pid,ppid,state,cmd | awk '$3 == "Z" {print $1}')

if [ -z "$zombie_pids" ]; then
    echo "No zombie processes found."
    exit 0
fi


