#!/bin/bash

input_file="input.fasta"
output_directory="output"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Split the input file into individual FASTA records
awk '/^>/{filename=sprintf("%s.fasta",substr($0,2));}{print > filename;}' "$input_file"

# Remove the leading ">" character from the generated files
for file in $output_directory/*.fasta; do
    sed -i 's/^>//' "$file"
done

echo "FASTA file split complete."
