# esp8266-toolchain-docker

A simple Dockerfile and build script for building the `xtensa-lx106-elf` toolchain required by [`esp-open-rtos`](https://github.com/SuperHouse/esp-open-rtos). Note that this toolchain is **experimental**, featuring very recent GCC (7.2.0). Newlib 2.0.0 is built, but this is mainly to enable building the C++ compiler. `esp-open-rtos` includes its own newlib.

Uses [`crosstool-NG`](http://crosstool-ng.github.io) for toolchain generation, accompanied with the `xtensa-lx106` overlay and patches (under directory `overlays` and `local-patches`) acquired from [Max Filippov's repository](https://github.com/jcmvbkbc/xtensa-toolchain-build).

The container also has `lx106-hal` built from [tommie's repo](https://github.com/tommie/lx106-hal), available to the compiler.
