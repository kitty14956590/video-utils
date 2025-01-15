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

ROOT=$(cd "${0%/*}" && echo $PWD)
ENCODING="$($ROOT/identify.sh $FILE)";
if [ "$ENCODING" == "hevc" ]; then
	echo "yes"
	exit 0
fi
echo "no"
