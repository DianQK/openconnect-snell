FROM alpine:edge

LABEL maintainer="DianQK <dianqk@icloud.com>"

RUN apk update \
  && apk add --no-cache \
    unzip \
    upx \
  && wget -O snell-server.zip https://github.com/surge-networks/snell/releases/download/2.0.1/snell-server-v2.0.1-linux-amd64.zip \
  && unzip snell-server.zip \
  && upx --brute snell-server \
  && mv snell-server /usr/local/bin/

ENV GLIBC_VERSION 2.31-r0

ENV SERVER_HOST 0.0.0.0
ENV SERVER_PORT 8388
ENV PSK=
ENV OBFS http

EXPOSE ${SERVER_PORT}/tcp
EXPOSE ${SERVER_PORT}/udp

RUN apk add libgcc libstdc++
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget -O glibc.apk  https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk
RUN apk add glibc.apk
RUN wget -O glibc-bin.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-bin-2.31-r0.apk
RUN apk add glibc-bin.apk
RUN rm -rf glibc.apk glibc-bin.apk /var/cache/apk/*

ENV OC_USER=
ENV OC_PASSWD= 
ENV OC_AUTH_GROUP=
ENV OC_AUTH_CODE=
ENV OC_HOST=

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ openconnect

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
