#!/bin/bash
if [ "$#" != "1" ]; then
	echo "Usage: $0 <encoding>"
	exit 1
fi

ENCODING="$1"
if [ "$ENCODING" == "hevc" ] || [ "$ENCODING" == "h265" ]; then
	echo "hevc_nvenc"
	exit 0
fi

if [ "$ENCODING" == "h264" ]; then
	echo "h264_nvenc"
	exit 0
fi

echo "$ENCODING"
