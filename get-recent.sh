#!/bin/sh

wget -q http://eztv.it/ -O - \
	| grep dn= \
	| sed -E 's@.* href="(magnet:[^"]+)" class="magnet" title="Magnet Link"></a>.*@\1@'
	# | sed -E 's@.*dn=([^&]+)&.*@\1@'
