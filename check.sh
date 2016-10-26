#!/bin/bash

function check_port(){
	name=$1
	port=$2
	netstat -lntp|grep $port &>/dev/null&& echo "$name is ok" || (echo "$name is error";exit 1)
}

check_port grafana 3000
check_port prometheus 9090
check_port prometheus 9093
