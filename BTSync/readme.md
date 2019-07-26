### BTSync,WEBGUI忘记密码后：

1. 开启SSH，进入SSH；
2. sudo -i ，管理员模式；
3. 先停掉btsync，`synoservice --stop pkgctl-resiliosync`（或进DSM网页设置）;
4. 找到路径`/usr/local/resiliosync/var`的`settings.dat`和`settings.dat.old`文件，删除或移开；
5. 再启动btsync，`synoservice --start pkgctl-resiliosync`（或进DSM网页设置）;
6. 打开webgui,进行新用户名和密码设置.

- [方法参考](https://help.resilio.com/hc/en-us/articles/205450295)
- [路径参考](https://help.resilio.com/hc/en-us/articles/206664690)
