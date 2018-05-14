#!/bin/sh

# Prepare install.tar.gz-s for WSL app updates

set -e
if [ -z "$2" ]; then
    echo "Usage:"
    echo " $0 <xenial|bionic> <target directory>"
    exit 1
fi
release=$1
target=$2

case $1 in
    xenial)
        mkdir -p ${target}/x64
        cd ${target}
        rm -f SHA256SUMS.gpg SHA256SUMS
        for i in ${release}-server-cloudimg-amd64-root.tar.gz SHA256SUMS.gpg SHA256SUMS; do
            wget -c https://cloud-images.ubuntu.com/${release}/current/$i
        done
        gpg --verify SHA256SUMS.gpg SHA256SUMS
        sha256sum -c SHA256SUMS 2>&1 | grep OK
        mv ${release}-server-cloudimg-amd64-root.tar.gz x64/install.tar.gz
        ;;
    bionic)
        mkdir -p ${target}/x64 ${target}/ARM64
        cd ${target}
        rm -f SHA256SUMS.gpg SHA256SUMS
        for i in ${release}-server-cloudimg-amd64.squashfs ${release}-server-cloudimg-arm64.squashfs SHA256SUMS.gpg SHA256SUMS; do
            wget -c https://cloud-images.ubuntu.com/${release}/current/$i
        done
        gpg --verify SHA256SUMS.gpg SHA256SUMS
        sha256sum -c SHA256SUMS 2>&1 | grep OK
        fakeroot bash -c  "unsquashfs ${release}-server-cloudimg-amd64.squashfs && (cd squashfs-root/ && tar -czf ../x64/install.tar.gz *) && rm -rf squashfs-root"
        fakeroot bash -c "unsquashfs ${release}-server-cloudimg-arm64.squashfs && (cd squashfs-root/ && tar -czf ../ARM64/install.tar.gz *) && rm -rf squashfs-root"
        rm ${release}-server-cloudimg-amd64.squashfs ${release}-server-cloudimg-arm64.squashfs
esac
