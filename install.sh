#!/usr/bin/env bash

for p in unzip wget; do 
    if ! hash "$p" &>/dev/null
    then
        echo "$p is not installed, please install unzip wget"
        exit
    fi
done

if [[ $EUID -ne 0 ]]
then
    echo "please run as root"
    exit
fi


useradd -r -s /bin/false clash

mkdir -p /opt/clash
cd /opt/clash
wget -O master.zip https://cdn-gh.hinnka.com/bjzhou/clash_meta_gateway/archive/refs/heads/master.zip
mkdir git_temp && unzip master.zip -d git_temp
mv git_temp/rootfs/* .
rm -rf git_temp
echo "[Unit]
Description=Clash-Meta Daemon, Another Clash Kernel.
After=network.target NetworkManager.service systemd-networkd.service iwd.service

[Service]
Type=simple
User=clash
Group=clash
LimitNPROC=500
LimitNOFILE=1000000
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE
Restart=always
ExecStartPre=/usr/bin/sleep 1s
ExecStart=/opt/clash/usr/bin/clash -d /opt/clash/data

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/clash.service


echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

if [[ "$1" ]]
then
    SUBS_URL=${1//&/\\&}
    if [ -e .last_subs_url ]
    then
        lastSubsUrl=`cat .last_subs_url`
        if [ "$lastSubsUrl" != "$SUBS_URL" ]
        then
            sed -i "s|${lastSubsUrl}|${SUBS_URL}|g" /opt/clash/data/config.yaml
            echo ${SUBS_URL} > .last_subs_url
        fi
    else
        sed -i "s|SUBS_URL_PLACEHOLDER|${SUBS_URL}|g" /opt/clash/data/config.yaml
        echo ${SUBS_URL} > .last_subs_url
    fi
else
    echo "modify /opt/clash/data/config.yaml to add subs url then run command 'systemctl restart clash'"
fi


systemctl enable clash.service
systemctl start clash.service
