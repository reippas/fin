#!/bin/bash

# Import the legacy root-level L<n>.json source files into the lessons/
# folder and manifest via append_lesson.sh. Adjust the range as needed.
for i in {18..33}; do
  FILE="L${i}.json"
  if [ -f "$FILE" ]; then
    ./append_lesson.sh "$FILE"
  else
    echo "Warning: $FILE not found, skipping."
  fi
done
