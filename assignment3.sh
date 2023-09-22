#!/bin/bash

echo "enter the path of the file: "
read filepath

if [ -e "$filepath" ]; then
if [ -s "$filepath" ]; then

echo "the file is not empty."
else
echo "the file is empty."
fi
else
echo "file not found: $filepath"
fi
