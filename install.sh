#!/bin/bash -ex

apt-get update
apt-get install -y -q --no-install-recommends \
  curl ca-certificates make g++ sudo bash

/usr/bin/curl -sSL https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent4.sh | sh
