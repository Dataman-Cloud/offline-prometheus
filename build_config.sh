#!/bin/bash

set -eu


#export LC_CTYPE=C

replace_var(){
	LIST=""
	for i in $(cat /tmp/prometheus-hosts)
	do
		LIST=${LIST}" ""'"${i}"'"
	done
	TARGETS=$(echo $LIST|sed "s/ /,/g")
	echo $TARGETS
	files=$@
	echo $files | xargs sed -i 's#--TARGETS--#'$TARGETS'#g'
}

preconfigserver_conf(){
	    rm -rf conf_d_tmp
            cp -rf conf_d.temp conf_d_tmp

	    files=`grep -rl '' conf_d_tmp/*`
	    replace_var $files
            rm -rf conf.d
            mv conf_d_tmp conf.d
}

preconfigserver_conf
