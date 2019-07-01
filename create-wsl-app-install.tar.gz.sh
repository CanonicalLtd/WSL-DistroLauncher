#!/bin/sh

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

if [ -z "$2" ]; then
    echo "Usage:"
    echo " $0 <xenial|bionic> <target directory>"
    exit 1
fi
release=$1
target=$(readlink -f $2)
base_url="https://partner-images.canonical.com/hyper-v/tmp/wsl"

mkdir -p $target
tmp_dir=$(mktemp -d ${target}/get-tars-XXXXXX)
trap "rm -r $tmp_dir" EXIT

cd ${tmp_dir}

# TODO enable checking the signature when download location moves to https://cloud-images.ubuntu.com/
for i in sha256sums; do
    wget ${base_url}/${release}/current/$i
done
# gpg --verify SHA256SUMS.gpg SHA256SUMS

for arch in amd64 arm64; do
    ! [ $release = "xenial" -a $arch = "arm64" ] || continue
    wget ${base_url}/${release}/current/livecd.ubuntu-cpc.wsl.rootfs.${arch}.tar.gz
    sha256sum -c sha256sums 2>&1 | grep OK
    win_arch=$(arch_to_win_arch ${arch})
    mkdir -p ../${win_arch}
    mv livecd.ubuntu-cpc.wsl.rootfs.${arch}.tar.gz ../${win_arch}/install.tar.gz
done
