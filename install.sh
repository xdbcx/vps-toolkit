#!/bin/bash
set -e
DIR=/opt/vps-toolkit
mkdir -p "$DIR"
cp -a ./* "$DIR/" 2>/dev/null || true
find "$DIR" -name "*.sh" -exec chmod +x {} \;
ln -sf "$DIR/vps.sh" /usr/local/bin/vt
ln -sf "$DIR/vps.sh" /usr/local/bin/vps-toolkit
echo "VPS Toolkit installed"
cat "$DIR/version"
