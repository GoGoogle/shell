```
crontab -e
0 5 * * * /root/restartEdge.sh
```

`chmod +x 0 5 /root/restartEdge.sh`

/root/restartEdge.sh

```
#!/bin/bash
kill -9 $(ps aux --sort=start_time | grep edgeCto | awk 'NR==1{print $2}')
sleep 3
/usr/sbin/edge -d edgeCto -a 10.0.0.2 -c name -k password -l 1.1.1.1:4321 -m fa:16:3e:66:a2:66 -r
sleep 2
kill -9 $(ps aux --sort=start_time | grep ss2.json | awk 'NR==1{print $2}')
sleep 2
nohup /usr/bin/ss-local -c /root/ss2.json </dev/null &>>/root/ss2-local.log &
```

/root/ss2.json

```
{
        "server":"10.0.0.3",
        "server_port":8888,
        "local_address":"0.0.0.0",
        "local_port":1081,
        "password":"passwords",
        "timeout":60,
        "method":"aes-256-cfb",
        "fast_open":true
}
```
