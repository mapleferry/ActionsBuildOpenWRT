#!/bin/bash

# Modify default IP for x86_64 platform to 192.168.18.1
# Note: Retained only the most common path for IP modification
sed -i 's/192.168.1.1/192.168.18.1/g' package/base-files/files/bin/config_generate


# 1. 确保 DIY 文件目录结构包含 /boot (这是让它进入固件 rootfs 的标准方式)
mkdir -p files/boot
touch files/boot/.placeholder

# 2. **关键修复**：在 OpenWrt 源码中创建 base-files 的 /boot 路径
mkdir -p package/base-files/files/boot
touch package/base-files/files/boot/.placeholder


# 3. 强制 Rust 相关的软件包使用单线程编译 (防止内存超限)
find feeds/packages/lang/rust/ -name Makefile | xargs -i sed -i 's/PKG_JOBS:=$(shell nproc)/PKG_JOBS:=1/g' {}


# ----------------------------------------------------
# 排除高风险软件包 (如果编译仍失败，可取消以下注释)
# ----------------------------------------------------
# # 禁用 luci-app-turboacc (涉及内核网络加速补丁，最可能是主要冲突源)
# sed -i 's/CONFIG_DEFAULT_luci-app-turboacc=y/# CONFIG_DEFAULT_luci-app-turboacc is not set/g' .config

# # 禁用 luci-app-ssr-plus (涉及复杂内核依赖和加密库，也容易出错)
# sed -i 's/CONFIG_DEFAULT_luci-app-ssr-plus=y/# CONFIG_DEFAULT_luci-app-ssr-plus is not set/g' .config

# # 禁用 MOLD 链接器
# sed -i 's/CONFIG_MOLD=y/# CONFIG_MOLD is not set/g' .config

# # 重新运行 make defconfig 以确保配置生效
# make defconfig