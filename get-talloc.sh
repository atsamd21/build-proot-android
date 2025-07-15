#!/bin/bash

set -e
shopt -s nullglob

. ./config

cd "$BUILD_DIR"

if [ -d "talloc-$TALLOC_V" ] ; then exit 0 ; fi

wget -O - "https://download.samba.org/pub/talloc/talloc-$TALLOC_V.tar.gz" | tar -xzv

sudo apt-get install gawk -y

install_ndk() {
    echo -e "Setting up Android NDK..."

    mkdir -p "$ANDROID_SDK_ROOT"

    if [ ! -d "$NDK_ROOT" ]; then
        echo "Downloading Android NDK..."
        wget "$NDK_DOWNLOAD_URL" -O "/tmp/${NDK_FILENAME}" || {
            echo -e "Failed to download Android NDK"
            exit 1
        }

        echo "Extracting NDK..."
        unzip -q "/tmp/${NDK_FILENAME}" -d "$ANDROID_SDK_ROOT"
        rm "/tmp/${NDK_FILENAME}"
        mv "$ANDROID_SDK_ROOT/android-ndk-r25b" "$NDK_ROOT"
    fi

    if [ ! -f "$NDK_ROOT/ndk-build" ]; then
        echo -e "NDK installation failed"
        exit 1
    fi

    echo -e "NDK installed successfully"
}

install_ndk
