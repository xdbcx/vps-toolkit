#!/bin/bash
if command -v fail2ban-client >/dev/null 2>&1; then
    echo "fail2ban already installed"
else
    apt update
    apt install -y fail2ban
fi
systemctl enable --now fail2ban 2>/dev/null || true
fail2ban-client status 2>/dev/null || true
