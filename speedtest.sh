#!/bin/bash

ZSERVER=10.19.69.1
ZAGENT="10.19.69.71"
AGENTCONF=/etc/zabbix/zabbix_agentd.conf
RESULT="`/usr/bin/speedtest-cli --csv`"
IFS=','
read -ra ITEM <<< "${RESULT}"
NAME[0]="ServerID"
NAME[1]="Sponsor"
NAME[2]="ServerName"
NAME[3]="Timestamp"
NAME[4]="Distance"
NAME[5]="Ping"
NAME[6]="download"
NAME[7]="upload"
NAME[8]="Share"
NAME[9]="IPAddress"

for i in 6 7
do
	zabbix_sender -z ${ZSERVER} \
		-s "${ZAGENT}" \
		-k speedtest.${NAME[$i]} \
		-o ${ITEM[$i]} \
		-c ${AGENTCONF} -vv
done
