#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/openwrt"

# Ensure custom first-boot scripts are executable
[ -d files/etc/uci-defaults ] && chmod +x files/etc/uci-defaults/*

# Prepare temporary clone directories
rm -rf theme-temp package-temp
mkdir -p theme-temp package-temp

# Add luci-theme-opentomcat
rm -rf package/lean/luci-theme-opentomcat
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git theme-temp/luci-theme-opentomcat
rm -rf theme-temp/luci-theme-opentomcat/LICENSE
rm -rf theme-temp/luci-theme-opentomcat/README.md
mv -f theme-temp/luci-theme-opentomcat package/lean/
rm -rf theme-temp

# Add luci-app-amlogic
mkdir -p package-temp
rm -rf package-temp/luci-app-amlogic package/lean/luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic.git package-temp/luci-app-amlogic
mv -f package-temp/luci-app-amlogic/luci-app-amlogic package/lean/
rm -rf package-temp

# Add luci-app-openclash
mkdir -p package-temp
rm -rf package-temp/OpenClash package/lean/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git package-temp/OpenClash
mv -f package-temp/OpenClash/luci-app-openclash package/lean/
rm -rf package-temp
