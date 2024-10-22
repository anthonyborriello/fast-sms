#!/bin/bash

# Fast SMS Installer and Configurator (Powered by Gammu and ModemManager)

FASTSMS_URL="https://github.com/anthonyborriello/fast-sms/raw/main/fastsms.sh"
SMS_TEST_URL="https://github.com/anthonyborriello/fast-sms/raw/main/sms_test.sh"
FASTSMS_NAME="fastsms.sh"
SMS_TEST_NAME="sms_test.sh"
GAMMU_CONFIG="/etc/gammurc"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a package if it doesn't exist
install_package() {
    local package="$1"
    if command_exists "$package"; then
        echo "$package is already installed."
    else
        echo "$package is not installed. Installing..."
        sudo apt update
        sudo apt install -y "$package"
        if [ $? -eq 0 ]; then
            echo "$package installed successfully."
        else
            echo "Failed to install $package. Please check your system settings."
            exit 1
        fi
    fi
}

# Function to download scripts
download_scripts() {
    # Download Fast SMS script
    echo "Downloading Fast SMS script..."
    wget -O "$FASTSMS_NAME" "$FASTSMS_URL"
    if [ $? -eq 0 ]; then
        echo "Script downloaded successfully as $FASTSMS_NAME."
        chmod +x "$FASTSMS_NAME"
        echo "Script is now executable."
    else
        echo "Failed to download Fast SMS script. Please check your internet connection or the URL."
        exit 1
    fi

    # Download SMS test script
    echo "Downloading SMS Test script..."
    wget -O "$SMS_TEST_NAME" "$SMS_TEST_URL"
    if [ $? -eq 0 ]; then
        echo "Script downloaded successfully as $SMS_TEST_NAME."
        chmod +x "$SMS_TEST_NAME"
        echo "SMS Test script is now executable."
    else
        echo "Failed to download SMS Test script. Please check your internet connection or the URL."
        exit 1
    fi
}

# Function to check for connected modems
check_modem() {
    echo "Checking for connected modems..."
    modem_info=$(mmcli -L 2>/dev/null)
    if [[ $? -eq 0 && "$modem_info" != "" ]]; then
        echo "Modem detected:"
        echo "$modem_info"
        return 0
    else
        echo "No modem detected or ModemManager is not running."
        return 1
    fi
}

# Function to configure Gammu
configure_gammu() {
    echo "Configuring Gammu..."

    # Detect supported modems first
    if echo "$modem_info" | grep -q -e "E3531" -e "MF627" -e "K3765" -e "MF110" -e "MF636"; then
        device="/dev/ttyUSB0"
        echo "Supported modem found. Using $device."
    elif echo "$modem_info" | grep -q "GTM382"; then
        device="/dev/ttyHS2"
        echo "GTM382 modem found. Using $device."
    else
        device="/dev/ttyUSB0"
        echo "No supported modem found. Defaulting to $device."
    fi

    # Write to the gammurc file
    if [[ ! -f "$GAMMU_CONFIG" ]]; then
        echo "Creating $GAMMU_CONFIG configuration file."
        sudo bash -c "cat > $GAMMU_CONFIG" <<EOL
[gammu]
device = $device
connection = at
EOL
        echo "Gammu configuration written to $GAMMU_CONFIG."
    else
        echo "Gammu configuration file already exists. Please check $GAMMU_CONFIG if there are issues."
    fi
}

# Main execution
install_package "gammu"
install_package "ModemManager"

if check_modem; then
    configure_gammu
else
    echo "No modem found. Please connect a supported modem and rerun the script."
    exit 1
fi

download_scripts

echo "Installation and configuration completed. You can now run the scripts with:"
echo "./$FASTSMS_NAME"
echo "./$SMS_TEST_NAME" <phone number>
echo
echo -e "\033[32mIMPORTANT: The file /etc/gammurc is crucial for Gammu's functionality. If Gammu does not work as expected,\033[0m"
echo -e "\033[32mplease edit /etc/gammurc and ensure the 'device' parameter matches the correct tty port for your modem.\033[0m"
echo -e "\033[32mFor example, if the default /dev/ttyUSB0 does not work, try changing it to /dev/ttyS0 or /dev/ttyHS2.\033[0m"
echo -e "\033[32mYou can modify the file using the following command:\033[0m"
echo -e "\033[32msudo nano /etc/gammurc\033[0m"
