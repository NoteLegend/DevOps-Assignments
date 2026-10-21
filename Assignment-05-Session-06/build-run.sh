#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker build -t devops-a05-multistage:local multi-stage-app
docker run -d --name devops-a05-multistage --label devops.assignment=05 -p 8080:8080 devops-a05-multistage:local
for attempt in {1..30}; do if curl -fsS http://127.0.0.1:8080 > evidence/multistage-response.html; then break; fi; sleep 2; done
grep -q 'Hello World from Docker multi-stage build' evidence/multistage-response.html
docker ps --filter label=devops.assignment=05 --format 'table {{.Names}}\t{{.Ports}}\t{{.Status}}'
for entry in 'nodejs-app:3000:8081' 'python-app:8000:8082' 'java-app:8080:8083'; do
 IFS=: read -r folder port host_port <<< "$entry"
 cp -r "../Assignment-04-Session-05/$folder" .
 docker build -t "devops-a05-$folder:local" "$folder"
 docker run -d --name "devops-a05-$folder" --label devops.assignment=05 -p "$host_port:$port" "devops-a05-$folder:local"
 for attempt in {1..30}; do if curl -fsS "http://127.0.0.1:$host_port" > "evidence/$folder-response.html"; then break; fi; sleep 2; done
 grep -q 'Hello World' "evidence/$folder-response.html"
done
docker ps --filter label=devops.assignment=05 --format 'table {{.Names}}\t{{.Ports}}\t{{.Status}}'
