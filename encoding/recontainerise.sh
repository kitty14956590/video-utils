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
if [ "$FILETYPE" != "video/mp4" ] && [ "$FILETYPE" != "video/webm" ] && [ "$FILETYPE" != "video/x-matroska" ] && [ "$FILETYPE" != "video/ogg" ] && [ "$FILETYPE" != "video/quicktime" ]; then
	echo "$FILE is not a video."
	exit 1
fi

if [ "$FILETYPE" == "video/mp4" ]; then
	echo "$FILE"
	exit 0
fi

# we only accept mp4 and vp8 webms, so recontainerise everything else
STRIPPED=${FILE%.*}
ROOT=$(cd "${0%/*}" && echo $PWD)
ENCODING="$($ROOT/identify.sh $FILE)"
TRANSCODE="$ROOT/transcode.sh"
if [ "$FILETYPE" == "video/webm" ] && [ "$ENCODING" == "vp8" ]; then
        echo "$FILE"
        exit 0
fi

$TRANSCODE "h264" "$FILE" "${STRIPPED}.mp4" &>/dev/null
rm "$FILE" # ?
echo "${STRIPPED}.mp4"
