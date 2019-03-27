#!/bin/sh

#Check pppoe-Server
if [ -z "$(opkg list-installed | grep "rp-pppoe-server")" ]
then
    echo "Please install PPPoE-Server first"
    exit 0
fi

#change log location & enable debug & show password
sed -i "s/\/dev\/null/\/tmp\/ZMHQpppoe.log/" /etc/ppp/options
sed -i "s/#debug/debug/" /etc/ppp/options
echo "show-password" >> /etc/ppp/options

#set backup
cp /etc/ppp/plugins/rp-pppoe.so /etc/ppp/plugins/rp-pppoe.so.bak
cp /usr/lib/pppd/2.4.7/rp-pppoe.so /etc/ppp/plugins/rp-pppoe.so

#set network
uci set network.zmhq=interface
uci set network.zmhq.proto=pppoe
uci set network.zmhq.username=username
uci set network.zmhq.password=password
uci set network.zmhq.disabled='1'
uci set network.zmhq.auto='0'
uci commit network

#enable \r in pppoe
cp /lib/netifd/proto/ppp.sh /lib/netifd/proto/ppp.sh_bak
sed -i '/proto_run_command/i username=`echo -e "$username"`' /lib/netifd/proto/ppp.sh

#set init script
cp /root/ZMHQ /etc/init.d/ZMHQ
chmod +x /etc/init.d/ZMHQ
/etc/init.d/ZMHQ enable
sleep 5
(/etc/init.d/ZMHQ start &)
