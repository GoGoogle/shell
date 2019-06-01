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
