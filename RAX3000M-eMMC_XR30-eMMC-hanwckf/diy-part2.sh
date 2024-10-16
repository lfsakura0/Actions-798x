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

# Modify default IP/自定义管理地址ip
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

##移除要替换的包
rm -rf feeds/packages/net/open-app-filter
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-alist
#rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-smartdns
# rm -rf feeds/luci/themes/luci-theme-design

##添加额外插件/内容
# 5G模块驱动和插件
#git clone https://github.com/4IceG/luci-app-3ginfo-lite.git package/luci-app-3ginfo-lite
git clone https://github.com/4IceG/luci-app-modemband package/luci-app-modemband
#svn co https://github.com/kiddin9/kwrt-packages/trunk/luci-app-3ginfo-lite package/luci-app-3ginfo-lite
#svn co https://github.com/kiddin9/kwrt-packages/trunk/luci-app-modem package/luci-app-modem








#主题
# git clone --depth=1 -b js https://github.com/kenzok78/luci-theme-design.git  package/luci-theme-design
git clone --depth=1 https://github.com/derisamedia/luci-theme-alpha package/luci-theme-alpha

# golang版本1.2以上
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# Passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall

# 小猫咪
git clone --depth=1 https://github.com/vernesong/OpenClash package/luci-app-openclash

# 系统监控
#git clone --depth=1 https://github.com/muink/luci-app-netdata package/luci-app-netdata

# 网络测速/测试
#git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
#git clone https://github.com/muink/luci-app-netspeedtest package/luci-app-netspeedtest


# SmartDNS
git clone --depth=1 -b master https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

# MosDNS
git clone --depth=1 -b v5 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# Alist
git clone --depth=1 https://github.com/sbwml/luci-app-alist package/luci-app-alist

##-----------------Add OpenClash dev core------------------
# curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
# tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
# chmod +x /tmp/clash >/dev/null 2>&1
# mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
# mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
# rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

##-----------------Delete DDNS's examples-----------------
# sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
##-----------------Manually set CPU frequency for MT7981B-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo
