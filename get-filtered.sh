#!/bin/sh

echo Loading a list of shows I like...
SHOWS=`cat my-shows`

echo Downloading a list of recent shows...
RECENT=`./get-recent.sh`
COUNT=`echo ${RECENT} | wc -l`
echo Done. Found ${COUNT} unfiltered episodes. 

LAUNCH='/c/Program Files (x86)/uTorrent/uTorrent.exe'

for show in $SHOWS; do
	echo --- $show ---
	for recent in $RECENT; do
		if echo $recent | grep $show; then
			echo $recent
			"${LAUNCH}" $recent &
		fi
	done
done
