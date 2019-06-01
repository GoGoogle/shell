

```
$ cat /etc/nginx/sites-enabled/test.conf
server {
        listen 80;
        listen [::]:80;
        client_max_body_size 20m;
# 指定网站目录，可根据自己情况更换，建议放在 /var/www 目录下
        root /var/www/test.local;
        #if ($http_user_agent ~* "MSIE [6-9].[0-9]") {rewrite /no_ie.html break;}
        index index.html index.php index.htm;

# 默认第一个域名，替换 test.local 为您的域名
        server_name www.test.local;
        server_name test.local;

        error_page 404 /custom_404.html;
        location = /custom_404.html {
                root /usr/share/nginx/html;
                internal;
        }

        error_page 500 502 503 504 /custom_50.html;
        location = /custom_50.html {
                root /usr/share/nginx/html;
                internal;
        }

        location /testing {
                fastcgi_pass unix:/does/not/exist;
        }

        location / {
            try_files $uri $uri/ =404;
                if (!-e $request_filename) {
                        rewrite (.*) /index.php;
                }
				# 禁止wget、Go--client以及curl等机器爬虫行为
                if ($http_user_agent ~* (wget|Go--client|curl) ) {
                return 404;
        }
        }

# 开启 PHP7.1-fpm 模式，如需要安装 PHP 7.0.x 请修改为 fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        }
        location /wp/ {
                if (!-e $request_filename) {
                        rewrite (.*) /wp/index.php;
                 }
        }
	}
```
