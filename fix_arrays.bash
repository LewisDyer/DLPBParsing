#!/bin/bash

input_file="dblp_v14.json"
output_dir="splits"

# each file contains 50,000 records
split -d -a 3 -l 50000 --additional-suffix=".json" "$input_file" "$output_dir/file_"

# count the number of split files and subtract one to get the index of the last file
num_files=$(ls "$output_dir" | grep -c "file_")
last_file_index=$((num_files - 1))

# loop through the split files and modify them to be valid JSON arrays
for i in $(seq 0 $last_file_index); do
  input_path="$output_dir/file_$(printf "%03d" $i).json"
  output_path="$output_dir/file_$(printf "%03d" $i)_modified.json"

  # add a '[' at the beginning of each file except for the first one
  if [[ $i -gt 0 ]]; then
    echo "[" > "$output_path"
  fi

  # copy the contents of the input file to the output file
  cat "$input_path" >> "$output_path"

  # remove the comma after the last element of each file, except for the last file
  if [[ $i -lt $last_file_index ]]; then
    sed -i '$s/,$//' "$output_path"
    echo "]" >> "$output_path"
  else
    echo "]" >> "$output_path"
  fi
done