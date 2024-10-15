#!/bin/bash

# Fast SMS (powered by Gammu)
# Copyright (c) 2024 Antonio Borriello
# Website: https://antonioborriello.wordpress.com
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Function to ask the user to enter the message text
get_message() {
    read -p "Enter the message text: " message
}

# Function to ask the user to enter the destination number
get_destination_number() {
    read -p "Enter the destination phone number (international format, e.g., +39123456): " destination_number
}

# Function to extract ICCID and operator name
get_iccid_and_operator() {
    for modem in {0..3}; do
        iccid=$(sudo mmcli -i $modem 2>/dev/null | grep -oP 'iccid: \K.*')
        operator_name=$(sudo mmcli -i $modem 2>/dev/null | grep -oP 'operator name: \K.*')
        
        # Check if ICCID and operator name were successfully extracted
        if [ -n "$iccid" ] && [ -n "$operator_name" ]; then
            return 0
        fi
    done
    return 1
}

# Function to send the SMS using Gammu
send_sms() {
    echo "$message" | sudo gammu --sendsms TEXT "$destination_number"
}

# Run the interactive script
echo "Welcome! This script allows you to send an SMS using Gammu."

# Extract ICCID and operator name
if ! get_iccid_and_operator; then
    echo "Error: unable to extract ICCID or operator name from any modem."
    exit 1
fi

# Display ICCID and operator name
echo "ICCID: $iccid"
echo "Operator: $operator_name"

# Ask the user to enter the message text
get_message

# Ask the user to enter the destination number
get_destination_number

# Print the message and the destination number entered by the user
echo "You are about to send the following message:"
echo "Message text: $message"
echo "Destination number: $destination_number"

# Ask for user confirmation before sending the SMS
read -p "Do you want to proceed with sending the SMS? (Yes/No): " confirm
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')  # Convert the response to lowercase

if [[ $confirm == "y" || $confirm == "yes" ]]; then
    # Send the SMS and capture the response
    response=$(send_sms)

    # Display the original response from Gammu
    echo "$response"

    # Check if the sending was successful
    if echo "$response" | grep -q "OK"; then
        message_status="SMS sent successfully!"
        message_reference=$(echo "$response" | awk -F'=' '{print $2}' | xargs) # Extract the reference number
    else
        message_status="Message not sent"
        message_reference=""
    fi

    # Write the details to the log
    {
        echo "$(date '+%Y-%m-%d %H:%M:%S') - ICCID: $iccid - Operator name: $operator_name - Message text: $message - Destination number: $destination_number - $message_status ${message_reference:+Message reference=$message_reference}"
    } >> sms_log.txt

    echo "$message_status"
else
    echo "SMS sending canceled."
fi
