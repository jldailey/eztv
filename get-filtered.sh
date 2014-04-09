#!/bin/sh

SHOWS=`cat my-shows`

RECENT=`./get-recent.sh`

for show in $SHOWS; do
	echo --- $show ---
	for recent in $RECENT; do
		if echo $recent | grep $show; then
			echo $recent
		fi
	done
done | grep -v 720p | uniq
