#!/bin/bash

## CONFIGS
IP_CHECK=${IP_CHECK:-208.67.222.222} #opendns
GW1=${GW1:-192.168.1.1}
GW2=${GW2:-192.168.2.1}
PING_TIMEOUT=${PING_TIMEOUT:-2}
IF1=${IF1:-eth0}
IF2=${IF2:-eth0}
TIME=`date +%b' '%d' '%T`
#########

CURRENT_GW="$(ip route get $IP_CHECK | sed -rn 's/^.*via ([^ ]*).*$/\1/p')"

ping -c 2 -W $PING_TIMEOUT $IP_CHECK > /dev/null
IS_GW_OFFLINE=$?

if [ "$IS_GW_OFFLINE" == "1" ]
then
	echo "$TIME: GW $CURRENT_GW offline!"
    if [ "$CURRENT_GW" != "$GW2" ]
	then
        ip route del default
        ip route add default via "$GW2" dev "$IF2"
	#ip route flush cache
	echo "$TIME: change gw $CURRENT_GW -> $GW2"

    elif [ "$CURRENT_GW" != "$GW1" ]
	then
        ip route del default
        ip route add default via "$GW1" dev "$IF1"
	#ip route flush cache
	echo "$TIME: change gw $CURRENT_GW -> $GW1"
    fi
else
	echo "$TIME: GW $CURRENT_GW online!"
fi
