FROM alpine:latest

ADD rootfs.tar.gz /

ENV SUBS_URL=""

ENTRYPOINT [ "/start.sh" ]