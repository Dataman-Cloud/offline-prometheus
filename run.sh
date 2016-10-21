#!/bin/bash
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ../config.cfg

CONSUL_DNS=""
for i in $(echo $SRY_MASTER_LIST | sed "s/,/ /g")
do
  x=`expr $x + 1`
  MASTER="MASTER$x"
  eval "${MASTER}=${i}"
done

if [ -f docker-compose.yml ];then
        rm -Rf docker-compose.yml
fi

cp docker-compose.yml.tmp docker-compose.yml
sed -i 's#--CONSUL_DNS_1--#'$MASTER1'#g' docker-compose.yml
if [ "x$MASTER2" != "x" ];then 
	sed -i 's#--CONSUL_DNS_2--#'$MASTER2'#g' docker-compose.yml
fi
if [ "x$MASTER3" != "x" ];then 
	sed -i 's#--CONSUL_DNS_3--#'$MASTER3'#g' docker-compose.yml
fi
sed -i 's#--PROMETHEUS_IP--#'$PROMETHEUS_IP'#g' docker-compose.yml

docker-compose -p dataman up -d
