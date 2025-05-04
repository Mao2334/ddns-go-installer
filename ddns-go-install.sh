#!/bin/sh

# 自动识挂载点
MNT_PATH=$(ls -1 /tmp/mnt | grep -v "^rom$" | head -n 1)
FULL_PATH="/tmp/mnt/$MNT_PATH/ddns"

# 创建安装目录
mkdir -p "$FULL_PATH" && cd "$FULL_PATH"

# 下载ddns-go arm64
wget -O ddns-go.tar.gz https://gh-proxy.com/github.com/jeessy2/ddns-go/releases/download/v6.9.1/ddns-go_6.9.1_linux_arm64.tar.gz

# 解压并授权执行
tar -zxvf ddns-go.tar.gz
chmod +x ddns-go

# 写入 watchdog 脚本
cat << EOF > "$FULL_PATH/ddns_watchdog.sh"
#!/bin/sh
LOGFILE="$FULL_PATH/log.txt"
if ! ps | grep "[d]dns-go" > /dev/null; then
    echo "\$(date): ddns-go not running, restarting..." >> "\$LOGFILE"
    cd "$FULL_PATH"
    ./ddns-go > /dev/null 2>&1 &
else
    echo "\$(date): ddns-go is running" >> "\$LOGFILE"
fi
EOF
chmod +x "$FULL_PATH/ddns_watchdog.sh"

# 写入 post-mount 自动启动脚本
mkdir -p /jffs/scripts
cat << EOF > /jffs/scripts/post-mount
#!/bin/sh
sleep 10
$FULL_PATH/ddns_watchdog.sh &
EOF
chmod +x /jffs/scripts/post-mount

# 启动一次 watchdog
"$FULL_PATH/ddns_watchdog.sh"
