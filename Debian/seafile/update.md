## 前期准备
### https://bbs.seafile.com/t/topic/10681

```
# 下载7.0.5
wget http://seafile-downloads.oss-cn-shanghai.aliyuncs.com/seafile-server_7.0.5_x86-64.tar.gz

# 解压
tar -vxf seafile-server_7.0.5_x86-64.tar.gz

# 停止老版本
cd seafile-server-latest
./seafile.sh stop
./seahub.sh stop

# 备份老版本
cd ..
mv seafile-server-latest seafile-server-latest-bak

# 改目录名
mv seafile-server-7.0.5 seafile-server-latest
cd seafile-server-latest

# 从6.2升级到6.3
./upgrade/upgrade_6.2_6.3.sh

# 从6.3升级到7.0
./upgrade/upgrade_6.3_7.0.sh

# 清空缓存，不然WEB后台系统设置排排会乱。
rm -rf /tmp/seahub_cache/*
```

## 看端口配置
`cat /home/bmwcto/conf/seafile.conf|grep port`
```
[fileserver]
port = 8082
```

## nginx反代配置
```
cat /etc/nginx/sites-enabled/seafile.conf
server {
    listen 80;
    server_name yourdomain.com;

    proxy_set_header X-Forwarded-For $remote_addr;

    location / {
         proxy_pass         http://127.0.0.1:8000;
         proxy_set_header   Host $host;
         proxy_set_header   X-Real-IP $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header   X-Forwarded-Host $server_name;
         proxy_read_timeout  1200s;

         # used for view/edit office file via Office Online Server
         client_max_body_size 0;

         access_log      /var/log/nginx/seahub.access.log;
         error_log       /var/log/nginx/seahub.error.log;
    }

    location /seafhttp {
        rewrite ^/seafhttp(.*)$ $1 break;
        proxy_pass http://127.0.0.1:8082;
        client_max_body_size 0;

                proxy_request_buffering off;
        proxy_connect_timeout  36000s;
        proxy_read_timeout  36000s;
        proxy_send_timeout  36000s;

        send_timeout  36000s;
    }
    location /media {
        root /home/bmwcto/seafile-server-latest/seahub;
    }
}
```

## 启动SEAFILE
```
./seafile.sh start
./seahub.sh start
```

### 刚开始发现一个问题，就是MD文件无法打开，查得是500报错，按此方法解决了：
https://bbs.seafile.com/t/topic/9232/2

> 这是因为你在 6.3 版升级的时候忘记需要升级迁移文件评论数据库表了。

## 但我是按升级手册里面的步骤进行的，不知道哪一句是迁移文件评论数据库，或者说就没有这个？

## 进入 seahub-db, 删除 base_filecomment 数据库表，然后重新创建一下:
```
CREATE TABLE `base_filecomment` (

    `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(255) NOT NULL,

    `comment` longtext NOT NULL,
  `created_at` datetime NOT NULL,

    `updated_at` datetime NOT NULL,
  `uuid_id` char(32) NOT NULL,

    `detail` longtext NOT NULL,
  `resolved` tinyint(1) NOT NULL,

    PRIMARY KEY (`id`),
  KEY `base_filecomment_uuid_id_4f9a2ca2_fk_tags_fileuuidmap_uuid` (`uuid_id`),

    KEY `base_filecomment_author_8a4d7e91` (`author`),

    KEY `base_filecomment_resolved_e0717eca` (`resolved`),

    CONSTRAINT `base_filecomment_uuid_id_4f9a2ca2_fk_tags_fileuuidmap_uuid` FOREIGN KEY (`uuid_id`) REFERENCES `tags_fileuuidmap` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

## 重启SEAFILE
```
./seafile.sh restart
./seahub.sh restart
```

# 升级完毕，若有其它问题，还请指正，谢谢大家！
