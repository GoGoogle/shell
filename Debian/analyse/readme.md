```
chmod +x analyse
./analyse /root/txt
```

`127.0.0.1:8080/analyse`


`apt-get install apache2-utils`

安装加密命令

`htpasswd -c /var/www/pass name`

输入name的密码

`vim /etc/nginx/sites-enabled/default`

编辑目录浏览并加密码访问

```
location /txt/ {
                autoindex on;
                autoindex_exact_size off;
                autoindex_localtime on;
                auth_basic 'Restricted';
                auth_basic_user_file /var/www/pass;
                        }
```

`systemctl restart nginx`

重启nginx服务
