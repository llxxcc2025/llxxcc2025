#!/bin/bash

# 关闭并禁用 systemd 服务
systemctl stop hysteria-server
systemctl disable hysteria-server
rm -f /etc/systemd/system/hysteria-server.service
systemctl daemon-reload

# 删除程序文件
rm -f /usr/local/bin/hysteria
rm -f /usr/local/bin/s5server

# 删除配置文件和日志
rm -rf /etc/hysteria
rm -rf /var/log/hysteria

# 输出提示
echo "Hysteria SOCKS5 服务已成功卸载。"