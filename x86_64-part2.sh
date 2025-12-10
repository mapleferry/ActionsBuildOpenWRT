#!/bin/bash

# Modify default IP for x86_64 platform to 192.168.18.1
# Note: Retained only the most common path for IP modification
sed -i 's/192.168.1.1/192.168.18.1/g' package/base-files/files/bin/config_generate

# ----------------------------------------------------
# 优化：解决 Rust 语言包编译失败 (Error 2)
# ----------------------------------------------------
# 强制 Rust 相关的软件包使用单线程编译，减轻内存压力
# 编译 Rust 工具链时，GitHub Actions 的 7GB 内存常会超限
find feeds/packages/lang/rust/ -name Makefile | xargs -i sed -i 's/PKG_JOBS:=$(shell nproc)/PKG_JOBS:=1/g' {}

# ----------------------------------------------------
# 修复引导路径缺失导致的 cp 报错 (No such file or directory)
# ----------------------------------------------------
# 确保在编译镜像时，staging 引导目录结构完整
mkdir -p package/base-files/files/boot
touch package/base-files/files/boot/.placeholder