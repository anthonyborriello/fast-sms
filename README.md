# Fast SMS (Powered by Gammu)

A Bash script to send SMS messages using Gammu. This script allows users to quickly send text messages through a modem connected to their system.

## Features

- **Send SMS**: Easily send SMS to any destination number in international format.
- **ICCID and Operator Information**: Automatically retrieves and displays ICCID and operator name from the connected modem.
- **Logging**: Logs details of sent messages, including timestamps, to a log file.

## Prerequisites

To use this script, you need:
- A USB modem connected to your system (e.g., Huawei E-3531, ZTE MF-627, Huawei K3765, or Huawei E392 for LTE).
- [Gammu](https://wammu.eu/gammu/) installed on your system. (e.g., `sudo apt install gammu`)
- Proper configuration of Gammu to use the correct tty device (e.g., `/dev/ttyUSB0`).

## Installation

1. Clone this repository or download the script file directly.

   To clone the repository:

   ```bash
   git clone https://github.com/anthonyborriello/fast-sms.git
   cd fast-sms
    ```

   Or, to download the script directly using `wget`:

   ```bash
   wget https://github.com/anthonyborriello/fast-sms/raw/main/fastsms.sh
   ```

2. Make the script executable:

   ```bash
   chmod +x fastsms.sh
   ```

3. (Recommended) This command will help identify the appropriate device port (e.g., /dev/ttyUSB0, /dev/ttyUSB1)  
or (/dev/ttyHS0 for GSM modules like Waveshare).  
Once identified, create or edit the gammurc file (usually located at /etc/gammurc) to ensure it points to the correct tty device:

   ```
   sudo gammu-detect
   ```
   
   ```
   sudo nano /etc/gammurc
   ```

   ```
   [gammu]
   device = /dev/ttyUSB0
   connection = at
   ```

## Usage

Run the script using the following command:

```bash
./fastsms.sh
```
or

```bash
bash fastsms.sh
```

Follow the prompts to enter the message text and the destination phone number.

## Logging

All sent messages and their details will be logged in a file named `sms_log.txt` located in the same directory of fastsms.sh

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Antonio Borriello  
[antonioborriello.wordpress.com](https://antonioborriello.wordpress.com)
