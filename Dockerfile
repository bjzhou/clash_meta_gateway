FROM alpine:latest

ADD rootfs.tar.gz /

ENV SUBS_URL=""

RUN apk add --no-cache iptables

ENTRYPOINT [ "/start.sh" ]