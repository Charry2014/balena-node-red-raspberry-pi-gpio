#!/bin/bash

LOG_FILE=/data/logs/node.log

# This is some nasty hacky log rotation - simply remove the logs file every time the container restarts
rm -rf ${LOG_FILE}
touch ${LOG_FILE}

# Read device information to get the IP address which may be useful
DEVICE_DATA=$(curl -X GET --silent --header "Content-Type:application/json" \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device?apikey=$BALENA_SUPERVISOR_API_KEY")
DEVICE_IP=$(/usr/bin/jq '.ip_address' <<<"${DEVICE_DATA}")
if [[ -z "$DEVICE_IP" ]]; then
  DEVICE_IP="??.??.??.??"
fi

# Tail the logs from the Balena supervisor and spool them into the log file, embellished with useful device information
{
while read -r line; do
    OUT_MESSAGE="{\"ip_address\":${DEVICE_IP},\"device_name\":\"${BALENA_DEVICE_NAME_AT_INIT}\",\"device_type\":\"${BALENA_DEVICE_TYPE}\",\"application\":\"${BALENA_APP_NAME}\",\"message\":\"${line}\"}"
    echo "${OUT_MESSAGE}"
done < <(curl -X POST --silent -H "Content-Type: application/json" --data '{"follow":true,"all":true}' "$BALENA_SUPERVISOR_ADDRESS/v2/journal-logs?apikey=$BALENA_SUPERVISOR_API_KEY")
} > ${LOG_FILE}
