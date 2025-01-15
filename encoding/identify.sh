#!/bin/bash

if [ "$#" != "1" ]; then
	echo "Usage: $0 <video>"
	exit 1
fi

FILE="$1"
if [ ! -f "$FILE" ]; then
	echo "File $FILE does not exist."
	exit 1
fi

FILETYPE="$(file --mime-type -b $FILE)"
if [ "$FILETYPE" != "video/mp4" ]; then
	echo "$FILE is not a video."
	exit 1
fi

ENCODING="$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=nokey=1:noprint_wrappers=1 $FILE)";
echo "$ENCODING"
