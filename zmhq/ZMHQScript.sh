#!/bin/sh

#Check pppoe-Server
if [ -z "$(opkg list-installed | grep "rp-pppoe-server")" ]
then
	echo "Please install PPPoE-Common&PPPoE-Server first"
	exit 0
fi

#change log location & enable debug & show password
sed -i "s/\/dev\/null/\/tmp\/ZMHQpppoe.log/" /etc/ppp/options
sed -i "s/#debug/debug/" /etc/ppp/options
echo "show-password" >> /etc/ppp/options

#set backup
cp /etc/ppp/plugins/rp-pppoe.so /etc/ppp/plugins/rp-pppoe.so.bak
cp /usr/lib/pppd/2.4.7/rp-pppoe.so /etc/ppp/plugins/rp-pppoe.so

#set init script
cp /root/zmhq/ZMHQ /etc/init.d/ZMHQ
chmod +x /etc/init.d/ZMHQ
/etc/init.d/ZMHQ enable
sleep 5
(/etc/init.d/ZMHQ start &)

sleep 1
echo "Rp-pppoe-server OK next set network"

#set network
uci set network.zmhq=interface
uci set network.zmhq.proto=pppoe
uci set network.zmhq.username=username
uci set network.zmhq.password=password
uci set network.zmhq.disabled='1'
uci set network.zmhq.auto='0'
uci commit network

sleep 1
echo "Set network OK"
echo "ZMHQ OK"
