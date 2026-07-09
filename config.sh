#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/openwrt"
# 禁用 ksmbd 及相关包，避免当前内核与 ksmbd 3.5.4 不兼容
# ksmbd-server、ksmbd-tools、luci-app-ksmbd 和 autosamba 依赖 kmod-fs-ksmbd，必须一起禁用
rm -rf package/kernel/ksmbd \
       feeds/packages/net/ksmbd-tools \
       package/feeds/packages/ksmbd-tools \
       feeds/luci/applications/luci-app-ksmbd \
       package/feeds/luci/luci-app-ksmbd
touch .config
sed -i '/^# BEGIN Cloud-N1-OpenWrt custom config$/,/^# END Cloud-N1-OpenWrt custom config$/d' .config
cat >> .config <<EOF
# BEGIN Cloud-N1-OpenWrt custom config
# CONFIG_KMOD_FS_KSMBD is not set
# CONFIG_PACKAGE_kmod-fs-ksmbd is not set
# CONFIG_PACKAGE_ksmbd-server is not set
# CONFIG_PACKAGE_ksmbd-tools is not set
# CONFIG_PACKAGE_luci-app-ksmbd is not set
# CONFIG_PACKAGE_luci-i18n-ksmbd-zh-cn is not set
# CONFIG_PACKAGE_autosamba is not set

