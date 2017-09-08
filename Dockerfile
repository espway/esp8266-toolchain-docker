FROM debian:9.1

MAINTAINER Sakari Kapanen sakari.m.kapanen@gmail.com

COPY ./esp-open-sdk /tmp/esp-open-sdk

ENV DEVEL_DEPS make perl nodejs python
ENV BUILD_DEPS \
  libtool-bin gcc g++ gperf automake autoconf flex bison texinfo \
  help2man sed gawk ncurses-dev wget bzip2 libexpat-dev python-pip

RUN apt-get update \
  && apt-get install -y $DEVEL_DEPS $BUILD_DEPS \
  && pip install esptool==2.1 \
  && useradd -U ctng && chown -R ctng:ctng /tmp/esp-open-sdk \
  && echo "CT_DEBUG_gdb=n" >> /tmp/esp-open-sdk/crosstool-config-overrides \
  && su - ctng -c "cd /tmp/esp-open-sdk && make toolchain libhal STANDALONE=n" \
  && mv /tmp/esp-open-sdk/xtensa-lx106-elf /opt \
  && chown -R root:root /opt/xtensa-lx106-elf \
  && rm -rf /tmp/esp-open-sdk \
  && apt-get remove --purge -y --allow-remove-essential $BUILD_DEPS \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists

ENV PATH=/opt/xtensa-lx106-elf/bin:$PATH

