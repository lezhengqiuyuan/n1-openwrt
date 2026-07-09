# 云编译 N1 OpenWrt 固件

**说明**：
- 本项目使用 Github Actions 下载 [Lean](https://github.com/coolsnowwolf/lede) 的 `Openwrt` 源码仓库，进行云编译。
- 本项目使用定时编译（北京时间每月15日下午12点30分开始运行编译）及触发编译（更新 `README.md`、`script.sh`、`config.sh`、`files/**`、`.github/workflows/**` 后可开始编译）两种方式。
- 本项目编译固件适配斐讯 N1 盒子，用作旁路由。
- 默认 IP：`192.168.31.254`，主路由 IP：`192.168.31.1`，默认用户名/密码：`root/password`。
- 默认旁路由配置：N1 LAN 使用静态 IP，网关/DNS 指向主路由，LAN DHCP 默认关闭，不配置 WAN 口，避免和主路由 DHCP 冲突。
- 发布 Release 需要在仓库 Secrets 中配置 `actions_release`，并确保该 Token 具备创建/更新 Release 与删除旧 Release 的权限；工作流仅在固件产物整理成功且 Token 已配置时发布和清理 Release，Token 仅在检测、发布和清理旧 Release 步骤中注入。
- 工作流默认仓库权限已收敛为 `contents: read`，并在 `feeds update` 后验证并应用 `xfsprogs` 兼容性补丁，避免补丁静默失效或被后续 feeds 更新覆盖；`ophub/flippy-openwrt-actions` 已固定到完整提交哈希，避免浮动 `main` 引用。
- 打包后会校验 `PACKAGED_OUTPUTPATH` 非空、目录存在且包含文件，确认 N1 刷机固件产物有效后才上传 Artifact、发布 Release 和清理旧 Release。
- 本项目编译配置如下：

**基础配置**
  - [x] 修改架构适配斐讯 N1 盒子
    - [x] Target System —— QEMU ARM Virtual Machine
    - [x] Subtarget —— 64-bit ARM machines

**已启用插件/组件**
  - [x] `luci-app-amlogic` —— 晶晨盒子管理工具
  - [x] `luci-app-openclash` —— OpenClash 代理/分流插件
  - [x] `luci-app-turboacc` —— 网络加速套件
    - [x] `Include Flow Offload`
    - [x] `Include Shortcut-FE CM`
    - [x] `Include BBR CCA`
    - [x] `Include Pdnsd`
  - [x] `luci-theme-opentomcat` —— 管理界面主题
  - [x] `ttyd` —— Web 终端
  - [x] `vsftpd-alt` —— FTP 服务器轻量版
  - [x] `dnsmasq-full` —— 完整 DNS/DHCP 组件，OpenClash 依赖
  - [x] `kmod-tun` —— OpenClash TUN 模式依赖

**已禁用插件/组件**
  - [ ] `luci-app-accesscontrol`
  - [ ] `luci-app-adguardhome`
  - [ ] `luci-app-arpbind`
  - [ ] `luci-app-ddns`
  - [ ] `luci-app-docker`
  - [ ] `luci-app-dockerman`
  - [ ] `luci-app-ssr-plus`
    - [ ] `Include ChinaDNS-NG`
    - [ ] `Include MosDNS`
    - [ ] `Include Shadowsocks Simple Obfs Plugin`
    - [ ] `Include ShadowsocksR Libev Client`
  - [ ] `luci-app-upnp`
  - [ ] `luci-app-vsftpd`
  - [ ] `aliyundrive-webdav`
  - [ ] `rclone-webui / rclone-ng`
  - [ ] `UnblockNeteaseMusic Golang Version`

**更新日志**
- 20260709 修复工作流 `xfsprogs` 补丁顺序与命中验证、打包产物校验、Release 条件保护、权限/Token 使用范围、第三方 Action 浮动引用与脚本路径/重复执行清理逻辑
- 20260515 修改打包脚本，获取实际内核版本，输出到 release 说明
- 20250424 修正底层编译环境 `Ubuntu 20.04` 弃用造成的编译错误
- 20250303 修正 `actions/upload-artifact` 版本升级造成的编译错误
- 20240224 更新配置
- 20231129 更新内核版本 6.1.63，删除失效的插件
- 20231015 更新内核版本 6.1.57，集成 `PassWall`
- 20231013 更新截图
- 20231009 更新内核版本 6.1.56
- 20230915 修正 Github Action 空间不足导致的打包失败，更新内核版本 6.1.52
- 20230619 修正 Github Action 空间不足导致的打包失败，更新内核版本 6.1.34
- 20230525 更新配置
- 20230523 更新配置
- 20230211 修正 `set-output` 有效性造成的编译错误，更新内核版本 6.1.10
- 20230118 更新内核版本 6.1.6
- 20221031 更新内核版本 6.0.6
- 20220917 更新配置
- 20220814 更新内核版本 5.19.1
- 20220731 更新内核版本 5.18.15
- 20220620 更新内核版本 5.18.5
- 20220509 更新配置，更新内核版本 5.17.5
- 20220428 添加自动打包命令，生成刷机固件
- 20220427 更新配置，Release 默认保留3个
- 20220426 更新依赖安装命令，更新配置
- 20210827 更新配置，具体功能见截图
- 20210210 修正源码更新造成的编译错误，集成 `docker`。脚本文件调整
- 20201124 修正 `set-env` 有效性造成的编译错误
- 20200926 修正 `openclash` 编译错误
- 20200727 `docker` 兼容性造成编译错误，暂不集成

**界面截图**

![N1_OpenWRT.png](https://github.com/huangqian8/Cloud-N1-OpenWrt/blob/main/snapshot.png)

## 感谢 ❤️
- 源码来源： Lean 的 Openwrt 源码仓库 https://github.com/coolsnowwolf/lede
- 脚本来源： P3TERX 的 使用 GitHub Actions 云编译 OpenWrt https://github.com/P3TERX/Actions-OpenWrt
- 打包脚本： Flippy 的 OpenWrt 打包脚本 Actions https://github.com/ophub/flippy-openwrt-actions