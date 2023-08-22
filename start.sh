#!/usr/bin/env sh

ulimit -n 1000000
sysctl -w "net.ipv4.ip_forward=1"
sysctl -w "fs.file-max=1000000"
sed -i "s|SUBS_URL_PLACEHOLDER|${SUBS_URL}|g" /data/config.yaml
/usr/bin/clash -d /data