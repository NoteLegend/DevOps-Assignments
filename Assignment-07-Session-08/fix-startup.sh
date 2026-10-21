#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker logs devops-a07-demo-frontend-1 --tail 4
docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml config -q
docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml up -d
curl --retry 15 --retry-connrefused --retry-delay 2 -fsS http://127.0.0.1:8081
