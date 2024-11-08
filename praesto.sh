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

    # Use curl to check if the website is online and measure response time
    response_time=$(curl -o /dev/null -s -w '%{time_connect}\n' "https://$website")

    if [ $? -eq 0 ]; then
        # Convert response time from seconds to milliseconds
        response_time_ms=$(echo "$response_time * 1000" | bc)
        website_message="$current_time - $website is online with response time ${response_time_ms} ms"
        echo "$website_message" | tee -a "$log_file"
    else
        website_message="$current_time - $website is offline or not reachable via HTTP/HTTPS"
        echo "$website_message" | tee -a "$log_file"
    fi
else
    # Message for no internet connection
    no_internet_message="$current_time - NOK - Not connected to the Internet"
    echo "$no_internet_message" | tee -a "$log_file"
fi
