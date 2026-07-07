#!/bin/bash
set -e

DIR=/opt/vps-toolkit

if [ "$(id -u)" != "0" ]; then
 echo "Please run as root"
 exit 1
fi

mkdir -p $DIR

cp -rf modules config version update.sh rollback.sh vps-toolkit.sh $DIR/

chmod +x $DIR/*.sh

ln -sf $DIR/vps-toolkit.sh /usr/local/bin/vps-toolkit

echo "VPS Toolkit installed"
echo "Version:"
cat $DIR/version
