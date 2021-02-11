#!/bin/bash -ex

# Remove docs and postgres references
rm -rf /opt/td-agent/embedded/share/doc \
  /opt/td-agent/embedded/share/gtk-doc \
  /opt/td-agent/embedded/lib/postgresql \
  /opt/td-agent/embedded/bin/postgres \
  /opt/td-agent/embedded/share/postgresql

curl -Lo /tmp/tini.deb https://github.com/krallin/tini/releases/download/v0.19.0/tini_0.19.0-amd64.deb
curl -Lo /tmp/watchexec.deb https://github.com/watchexec/watchexec/releases/download/1.14.0/watchexec-1.14.0-x86_64-unknown-linux-gnu.deb
apt-get install -y -q --no-install-recommends \
  /tmp/tini.deb \
  /tmp/watchexec.deb

apt-get remove -y make g++
apt-get autoremove -y
apt-get clean -y

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
