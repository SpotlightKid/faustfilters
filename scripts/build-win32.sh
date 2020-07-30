#!/bin/bash

set -e

# Preparation
_FLAGS="-DPTW32_STATIC_LIB -Werror"
_ARCH=i686-w64-mingw32
_PREFIX="/usr/${_ARCH}"
export PATH=${_PREFIX}/bin:$PATH
export AR=${_ARCH}-ar
export CC=${_ARCH}-gcc
export CXX=${_ARCH}-g++
export PKG_CONFIG_PATH=${_PREFIX}/lib/pkgconfig
export WIN32=true
export CFLAGS="${_FLAGS}"
export CXXFLAGS="${_FLAGS}"
export LDFLAGS="-static"
export CROSS_COMPILING=true

# Start clean
make clean > /dev/null
make -C dpf clean > /dev/null
rm -rf bin-w32

# Build now
make HAVE_CAIRO=false HAVE_JACK=false
mv bin bin-w32
