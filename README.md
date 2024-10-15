# Fast SMS (Powered by Gammu)

A Bash script to send SMS messages using Gammu. This script allows users to quickly send text messages through a modem connected to their system.

## Features

- **Send SMS**: Easily send SMS to any destination number in international format.
- **ICCID and Operator Information**: Automatically retrieves and displays ICCID and operator name from the connected modem.
- **Logging**: Logs details of sent messages, including timestamps, to a log file.

## Prerequisites

To use this script, you need:
- A modem connected to your system.
- [Gammu](https://wammu.eu/gammu/) installed on your system.
- Proper configuration of Gammu to use the correct tty device (e.g., `/dev/ttyUSB0`).

## Installation

1. Clone this repository or download the script file directly.

   ```bash
   git clone https://github.com/yourusername/FastSMS.git
   cd FastSMS
