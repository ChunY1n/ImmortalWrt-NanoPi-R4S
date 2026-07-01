#!/bin/bash

# 1. 修改默认管理 IP 为 10.0.0.1
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认 Root 密码为 root
sed -i 's/root::0:0:99999:7:::/root:$1$V479998d$wOfwMft1sl924wCwA9890.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# 3. 调整根文件系统分区大小为 1024MB（先删旧行，再追加，确保生效，不管原文件里有没有这两行）
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d;/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=32" >> .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config
