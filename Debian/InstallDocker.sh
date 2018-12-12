#官方说明
https://docs.docker.com/install/linux/docker-ce/debian/
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh


#先升级
apt update
apt list --upgradable
apt upgrade

#安装docker V1
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get install docker-ce

#安装docker V2 [AliYun的源]
curl https://get.docker.com/ | sudo sh

#安装docker V3
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     python-software-properties
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/docker/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo sed '/^deb-src.*download.docker.com.*/ s/^/#/g' -i /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y -q docker-ce=17.09.1*
sudo service docker start
sudo service docker status

sudo service docker start
sudo docker info
