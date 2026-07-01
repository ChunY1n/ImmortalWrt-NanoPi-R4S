# NanoPi R4S (1G) ImmortalWrt 自动编译固件

## 目录结构
```
.github/workflows/build-r4s.yml   # 自动编译工作流（每天检测上游更新，有更新才编译并发布Release）
diy-part.sh                       # 编译前的源码定制脚本（LAN IP、主机名等）
.config                           # 预设软件包与目标设备种子配置
files/etc/uci-defaults/99-custom-settings  # 固件首次启动时自动写入的运行时设置
```

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

## 已确认的最终预装 LuCI 应用
luci-app-dockerman、luci-app-diskman、luci-app-passwall、luci-app-homeproxy、luci-app-upnp、luci-app-cpufreq

## 登录信息
- 地址：`http://10.0.0.1`
- 用户名：`root`
- 密码：`root`（首次登录后强烈建议手动修改）
