#!/bin/bash

# Define the log file
log_file="praestoLog.txt"
service="google.com"

# Get the current date and time
current_time=$(date '+%Y-%m-%d %H:%M:%S')

# Check internet connection by pinging Google
ping -c 1 -q $service &> /dev/null
if [ $? -eq 0 ]; then
    # Message for internet connection status
    internet_message="$current_time : Status OK! Connected to the Internet!"
    echo "$internet_message" | tee -a "$log_file"

    # Prompt user for the website to check
    echo "Enter the website you want to check: "
    read website

    # Check if the specified website is online
    ping -c 1 -q "$website" &> /dev/null
    if [ $? -eq 0 ]; then
        # Extract response time
        response_time=$(ping -c 1 "$website" | grep 'time=' | sed 's/.*time=\(.*\) ms/\1/')
        website_message="$current_time - $website is online with ping $response_time ms"
        echo "$website_message" | tee -a "$log_file"
    else
        website_message="$current_time - $website is offline"
        echo "$website_message" | tee -a "$log_file"
    fi
else
    # Message for no internet connection
    no_internet_message="$current_time - NOK - Not connected to the Internet"
    echo "$no_internet_message" | tee -a "$log_file"
fi
