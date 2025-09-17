#!/bin/bash

# build files in playground
RESULT_RECORD=$HOME/Desktop/bash_pp/playground/
mkdir -p $RESULT_RECORD
touch ~/Desktop/bash_pp/playground/20230917_abc.txt  ~/Desktop/bash_pp/playground/20230917_abc.zip
echo "RAMDUMP" > ~/Desktop/bash_pp/playground/20230917_abc.txt

scan_files()
{
	local record_files=$(find "$RESULT_RECORD" -name "*.txt")

	for record_file in $record_files; do
		local filename=$(basename -- "$record_file")
		local timestamp="${filename%%_*}"
		local zip_file=$(find "$RESULT_RECORD" -maxdepth 1 -type f -name "${timestamp}_*.zip")

		if [ -f "$zip_file" ]; then
			echo "$filename"
			echo $timestamp
			if grep -q "RAMDUMP" "$record_file"; then
				echo "Please manually delete RAMDUMP"
			fi
			rm "$zip_file" "$record_file"
		else
			echo "Error: Failed to create record from file: $record_file"
		fi
	done
}

scan_files

