#!/bin/bash

set -x 

. konnect-env.sh

#if [ ! -d ./logs ]; then
#	mkdir ./logs
#fi

if [ ! -f "certs/tls.crt" -o ! -f "certs/tls.key"]; then
	echo "Please make tls.crt and tls.key in ./certs dir"
	exit 1
fi

which http > /dev/null 2>&1
if [ $? -ne 0 ]; then
	if [ "$(uname)" == "Darwin" ]; then
		brew install httpie
	else
		curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list > /dev/null
		sudo apt update -y
		sudo apt-get install httpie -y
	fi
fi

CPID=$(https GET https://us.api.konghq.com/v2/control-planes --auth-type=bearer --auth=$KONNECT_TOKEN | jq -r '.data[] | select(.name == "simple-nginx") | .id')
export CPURL="https://us.api.konghq.com/v2/control-planes/$CPID"
export KONG_CLUSTER_CONTROL_PLANE=$(https GET $CPURL --auth-type=bearer --auth=$KONNECT_TOKEN | jq -r '.config.control_plane_endpoint' | cut -c 9-)
export KONG_CLUSTER_TELEMETRY_ENDPOINT=$(https GET $CPURL --auth-type=bearer --auth=$KONNECT_TOKEN | jq -r '.config.telemetry_endpoint' | cut -c 9-)

CERT=$(cat certs/tls.crt)
https POST $CPURL/dp-client-certificates cert="$CERT" --auth-type=bearer --auth=$KONNECT_TOKEN

cat <<EOF > ./cp-env.sh
export CPID=$CPID
export CPURL=$CPURL
export KONG_CLUSTER_CONTROL_PLANE=$KONG_CLUSTER_CONTROL_PLANE
export KONG_CLUSTER_TELEMETRY_ENDPOINT=$KONG_CLUSTER_TELEMETRY_ENDPOINT
EOF



