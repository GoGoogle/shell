# shell
一些Linux脚本、记录

## Cisco
关于思科的一些笔记，其实有很多很多，慢慢的搬上来

## testip
测试IP的脚本

PING 4 次，取平均值res 的整数num，小于150ms的显示ok，否则显示fail。

用法：testip.sh ip.txt列表文件（一行一个IPV4）

## update_eav
病毒库更新，结构：
<pre>
update_eav
├── 8002.reg
├── eav_bak
│   ├── eav_2018-11-05-00-01-01.zip
│   └── eav_2018-12-03-00-01-01.zip
├── eav.sh
├── index.php
├── offline
│   ├── nod04AC.nup
│   ├── xxx.nup
│   ├── nodFE87.nup
│   └── update.ver
├── offline_update_eav.zip
└── update_eav.sh
</pre>


## 关于用PuTTY
因为putty使用的是自己的ppk文件，因此需要对id_rsa进行转换。这项需求需要使用puttygen来实现。
打开puttygen.exe，load现有的id_rsa文件。如果设置了私钥密码，则要在key passphrase中输入密码并确认。点击“save private key”，保存为putty的.ppk文件。
在putty中，设置需要登录的服务器ip和端口之后，在Connection - SSH - Auth中的Private key file for authentication中选择生成的ppk文件。这样就可以使用密钥进行登录了。
也可以在Connection - Data 的Auto-login username中设置好登录的用户，那么打开session就可以自动连接上服务器了。

## 其它
[HTML2MD](https://tool.lu/markdown/)

[1.中国执行信息公开网](http://zxgk.court.gov.cn/?dt_dapp=1)  
可以查到一个人的失信记录
  
[2.全国标准信息公共服务平台](http://www.std.gov.cn/?dt_dapp=1)  
每个行业接触到的各种标准，包括行业标准、团体标准、国外标准，已废止的、现行的、即将实施的都能查到。  
  
[3.征信中心（银行一般规定：一个月不要查询超过三次](https://ipcrs.pbccrc.org.cn/?dt_dapp=1)  
用来查询自己的个人信用记录，违约、延迟还款和查询是否存在不良记录。  
 
[4.中国法律法规资讯网](http://www.86148.com/?dt_dapp=1)  
  
[5.全国企业信用信息公示系统](http://gsxt.saic.gov.cn/)  
毕业学生找工作不知道公司靠不靠谱，可以上这里查询是不是正规公司。  
  
[6.中国裁判文书网](http://wenshu.court.gov.cn/)  
检索对方的名字，不仅是刑事案件，经济纠纷债权债务啥的也可以了解。  
  
[7.支fu宝查询婚姻状况（更新）支fu宝可以查婚姻状况望周知](https://www.douban.com/doubanapp/dispatch?uri=/group/topic/142322388&dt_dapp=1)  
  
[8.莆系网](http://m.putianxi.cn/)  
可查询各个地方的莆田系医院  
  
[9.商务部直销行业管理](http://zxgl.mofcom.gov.cn/front/index;jsessionid=ACF8933475B5C95D2D52197FDD72A7FF)  
可查传销还是直销  
  
[10.国家药品监督管理局](http://www.nmpa.gov.cn/WS04/CL2042/)  
凡是没有通过国家药监局备案的产品都是三无产品
