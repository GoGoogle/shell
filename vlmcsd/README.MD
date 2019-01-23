
## 这是啥
## 我不懂
## 自己看

https://github.com/Wind4/vlmcsd/releases

https://forums.mydigitallife.net/threads/emulated-kms-servers-on-non-windows-platforms.50234/

mkdir ~/kms

wget -P ~/kms -O "bin-20181112.tar.gz" https://github.com/Wind4/vlmcsd/releases/download/svn1112/binaries.tar.gz

cd ~/kms

mkdir ~/kms/2018

tar -zvxf bin-20181112.tar.gz -C ~/kms/2018

cp ~/kms/2018/binaries/Linux/intel/static/vlmcsd-x64-musl-static ~/kms/vlmcsd-x64-musl-static-2018

chmod u+x ~/kms/vlmcsd-x64-musl-static-2018

~/kms/vlmcsd-x64-musl-static-2018

## 查进程
netstat -lnp | grep :1688
## 杀进程
kill PID
