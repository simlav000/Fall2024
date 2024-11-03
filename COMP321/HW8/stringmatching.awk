#!/bin/bash

while true; do
    read pattern
    read text

    # Exit loop if both inputs are empty
    if [ -z "$text" ] && [ -z "$pattern" ]; then
        break
    fi

    echo "$text" | awk -v pattern="$pattern" '
    {
        start = 1
        indices = ""
        # Loop until no matches are found. We keep moving the start variable
        # further down the line after each match using substr()
        while ((match(substr($0, start), pattern)) > 0) {
            # Check to see if indices is nonempty. If nonempty, append space 
            # immediately before the index.
            # start: begins at index 0 of original string. 
            # RSTART: 1-based index of match in substring
            # start + RSTART - 1: 0-based index of match in original string
            indices = indices (indices ? " " : "") start + RSTART - 2
            start += RSTART
        }
        if (indices) {
            print indices
        }
        else {
            print ""
        }
    }'
done
