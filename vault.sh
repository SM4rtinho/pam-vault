#!/bin/bash

CREDENTIALS_FILE="vault.db"

encrypt() {
    echo "$1" | openssl enc -aes-256-cbc -a -salt -pass pass:"$MASTER_PASSWORD"
}

decrypt() {
    echo "$1" | openssl enc -aes-256-cbc -a -d -salt -pass pass:"$MASTER_PASSWORD" 2>/dev/null
}

add_credential() {
    read -p "Enter service name: " service
    read -p "Enter username: " username
    read -sp "Enter password for $username@$service: " password
    echo
    encrypted_password=$(encrypt "$password")
    echo "$service:$username:$encrypted_password" >> "$CREDENTIALS_FILE"
    echo "Credential saved for $service."
}

list_credentials() {
    echo "Saved credentials:"
    while IFS=: read -r service username encrypted; do
        decrypted_pass=$(decrypt "$encrypted")
        echo "$service | $username | $decrypted_pass"
    done < "$CREDENTIALS_FILE"
}

cleanup() {
    # Clear the master password from memory when exiting
    MASTER_PASSWORD=""
    echo -e "\nClearing sensitive data and exiting..."
}

# Set trap to clean up on exit
trap cleanup EXIT

# Create credentials file if it doesn't exist
touch "$CREDENTIALS_FILE"

# Set master password once at the start
echo -n "Set a master password: "
read -s MASTER_PASSWORD
echo

while true; do
    echo
    echo "1. Add credential"
    echo "2. List credentials"
    echo "3. Exit"
    read -p "Choose an option: " option

    case $option in
        1) add_credential ;;
        2) list_credentials ;;
        3) echo "Bye!"; exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done
