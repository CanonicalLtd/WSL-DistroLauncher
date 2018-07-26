#!/bin/sh

# Prepare USB image to be attached to a Windows System to build the app

set -e

image="$1"

[ -n "$image" ] || (printf " Usage: $0 <image path>\n" ; exit 1)
! [ -e "$image" ] || (printf "Image already exist!\n" ; exit 1)

# prepare image, count is multiple of 63 to avoid mtools complaints
dd bs=1M count=2016 if=/dev/zero of="$image"
mkfs.vfat "$image"

# export source into the image
src_dir=$(mktemp -d)
trap "rm -rf ${src_dir}" EXIT
git archive HEAD | tar -C "$src_dir" -xf -

mcopy -i "$image" -s "$src_dir"/* ::

# copy install.tar.gz-s, too, if they exist
mcopy -i "$image" -s x64 :: || true
mcopy -i "$image" -s ARM64 :: || true

