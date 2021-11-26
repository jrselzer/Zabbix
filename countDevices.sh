#!/bin/bash -x
ZSERVER=10.19.69.1
ZAGENT="10.19.69.71"
AGENTCONF=/etc/zabbix/zabbix_agentd.conf

SUBNET[0]="192.168.10.0/24"
NAME[0]="hotel"
SUBNET[1]="192.168.4.255/22"
NAME[1]="seminar"

for i in 0
do
	RESULT=`nmap -sn ${SUBNET[$i]} | grep -c "Host is up"`

	zabbix_sender -z ${ZSERVER} \
		-s "${ZAGENT}" \
		-k devices.${NAME[$i]} \
		-o ${RESULT} \
		-c ${AGENTCONF} -vv
done
