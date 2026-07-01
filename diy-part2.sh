#!/bin/bash

# 1. 修改默认管理 IP 为 10.0.0.1
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认 Root 密码为 root (生成 shadow 格式的加密密码)
# 'root' 经过 openssl passwd -1 加密后为 $1$V479998d$wOfwMft1sl924wCwA9890.
sed -i 's/root::0:0:99999:7:::/root:$1$V479998d$wOfwMft1sl924wCwA9890.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# 3. 调整 Root 软件空间为 1024MB (1G)
sed -i 's/CONFIG_TARGET_KERNEL_PARTSIZE=.*/CONFIG_TARGET_KERNEL_PARTSIZE=32/g' .config
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/g' .config

# diy-part2.sh 里加一行（如果没有该行则追加）
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d;/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=32" >> .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=512" >> .config