CONFIG_TARGET_armvirt=y
CONFIG_TARGET_armvirt_64=y
CONFIG_TARGET_armvirt_64_DEVICE_generic=y
CONFIG_BRCMFMAC_PCIE=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BTRFS_PROGS_ZSTD=y
# Docker依赖-cgroup挂载（禁用）
# CONFIG_CGROUPFS_MOUNT_KERNEL_CGROUPS is not set
# Docker依赖-cgroup选项（禁用）
# CONFIG_DOCKER_CGROUP_OPTIONS is not set
# Docker依赖-macvlan网络（禁用）
# CONFIG_DOCKER_NET_MACVLAN is not set
# Docker可选功能（禁用）
# CONFIG_DOCKER_OPTIONAL_FEATURES is not set
# Docker存储驱动ext4（禁用）
# CONFIG_DOCKER_STO_EXT4 is not set
CONFIG_DRIVER_11AC_SUPPORT=y
CONFIG_KERNEL_ARM_PMU=y
CONFIG_KERNEL_CFQ_GROUP_IOSCHED=y
CONFIG_KERNEL_CGROUP_DEVICE=y
CONFIG_KERNEL_CGROUP_FREEZER=y
CONFIG_KERNEL_CGROUP_HUGETLB=y
CONFIG_KERNEL_CGROUP_NET_PRIO=y
CONFIG_KERNEL_CGROUP_PERF=y
CONFIG_KERNEL_EXT4_FS_POSIX_ACL=y
CONFIG_KERNEL_EXT4_FS_SECURITY=y
CONFIG_KERNEL_FS_POSIX_ACL=y
CONFIG_KERNEL_HUGETLBFS=y
CONFIG_KERNEL_HUGETLB_PAGE=y
CONFIG_KERNEL_MEMCG_SWAP_ENABLED=y
CONFIG_KERNEL_NET_CLS_CGROUP=y
CONFIG_KERNEL_PERF_EVENTS=y
CONFIG_KERNEL_TRANSPARENT_HUGEPAGE=y
CONFIG_KERNEL_TRANSPARENT_HUGEPAGE_ALWAYS=y
CONFIG_MBEDTLS_AES_C=y
CONFIG_MBEDTLS_CMAC_C=y
CONFIG_MBEDTLS_DES_C=y
CONFIG_MBEDTLS_ECP_DP_CURVE25519_ENABLED=y
CONFIG_MBEDTLS_ECP_DP_SECP256K1_ENABLED=y
CONFIG_MBEDTLS_ECP_DP_SECP256R1_ENABLED=y
CONFIG_MBEDTLS_ECP_DP_SECP384R1_ENABLED=y
CONFIG_MBEDTLS_ENTROPY_FORCE_SHA256=y
CONFIG_MBEDTLS_GCM_C=y
CONFIG_MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED=y
CONFIG_MBEDTLS_KEY_EXCHANGE_ECDHE_PSK_ENABLED=y
CONFIG_MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED=y
CONFIG_MBEDTLS_KEY_EXCHANGE_PSK_ENABLED=y
CONFIG_MBEDTLS_NIST_KW_C=y
CONFIG_MBEDTLS_RSA_NO_CRT=y
# IPv6 相关组件（禁用）
# CONFIG_PACKAGE_6in4 is not set
CONFIG_PACKAGE_MAC80211_DEBUGFS=y
CONFIG_PACKAGE_MAC80211_MESH=y
CONFIG_PACKAGE_TAR_BZIP2=y
CONFIG_PACKAGE_TAR_GZIP=y
CONFIG_PACKAGE_TAR_XZ=y
CONFIG_PACKAGE_TAR_ZSTD=y
# 阿里云盘WebDAV挂载（禁用）
# CONFIG_PACKAGE_aliyundrive-webdav is not set
CONFIG_PACKAGE_attr=y
CONFIG_PACKAGE_bash=y
CONFIG_PACKAGE_blkid=y
CONFIG_PACKAGE_brcmfmac-firmware-usb=y
CONFIG_PACKAGE_bsdtar=y
CONFIG_PACKAGE_btrfs-progs=y
CONFIG_PACKAGE_bzip2=y
# CA证书包，OpenClash下载订阅/核心依赖
CONFIG_PACKAGE_ca-bundle=y
# Docker依赖-cgroup挂载工具（禁用）
# CONFIG_PACKAGE_cgroupfs-mount is not set
# 文件属性修改工具
CONFIG_PACKAGE_chattr=y
# Docker依赖-容器运行时（禁用）
# CONFIG_PACKAGE_containerd is not set
# Docker客户端（禁用）
# CONFIG_PACKAGE_docker is not set
# Docker守护进程（禁用）
# CONFIG_PACKAGE_dockerd is not set
# 普通dnsmasq禁用，避免和dnsmasq-full冲突
# CONFIG_PACKAGE_dnsmasq is not set
# 完整版dnsmasq，OpenClash DNS功能依赖
CONFIG_PACKAGE_dnsmasq-full=y
CONFIG_PACKAGE_dosfstools=y
CONFIG_PACKAGE_f2fs-tools=y
CONFIG_PACKAGE_f2fsck=y
CONFIG_PACKAGE_fdisk=y
# HTTP下载工具，OpenClash订阅/核心下载依赖
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_gawk=y
CONFIG_PACKAGE_getopt=y
CONFIG_PACKAGE_hostapd-common=y
# 完整ip命令，OpenClash路由规则依赖
CONFIG_PACKAGE_ip-full=y
# CONFIG_PACKAGE_ip6tables is not set
CONFIG_PACKAGE_iptables-mod-conntrack-extra=y
CONFIG_PACKAGE_iptables-mod-iprange=y
CONFIG_PACKAGE_iptables-mod-socket=y
# TProxy透明代理规则，OpenClash依赖
CONFIG_PACKAGE_iptables-mod-tproxy=y
# IP集合规则，OpenClash分流依赖
CONFIG_PACKAGE_ipset=y
# CONFIG_PACKAGE_ipv6helper is not set
CONFIG_PACKAGE_iw=y
CONFIG_PACKAGE_iwinfo=y
CONFIG_PACKAGE_jq=y
CONFIG_PACKAGE_kmod-asn1-encoder=y
CONFIG_PACKAGE_kmod-br-netfilter=y
CONFIG_PACKAGE_kmod-brcmfmac=y
CONFIG_PACKAGE_kmod-brcmutil=y
CONFIG_PACKAGE_kmod-cfg80211=y
CONFIG_PACKAGE_kmod-crypto-cbc=y
CONFIG_PACKAGE_kmod-crypto-ccm=y
CONFIG_PACKAGE_kmod-crypto-cmac=y
CONFIG_PACKAGE_kmod-crypto-crc32c=y
CONFIG_PACKAGE_kmod-crypto-ctr=y
CONFIG_PACKAGE_kmod-crypto-gcm=y
CONFIG_PACKAGE_kmod-crypto-gf128=y
CONFIG_PACKAGE_kmod-crypto-ghash=y
CONFIG_PACKAGE_kmod-crypto-hmac=y
CONFIG_PACKAGE_kmod-crypto-lib-chacha20=y
CONFIG_PACKAGE_kmod-crypto-lib-chacha20poly1305=y
CONFIG_PACKAGE_kmod-crypto-lib-curve25519=y
CONFIG_PACKAGE_kmod-crypto-lib-poly1305=y
CONFIG_PACKAGE_kmod-crypto-rng=y
CONFIG_PACKAGE_kmod-crypto-seqiv=y
CONFIG_PACKAGE_kmod-crypto-sha256=y
CONFIG_PACKAGE_kmod-crypto-sha512=y
CONFIG_PACKAGE_kmod-dax=y
CONFIG_PACKAGE_kmod-dm=y
CONFIG_PACKAGE_kmod-dummy=y
# CONFIG_PACKAGE_kmod-e1000 is not set
CONFIG_PACKAGE_kmod-fs-btrfs=y
CONFIG_PACKAGE_kmod-ikconfig=y
CONFIG_PACKAGE_kmod-inet-diag=y
# CONFIG_PACKAGE_kmod-ip6tables is not set
CONFIG_PACKAGE_kmod-ipt-conntrack-extra=y
CONFIG_PACKAGE_kmod-ipt-iprange=y
# CONFIG_PACKAGE_kmod-ipt-nat6 is not set
CONFIG_PACKAGE_kmod-ipt-physdev=y
CONFIG_PACKAGE_kmod-ipt-socket=y
# TProxy内核模块，OpenClash透明代理依赖
CONFIG_PACKAGE_kmod-ipt-tproxy=y
CONFIG_PACKAGE_kmod-iptunnel=y
CONFIG_PACKAGE_kmod-iptunnel4=y
CONFIG_PACKAGE_kmod-keys-encrypted=y
CONFIG_PACKAGE_kmod-keys-trusted=y
CONFIG_PACKAGE_kmod-lib-crc32c=y
CONFIG_PACKAGE_kmod-lib-raid6=y
CONFIG_PACKAGE_kmod-lib-xor=y
CONFIG_PACKAGE_kmod-lib-zlib-deflate=y
CONFIG_PACKAGE_kmod-lib-zlib-inflate=y
CONFIG_PACKAGE_kmod-lib-zstd=y
CONFIG_PACKAGE_kmod-mac80211=y
CONFIG_PACKAGE_kmod-mmc=y
CONFIG_PACKAGE_kmod-netlink-diag=y
# CONFIG_PACKAGE_kmod-nf-ipt6 is not set
CONFIG_PACKAGE_kmod-nf-ipvs=y
# CONFIG_PACKAGE_kmod-nf-log6 is not set
# CONFIG_PACKAGE_kmod-nf-nat6 is not set
# CONFIG_PACKAGE_kmod-nf-reject6 is not set
CONFIG_PACKAGE_kmod-nf-socket=y
CONFIG_PACKAGE_kmod-oid-registry=y
CONFIG_PACKAGE_kmod-random-core=y
CONFIG_PACKAGE_kmod-sit=y
CONFIG_PACKAGE_kmod-tpm=y
# TUN虚拟网卡，OpenClash TUN模式依赖
CONFIG_PACKAGE_kmod-tun=y
CONFIG_PACKAGE_kmod-udptunnel4=y
CONFIG_PACKAGE_kmod-udptunnel6=y
CONFIG_PACKAGE_kmod-usb-core=y
CONFIG_PACKAGE_kmod-veth=y
CONFIG_PACKAGE_kmod-wireguard=y
CONFIG_PACKAGE_libarchive=y
CONFIG_PACKAGE_libatomic=y
CONFIG_PACKAGE_libattr=y
CONFIG_PACKAGE_libbz2=y
CONFIG_PACKAGE_libcap=y
CONFIG_PACKAGE_libcap-bin=y
CONFIG_PACKAGE_libcap-bin-capsh-shell="/bin/sh"
CONFIG_PACKAGE_libexpat=y
CONFIG_PACKAGE_libfdisk=y
CONFIG_PACKAGE_libgmp=y
CONFIG_PACKAGE_libltdl=y
CONFIG_PACKAGE_liblua5.3=y
CONFIG_PACKAGE_liblzma=y
CONFIG_PACKAGE_liblzo=y
CONFIG_PACKAGE_libmbedtls=y
CONFIG_PACKAGE_libmount=y
CONFIG_PACKAGE_libncurses=y
CONFIG_PACKAGE_libparted=y
CONFIG_PACKAGE_libreadline=y
CONFIG_PACKAGE_libseccomp=y
CONFIG_PACKAGE_libstdcpp=y
CONFIG_PACKAGE_libuv=y
CONFIG_PACKAGE_libwebsockets-full=y
CONFIG_PACKAGE_libzstd=y
CONFIG_PACKAGE_losetup=y
CONFIG_PACKAGE_lsattr=y
CONFIG_PACKAGE_lsblk=y
# 上网时间控制/家长控制（禁用）
# CONFIG_PACKAGE_luci-app-accesscontrol is not set
# DNS去广告服务器（禁用）
# CONFIG_PACKAGE_luci-app-adguardhome is not set
# 晶晨盒子管理工具，N1必备
CONFIG_PACKAGE_luci-app-amlogic=y
# IP/MAC绑定防ARP欺骗（禁用）
# CONFIG_PACKAGE_luci-app-arpbind is not set
# 动态DNS，域名绑定动态公网IP（禁用）
# CONFIG_PACKAGE_luci-app-ddns is not set
# Docker容器管理（禁用）
# CONFIG_PACKAGE_luci-app-docker is not set
# Docker Manager界面（禁用）
# CONFIG_PACKAGE_luci-app-dockerman is not set
# rclone网盘挂载WebUI（禁用）
# CONFIG_PACKAGE_luci-app-rclone_INCLUDE_rclone-ng is not set
# rclone网盘挂载WebUI（禁用）
# CONFIG_PACKAGE_luci-app-rclone_INCLUDE_rclone-webui is not set
# 科学上网SSR/SS/V2Ray/Trojan/Xray（禁用）
# CONFIG_PACKAGE_luci-app-ssr-plus is not set
# SSR客户端（禁用）
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client is not set
# SS混淆插件（禁用）
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Simple_Obfs is not set
# ChinaDNS-NG（禁用）
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ChinaDNS_NG is not set
# MosDNS（禁用）
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_MosDNS is not set
# OpenClash代理/分流插件，旁路由常用
CONFIG_PACKAGE_luci-app-openclash=y
# 网络加速套件
CONFIG_PACKAGE_luci-app-turboacc=y
# turboacc内置BBR拥塞控制算法
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_BBR_CCA=y
# turboacc内置Flow Offload流量分载
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_OFFLOADING=y
# turboacc内置Pdnsd DNS缓存
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_PDNSD=y
# 解锁网易云灰色歌曲（禁用）
# CONFIG_PACKAGE_luci-app-unblockmusic_INCLUDE_UnblockNeteaseMusic_Go is not set
# 自动端口转发UPnP（禁用）
# CONFIG_PACKAGE_luci-app-upnp is not set
# FTP服务器（已用vsftpd-alt替代）
# CONFIG_PACKAGE_luci-app-vsftpd is not set
# amlogic中文语言包
CONFIG_PACKAGE_luci-i18n-amlogic-zh-cn=y
# docker中文语言包（禁用）
# CONFIG_PACKAGE_luci-i18n-docker-zh-cn is not set
# dockerman中文语言包（禁用）
# CONFIG_PACKAGE_luci-i18n-dockerman-zh-cn is not set
# docker支持库（禁用）
# CONFIG_PACKAGE_luci-lib-docker is not set
# LuCI兼容库，OpenClash依赖
CONFIG_PACKAGE_luci-compat=y
# IPv6协议支持（禁用）
# CONFIG_PACKAGE_luci-proto-ipv6 is not set
# opentomcat简洁主题
CONFIG_PACKAGE_luci-theme-opentomcat=y
# UPnP守护进程（禁用）
# CONFIG_PACKAGE_miniupnpd is not set
CONFIG_PACKAGE_mount-utils=y
# CONFIG_PACKAGE_odhcp6c is not set
# CONFIG_PACKAGE_odhcpd-ipv6only is not set
CONFIG_PACKAGE_parted=y
# Pdnsd DNS缓存服务器（turboacc依赖）
CONFIG_PACKAGE_pdnsd-alt=y
CONFIG_PACKAGE_perl=y
CONFIG_PACKAGE_perl-http-date=y
CONFIG_PACKAGE_perlbase-base=y
CONFIG_PACKAGE_perlbase-bytes=y
CONFIG_PACKAGE_perlbase-charnames=y
CONFIG_PACKAGE_perlbase-class=y
CONFIG_PACKAGE_perlbase-config=y
CONFIG_PACKAGE_perlbase-cwd=y
CONFIG_PACKAGE_perlbase-dynaloader=y
CONFIG_PACKAGE_perlbase-errno=y
CONFIG_PACKAGE_perlbase-essential=y
CONFIG_PACKAGE_perlbase-fcntl=y
CONFIG_PACKAGE_perlbase-file=y
CONFIG_PACKAGE_perlbase-filehandle=y
CONFIG_PACKAGE_perlbase-getopt=y
CONFIG_PACKAGE_perlbase-i18n=y
CONFIG_PACKAGE_perlbase-integer=y
CONFIG_PACKAGE_perlbase-io=y
CONFIG_PACKAGE_perlbase-list=y
CONFIG_PACKAGE_perlbase-locale=y
CONFIG_PACKAGE_perlbase-params=y
CONFIG_PACKAGE_perlbase-posix=y
CONFIG_PACKAGE_perlbase-re=y
CONFIG_PACKAGE_perlbase-scalar=y
CONFIG_PACKAGE_perlbase-selectsaver=y
CONFIG_PACKAGE_perlbase-socket=y
CONFIG_PACKAGE_perlbase-symbol=y
CONFIG_PACKAGE_perlbase-tie=y
CONFIG_PACKAGE_perlbase-time=y
CONFIG_PACKAGE_perlbase-unicode=y
CONFIG_PACKAGE_perlbase-unicore=y
CONFIG_PACKAGE_perlbase-utf8=y
CONFIG_PACKAGE_perlbase-xsloader=y
CONFIG_PACKAGE_pigz=y
CONFIG_PACKAGE_pv=y
# Docker依赖-OCI容器运行时（禁用）
# CONFIG_PACKAGE_runc is not set
# Ruby运行环境，OpenClash配置解析依赖
CONFIG_PACKAGE_ruby=y
# Ruby YAML库，OpenClash配置解析依赖
CONFIG_PACKAGE_ruby-yaml=y
# tar归档工具
CONFIG_PACKAGE_tar=y
# 终端信息数据库
CONFIG_PACKAGE_terminfo=y
# Docker依赖-简易init进程（禁用）
# CONFIG_PACKAGE_tini is not set
# Web终端，通过浏览器访问SSH
CONFIG_PACKAGE_ttyd=y
# 解压工具，OpenClash核心/配置文件处理依赖
CONFIG_PACKAGE_unzip=y
CONFIG_PACKAGE_uuidgen=y
CONFIG_PACKAGE_wireguard-tools=y
CONFIG_PACKAGE_wireless-regdb=y
CONFIG_PACKAGE_wpa-cli=y
CONFIG_PACKAGE_wpad-basic=y
CONFIG_PACKAGE_xfs-fsck=y
CONFIG_PACKAGE_xfs-mkfs=y
CONFIG_PACKAGE_xz=y
CONFIG_PACKAGE_xz-utils=y
CONFIG_PARTED_READLINE=y
CONFIG_PERL_NOCOMMENT=y
CONFIG_PERL_THREADS=y
# CONFIG_TARGET_ROOTFS_CPIOGZ is not set
# CONFIG_TARGET_ROOTFS_EXT4FS is not set
# CONFIG_TARGET_ROOTFS_INITRAMFS is not set
CONFIG_TARGET_ROOTFS_PARTSIZE=512
CONFIG_TARGET_ROOTFS_TARGZ=y
# CONFIG_TARGET_ROOTFS_SQUASHFS is not set
CONFIG_WPA_MSG_MIN_PRIORITY=3
CONFIG_ZSTD_OPTIMIZE_O3=y
# CONFIG_PACKAGE_grub2-efi-arm is not set
# CONFIG_PACKAGE_kmod-crypto-kpp is not set
CONFIG_PACKAGE_kmod-fs-vfat=y
# iptables流量分载内核模块（turboacc依赖）
CONFIG_PACKAGE_kmod-ipt-offload=y
# Netfilter流表加速（turboacc依赖）
CONFIG_PACKAGE_kmod-nf-flow=y
# 字符集CP437支持
CONFIG_PACKAGE_kmod-nls-cp437=y
# 字符集ISO8859-1支持
CONFIG_PACKAGE_kmod-nls-iso8859-1=y
# 字符集UTF8支持
CONFIG_PACKAGE_kmod-nls-utf8=y
# BBR拥塞控制内核模块（turboacc依赖）
CONFIG_PACKAGE_kmod-tcp-bbr=y
# turboacc内置Shortcut-FE快速转发
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_SHORTCUT_FE_CM=y
# FTP服务器（轻量版）
CONFIG_PACKAGE_vsftpd-alt=y
# vsftpd使用UCI配置
CONFIG_VSFTPD_USE_UCI_SCRIPTS=y
# END Cloud-N1-OpenWrt custom config
EOF
