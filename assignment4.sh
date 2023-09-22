#!/bin/bash

echo "enter the directory path: "
read dirpath

if [ -d "$dirpath" ]; then

num_files=$(find "$dirpath" -type f)
num_directories=$(find "$dirpath" -type d)

echo "number of files in $dirpath: $num_files"
echo "number of directories in $dirpath: $num_directories"
else
echo "directory not found: $dirpath"
fi
