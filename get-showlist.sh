#!/bin/sh

wget http://eztv.it/showlist -O - \
	| grep thread_link \
	| sed -E 's@.* href="([^"]+)" class="thread_link">([^<]+)</a></td>@{"name":"\2" "link":"\1"}@'

