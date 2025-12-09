#!/bin/bash
set -euo pipefail

echo "🔧 Applying custom feeds and packages..."

# Clean up previous attempts
rm -rf package/helloworld package/luci-app-parentcontrol

# Remove existing helloworld/lienol entries to avoid duplicates
sed -i '/helloworld/d; /lienol/d' ./feeds.conf.default

# Add custom feeds (method 3 from helloworld README)
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> ./feeds.conf.default
echo "src-git lienol https://github.com/Lienol/openwrt-package.git" >> ./feeds.conf.default

# Optional: Add nikki (uncomment if needed)
# echo "src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main" >> ./feeds.conf.default

# Clone development packages not in feeds
git clone --depth=1 https://github.com/sirpdboy/luci-app-parentcontrol.git package/luci-app-parentcontrol

# Optional: homeproxy (uncomment if needed)
# git clone --depth=1 https://github.com/immortalwrt/homeproxy.git package/homeproxy

echo "✅ diy-part1.sh completed."