FROM debian:9.1

LABEL maintainer="Sakari Kapanen sakari.m.kapanen@gmail.com"

COPY . /tmp/build

ENV DEVEL_DEPS make python
ENV BUILD_DEPS \
  libtool-bin gcc g++ gperf automake autoconf flex bison texinfo \
  help2man sed gawk ncurses-dev wget bzip2 patch python-pip ca-certificates \
  python-setuptools

RUN useradd ctng \
  && chown -R ctng /tmp/build \
  && apt-get update \
  && apt-get install -y --no-install-recommends $DEVEL_DEPS $BUILD_DEPS \
  && pip install esptool==2.1 \
  && su - ctng -c "cd /tmp/build && ./build-ctng" \
  && mv /tmp/build/xtensa-lx106-elf /opt \
  && chown -R root:root /opt/xtensa-lx106-elf \
  && rm -rf /tmp/build \
  && apt-get remove -y --purge --allow-remove-essential $BUILD_DEPS \
  && apt-get autoremove -y --purge \
  && rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/xtensa-lx106-elf/bin:$PATH

