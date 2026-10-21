#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker run -d --name devops-a16-browser --label assignment=16 -p 8090:5000 devops-a16-app:local
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8090/health
docker exec devops-a16-browser head -3 /etc/os-release
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 06-actual-application-page --url http://127.0.0.1:8090
docker ps --filter label=assignment=16
docker rm -f devops-a16-browser
