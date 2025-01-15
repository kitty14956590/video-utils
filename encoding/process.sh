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

#      we want to make a h265 video for (modern) chrome and h264 for firefox
# we also keep the original if its neither so users can manually select it if they wish

STRIPPED=${FILE%.*}
ROOT=$(cd "${0%/*}" && echo $PWD)
ENCODING="$($ROOT/identify.sh $FILE)"
H264_ENCODER="$($ROOT/encoder.sh h264)"
H265_ENCODER="$($ROOT/encoder.sh hevc)"
if [ "$ENCODING" == "hevc" ]; then
	mv "$FILE" "${STRIPPED}_h265.mp4"
	ffmpeg -y -hwaccel auto -i "${STRIPPED}_h265.mp4" -c:v "$H264_ENCODER" -c:a aac "${STRIPPED}_h264.mp4" &>/dev/null
	echo '{"codec":["h264","h265"],"chrome":"h265","firefox":"h264"}';
	exit 0
fi
if [ "$ENCODING" == "h264" ]; then
	mv "$FILE" "${STRIPPED}_h264.mp4"
	ffmpeg -y -hwaccel auto -i "${STRIPPED}_h264.mp4" -c:v "$H265_ENCODER" "${STRIPPED}_h265.mp4" &>/dev/null
	echo '{"codec":["h264","h265"],"chrome":"h265","firefox":"h264"}';
	exit 0
fi
mv "$FILE" "${STRIPPED}_${ENCODING}.mp4"
ffmpeg -y -hwaccel auto -i "${STRIPPED}_${ENCODING}.mp4" -c:v "$H264_ENCODER" -c:a aac "${STRIPPED}_h264.mp4" &>/dev/null
ffmpeg -y -hwaccel auto -i "${STRIPPED}_${ENCODING}.mp4" -c:v "$H265_ENCODER" "${STRIPPED}_h265.mp4" &>/dev/null
echo "{\"codec\":[\"${ENCODING}\",\"h264\",\"h265\"],\"chrome\":\"h265\",\"firefox\":\"h264\"}"
