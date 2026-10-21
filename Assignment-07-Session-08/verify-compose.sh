#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
runtime_env=/workspace/.local-tools/runtime/mysql.env
for demo in basic compose-app demo; do
 if [[ "$demo" == demo ]]; then compose_file=demo/docker-compose.yml; else compose_file="$demo/compose.yaml"; fi
 project="devops-a07-$demo"
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" config -q
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" up -d --build
 for attempt in {1..60}; do if curl -fsS http://127.0.0.1:8081 > "evidence/$demo-response.html"; then break; fi; sleep 2; done
 if [[ "$demo" == demo ]]; then
  for attempt in {1..60}; do if curl -fsS http://127.0.0.1:8081/api > evidence/api.json; then break; fi; sleep 2; done
  grep -q 'Hello from MySQL' evidence/api.json
  /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-three-tier-app --url http://127.0.0.1:8081
  docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" exec -T backend python -c 'import socket; print("database DNS:",socket.gethostbyname("database"))'
 fi
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" ps
 docker volume ls --filter label=com.docker.compose.project="$project"
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" down -v
done
