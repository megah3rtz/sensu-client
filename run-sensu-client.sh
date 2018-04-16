#!/bin/bash


CLIENT_IP_ADDRESS=$(cat /etc/hosts | tail -n 1 | awk {'print $1'})
HOSTNAME=$(hostname)
CLIENT_NAME="$CLIENT_NAME-$HOSTNAME"

cat /tmp/config.json \
	| sed s/SENSU_SERVER/${SENSU_SERVER}/g \
	| sed s/SENSU_USER/${SENSU_USER}/g \
	| sed s/SENSU_PASSWORD/${SENSU_PASSWORD}/g > /etc/sensu/config.json

cat /tmp/client.json \
	| sed s/CLIENT_NAME/${CLIENT_NAME}/g \
	| sed s/CLIENT_IP_ADDRESS/${CLIENT_IP_ADDRESS}/g > /etc/sensu/conf.d/client.json

cat /tmp/check_http.json \
| sed s/SERVICE_PORT/${SERVICE_PORT}/g \
| sed s/SERVICE_NAME/${SERVICE_NAME}/g > /etc/sensu/conf.d/check_http.json

/opt/sensu/bin/sensu-client
