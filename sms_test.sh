#!/bin/bash

# Check if a phone number was passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <phone number>"
    exit 1
fi

# Check if Gammu is installed
if ! command -v gammu &> /dev/null; then
    echo "Gammu is not installed. Please install it before running the script."
    exit 1
fi

# Phone number passed as an argument
PHONE_NUMBER=$1

# Test message
MESSAGE="This is a test SMS sent using Gammu."

# Send the SMS
gammu sendsms TEXT "$PHONE_NUMBER" -text "$MESSAGE"

# Check if the message was sent successfully
if [ $? -eq 0 ]; then
    echo "SMS successfully sent to $PHONE_NUMBER"
else
    echo "Failed to send SMS"
fi
