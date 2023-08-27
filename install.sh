#!/usr/bin/env bash

for p in unzip wget; do 
    if ! hash "$p" &>/dev/null
    then
        echo "$p is not installed, please install unzip wget"
        exit
    fi
done


mkdir -p /opt/clash
cd /opt/clash
wget -O openwrt.zip https://cdn-gh.hinnka.com/bjzhou/clash_meta_gateway/archive/refs/heads/openwrt.zip
unzip openwrt.zip -d .
mv clash_meta_gateway-openwrt/rootfs/etc/init.d/clash /etc/init.d/
mv clash_meta_gateway-openwrt/rootfs/opt/clash/* .
rm -rf clash_meta_gateway-openwrt
rm -rf openwrt.zip
chmod +x /opt/clash/bin/clash
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
