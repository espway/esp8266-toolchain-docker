FROM alpine:3.6

MAINTAINER Sakari Kapanen sakari.m.kapanen@gmail.com

COPY ./esp-open-sdk /tmp/esp-open-sdk

RUN addgroup -S ctng && adduser -S -g ctng ctng && chown -R ctng:ctng /tmp \
  && apk add --no-cache make perl nodejs python \
  && apk add --no-cache --virtual build-dependencies \
       libtool gcc g++ gperf automake autoconf flex bison texinfo \
       help2man sed gawk ncurses-dev wget bzip2 expat-dev patch py-pip
  && pip install esptool

USER ctng:ctng
RUN cd /tmp/esp-open-sdk \
  && echo "CT_DEBUG_GDB=n" >> crosstool-config-overrides \
  && make toolchain libhal STANDALONE=n

USER root
RUN mkdir /opt \
  && cp -r xtensa-lx106-elf /opt \
  && chown -R root:root /opt \
  && rm -rf /tmp \
  && apk del build-dependencies

ENV PATH=/opt/xtensa-lx106-elf

