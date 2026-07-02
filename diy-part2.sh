#!/bin/bash
# 1. 修改默认管理 IP 为 10.0.0.1
sed -i 's/192.168.1.1/10.0.0.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. 修改默认 Root 密码为 password（可自行替换成你想要的密码生成的哈希）
sed -i 's/^root:::/root:$6$QzThC33tGP4Hx1ER$ADP8vSrbrH4CVnleMiIXgGX6\/NM9Fgxk68oOj.pXo5gEBJyWoaR0ZDTNKRRPv858Y.mj43GKpfObcopvxh8ef\/:/' openwrt/package/base-files/files/etc/shadow

# 3. 分区大小仍然改根目录下的 .config（后面会被复制进 openwrt/）
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d;/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=32" >> .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config
