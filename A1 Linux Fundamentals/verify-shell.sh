#!/usr/bin/env bash
set -euxo pipefail
bash -n system-information.sh
printf 'system-report\n' | bash system-information.sh
test -s system-report/processes.txt
head -n 12 system-report/processes.txt
