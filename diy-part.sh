#!/bin/bash
# diy-part.sh —— 在 make defconfig 之前对源码树做的定制修改
set -e

# 1. 修改默认 LAN IP（也会在固件里写入，uci-defaults 里再次确保生效）
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 2. 默认主机名（可按需修改）
sed -i "s/hostname='.*'/hostname='ImmortalWrt-R4S'/g" package/base-files/files/bin/config_generate

echo "diy-part.sh 执行完成"
