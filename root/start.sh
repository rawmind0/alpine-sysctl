#!/usr/bin/env bash

KEEP_ALIVE=${KEEP_ALIVE:-"0"}
SYSCTL_KEY=${SYSCTL_KEY:-"vm.max_map_count"}
SYSCTL_VALUE=${SYSCTL_VALUE:-1}
SYSCTL_FORCE=${SYSCTL_FORCE:-0}

if [ -n "${SYSCTL_KEY}" ] && [ "${SYSCTL_VALUE}" -gt "0" ]; then
	VALUE=$(sysctl ${SYSCTL_KEY})
	rc=$?
	if [ "$rc" -eq "0" ]; then

		CURRENT_VALUE=$(echo ${VALUE} | tr -d '[:space:]' | cut -d= -f2)

		if [ "${SYSCTL_FORCE}" -eq "0" ]; then
			if [ "${CURRENT_VALUE}" -lt "${SYSCTL_VALUE}" ]; then
	    		echo `date` $ME - "Updating sysctl key ${SYSCTL_KEY} from ${CURRENT_VALUE} to ${SYSCTL_VALUE} ..."
	    		sysctl -w ${SYSCTL_KEY}=${SYSCTL_VALUE}
				CURRENT_VALUE=$(sysctl ${SYSCTL_KEY} | tr -d '[:space:]' | cut -d= -f2)
	    	else
	    		echo `date` $ME - "Current ${SYSCTL_KEY} value is higher or equal that desired value. ${CURRENT_VALUE} - ${SYSCTL_VALUE}"
	    	fi
	    else 
	    	echo `date` $ME - "Updating sysctl key ${SYSCTL_KEY} from ${CURRENT_VALUE} to ${SYSCTL_VALUE} ..."
	    	sysctl -w ${SYSCTL_KEY}=${SYSCTL_VALUE}
			CURRENT_VALUE=$(sysctl ${SYSCTL_KEY} | tr -d '[:space:]' | cut -d= -f2)
		fi
    	echo `date` $ME - "sysctl key ${SYSCTL_KEY} value ${CURRENT_VALUE} ..."
	else
		echo `date` $ME - "[Error]: Getting sysctl key ${SYSCTL_KEY}"
		exit 1
	fi
else
	echo `date` $ME - "ERROR: You need to define SYSCTL_KEY and SYSCTL_VALUE env variables...."
	exit 1
fi

if [ "x$KEEP_ALIVE" == "x1" ]; then
	trap "exit 0" SIGINT SIGTERM
	while :
	do
		echo `date` $ME - "I'm alive"
		sleep 600
	done
fi

exit 0
