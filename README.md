# NanoPi R4S (1G) ImmortalWrt 自动编译固件

## 目录结构
```
.github/workflows/build-r4s.yml   # 自动编译工作流（每天检测上游更新，有更新才编译并发布Release）
diy-part.sh                       # 编译前的源码定制脚本（LAN IP、主机名等）
.config                           # 预设软件包与目标设备种子配置
files/etc/uci-defaults/99-custom-settings  # 固件首次启动时自动写入的运行时设置
```

## 使用方法
1. 在 GitHub 新建一个**私有或公开仓库**，把以上文件按相同目录结构上传（或 `git push`）。
2. 进入仓库 Settings → Actions → General，把 "Workflow permissions" 设为
   **Read and write permissions**（否则无法推送 `last_build_commit.txt` 和发布 Release）。
3. 默认每天北京时间 06:00 自动检查 immortalwrt/immortalwrt 上游是否有新提交：
   - 有更新 → 自动编译并发布到 Releases；
   - 无更新 → 跳过，不消耗 Actions 时长。
4. 也可以在 Actions 页面手动点 "Run workflow"，并把 `force_build` 设为 `true` 强制编译。
5. 编译产物在仓库的 **Releases** 页面下载，文件名包含 `sysupgrade` 的即为升级用镜像，
   另一份是可直接 `dd` 到 TF 卡/eMMC 的完整镜像（`.img.gz`）。

## 已确认/已配置的关键参数
| 项目 | 配置 |
|---|---|
| 设备 | NanoPi R4S（DEVICE_friendlyarm_nanopi-r4s，1G/4G内存通用同一固件） |
| 镜像格式 | 标准 img.gz（非EFI，按你的确认已去掉EFI要求） |
| 管理地址 | 10.0.0.1 |
| 子网掩码 | 255.255.255.0 |
| 后台密码 | root |
| IPv6 | 已启用（LAN下发SLAAC+DHCPv6） |
| Web服务器 | uhttpd |
| 软件分区(overlay)大小 | 约1024MB |

## ⚠️ 已核实的 feed 情况
1. **官方自带、无需额外配置**：`luci-app-diskman`、`luci-app-dockerman`、`luci-app-homeproxy`、
   `luci-app-upnp` 均已确认存在于 ImmortalWrt 官方 `feeds/luci/applications/` 中，workflow 不会再额外拉取这几个。
2. **luci-app-passwall**：xiaorouji 原仓库已整体迁移到新组织 `Openwrt-Passwall`，workflow 已使用
   官方当前推荐的新地址，并按官方说明插入到 `feeds.conf.default` **顶部**，以确保覆盖官方
   packages feed 自带的旧版 xray-core/sing-box 等依赖。
3. **luci-app-homebox / luci-app-nekobox：已按你的要求去掉**。原因：这两个插件没有统一的
   官方维护仓库——homebox 至少有 selfcan / xiangfeidexiaohuo / jjm2473 三个互不关联的打包版本，
   nekobox 能找到的仓库（Thaolga/openwrt-nekobox、nosignals/openwrt-neko）更新都不活跃，
   后者作者甚至在 README 里写明已弃坑。放进每日自动编译里风险较高，故未启用。
   如果后续想装，建议手动 `opkg`/`apk` 单独安装某个具体版本，而不是写进自动编译流程。

## 已确认的最终预装 LuCI 应用
luci-app-dockerman、luci-app-diskman、luci-app-passwall、luci-app-homeproxy、luci-app-upnp、luci-app-cpufreq

## 需要你自行核实的地方
1. **passwall 第三方源是否仍然有效**：虽然已更新为新组织地址，但第三方仓库未来仍可能再次迁移或改名，
   建议每次编译失败时先去 https://github.com/Openwrt-Passwall/openwrt-passwall 确认仓库状态。

2. **1G 软件空间是否够用**：dockerman + passwall + homeproxy 这几个加起来体积不小，
   尤其是 Docker 相关内核模块和 xray/sing-box 内核会占用较多空间，1024MB 的 overlay
   分区大概率是够的，但如果你后续在 LuCI 里继续装很多 docker 镜像，存储会很快吃紧——
   R4S 的 eMMC/TF 卡建议至少 8G 以上，并且 dockerman 的镜像数据建议通过 diskman
   挂载到外接存储而不是塞进 overlay。

## 登录信息
- 地址：`http://10.0.0.1`
- 用户名：`root`
- 密码：`root`（首次登录后强烈建议手动修改）
