FROM alpine:3.6

LABEL maintainer="Sakari Kapanen sakari.m.kapanen@gmail.com"

COPY . /tmp/build

ENV DEVEL_DEPS make python
ENV BUILD_DEPS \
  libtool gcc g++ gperf automake autoconf flex bison texinfo \
  help2man sed gawk ncurses-dev wget bzip2 patch py-pip ca-certificates

RUN adduser -D ctng \
  && chown -R ctng /tmp/build \
  && apk update \
  && apk add --no-cache $DEVEL_DEPS \
  && apk add --no-cache --virtual build-deps $BUILD_DEPS \
  && pip install esptool==2.1 \
  && su - ctng -c "cd /tmp/build && ./build-ctng" \
  && mv /tmp/build/xtensa-lx106-elf /opt \
  && chown -R root:root /opt/xtensa-lx106-elf \
  && rm -rf /tmp/build \
  && apk del build-deps

ENV PATH=/opt/xtensa-lx106-elf/bin:$PATH

