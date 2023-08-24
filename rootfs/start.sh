#!/usr/bin/env sh

ulimit -n 1000000
sysctl -w "net.ipv4.ip_forward=1"
sysctl -w "fs.file-max=1000000"

SUBS_URL=${SUBS_URL//&/\\&}
main_interface=$(ip route get 8.8.8.8 | awk -- '{printf $5}')

if [ -e /.last_subs_url ]
then
    lastSubsUrl=`cat /.last_subs_url`
    if [ "$lastSubsUrl" != "$SUBS_URL" ]
    then
        sed -i "s|${lastSubsUrl}|${SUBS_URL}|g" /data/config.yaml
        echo ${SUBS_URL} > /.last_subs_url
    fi
else
    sed -i "s|SUBS_URL_PLACEHOLDER|${SUBS_URL}|g" /data/config.yaml
    echo ${SUBS_URL} > /.last_subs_url
fi

if [ "$main_interface" -ne "eth0" ]
then
    sed -i "s|: eth0|: $main_interface|g" /data/config.yaml
fi

/usr/bin/clash -d /data