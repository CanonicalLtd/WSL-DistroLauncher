#!/bin/sh

# Copyright (c) 2018-2019 Canonical
# Author: Balint Reczey <rbalint@ubuntu.com>
#
# All rights reserved.

# Prepare install.tar.gz-s for WSL app updates

set -e

arch_to_win_arch() {
    case $1 in
        amd64)
            echo x64
            ;;
        arm64)
            echo ARM64
            ;;
    esac
}

if [ -z "$1" -o -n "$2" ]; then
    echo "Usage:"
    echo " $0 <release>"
    echo "Download latest tarballs for the release and save them in the"
    echo "structure expected by the WSL app's build script."
    exit 1
fi

release=$1
base_url="https://cloud-images.ubuntu.com/"

tmp_dir=$(mktemp -d ${PWD}/get-tars-XXXXXX)
trap "rm -r $tmp_dir" EXIT

cd ${tmp_dir}

for i in SHA256SUMS SHA256SUMS.gpg; do
    wget ${base_url}/${release}/current/$i
done
gpg --verify SHA256SUMS.gpg SHA256SUMS

for arch in amd64 arm64; do
    ! [ $release = "xenial" -a $arch = "arm64" ] || continue
    tarfile=${release}-server-cloudimg-${arch}-wsl.rootfs.tar.gz
    wget ${base_url}/${release}/current/${tarfile}
    sha256sum -c SHA256SUMS 2>&1 | grep OK
    win_arch=$(arch_to_win_arch ${arch})
    mkdir -p ../${win_arch}
    mv ${tarfile} ../${win_arch}/install.tar.gz
done
