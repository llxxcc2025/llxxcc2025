#!/bin/sh

set -e

FRP_VERSION="0.61.0"
ARCH="amd64"
FRP_DIR="/home/frp"
FRP_DOWNLOAD_URL="https://cdn.jsdelivr.net/gh/fatedier/frp@v${FRP_VERSION}/release/frp_${FRP_VERSION}_linux_${ARCH}.tar.gz"
INSTALL_DIR="${FRP_DIR}/frp_${FRP_VERSION}_linux_${ARCH}"

# 创建安装目录
mkdir -p "$FRP_DIR"
cd "$FRP_DIR"

echo "正在下载 FRP..."
curl -L -o frp.tar.gz "$FRP_DOWNLOAD_URL"

# 检查文件是否为有效 gzip 文件
# FILE_TYPE=$(file frp.tar.gz)
# echo "$FILE_TYPE" | grep -q "gzip compressed" || {
#     echo "❌ 下载的文件不是有效的 gzip 文件"
#     exit 1
# }


echo "解压中..."
tar -xzf frp.tar.gz

# 检查解压目录是否存在
if [ ! -d "$INSTALL_DIR" ]; then
    echo "❌ 解压失败，目录不存在: $INSTALL_DIR"
    exit 1
fi

echo "生成配置文件..."
cat > "$INSTALL_DIR/frpc.toml" <<EOF
[common]
server_addr = "140.245.41.162"
server_port = 8056
token = "02a2a8c0c5315b7a6882823b92dcde83"

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 6000
EOF

echo "创建快捷命令 k..."
cat > /usr/bin/k <<EOF
#!/bin/sh
$INSTALL_DIR/frpc -c $INSTALL_DIR/frpc.toml
EOF

chmod +x /usr/bin/k

echo "✅ 安装完成！你现在可以用 k 命令来启动 frpc 了"
