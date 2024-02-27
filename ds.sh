#!/bin/bash

# Get the current directory
folder_path=$(pwd)

# Function to upload files to Telegram
upload_to_telegram() {
    local file="$1"
    # Upload the file to Telegram using telegram-upload
    telegram-upload "$file"
}

# Function to zip folders and upload them to Telegram
zip_and_upload() {
    local folder="$1"
    local zip_filename="${folder}.zip"
    # Zip the folder
    zip -r "$zip_filename" "$folder"
    # Upload the zip file to Telegram
    upload_to_telegram "$zip_filename"
    # Remove the zip file after uploading
    rm "$zip_filename"
}

# Iterate over each item in the current directory
for item in "$folder_path"/*; do
    # Check if the item is a regular file
    if [ -f "$item" ]; then
        # Upload regular files to Telegram
        upload_to_telegram "$item"
    elif [ -d "$item" ]; then
        # If the item is a directory, zip it and upload
        zip_and_upload "$item"
    fi
done

