#!/bin/bash

# Fast SMS Installer and Configurator

SCRIPT_URL="https://github.com/anthonyborriello/fast-sms/raw/main/fastsms.sh"
SCRIPT_NAME="fastsms.sh"
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

# Function to download the Fast SMS script
download_script() {
    echo "Downloading Fast SMS script..."
    wget -O "$SCRIPT_NAME" "$SCRIPT_URL"
    if [ $? -eq 0 ]; then
        echo "Script downloaded successfully as $SCRIPT_NAME."
        chmod +x "$SCRIPT_NAME"
        echo "Script is now executable."
    else
        echo "Failed to download the script. Please check your internet connection or the URL."
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

    # Detect if a specific modem model is present
    if echo "$modem_info" | grep -q -e "E3531" -e "MF627" -e "K3765" -e "MF110" -e "MF636"; then
        device="/dev/ttyUSB0"
        echo "Supported modem found. Using $device."
    else
        # Check other available ports in /dev
        if [[ -e /dev/ttyS0 ]]; then
            device="/dev/ttyS0"
            echo "Using /dev/ttyS0 as the modem port."
        elif [[ -e /dev/ttyHS2 ]]; then
            device="/dev/ttyHS2"
            echo "Using /dev/ttyHS2 as the modem port."
        else
            device="/dev/ttyUSB0"
            echo "Defaulting to /dev/ttyUSB0 as the modem port."
        fi
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

download_script

echo "Installation and configuration completed. You can now run the script with:"
echo "./$SCRIPT_NAME"
echo
echo "IMPORTANT: The file /etc/gammurc is crucial for Gammu's functionality. If Gammu does not work as expected,"
echo "please edit /etc/gammurc and ensure the 'device' parameter matches the correct tty port for your modem."
echo "For example, if the default /dev/ttyUSB0 does not work, try changing it to /dev/ttyS0 or /dev/ttyHS2."
echo "You can modify the file using the following command:"
echo "sudo nano /etc/gammurc"
