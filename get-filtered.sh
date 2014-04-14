#!/bin/sh

SHOWS=`cat my-shows`

RECENT=`./get-recent.sh`

LAUNCH='/c/Program Files (x86)/uTorrent/uTorrent.exe'

for show in $SHOWS; do
	echo --- $show ---
	for recent in $RECENT; do
		if echo $recent | grep $show; then
			echo $recent
			"${LAUNCH}" $recent
		fi
	done
done | grep -v 720p | uniq
