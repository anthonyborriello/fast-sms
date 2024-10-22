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
#
# This is a test script to check if Gammu is working

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
sudo gammu sendsms TEXT "$PHONE_NUMBER" -text "$MESSAGE"

# Check if the message was sent successfully
if [ $? -eq 0 ]; then
    echo "SMS successfully sent to $PHONE_NUMBER"
else
    echo "Failed to send SMS"
fi
