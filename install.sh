#!/bin/bash
set -e
DIR=/opt/vps-toolkit
REPO=https://github.com/xdbcx/vps-toolkit.git

if ! command -v git >/dev/null; then
 apt update && apt install -y git
fi

rm -rf /tmp/vps-toolkit-install
git clone -q $REPO /tmp/vps-toolkit-install

mkdir -p $DIR
cp -rf /tmp/vps-toolkit-install/* $DIR/

chmod +x $DIR/*.sh
chmod +x $DIR/vps.sh

ln -sf $DIR/vps.sh /usr/local/bin/vt
ln -sf $DIR/vps.sh /usr/local/bin/vps-toolkit

echo Installed
cat $DIR/version
