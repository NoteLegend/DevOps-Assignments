#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
for network in front data isolated; do docker network create --label devops.assignment=06 "devops-a06-$network"; done
docker run -d --name devops-a06-frontend --label devops.assignment=06 --network devops-a06-front nginx:alpine
docker run -d --name devops-a06-backend --label devops.assignment=06 --network devops-a06-front nginx:alpine
docker network connect devops-a06-data devops-a06-backend
python3 - <<'PYGEN'
from pathlib import Path
import secrets
p=Path('../../.local-tools/runtime/mysql.env');p.write_text('MYSQL_ROOT_PASSWORD='+secrets.token_hex(24)+'\nMYSQL_DATABASE=assignment\n');p.chmod(0o600)
PYGEN
docker run -d --name devops-a06-database --label devops.assignment=06 --network devops-a06-data --env-file /workspace/.local-tools/runtime/mysql.env mysql:8.0
for attempt in {1..60}; do if docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'; then break; fi; sleep 2; done
docker exec devops-a06-frontend ping -c 2 devops-a06-backend
docker exec devops-a06-backend ping -c 2 devops-a06-database
if docker exec devops-a06-frontend ping -c 1 -W 2 devops-a06-database; then exit 1; else echo 'Frontend cannot resolve isolated database: expected.'; fi
docker inspect devops-a06-backend --format '{{range $name,$network := .NetworkSettings.Networks}}{{$name}} {{end}}'
docker network ls --filter label=devops.assignment=06
docker pull httpd:2.4-alpine
docker run -d --name devops-a06-apache --label devops.assignment=06 --network host httpd:2.4-alpine
../../.local-tools/vm.sh 'curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://127.0.0.1:80'
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-apache-host-network --url http://127.0.0.1:8088
mkdir -p bind-site
printf '<h1>Hello students</h1>\n' > bind-site/index.html
docker run -d --name devops-a06-bind --label devops.assignment=06 -p 8081:80 --mount "type=bind,source=/workspace/DevOps-Assignments/Assignment-06-Session-07/bind-site,target=/usr/share/nginx/html,readonly" nginx:alpine
curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://127.0.0.1:8081 | tee evidence/bind-before.html
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 03-bind-before --url http://127.0.0.1:8081
docker inspect devops-a06-bind --format '{{.Id}} {{.State.StartedAt}}' > evidence/bind-container-before.txt
printf '<h1>Hello students — updated without restart</h1>\n' > bind-site/index.html
curl -fsS http://127.0.0.1:8081 | tee evidence/bind-after.html
grep -q 'updated without restart' evidence/bind-after.html
docker inspect devops-a06-bind --format '{{.Id}} {{.State.StartedAt}}' > evidence/bind-container-after.txt
cmp evidence/bind-container-before.txt evidence/bind-container-after.txt
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 04-bind-after --url http://127.0.0.1:8081
docker ps --filter label=devops.assignment=06 --format 'table {{.Names}}\t{{.Ports}}\t{{.Status}}'
