# 在 Android 上利用 Termux 运行[EFB](https://github.com/blueset/ehForwarderBot)

- Arm v7/8
- Termux（[Play](https://play.google.com/store/apps/details?id=com.termux&hl=zh) [F-Droid](https://f-droid.org/en/packages/com.termux/) [Kali](https://store.nethunter.com/en/packages/com.termux/)）
- python3.8

## 配置基础环境

 > 一步一步来，先后有序，避免安装EFB的时候有意外

1. `pkg update`
2. `pkg upgrade`
3. `pkg install python`
4. `pkg install openssl`
5. `pkg install file`
6. `pkg install libwebp`
7. `pkg install ffmpeg`
8. `pip install cffi cairocffi libmagic pillow`

## 安装EFB

> 如果安装失败就需要慢慢排错了

1. `pip install ehforwarderbot efb-telegram-master efb-wechat-slave`

## 配置EFB

> 可以使用向导来配置（`efb-wizard`），也可以手动配置。

1. `mkdir -p ~/.ehforwarderbot/profiles/default`
2. `mkdir ~/.ehforwarderbot/profiles/default/blueset.telegram`
3. 生成 efb 配置文件：  

    ```bash
    echo "master_channel: blueset.telegram
    slave_channels:
            - blueset.wechat">~/.ehforwarderbot/profiles/default/config.yaml
    ```

4. 生成 telegram 配置文件：

    ```bash
    echo 'token: "xxx:yyy"
    admins:
            - nnn'>~/.ehforwarderbot/profiles/default/blueset.telegram/config.yaml
    ```

    > xxx:yyy即tgbot的token，nnn即自己的TGID  
    > 还可以单独添加 socks5 代理：  

    ```yaml
    request_kwargs:
                proxy_url: "socks5h://127.0.0.1:443"
    ```

## 运行EFB

> 可以重命名，免得太难记 （`alias efb=ehforwarderbot`）

然后使用 `ehforwarderbot` 或 `efb` 都可以直接运行了
