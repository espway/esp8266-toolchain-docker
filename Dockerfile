FROM alpine:3.6

MAINTAINER Sakari Kapanen sakari.m.kapanen@gmail.com

ADD . /tmp

RUN apk add --no-cache make \
  && apk add --no-cache --virtual build-dependencies \
       libtool gcc g++ gperf automake autoconf flex bison texinfo \
       help2man sed gawk ncurses-dev

USER builder
RUN cd /tmp/esp-open-sdk \
  && cp -f ../crosstool-config-overrides . \
  && make toolchain libhal STANDALONE=n

USER root
RUN mkdir /opt \
  && cp -r xtensa-lx106-elf /opt \
  && cd / \
  && rm -rf /tmp \
  && apk del build-dependencies

