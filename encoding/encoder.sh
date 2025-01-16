#!/bin/bash
if [ "$#" != "1" ]; then
	echo "Usage: $0 <encoding>"
	exit 1
fi

ENCODING="$1"
ROOT=$(cd "${0%/*}" && echo $PWD)
PRESET="$(cat $ROOT/preset)"
ENCODER="$($ROOT/$PRESET $ENCODING)"
echo "$ENCODER"
