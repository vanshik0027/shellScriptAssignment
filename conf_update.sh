#!/bin/bash

# Function to validate user input
validate_input() {
    local input="$1"
    local options="$2"
    local valid=false

    for option in ${options//\// }; do
        if [ "${input,,}" == "${option,,}" ]; then  # Convert input and option to lowercase for comparison
            valid=true
            break
        fi
    done

    if [ "$valid" == false ]; then
        return 1  # Return error status
    fi
}

# Function to prompt user for input
prompt_user() {
    local message="$1"
    local options="$2"
    local input

    while true; do
        read -p "$message: " input
        input=$(echo "$input" | tr '[:upper:]' '[:lower:]')  # Convert input to lowercase
        options=$(echo "$options" | tr '[:upper:]' '[:lower:]')  # Convert options to lowercase
        if validate_input "$input" "$options"; then
            echo "$input"
            break
        else
            echo "Invalid input. Please enter one of the options: $options" >&2  # Print error message to stderr
        fi
    done
}

# Main script

echo "Component:- INGESTOR/JOINER/WRANGLER/VALIDATOR"
echo
echo "Scale:- MID/HIGH/LOW" 
echo
echo "View:- Auction/Bid"
echo
echo "Count:- [0-9]"

# Prompt user for inputs
component=$(prompt_user "Component Name" "INGESTOR/JOINER/WRANGLER/VALIDATOR") || exit 1
scale=$(prompt_user "Scale" "MID/HIGH/LOW") || exit 1
view=$(prompt_user "View" "AUCTION/BID") || exit 1
count=$(prompt_user "Count (single digit number)" "0 1 2 3 4 5 6 7 8 9") || exit 1

# Handle special cases for view
if [ "${view,,}" == "auction" ]; then
    view="vdopiasample"
elif [ "${view,,}" == "bid" ]; then
    view="vdopiasample-bid"
fi

# Convert inputs to uppercase
component_upper=$(echo "$component" | tr '[:lower:]' '[:upper:]')
scale_upper=$(echo "$scale" | tr '[:lower:]' '[:upper:]')
view_upper=$(echo "$view" | tr '[:lower:]' '[:upper:]')

# Get current date and time
datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Create the new line for the conf file
new_line="$view_upper ; $scale_upper ; $component_upper ; ETL ; vdopia-etl= $count ; $datetime"

# Check if the file exists
if [ -f "sig.conf" ]; then
    # Append the new line to the file
    echo "$new_line" > sig.conf
    echo "New line added successfully"
else
    echo "Error: sig.conf file not found."
fi

