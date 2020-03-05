## Win7 匿名共享的一些问题


### 匿名共享，手机却提示要密码
  电脑可以正常访问，但手机却不行，必须要用户名密码，好奇心上来了，裤子都没穿，冻得我直哆嗦，不研究不舒服斯基。（凌晨两点半）
  
  检查了各种组策略的配置，防火墙配置（甚至把防火墙关了），还是不得行
  
  以为是要害：
  
  ```
  1、从网络访问添加Guest；
  2、把Guest账号启用；
  3、设置访问模式 “仅来宾”
  ```
  
  结果还是不行，好冷，准备睡。
  
  躺了一会儿，放不下心，就是不爽，之前出现过几次的，重启就能解决，但我这次不想重启了，就再次把它打开（远程）；
  
  然后突然想到了去把server服务重启一下试试，果然，出现了“1130错误，提示服务器系统存储空间不足”的提示；
  
  马上Google，找到一个看起来靠谱的解决方案，试了一下：
  
  ```
  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters
  的Size修改为3
  
  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management
  的LargeSystemCache修改为1
  ```
  
  然后再重启Server服务，解决了。
  
  其实这个系统是被精减过了，本来想直接重装系统的，但患有懒癌，罢了。
  
  
