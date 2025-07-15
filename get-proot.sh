#!/bin/bash

set -e
shopt -s nullglob

. ./config

cd "$BUILD_DIR"

if [ -d "proot-$PROOT_V" ] ; then exit 0 ; fi

wget -O - "https://github.com/atsamd21/proot/archive/refs/tags/v$PROOT_V.tar.gz" | tar -xzv
