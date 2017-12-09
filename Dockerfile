FROM alpine:3.7

LABEL maintainer="Sakari Kapanen sakari.m.kapanen@gmail.com"

COPY . /tmp/build

ENV TOOLCHAIN_DIR=/opt/xtensa-lx106-elf \
  DEVEL_DEPS="make grep sed" \
  BUILD_DEPS="libtool gcc g++ gperf automake autoconf flex bison texinfo xz \
    file help2man gawk ncurses-dev wget bzip2 patch ca-certificates"
ENV PATH=$TOOLCHAIN_DIR/bin:$PATH

RUN adduser -D ctng \
  && mkdir -p $TOOLCHAIN_DIR/.. \
  && chown -R ctng $TOOLCHAIN_DIR/.. \
  && chown -R ctng /tmp/build \
  && apk update \
  && apk add --no-cache $DEVEL_DEPS \
  && apk add --no-cache --virtual build-deps $BUILD_DEPS \
  && su - ctng -c "cd /tmp/build && ./build-ctng $TOOLCHAIN_DIR" \
  && chown -R root:root $TOOLCHAIN_DIR/.. \
  && rm -rf /tmp/build \
  && apk del build-deps
