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

ROOT=$(cd "${0%/*}" && echo $PWD)
FILETYPE="$(file --mime-type -b $FILE)"
if [ "$FILETYPE" != "video/mp4" ]; then
	NEW="$($ROOT/recontainerise.sh $FILE)"
	if [ "$NEW" == "ERROR" ]; then
		echo "$FILE is not a video."
		exit 1
	fi
	FILE="$NEW"
fi

# transcode into h264, h265, mpeg4, vp8, vp9, mpeg1, and mpeg2
STRIPPED=${FILE%.*}
ENCODING="$($ROOT/identify.sh $FILE)"
TRANSCODE="$ROOT/transcode.sh"

NEW_FILE="${STRIPPED}_${ENCODING}.mp4"
CODECS=("$ENCODING")
process() {
	NEW_ENCODING="$1"
	EXTENSION="$2"
	if [ "$ENCODING" == "$NEW_ENCODING" ]; then
		return 0
	fi

	$TRANSCODE "$NEW_ENCODING" "$NEW_FILE" "${STRIPPED}_${NEW_ENCODING}.${EXTENSION}" &>/dev/null
	CODECS+=( "$NEW_ENCODING" )
	return 0
}


mv "$FILE" "$NEW_FILE"
process h264 mp4
process h265 mp4
process mpeg4 mp4
process vp8 webm
process vp9 mp4
process mpeg1video mp4
process mpeg2video mp4

CODECS_JSON=$(printf "%s\n" "${CODECS[@]}" | jq -R . | jq -c -s .)
echo "{\"codec\":${CODECS_JSON},\"chrome\":\"h265\",\"firefox\":\"h264\"}"
