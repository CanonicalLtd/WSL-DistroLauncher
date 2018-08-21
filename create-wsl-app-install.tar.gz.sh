#!/bin/sh

# Prepare install.tar.gz-s for WSL app updates

set -e
if [ -z "$2" ]; then
    echo "Usage:"
    echo " $0 <xenial|bionic> <target directory>"
    exit 1
fi

release=$1
target=$(readlink -f $2)

mkdir -p $target
tmp_dir=$(mktemp -d ${target}/get-tars-XXXXXX)
trap "rm -r $tmp_dir" EXIT

cd ${tmp_dir}
for i in SHA256SUMS.gpg SHA256SUMS; do
    wget https://cloud-images.ubuntu.com/${release}/current/$i
done

case $release in
    xenial)
        for arch in amd64; do
            wget https://cloud-images.ubuntu.com/${release}/current/${release}-server-cloudimg-${arch}-root.tar.gz
        done
        ;;
    *) # bionic and later
        for arch in amd64 arm64; do
            wget https://cloud-images.ubuntu.com/${release}/current/${release}-server-cloudimg-${arch}-root.tar.xz
        done
esac

gpg --verify SHA256SUMS.gpg SHA256SUMS
sha256sum -c SHA256SUMS 2>&1 | grep OK

case $release in
    xenial)
        mkdir -p ../x64
        mv ${release}-server-cloudimg-amd64-root.tar.gz ../x64/install.tar.gz
        ;;
    *) # bionic and later
        mkdir -p ../x64 ../ARM64
        xzcat ${release}-server-cloudimg-amd64-root.tar.xz | gzip > ../x64/install.tar.gz
        xzcat ${release}-server-cloudimg-arm64-root.tar.xz | gzip > ../ARM64/install.tar.gz
esac
