#!/bin/bash
set -x

. ./cp-env.sh
if [ -z "$KONG_CLUSTER_CONTROL_PLANE" ]; then
	echo "undefined env: KONG_CLUSTER_CONTROL_PLANE"
	exit 1
fi

if [ "$1" != "stop" ]; then
docker-compose -f ./docker-compose-dp.yaml up -d
else
docker-compose -f ./docker-compose-dp.yaml down
fi

