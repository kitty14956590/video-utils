#!/bin/bash
if [ "$#" != "1" ]; then
	echo "Usage: $0 <encoding>"
	exit 1
fi

ENCODING="$1"
if [ "$ENCODING" == "hevc" ] || [ "$ENCODING" == "h265" ]; then
	echo "hevc" # you may want to use hevc_nvenc or hevc_vaapi for NVIDIA and AMD gpus respectively
	exit 0
fi

if [ "$ENCODING" == "h264" ]; then
	echo "libx264" # you may want to use h264_nvenc or h264_vaapi for NVIDIA and AMD gpus respectively
	exit 0
fi

if [ "$ENCODING" == "vp8" ]; then
	echo "vp8" # you may want to use vp8_vaapi for AMD gpus
	exit 0
fi

if [ "$ENCODING" == "vp9" ]; then
	echo "vp9" # you may want to use vp9_vaapi for AMD gpus
	exit 0
fi

if [ "$ENCODING" == "mpeg2video" ]; then
	echo "mpeg2video" # you may want to use mpeg2_vaapi for AMD gpus
	exit 0
fi

echo "$ENCODING"
