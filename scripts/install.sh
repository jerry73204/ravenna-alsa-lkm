#!/usr/bin/env bash
set -e
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$script_dir/.."

_pkgbase=ravenna-alsa-lkm
pkgver=$(printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)")
sed -i 's/\.\.\/common/common/g' driver/*

sudo -- bash /dev/stdin <<EOF
set -e
apt install -y dkms

install -Dm644 scripts/dkms.conf "/usr/src/${_pkgbase}-${pkgver}/dkms.conf"
cp -rv driver/* "/usr/src/${_pkgbase}-${pkgver}/"
cp -rv common "/usr/src/${_pkgbase}-${pkgver}/common"

install -Dm644 Butler/LICENSE.md /usr/share/licenses/ravenna-alsa-daemon/COPYING
install -Dm644 scripts/ravenna-alsa.service /usr/lib/systemd/user/ravenna-alsa.service

install -d /opt/ravenna-alsa
cp -rv Butler/* /opt/ravenna-alsa/
install -Dm755 scripts/ravenna_start.sh /opt/ravenna-alsa/ravenna_start.sh
chmod +x /opt/ravenna-alsa/Merging_RAVENNA_Daemon
chmod 777 /opt/ravenna-alsa/merging_ravenna_daemon.conf
sh -c 'echo "web_app_path=/opt/ravenna-alsa/webapp/advanced/" >> /opt/ravenna-alsa/merging_ravenna_daemon.conf'

dkms add -m ${_pkgbase} -v ${pkgver}
dkms build -m ${_pkgbase} -v ${pkgver}
dkms install -m ${_pkgbase} -v ${pkgver}
EOF
