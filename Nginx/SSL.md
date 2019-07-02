[安装certbot-auto参考](https://certbot.eff.org/docs/install.html#certbot-auto)

```
apt install certbot
wget https://dl.eff.org/certbot-auto
mv certbot-auto /usr/local/bin/certbot-auto
chown root /usr/local/bin/certbot-auto
chmod 0755 /usr/local/bin/certbot-auto
/usr/local/bin/certbot-auto --help
apt-get update
apt install certbot
certbot renew
nginx -s reload
```


#反向代理

```
proxy_set_header   X-Real-IP $remote_addr;
proxy_set_header   X-Forwarded-For $remote_addr;
proxy_set_header   Host      $host;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_pass         http://127.0.0.1:8081;
```
