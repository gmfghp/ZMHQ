#!/bin/sh

#start pppoe-server
sleep 30
if [ -n "$(ps | grep pppoe-server | grep -v grep)" ]
then
	killall pppoe-server
fi
sleep 5
pppoe-server -k -I br-lan

while :
do
	#read the last username in ZMHQpppoe.log
	var_user=$(grep 'user=' /tmp/ZMHQpppoe.log | grep 'rcvd' | tail -n 1)
	var_mac=$(grep 'Connected to' /tmp/ZMHQpppoe.log | grep 'Connected to' | tail -n 1)
	macaddr=${var_mac:13:17}
	name=${var_user#*'"'}
	username=${name%'" password="'*}
	word=${var_user#*'" password="'}
	password=${word%'"'*}
	
	if [ "$username"x != "$username_old"x ]
	then
		var_mac=$(grep 'Connected to' /tmp/ZMHQpppoe.log | grep 'Connected to' | tail -n 1)
		var_user=$(grep 'user=' /tmp/ZMHQpppoe.log | grep 'rcvd' | tail -n 1)
		cat /dev/null > /tmp/ZMHQpppoe.log
		echo "$var_mac" >> /tmp/ZMHQpppoe.log
		echo "$var_user" >> /tmp/ZMHQpppoe.log
		echo "Mac_$macaddr" >> /tmp/ZHMM.log
		echo "$var_user" >> /tmp/ZHMM.log
		uci set network.zmhq.username="$username"
		uci set network.zmhq.password="$password"
		uci commit network
		username_old="$username"
		logger -t zmhq "new username $username"
		sleep 3
	else
		var_mac=$(grep 'Connected to' /tmp/ZMHQpppoe.log | grep 'Connected to' | tail -n 1)
		var_user=$(grep 'user=' /tmp/ZMHQpppoe.log | grep 'rcvd' | tail -n 1)
		cat /dev/null > /tmp/ZMHQpppoe.log
		echo "$var_mac" >> /tmp/ZMHQpppoe.log
		echo "$var_user" >> /tmp/ZMHQpppoe.log
		sleep 5
	fi

done
