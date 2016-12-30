#!/usr/bin/bash

xinput='/usr/bin/xinput'
grep='/usr/bin/grep'
id=`${xinput} list | ${grep} TouchPad | ${grep} -Po 'id=\K[^\s]*'`

case "$1" in
	on)
		echo "Setting touch pad on"
		${xinput} set-prop ${id} 'Device Enabled' 1
		;;
	off)
		echo "Setting touch pad off"
		${xinput} set-prop ${id} 'Device Enabled' 0
		;;
	*)
		echo "Usage: $0 [on|off]"
esac

