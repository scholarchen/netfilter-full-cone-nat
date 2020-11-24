## stun���ͼ�⹤������
http://sourceforge.net/projects/stun/
## ֪ʶ����
https://blog.csdn.net/u011245325/article/details/9294229
## �ں�ʵ��full-core-nat
��Ҫ��չiptables�����ں�patch��ֻ��udp
### ֪ʶ�ĵ�
https://blog.chionlab.moe/2018/02/09/full-cone-nat-with-linux/
### ���� 
linux ��https://github.com/Chion82/netfilter-full-cone-nat
openwrt ��https://github.com/LGA1150/openwrt-fullconenat
### ʹ��
#### ���밲װ
1. �ں˿���CONFIG_NF_CONNTRACK_EVENTS��
2. Ӧ�ò�ͬ��Ŀ¼����iptablesͷ�ļ���libxtables.so(���б������x86��ʹ��Ŀ¼�ж�Ӧͷ�ļ��Ϳ��ļ�)
3. �޸�makefileһ���Ա���so��ko
4. ����Ӧ��iptables�Ŀ��ļ���iptables�Ŀ�Ŀ¼
/usr/lib/xtables/libipt_FULLCONENAT.so
5. �����ں�ģ��
insmod xt_FULLCONENAT.ko
#### ����nat1ȫ׶������
```
iptables -F ;iptables -F -t nat;
iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT;
iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT;
```
#### ����nat2 ip��������
```
insmod xt_FULLCONENAT.ko g_type=2
iptables -F ;iptables -F -t nat;
iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT;
iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT;
```
#### ����nat3 �˿���������1
```
insmod xt_FULLCONENAT.ko g_type=3
iptables -F ;iptables -F -t nat;
iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT;
iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT;
```
#### ����nat3 �˿���������2
LINUXĬ�ϵ�MASQUERADE ����Ϊ�˿���������
```
iptables -F ;iptables -F -t nat;
rmmod xt_FULLCONENAT;
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE;
```
#### ����nat4 �Գ���nat
LINUXĬ�ϵ�MASQUERADE ������Ӷ˿�������Լ�Ϊ�Գ���
```
iptables -F ;iptables -F -t nat;
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE --random;
```
