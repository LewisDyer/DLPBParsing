#!/bin/bash

# set the input file name and the output directory
input_file="path/to/large_file.json"
output_dir="path/to/output_dir/"

# split the input file into multiple files with a prefix
split -l 100000 --additional-suffix=".json" "$input_file" "$output_dir/file_"

# count the number of split files and subtract one to get the index of the last file
num_files=$(ls "$output_dir" | grep -c "file_")
last_file_index=$((num_files - 1))

# loop through the split files and modify them to be valid JSON arrays
for i in $(seq 0 $last_file_index); do
  input_path="$output_dir/file_$(printf "%02d" $i).json"
  output_path="$output_dir/file_$(printf "%02d" $i)_modified.json"

  # add a '[' at the beginning of each file except for the first one
  if [[ $i -gt 0 ]]; then
    echo "[" > "$output_path"
  fi

  # copy the contents of the input file to the output file
  cat "$input_path" >> "$output_path"

  # add a ']' at the end of each file except for the last one
  if [[ $i -lt $last_file_index ]]; then
    echo "]" >> "$output_path"
  fi
done