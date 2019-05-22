内网A客户端A：

`edge -d edge0 -a 10.1.1.2 -c name -k password -l 1.1.1.1:4321 -m ab:cd:22:33:44:55`

内网B客户端B：

`edge -d edge0 -a 10.1.1.2 -c name -k password -l 1.1.1.1:4321 -m ab:cd:22:33:44:55`

服务端(假设IP为1.1.1.1)：

`supernode -l 4321 -v`

*编译安装n2n*

```
$ apt install -y subversion git build-essential libssl-dev net-tools make gcc autoconf
$ git clone https://github.com/ntop/n2n.git
$ cd n2n
$ ./autogen.sh

Now running ./configure
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for AES_cbc_encrypt in -lcrypto... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config.h

$ make
$ make install
/bin/sh: 1: pkg-config: not found
echo "MANDIR=/usr/share/man"
MANDIR=/usr/share/man
mkdir -p /usr/sbin /usr/share/man/man1 /usr/share/man/man7 /usr/share/man/man8
install -m755 supernode /usr/sbin/
install -m755 edge /usr/sbin/
install -m644 edge.8.gz /usr/share/man/man8/
install -m644 supernode.1.gz /usr/share/man/man1/
install -m644 n2n.7.gz /usr/share/man/man7/
```

查看版本：

```
$ edge --version
22/May/2019 23:03:57 [edge.c:599] Starting n2n edge 2.5.0 May 22 2019 23:03:08
edge: unrecognized option '--version'
22/May/2019 23:03:57 [edge.c:618] ip_mode='static'
Welcome to n2n v.2.5.0 for Debian 9.7
Built on May 22 2019 23:03:07
Copyright 2007-18 - ntop.org and contributors

$ supernode -h
Welcome to n2n v.2.5.0 for Debian 9.7
Built on May 22 2019 23:03:07
Copyright 2007-18 - ntop.org and contributors

edge <config file> (see edge.conf)
or
edge -d <tun device> -a [static:|dhcp:]<tun IP address> -c <community> [-k <encrypt key>]
    [-s <netmask>] [-u <uid> -g <gid>][-f][-m <MAC address>] -l <supernode host:port>
    [-p <local port>] [-M <mtu>] [-r] [-E] [-v] [-i <reg_interval>] [-t <mgmt port>] [-b] [-A] [-h]

-d <tun device>          | tun device name
-a <mode:address>        | Set interface address. For DHCP use '-r -a dhcp:0.0.0.0'
-c <community>           | n2n community name the edge belongs to.
-k <encrypt key>         | Encryption key (ASCII) - also N2N_KEY=<encrypt key>.
-s <netmask>             | Edge interface netmask in dotted decimal notation (255.255.255.0).
-l <supernode host:port> | Supernode IP:port
-i <reg_interval>        | Registration interval, for NAT hole punching (default 20 seconds)
-b                       | Periodically resolve supernode IP
                         | (when supernodes are running on dynamic IPs)
-p <local port>          | Fixed local UDP port.
-u <UID>                 | User ID (numeric) to use when privileges are dropped.
-g <GID>                 | Group ID (numeric) to use when privileges are dropped.
-f                       | Do not fork and run as a daemon; rather run in foreground.
-m <MAC address>         | Fix MAC address for the TAP interface (otherwise it may be random)
                         | eg. -m 01:02:03:04:05:06
-M <mtu>                 | Specify n2n MTU of edge interface (default 1400).
-r                       | Enable packet forwarding through n2n community.
-A                       | Use AES CBC for encryption (default=use twofish).
-E                       | Accept multicast MAC addresses (default=drop).
-v                       | Make more verbose. Repeat as required.
-t <port>                | Management UDP Port (for multiple edges on a machine).

Environment variables:
  N2N_KEY                | Encryption key (ASCII). Not with -k.

$ supernode -h
Welcome to n2n v.2.5.0 for Debian 9.7
Built on May 22 2019 23:03:07
Copyright 2007-18 - ntop.org and contributors

supernode <config file> (see supernode.conf)
or
supernode -l <lport> -c <path> [-f] [-v]

-l <lport>      Set UDP main listen port to <lport>
-c <path>       File containing the allowed communities.
-v              Increase verbosity. Can be used multiple times.
-h              This help message.
```

中文参考：

```
edge -d 虚拟网卡名 -a 10.0.0.1 -c testnet -k senrame -l 1.2.3.4:1234
 
#参数说明
-d 虚拟网卡名
-a [static:|dhcp:]虚拟网段(IP)，static模式其实可以不用加那个static: 直接写IP就行
-c 用于区分节点的社区(组)名
-k 用于加密的字符串
-K 用于加密的Key文件，和-k不能共存
-s 子网掩码
-l supernode的IP:端口，可以指定多个supernode的
-i NAT打洞间隔
-b 当使用DHCP时定期刷新IP
-p 指定本地端口
-u 指定运行所用的UID
-g 指定运行所用的GID
-f 前台运行
-m 为虚拟网卡指定MAC地址
-r 启用包转发，当-a指定DHCP时需要启用
-E 接收组播MAC地址
-v 输出比较详细的log
-t 指定用于管理的UDP端口
```
