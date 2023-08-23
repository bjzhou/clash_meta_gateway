FROM alpine:latest

ENV SUBS_URL=""

COPY start.sh /
ADD https://github.com/MetaCubeX/Clash.Meta/releases/download/v1.15.0/clash.meta-linux-amd64-compatible-v1.15.0.gz /
ADD data.tar.gz /

RUN apk add --no-cache iptables

RUN gunzip clash.meta-linux-amd64-compatible-v1.15.0.gz \
    && mv clash.meta-linux-amd64-compatible-v1.15.0 /usr/bin/clash \
    && chmod +x /usr/bin/clash \
    && rm -rf clash.meta-linux-amd64-compatible-v1.15.0.gz


ENTRYPOINT [ "/start.sh" ]