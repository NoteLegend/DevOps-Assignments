#!/usr/bin/env bash
set -euxo pipefail
ip addr
ip -s link
ip route
ip route get 1.1.1.1
ip neigh
ss -tuln
ping -c 3 127.0.0.1
ping -c 3 -W 2 google.com || echo 'External ICMP did not receive replies; inspect HTTPS separately.'
traceroute -m 6 -w 1 google.com || true
netstat -tuln
printf 'GET / HTTP/1.0\r\nHost: google.com\r\n\r\n' | timeout 10 telnet google.com 80 || true
nslookup google.com
dig google.com
curl -sSI --max-time 20 https://www.google.com | sed '/^set-cookie:/Id'
arp -a
systemctl status systemd-networkd --no-pager
sudo timeout 8 tcpdump -i ens3 -nn -c 2 'port 53' &
capture_pid=$!
sleep 1
dig @10.0.2.3 example.org
wait "$capture_pid"
