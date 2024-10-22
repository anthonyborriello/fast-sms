# Fast SMS (Powered by Gammu)

A Bash script to send SMS messages using Gammu. This script allows users to quickly send text messages through a modem connected to their system.

## Features

- **Send SMS**: Easily send SMS to any destination number in international format.
- **ICCID and Operator Information**: Automatically retrieves and displays ICCID and operator name from the connected modem.
- **Logging**: Logs details of sent messages, including timestamps, to a log file.

## Prerequisites

To use this script, you need:
- A USB modem or a GSM module connected to your system (e.g., Huawei E-3531, ZTE MF-627, Huawei K3765, or Huawei E392 for LTE).
- [Gammu](https://wammu.eu/gammu/) installed on your system. (e.g., `sudo apt install gammu`)
- Modem Manager installed.
- The install script will automatically detect if Gammu and Modem Manager are installed, and if not, it will install them for you.  
It will also check for connected modems and configure Gammu accordingly. You can modify the Gammu configuration file later by doing: `sudo nano /etc/gammurc`.

## Installation

To install the script, run the following command:

```bash
sudo bash -c "$(wget -O - https://github.com/anthonyborriello/fast-sms/raw/main/install_fastsms.sh)"
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

## Read and delete received SMS

Use Gammu commands

```bash
sudo gammu getallsms
```
The SMS messages are stored in specific folders from `1 to 3`; it depends on the device.

```bash
sudo gammu deleteallsms 1 
```

## Test script

`sms_test.sh` can be used to quickly test Gammu.  
Usage:

```bash
./smstest.sh +390123456789 
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Antonio Borriello [antonioborriello.wordpress.com](https://antonioborriello.wordpress.com)

![github_test](https://github.com/user-attachments/assets/6a74254e-2343-4573-bdeb-54d6ba5be1a2)



