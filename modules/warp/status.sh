#!/bin/bash
systemctl status warp-svc --no-pager 2>/dev/null || echo WARP unavailable
