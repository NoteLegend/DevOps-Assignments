# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker run -d --name devops-a16-browser --label assignment=16 -p 8090:5000 devops-a16-app:local
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8090/health
docker exec devops-a16-browser head -3 /etc/os-release
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 06-actual-application-page --url http://127.0.0.1:8090
docker ps --filter label=assignment=16
docker rm -f devops-a16-browser

```

```text
Executed 2026-10-07T14:16:39.009074+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-16-Session-17
Script: verify-page.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ docker run -d --name devops-a16-browser --label assignment=16 -p 8090:5000 devops-a16-app:local
d0f76a96548035eb51c949952b727fddbf51b7d4948ac84ad31b469ec01718fa
+ curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8090/health
curl: (56) Recv failure: Connection reset by peer
{"status":"healthy"}
+ docker exec devops-a16-browser head -3 /etc/os-release
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.24.2
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 06-actual-application-page --url http://127.0.0.1:8090
+ docker ps --filter label=assignment=16
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                                         NAMES
d0f76a965480   devops-a16-app:local   "python -m flask --a…"   6 seconds ago   Up 4 seconds   0.0.0.0:8090->5000/tcp, [::]:8090->5000/tcp   devops-a16-browser
+ docker rm -f devops-a16-browser
devops-a16-browser

```
