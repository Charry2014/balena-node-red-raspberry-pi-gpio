#!/bin/bash

rm -rf /data/logs/node.log
touch /data/logs/node.log
curl -X POST -H "Content-Type: application/json" --data '{"follow":true,"all":true}' "$BALENA_SUPERVISOR_ADDRESS/v2/journal-logs?apikey=$BALENA_SUPERVISOR_API_KEY" > /data/logs/node.log