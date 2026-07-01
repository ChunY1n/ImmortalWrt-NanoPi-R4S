# ImmortalWrt for NanoPi R4S (1G)

基于 GitHub Actions 实现的 ImmortalWrt 固件自动编译与更新流水线。

## ⚙️ 固件默认配置

* **管理地址**：`10.0.0.1`
* **子网掩码**：`255.255.255.0`
* **初始密码**：`root`
* **系统分区**：核心软件空间已扩容至 **1GB**
* **核心预装**：Docker, Diskman, Passwall, HomeProxy, UPnP, IPv6 支持, uHTTPd Web 服务器

## 🚀 自动化与构建

* **自动更新**：每周五凌晨 04:00 (北京时间) 自动触发编译。
* **手动触发**：进入 GitHub 仓库的 **Actions** 页面 -> 选择 **Build ImmortalWrt** -> 点击 **Run workflow**。
* **下载固件**：编译完成后，在当次 Action 运行页面的 **Artifacts** 处下载 `*.img.gz`。
