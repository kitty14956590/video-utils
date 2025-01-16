#!/bin/bash
if [ "$#" != "1" ]; then
	echo "Usage: $0 <encoding>"
	exit 1
fi

ENCODING="$1"
if [ "$ENCODING" == "hevc" ] || [ "$ENCODING" == "h265" ]; then
	echo "hevc_vaapi"
	exit 0
fi

if [ "$ENCODING" == "h264" ]; then
	echo "h264_vaapi"
	exit 0
fi

if [ "$ENCODING" == "vp8" ]; then
	echo "vp8_vaapi"
	exit 0
fi

if [ "$ENCODING" == "vp9" ]; then
	echo "vp9_vaapi"
	exit 0
fi

if [ "$ENCODING" == "mpeg2video" ]; then
	echo "mpeg2_vaapi"
	exit 0
fi

echo "$ENCODING"
