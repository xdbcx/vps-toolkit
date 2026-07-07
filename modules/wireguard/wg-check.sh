#!/bin/bash
echo "===== WireGuard Check ====="
if ! command -v wg >/dev/null 2>&1; then
    echo "WireGuard not installed"
    exit 0
fi
wg show
echo
echo "[Handshake Check]"
NOW=$(date +%s)
wg show all latest-handshakes 2>/dev/null | while read iface peer ts; do
    if [ "$ts" = "0" ] || [ -z "$ts" ]; then
        echo "WARNING: $iface peer $peer no handshake"
    else
        AGE=$((NOW-ts))
        echo "$iface peer $peer handshake ${AGE}s ago"
        [ "$AGE" -gt 300 ] && echo "WARNING: handshake older than 300s"
    fi
done
