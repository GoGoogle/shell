# 有关 privoxy 安装完后无法启动的问题 排错思路

> 因某些原因，需要把 `socks5` 转化为 `http(s)` 来使用，需要用到 `privoxy`
> 
> 例如 `apt` `wget` `pip` 都还不支持 `socks5`

## 安装

```shell
$ apt install privoxy
……
Creating config file /etc/privoxy/config with new version
update-rc.d: We have no instructions for the privoxy init script.
update-rc.d: It looks like a network service, we disable it.
privoxy.service is a disabled or a static unit, not starting it.
Processing triggers for systemd (243-5) ...
Processing triggers for man-db (2.9.0-1) ...
Processing triggers for doc-base (0.10.9) ...
Processing 3 added doc-base files...
```

* 注意，已经有提示了

    `privoxy.service is a disabled or a static unit, not starting it.`

## 原因及解决方案

* 看看状态
    ```shell
    $ systemctl status privoxy
    ● privoxy.service - Privacy enhancing HTTP Proxy
    Loaded: loaded (/lib/systemd/system/privoxy.service; disabled; vendor preset: disabled)
    Active: failed (Result: exit-code) since Sun 2019-12-01 17:46:54 CST; 6min ago
        Docs: man:privoxy(8)
            https://www.privoxy.org/user-manual/

    Dec 01 17:46:53 BMWCTO systemd[1]: Starting Privacy enhancing HTTP Proxy...
    Dec 01 17:46:53 BMWCTO privoxy[974]: 2019-12-01 17:46:53.575 7f9551e5f0 Fatal error: can't check configuration file '/etc/privoxy/conf>
    Dec 01 17:46:54 BMWCTO systemd[1]: privoxy.service: Control process exited, code=exited, status=1/FAILURE
    Dec 01 17:46:54 BMWCTO systemd[1]: privoxy.service: Failed with result 'exit-code'.
    Dec 01 17:46:54 BMWCTO systemd[1]: Failed to start Privacy enhancing HTTP Proxy.
    ```

* 提示出现了，说配置文件有问题

    `Fatal error: can't check configuration file '/etc/privoxy/conf`

* 那么问题来了，这是默认配置，为什么还错了？

* 原因

    1. 默认的 8118 端口被占用
    2. 默认的其它参数有问题（冲突）

* 看log

    `$ cat /var/log/privoxy/logfile`

    > 有很多类似这样的玩意儿：

    ` Fatal error: can't bind to ::1:8118: Cannot assign requested address`

    > `::1:8118` 是个啥？配置文件里面有？

    ```shell
    $ cat /etc/privoxy/config | grep -a :8118
    #      127.0.0.1:8118
    #        listen-address  192.168.0.1:8118
    #        listen-address [::1]:8118
    listen-address  127.0.0.1:8118
    listen-address  [::1]:8118
    ```
    > 最后这两行的意思是用 `本机IP:8118` 来做http代理的
    > 
    > 其实只需要一个就够用了
    > 
    > 最后一行是IPV6，因为我把本机的IPV6模块关掉了，根本就没有IPV6
    > 
    > 所以它出错了，把它注释掉就OK了。

### 重启 `privoxy`

* `systemctl restart privoxy`

## 其它

### 设置代理：

* 脚本及显示如下：
    ```shell
    $ export http_proxy=http://127.0.0.1:8118;export https_proxy=http://127.0.0.1:8118 && echo now_proxy: ;export | grep -a proxy
    now_proxy:
    http_proxy=http://127.0.0.1:8118
    https_proxy=http://127.0.0.1:8118
    ```

### 测试代理：

* 用curl： `$ curl url`
* 用wget： `$ wget -O test url && cat test`

### 取消代理：

* 脚本及显示如下：
    ```shell
    $ echo before_proxy: ;export | grep -a proxy && unset http_proxy ; unset https_proxy ;echo ;echo now_proxy:&& export | grep -a proxy
    before_proxy:
    http_proxy=http://127.0.0.1:8118
    https_proxy=http://127.0.0.1:8118

    now_proxy:

    ```
