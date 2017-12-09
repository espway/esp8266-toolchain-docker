# esp8266-toolchain-docker

A simple Dockerfile and build script for building the `xtensa-lx106-elf` toolchain required by [`esp-open-rtos`](https://github.com/SuperHouse/esp-open-rtos).
Uses [`crosstool-NG`](http://crosstool-ng.github.io) for toolchain generation, accompanied with the `xtensa-lx106` overlay (under directory `overlays`) acquired from [Max Filippov's repository](https://github.com/jcmvbkbc/xtensa-toolchain-build).

The built toolchain image has `gcc-6.3.0`. It doesn't have `libc` (as that's provided by `esp-open-rtos`). However it has `lx106-hal` built from [tommie's repo](https://github.com/tommie/lx106-hal).
