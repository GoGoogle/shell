```
#! /bin/bash
mkdir -p blueset.telegram

cat>config.yaml<<EOF
master_channel: blueset.telegram
slave_channels:
        - blueset.wechat
EOF

cat>blueset.telegram/config.yaml<<EOF
token: "$1"
admins:
        - $2
flags:
        option_one: 10
        option_two: false
        option_three: "foobar"
        send_to_last_chat: "enabled"
EOF
```
复制粘贴到你本地Windows上，记事本保存成 `pxd.sh` ，然后上传到你的GCP上面的 `.ehforwarderbot/profiles/default` 路径下，执行 
`sh pxd.sh 你的botToken 你的TG账号ID`

不知能否看得懂 😂
