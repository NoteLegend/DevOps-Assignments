#!/usr/bin/env bash
set -euo pipefail
current_date=$(date --iso-8601=seconds)
host_name=$(hostname)
user_name=$(whoami)
echo "Date: $current_date"
echo "Hostname: $host_name"
echo "Username: $user_name"
echo 'Disk usage:'
df -h .
echo 'Running processes:'
ps -eo pid,ppid,user,stat,comm
read -r -p 'Directory name for the process report: ' report_dir
if [[ ! "$report_dir" =~ ^[a-zA-Z0-9_-]+$ ]]; then
 echo 'Use a simple directory name containing letters, digits, underscores or hyphens.' >&2
 exit 1
fi
mkdir -p -- "$report_dir"
report_file="$report_dir/processes.txt"
touch -- "$report_file"
ps -eo pid,ppid,user,stat,comm > "$report_file"
echo "Saved process report to $report_file"
