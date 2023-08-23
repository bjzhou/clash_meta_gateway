#!/usr/bin/env sh

ulimit -n 1000000
sysctl -w "net.ipv4.ip_forward=1"
sysctl -w "fs.file-max=1000000"

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


/usr/bin/clash -d /data