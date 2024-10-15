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

   To clone the repository:

   ```bash
   git clone https://github.com/anthonyborriello/fast-sms.git
   cd FastSMS
   ```

   Or, to download the script directly using `wget`:

   ```bash
   wget https://github.com/anthonyborriello/fast-sms/raw/main/fastsms.sh
   ```

2. Make the script executable:

   ```bash
   chmod +x fastsms.sh
   ```

3. (Recommended) Create a configuration file for Gammu. To speed up the script's execution, it is recommended to create a file named gammurc in the /etc directory. You can do this using the following command:

   ```bash
  sudo nano /etc/gammurc
   ```

## Usage

Run the script using the following command:

```bash
./fastsms.sh
```

Follow the prompts to enter the message text and the destination phone number.

## Logging

All sent messages and their details will be logged in a file named `sms_log.txt` located in your home directory.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Antonio Borriello  
[antonioborriello.wordpress.com](https://antonioborriello.wordpress.com)
