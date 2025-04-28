#!/bin/bash

# This script will display all 256 colors available in your terminal with both foreground and background color options.

echo -e "Displaying all 256 colors with both foreground and background options:\n"

# Loop through all 256 color codes
for i in {0..255}; do
    # Print color code with background and foreground colors
    # The first $i is for the foreground color, the second $i is for the background color
    printf "\033[38;5;${i}m Foreground: ${i} \033[48;5;${i}m Background: ${i} \033[0m"

    # Print a new line every 6 colors for better readability
    if (( (i + 1) % 6 == 0 )); then
        echo
    fi
done

echo -e "\nNote: Foreground colors are shown on the left, and background colors are shown on the right."
