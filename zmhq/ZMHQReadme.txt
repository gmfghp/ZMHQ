首先安装ipk
opkg update

opkg install rp-pppoe-server

或自行下载安装对应ipk
opkg install rp-pppoe-common.ipk

opkg install rp-pppoe-server.ipk

启用pppoe-server命令
killall pppoe-server
pppoe-server -k -I br-lan

文件名:
ZMHQ
ZMHQ.sh
ZMHQScript.sh

将文件全部拷贝到/root/zmhq/目录
运行 ZMHQScript.sh
命令：
sh /root/zmhq/ZMHQScript.sh

WINSCP登陆后可直接/tmp/目录查看下面文件
ZMHQpppoe.log
ZHMM.log

重启ZMHQ.sh命令

ps | grep ZMHQ.sh | grep -v grep

kill 进程号

sh /root/zmhq/ZMHQ.sh


SSH登陆运行以下命令可查看账号密码及MAC地址
tail -16 /tmp/ZHMM.log