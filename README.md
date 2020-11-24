## stun类型检测工具下载
http://sourceforge.net/projects/stun/
## 知识介绍
https://blog.csdn.net/u011245325/article/details/9294229
## 内核实现full-core-nat
需要拓展iptables，和内核patch。只有udp
### 知识文档
https://blog.chionlab.moe/2018/02/09/full-cone-nat-with-linux/
### 代码 
linux ：https://github.com/Chion82/netfilter-full-cone-nat
openwrt ：https://github.com/LGA1150/openwrt-fullconenat
### 使用
#### 编译安装
1. 内核开启CONFIG_NF_CONNTRACK_EVENTS，
2. 应用层同级目录创建iptables头文件及libxtables.so(自行编译或者x86可使用目录中对应头文件和库文件)
3. 修改makefile一次性编译so和ko
4. 拷贝应用iptables的库文件到iptables的库目录
/usr/lib/xtables/libipt_FULLCONENAT.so
5. 加载内核模块
insmod xt_FULLCONENAT.ko
#### 配置nat1全锥形类型
```
iptables -F ;iptables -F -t nat;
iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT;
iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT;
```
#### 配置nat2 ip受限类型
```
insmod xt_FULLCONENAT.ko g_type=2
iptables -F ;iptables -F -t nat;
iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT;
iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT;
```
#### 配置nat3 端口受限类型1
```
insmod xt_FULLCONENAT.ko g_type=3
iptables -F ;iptables -F -t nat;
iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT;
iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT;
```
#### 配置nat3 端口受限类型2
LINUX默认的MASQUERADE 规则即为端口受限类型
```
iptables -F ;iptables -F -t nat;
rmmod xt_FULLCONENAT;
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE;
```
#### 配置nat4 对称型nat
LINUX默认的MASQUERADE 规则添加端口随机属性即为对称型
```
iptables -F ;iptables -F -t nat;
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE --random;
```
