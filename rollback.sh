#!/bin/bash

BACKUP=$(ls -t /root/vps-toolkit-backup/*.tar.gz 2>/dev/null | head -1)

if [ -z "$BACKUP" ]; then
 echo "No backup found"
 exit 1
fi

tar xzf $BACKUP -C /

echo "Rollback completed"
