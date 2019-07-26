## iptables 防火墙 linux

```
iptables -I INPUT -p tcp --dport 443 -j DROP
#顺序不能错，先拒绝所有连接443端口权限

iptables -I INPUT -s 127.0.0.1 -p tcp --dport 443 -j ACCEPT
#添加本机访问443端口权限

iptables -I INPUT -m iprange --src-range 192.168.0.2-192.168.0.10 -p tcp --dport 443 -j ACCEPT
#添加一个IP段访问443端口权限

iptables -I INPUT -s 2.2.0.0/16 -p tcp --dport 443 -j ACCEPT
#添加一个子网访问443端口权限
```

#### 清除规则：
- 查看带序号的INPUT规则：

`iptables -L INPUT --line-numbers`

- 清除第1条：

`iptables -D INPUT 1`

## 另外
- 查看连接
`netstat -ano|grep :443|sort | uniq -c`
- 如果是先连上你在加防火墙规则是踢不出去的
- 把监听端口的服务停掉重新打开即可
- [有意思](https://github.com/shadowsocks/shadowsocks-libev/issues/2439)
