#!/bin/bash
if [ "$#" != "1" ]; then
	echo "Usage: $0 <encoding>"
	exit 1
fi

ENCODING="$1"
if [ "$ENCODING" == "hevc" ]; then
	CHECK="$(ffmpeg -v error -encoders | grep hevc_nvenc)"
	if [ "$CHECK" != "" ]; then
		echo "hevc_nvenc"
		exit 1
	fi
	echo "hevc"
fi

if [ "$ENCODING" == "h264" ]; then
	CHECK="$(ffmpeg -v error -encoders | grep h264_nvenc)"
	if [ "$CHECK" != "" ]; then
		echo "h264_nvenc"
		exit 1
	fi
	echo "libx264"
fi

echo "$ENCODING"
