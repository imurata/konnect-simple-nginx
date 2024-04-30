#!/bin/bash
set -x
. konnect-env.sh

if [ -z "$DECK_NGINX_HOST" -o -z "$DECK_NGINX_PORT" ]; then
	echo "set DECK_NGINX_HOST and DECK_NGINX_PORT"
	exit 1
fi

which deck > /dev/null 2>&1
if [ $? -ne 0 ]; then
	if [ "$(uname)" == "Darwin" ]; then
		brew tap kong/deck
		brew install deck
	else
		curl -sL https://github.com/kong/deck/releases/download/v1.36.1/deck_1.36.1_linux_amd64.tar.gz -o deck.tar.gz
		tar -xf deck.tar.gz -C /tmp
		sudo mv /tmp/deck /usr/local/bin/
	fi
fi

deck gateway sync nginx-deck.yaml --konnect-token=$KONNECT_TOKEN
