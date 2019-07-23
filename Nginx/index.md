### 开启目录浏览

```
root   /storage/emulated/0/Download/000.nginx/;
index  index.html index.htm;
location /other/ {
		autoindex on;
		autoindex_exact_size off;
		autoindex_localtime on;
		charset utf-8,gbk;
		}
error_page  404      /404.html;
```
