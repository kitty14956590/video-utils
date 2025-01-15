#!/bin/bash

if [ "$#" != "2" ]; then
	echo "Usage: $0 <video> <thumb>"
	exit 1
fi

FILE="$1"
THUMB="$2"
if [ ! -f "$FILE" ]; then
	echo "File $FILE does not exist."
	exit 1
fi

FILETYPE="$(file --mime-type -b $FILE)"
if [ "$FILETYPE" != "video/mp4" ]; then
	echo "$FILE is not a video."
	exit 1
fi

rm -f $THUMB

ffmpeg -i "$FILE" -vf "select=eq(n\,0)" -q:v 3 "$THUMB" &>/dev/null
echo "Generated thumbnail"
