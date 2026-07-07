#!/bin/bash

if ! command -v iperf3 >/dev/null; then
 apt update
 apt install -y iperf3
fi

echo "iperf3 installed"
echo "TCP:"
echo "iperf3 -c SERVER_IP"
echo "UDP:"
echo "iperf3 -u -c SERVER_IP"
