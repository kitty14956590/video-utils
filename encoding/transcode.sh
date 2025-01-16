#!/bin/bash
if [ "$#" != "3" ]; then
	echo "Usage: $0 <encoding> <video> <output>"
	exit 1
fi

ENCODING="$1"
INPUT="$2"
OUTPUT="$3"
if [ ! -f "$INPUT" ]; then
	echo "File $FILE does not exist."
	exit 1
fi

FILETYPE="$(file --mime-type -b $INPUT)"
if [ "$FILETYPE" != "video/mp4" ] && [ "$FILETYPE" != "video/webm" ] && [ "$FILETYPE" != "video/x-matroska" ] && [ "$FILETYPE" != "video/ogg" ] && [ "$FILETYPE" != "video/quicktime" ]; then
	echo "$INPUT is not a video."
	exit 1
fi

ROOT=$(cd "${0%/*}" && echo $PWD)
ENCODER="$($ROOT/encoder.sh $ENCODING)"
HWACCEL="-hwaccel auto"
if [[ "$ENCODER" == *"vaapi"* ]]; then
        HWACCEL="-hwaccel vaapi -hwaccel_output_format vaapi -vaapi_device /dev/dri/renderD128"
fi

ffmpeg -y $HWACCEL -i "$INPUT" -c:v "$ENCODER" "$OUTPUT" &>/dev/null
echo "Success!"
