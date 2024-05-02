#!/usr/bin/env bash
set -e
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$script_dir"

install -Dm644 LICENSE.md /usr/share/licenses/ravenna-alsa-daemon/COPYING
install -Dm644 ravenna-alsa.service /usr/lib/systemd/user/ravenna-alsa.service

install -d /opt/ravenna-alsa
install -Dm755 Merging_RAVENNA_Daemon /opt/ravenna-alsa/Merging_RAVENNA_Daemon
install -Dm644 merging_ravenna_daemon.conf /opt/ravenna-alsa/merging_ravenna_daemon.conf
cp -rv -t /opt/ravenna-alsa webapp
