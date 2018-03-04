#!/bin/bash

cat /tmp/config.json \
	| sed s/SENSU_SERVER/${SENSU_SERVER}/g \
	| sed s/SENSU_USER/${SENSU_USER}/g \
	| sed s/SENSU_PASSWORD/${SENSU_PASSWORD}/g > /etc/sensu/config.json 

cat /tmp/client.json \
	| sed s/CLIENT_NAME/${CLIENT_NAME}/g \
	| sed s/CLIENT_IP_ADDRESS/${CLIENT_IP_ADDRESS}/g > /etc/sensu/conf.d/client.json


/opt/sensu/bin/sensu-client
