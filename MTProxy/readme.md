## Telegram MTproxy代理搭建完全指南
官方：
https://github.com/TelegramMessenger/MTProxy

apt install git curl build-essential libssl-dev zlib1g-dev

git clone https://github.com/TelegramMessenger/MTProxy

cd MTProxy

make && cd objs/bin

curl -s https://core.telegram.org/getProxySecret -o proxy-secret

curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf

## 生成一个32位16进制secret用于客服端密钥
head -c 16 /dev/urandom | xxd -ps

screen -ls

screen -S mtp

./mtproto-proxy -u nobody -p 8888 -H 443 -S <secret> --aes-pwd proxy-secret proxy-multi.conf -M 1

##请将-p 8888 -H 443 -S <secret>替换为自己的，分别为本地端口号，用于链接服务器的端口，32位16进制密钥

