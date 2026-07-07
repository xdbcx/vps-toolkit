#!/bin/bash
systemctl status x-ui --no-pager 2>/dev/null || true
ps aux | grep xray | grep -v grep || true
