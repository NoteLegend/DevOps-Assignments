#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker version
folders=(nodejs-app python-app java-app Apache-app React-app nginx-app)
container_ports=(3000 8000 8080 80 80 80)
for i in "${!folders[@]}"; do
 folder=${folders[$i]}
 name="devops-a04-${folder,,}"
 host_port=$((8081+i))
 docker build -t "$name:local" "$folder"
 docker run -d --name "$name" --label devops.assignment=04 -p "$host_port:${container_ports[$i]}" "$name:local"
 for attempt in {1..30}; do
  if curl -fsS "http://127.0.0.1:$host_port" > "evidence/$folder-response.html"; then break; fi
  sleep 2
 done
 if [[ "$folder" == React-app ]]; then curl -fsS "http://127.0.0.1:$host_port/app.js" -o /dev/null; else grep -q 'Hello World' "evidence/$folder-response.html"; fi
 docker logs "$name"
done
docker ps --filter label=devops.assignment=04 --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}'
