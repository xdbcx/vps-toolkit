#!/bin/bash
set -e

APP=/opt/vps-toolkit
BACKUP=/root/vps-toolkit-backup
REPO=https://raw.githubusercontent.com/xdbcx/vps-toolkit/main

mkdir -p $BACKUP

tar czf $BACKUP/backup-$(date +%F-%H%M).tar.gz $APP 2>/dev/null || true

CURRENT=$(cat $APP/version)
LATEST=$(curl -fsSL $REPO/version)

echo "Current: $CURRENT"
echo "Latest : $LATEST"

if [ "$CURRENT" = "$LATEST" ]; then
 echo "Already latest"
 exit 0
fi

echo "Updating..."

cd /tmp
rm -rf vps-toolkit-update
git clone -q $REPO vps-toolkit-update 2>/dev/null || true

if [ -d /tmp/vps-toolkit-update ]; then
 cp -rf /tmp/vps-toolkit-update/modules $APP/
 cp -f /tmp/vps-toolkit-update/version $APP/
 cp -f /tmp/vps-toolkit-update/*.sh $APP/
fi

chmod +x $APP/*.sh

echo "Update completed"
