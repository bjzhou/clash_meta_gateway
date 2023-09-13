#!/usr/bin/env bash

opkg update
opkg install unzip

if hash nft; then
    opkg install kmod-nft-tproxy
else
    opkg install iptables-mod-tproxy
fi

mkdir -p /opt/clash
cd /opt/clash
curl -L https://ghproxy.com/https://github.com/bjzhou/clash_meta_gateway/archive/refs/heads/openwrt.zip -o openwrt.zip
unzip openwrt.zip -d .
mv clash_meta_gateway-openwrt/rootfs/etc/init.d/clash /etc/init.d/
mv clash_meta_gateway-openwrt/rootfs/opt/clash/* .
rm -rf clash_meta_gateway-openwrt
rm -rf openwrt.zip
chmod +x /opt/clash/bin/clash
chmod +x /opt/clash/bin/clash-rules
chmod +x /etc/init.d/clash

if [[ "$1" ]]
then
    SUBS_URL=${1//&/\\&}
    sed -i "s|SUBS_URL_PLACEHOLDER|${SUBS_URL}|g" /opt/clash/config.yaml
else
    echo "modify /opt/clash/config.yaml to add subs url then run command '/etc/init.d/clash restart'"
fi


/etc/init.d/clash enable
/etc/init.d/clash start
