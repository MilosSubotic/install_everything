#!/bin/bash

function usage() {
	echo "Usage: $0 [OPTION] [LATENCY_MSEC]
Loop mic to headphones with latency of LATENCY_MSEC milliseconds.
If LATENCY_MSEC is lacking, default latency is 1000.

-h, --help	display this help and exit

"
}

if [ $# -eq 1 ]
then
	case $1 in
		-h | --help)
			usage
			exit 0
			;;
		*)
			LATENCY_MSEC=$1
			;;
	esac
elif [ $# -eq 0 ]
then
	LATENCY_MSEC=1000
else
	echo "Too many arguments!"
	usage
	exit 1
fi

echo "LATENCY_MSEC=$LATENCY_MSEC"

pactl load-module module-loopback latency_msec=$LATENCY_MSEC
read -n 1 -r -p "Press any key to exit..."
pactl unload-module module-loopback
