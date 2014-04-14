#!/bin/sh

wget -q http://eztv.it/ -O - \
	| grep dn= \
	| sed -E 's@.* href="(magnet:[^"]+)" class="magnet" title="Magnet Link"></a>.*@\1@'
	| grep -v 720p
	# | sed -E 's@.*dn=([^&]+)&.*@\1@'
