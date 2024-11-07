#!/bin/bash

# Define the log file
log_file="praestoLog.txt"
service="google.com"

# Get the current date and time
current_time=$(date '+%Y-%m-%d %H:%M:%S')

# Check internet connection by pinging Google
ping -c 1 -q $service &> /dev/null
if [ $? -eq 0 ]; then
    echo "$current_time : Status OK! Connected to the Internet!" >> "$log_file"

    # Prompt user for the website to check
    echo "Enter the website you want to check: "
    read website

    # Check if the specified website is online
    ping -c 1 -q "$website" &> /dev/null
    if [ $? -eq 0 ]; then
        # Extract response time
        response_time=$(ping -c 1 "$website" | grep 'time=' | sed 's/.*time=\(.*\) ms/\1/')
        echo "$current_time - $website is online with ping $response_time ms" >> "$log_file"
    else
        echo "$current_time - $website is offline" >> "$log_file"
    fi
else
    echo "$current_time - NOK - Not connected to the Internet" >> "$log_file"
fi
