#!/bin/bash
set -euo pipefail

echo "🔧 Applying custom feeds and packages..."

# 清理旧内容（防止重复）
rm -rf package/luci-app-parentcontrol

# 清除 feeds.conf.default 中可能存在的旧条目
sed -i '/helloworld/d; /passwall/d; /nikki/d' ./feeds.conf.default

# 添加主流代理生态（按推荐顺序）
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> ./feeds.conf.default
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git" >> ./feeds.conf.default
echo "src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git" >> ./feeds.conf.default

# 手动添加家长控制（不在 feeds 中）
git clone --depth=1 https://github.com/sirpdboy/luci-app-parentcontrol.git package/luci-app-parentcontrol

# 可选：如需 homeproxy（ImmortalWrt 生态）
# git clone --depth=1 https://github.com/immortalwrt/homeproxy.git package/homeproxy

echo "✅ diy-part1.sh completed."