FROM alpine:edge
MAINTAINER DianQK <dianqk@icloud.com>


ENV GLIBC_VERSION 2.29-r0

ENV SERVER_HOST 0.0.0.0
ENV SERVER_PORT 8388
ENV PSK=
ENV OBFS http
ENV ARGS=

ENV OC_USER=
ENV OC_AUTH_GROUP=
ENV OC_AUTH_CODE=
ENV OC_HOST=

RUN apk update \
  && apk add --no-cache \
    unzip \
    upx \
  && wget -O snell-server.zip https://github.com/surge-networks/snell/releases/download/v${SNELL_VERSION}/snell-server-v${SNELL_VERSION}-linux-amd64.zip \
  && unzip snell-server.zip \
  && upx --brute snell-server \
  && mv snell-server /usr/local/bin/

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && wget -O glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && wget -O glibc-bin.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
  && apk add glibc.apk glibc-bin.apk \
  && apk add --no-cache libstdc++ \
  && rm -rf glibc.apk glibc-bin.apk /etc/apk/keys/sgerrand.rsa.pub /var/cache/apk/*

RUN set -xe apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ openconnect

# echo "r4&7/8X8R9BW\n246935" | openconnect -v --user=songxutao  --authgroup=commonn-vpn sslvpn.sankuai.com --passwd-on-stdin
