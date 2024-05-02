#!/bin/bash
set -x
PROXY_HOST=localhost
PROXY_PORT=28000
ROUTE_ENDPOINT="${PROXY_HOST}:${PROXY_PORT}"

while : ; do
	RUN_TIMES=$(($RANDOM%10))
	for ((i=0; i < $RUN_TIMES; i++)); do
		if [ $i -eq 1 ]; then
			curl $ROUTE_ENDPOINT/error-route > /dev/null 2>&1
		fi
		curl $ROUTE_ENDPOINT > /dev/null 2>&1
		sleep .5
	done
	sleep $(($RANDOM%60))
done
