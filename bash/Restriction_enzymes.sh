#!/bin/bash

# Input string
input="GATCAAAAGATCAAAAAAAAAAAAAAAAAAAAAAAAGATC"

# Substring to search for
substring="GATC"

# Find all occurrences of the substring
start=0
while [[ $input =~ $substring ]]; do
    # Extract the matched substring and its position
    match="${BASH_REMATCH[0]}"
    position=${BASH_REMATCH[@]}
    
    # Output the match and its position
    echo "Match: $match"
    echo "Position: $((start + ${#input} - ${#position}))"

    # Update the start index for the next search
    start=$((start + ${#input} - ${#position} + 1))

    # Remove the matched substring to continue searching
    input="${input#*$match}"
done


