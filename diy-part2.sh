#!/bin/bash

# 1. 修改默认管理 IP 为 10.0.0.1
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认 Root 密码为 root (生成 shadow 格式的加密密码)
# 'root' 经过 openssl passwd -1 加密后为 $1$V479998d$wOfwMft1sl924wCwA9890.
sed -i 's/root::0:0:99999:7:::/root:$1$V479998d$wOfwMft1sl924wCwA9890.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# 3. 调整根文件系统分区大小为 1024MB (1G)
# 先删除已存在的同名配置行，再追加新值，确保无论 .config 里原本有没有这两行都能正确生效
# （之前用 sed 's/pattern/replacement/' 直接替换，在原文件没有该行时会静默失效）
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d;/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=32" >> .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config
