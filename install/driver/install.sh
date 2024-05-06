#!/usr/bin/env bash
set -e
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$script_dir/../.."

_pkgbase=ravenna-alsa-lkm
pkgver=$(printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)")
# sed -i 's/\.\.\/common/common/g' driver/*

sudo -- bash /dev/stdin <<EOF
set -e
apt install -y dkms

install -Dm644 install/driver/dkms.conf "/usr/src/${_pkgbase}-${pkgver}/dkms.conf"
cp -rv driver/* "/usr/src/${_pkgbase}-${pkgver}/"
cp -rv common "/usr/src/${_pkgbase}-${pkgver}/common"

dkms add -m ${_pkgbase} -v ${pkgver}
dkms build -m ${_pkgbase} -v ${pkgver}
dkms install -m ${_pkgbase} -v ${pkgver}

modprobe MergingRavennaALSA
EOF
