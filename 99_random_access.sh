#!/bin/bash
set -x
PROXY_HOST=localhost
PROXY_PORT=28000

while : ; do
	curl $PROXY_HOST:$PROXY_PORT
	sleep $(($RANDOM%60))
done
