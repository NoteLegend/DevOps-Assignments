#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker run -d --name devops-a20-smoke --label assignment=20 -p 8080:8080 devops-a20-final:local
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8080/health
curl -fsS -H 'Content-Type: application/json' -d '{"marker":"actual-docker-storage-test"}' http://127.0.0.1:8080/storage
curl -fsS http://127.0.0.1:8080/storage
curl -fsS http://127.0.0.1:8080/metrics
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 09-final-docker-page --url http://127.0.0.1:8080
docker ps --filter label=assignment=20
docker logs --tail 6 devops-a20-smoke
docker rm -f devops-a20-smoke
