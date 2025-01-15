#!/bin/bash
if [ "$#" != "1" ]; then
	echo "Usage: $0 <encoding>"
	exit 1
fi

ENCODING="$1"
if [ "$ENCODING" == "hevc" ]; then
	echo "hevc"
	exit 0
fi

if [ "$ENCODING" == "h264" ]; then
	echo "libx264"
	exit 0
fi

echo "$ENCODING"
