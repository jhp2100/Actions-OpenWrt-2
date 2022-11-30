#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Exit with code 1 if error
set -e

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default settings


# Patch
# for i in $GITHUB_WORKSPACE/patches/*.patch; do patch --fuzz 3 -p0 < $i; done

# Set permissions
# chmod +x package/feeds/helloworld/luci-app-ssr-plus/root/etc/ssrplus/iptables_config.sh

#修改保留内存到1M
# sed -i '/vm.min_free_kbytes=/d' package/base-files/files/etc/sysctl.conf
# echo 'vm.min_free_kbytes=1024' >> package/base-files/files/etc/sysctl.conf

# bbr & cake
echo 'net.ipv4.tcp_congestion_control=bbr' >> package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.default_qdisc=cake' >> package/base-files/files/etc/sysctl.d/10-default.conf
echo 'vm.min_free_kbytes=1024' >> package/base-files/files/etc/sysctl.d/10-default.conf
