#!/usr/bin/env bash
set -euxo pipefail
cat /etc/os-release
adduser --version
useradd --help | sed -n '1,12p'
if ! id practicaltest; then sudo adduser --disabled-password --gecos 'DevOps assignment test user' practicaltest; fi
id practicaltest
sudo test -d /home/practicaltest
getent passwd practicaltest
sudo userdel -r practicaltest
if id practicaltest; then exit 1; else echo 'Test account removed after verification.'; fi
systemctl status docker --no-pager
journalctl -u docker -n 10 --no-pager
mkdir -p /tmp/devops-cheatsheet
cd /tmp/devops-cheatsheet
printf 'INFO demo\nERROR sample\n' > sample.log
less -F sample.log
more sample.log
sudo chown devops:devops sample.log
stat -c '%U:%G %a %n' sample.log
vmstat 1 2
iostat -xz 1 2
sar -u 1 2
nice -n 10 sleep 60 &
demo_pid=$!
renice -n 15 -p "$demo_pid"
kill "$demo_pid"
wait "$demo_pid" || true
rsync -av sample.log synced.log
cmp sample.log synced.log
file sample.log
lsof -i :22 || true
strace -e openat cat sample.log
ss -tulwn
sudo systemctl restart docker
systemctl is-active docker
sudo apt-get check
rm sample.log synced.log
