���Ȱ�װipk
opkg update

opkg install rp-pppoe-server

���������ذ�װ��Ӧipk
opkg install rp-pppoe-common.ipk

opkg install rp-pppoe-server.ipk

����pppoe-server����
killall pppoe-server
pppoe-server -k -I br-lan

�ļ���:
ZMHQ
ZMHQ.sh
ZMHQScript.sh

���ļ�ȫ��������/root/zmhq/Ŀ¼
���� ZMHQScript.sh
���
sh /root/zmhq/ZMHQScript.sh

WINSCP��½���ֱ��/tmp/Ŀ¼�鿴�����ļ�
ZMHQpppoe.log
ZHMM.log

����ZMHQ.sh����

ps | grep ZMHQ.sh | grep -v grep

kill ���̺�

sh /root/zmhq/ZMHQ.sh


SSH��½������������ɲ鿴�˺����뼰MAC��ַ
tail -16 /tmp/ZHMM.log