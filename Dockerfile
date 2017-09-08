FROM debian:9.1

MAINTAINER Sakari Kapanen sakari.m.kapanen@gmail.com

COPY ./esp-open-sdk /tmp/esp-open-sdk

ENV DEVEL_DEPS make perl nodejs python

ENV BUILD_DEPS \
  libtool-bin gcc g++ gperf automake autoconf flex bison texinfo \
  help2man sed gawk ncurses-dev wget bzip2 libexpat-dev python-pip

RUN useradd -U ctng && chown -R ctng:ctng /tmp \
  && apt-get update \
  && apt-get install -y $DEVEL_DEPS $BUILD_DEPS \
  && pip install esptool \
  && rm -rf /var/lib/apt/lists

USER ctng:ctng
RUN cd /tmp/esp-open-sdk \
  && echo "CT_DEBUG_gdb=n" >> crosstool-config-overrides \
  && make toolchain libhal STANDALONE=n

USER root
RUN mv /tmp/esp-open-sdk/xtensa-lx106-elf /opt \
  && chown -R root:root /opt \
  && rm -rf /tmp/esp-open-sdk \
  && apt-get remove --purge -y --allow-remove-essential $BUILD_DEPS \
  && apt-get autoremove -y

ENV PATH=/opt/xtensa-lx106-elf/bin:$PATH

