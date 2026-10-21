#!/usr/bin/env bash
set -euxo pipefail
mkdir -p work/links work/cheatsheet
cd work/links
printf 'original content\n' > original.txt
ln -s original.txt soft-link
ln original.txt hard-link
ls -li
stat -c '%n inode=%i links=%h type=%F' original.txt soft-link hard-link
cat soft-link hard-link
rm original.txt
if cat soft-link; then exit 1; else echo 'Symlink is dangling after target deletion (expected).'; fi
cat hard-link
rm soft-link hard-link
cd ../cheatsheet
pwd
printf 'INFO started\nERROR demo\nINFO finished\n' > app.log
ls -l
cp app.log copy.log
mv copy.log renamed.log
cat app.log
head -n 2 app.log
tail -n 1 app.log
grep ERROR app.log
chmod 640 app.log
stat -c '%a %n' app.log
find . -type f -name '*.log'
du -sh .
df -h .
ps -u "$(id -u)" -o pid,comm | head -20
sleep 60 &
demo_pid=$!
kill "$demo_pid"
wait "$demo_pid" || true
uname -a
hostname
whoami
id
groups
uptime
free -h
date --iso-8601=seconds
umask
lsblk -o NAME,SIZE,TYPE | head -20
systemctl --user list-units --type=service --state=running --no-pager | head -20
journalctl --user -n 5 --no-pager
journalctl -u docker.service -n 5 --no-pager
rm renamed.log
