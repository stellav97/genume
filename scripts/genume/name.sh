#!/bin/bash

# testing list values
git log --pretty="VALUES BAS authors \"%an %ce\"" | sort | uniq | grep -v noreply

# testing changing values
echo VALUE BAS date \"$(date)\"
