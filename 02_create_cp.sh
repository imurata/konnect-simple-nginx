#!/bin/bash
set -x 
. konnect-env.sh

curl -X POST https://us.api.konghq.com/v2/control-planes \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer $KONNECT_TOKEN" \
   -d '{
    "name":"simple-nginx",
    "description":"Created via API",
    "cluster_type":"CLUSTER_TYPE_HYBRID",
    "labels":{"CreatedBy":"ippei.murata"}
   }'
