#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./append_lesson.sh <input.json>"
  exit 1
fi

INPUT_JSON="$1"
HTML_FILE="index.html"

if [ ! -f "$INPUT_JSON" ]; then
  echo "Error: File '$INPUT_JSON' not found!"
  exit 1
fi

if [ ! -f "$HTML_FILE" ]; then
  echo "Error: File '$HTML_FILE' not found in current directory!"
  exit 1
fi

# Use awk to find the end of the `const INIT = [` array and insert the JSON
awk -v json_file="$INPUT_JSON" '
  # When we hit the start of the array, set a flag
  /const INIT = \[/ { in_init=1 }
  
  # When we hit the closing bracket of that array
  /^[ \t]*\];/ && in_init {
    # 1. Read and print the entire JSON file
    while ((getline line < json_file) > 0) {
      print "        " line
    }
    # 2. Add a trailing comma in case there are more inputs later
    print "        ,"
    
    # Reset flag so we only do this once
    in_init=0
  }
  
  # Print the original line from index.html
  { print }
' "$HTML_FILE" > tmp_index.html && mv tmp_index.html "$HTML_FILE"

echo "✅ Appended $INPUT_JSON into $HTML_FILE"
