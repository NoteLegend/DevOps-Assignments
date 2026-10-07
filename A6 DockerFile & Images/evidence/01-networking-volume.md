# Executed commands and captured output

```bash
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

```

```text
Executed 2026-10-07T13:18:17.585684+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-06-Session-07
Script: network-volume.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ export DEVOPS_WORKSPACE=/home/rushixd/Wurk/Scaler/DevOps
++ DEVOPS_WORKSPACE=/home/rushixd/Wurk/Scaler/DevOps
++ export PATH=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0XEF9Mq:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0x3FaAZ:/home/rushixd/.local/npm/lib/node_modules/@openai/codex/node_modules/@openai/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-path:/home/rushixd/.local/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
++ PATH=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0XEF9Mq:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0x3FaAZ:/home/rushixd/.local/npm/lib/node_modules/@openai/codex/node_modules/@openai/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-path:/home/rushixd/.local/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
++ export MINIKUBE_HOME=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/minikube
++ MINIKUBE_HOME=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/minikube
++ export KUBECONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/kubeconfig
++ KUBECONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/kubeconfig
+ for network in front data isolated
+ docker network create --label devops.assignment=06 devops-a06-front
038977fa2c4ad1d0064ebc1b118e89260b68437668ef90a5c03cd653047c5802
+ for network in front data isolated
+ docker network create --label devops.assignment=06 devops-a06-data
1dabde3af4c5e02c10550ca2057871481da436dfe0d27dc18979be75318e8578
+ for network in front data isolated
+ docker network create --label devops.assignment=06 devops-a06-isolated
3010b54aeb717a19ebe333989fe9b8e40a5523969932f154604d41de2a57f2bf
+ docker run -d --name devops-a06-frontend --label devops.assignment=06 --network devops-a06-front nginx:alpine
Unable to find image 'nginx:alpine' locally
alpine: Pulling from library/nginx
Digest: sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
Status: Downloaded newer image for nginx:alpine
6a67f835ce848aa895769a1e9e881523e24330b39f8f05b242e13a34681c18b2
+ docker run -d --name devops-a06-backend --label devops.assignment=06 --network devops-a06-front nginx:alpine
cb1788baf18777619fff6aa36098986ea8383d3e38b4ebd6c93e0d92d23bbefe
+ docker network connect devops-a06-data devops-a06-backend
+ python3 -
+ docker run -d --name devops-a06-database --label devops.assignment=06 --network devops-a06-data --env-file /workspace/.local-tools/runtime/mysql.env mysql:8.0
Unable to find image 'mysql:8.0' locally
8.0: Pulling from library/mysql
96d30d9fbee8: Pulling fs layer
7534d1db9f8d: Pulling fs layer
6ef6c7b50a93: Pulling fs layer
ab24264a27e9: Pulling fs layer
4c8a3e0d4e4b: Pulling fs layer
e3e5d1ac74c1: Pulling fs layer
297d04cfe470: Pulling fs layer
a63160a5eda1: Pulling fs layer
edf85873f64e: Pulling fs layer
0d74d296605b: Pulling fs layer
49ec2dab01d9: Pulling fs layer
e3e5d1ac74c1: Download complete
96d30d9fbee8: Download complete
7534d1db9f8d: Download complete
ab24264a27e9: Download complete
6ef6c7b50a93: Download complete
297d04cfe470: Download complete
4c8a3e0d4e4b: Download complete
796812c73292: Download complete
af166387641d: Download complete
0d74d296605b: Download complete
a63160a5eda1: Download complete
edf85873f64e: Download complete
edf85873f64e: Pull complete
6ef6c7b50a93: Pull complete
e3e5d1ac74c1: Pull complete
0d74d296605b: Pull complete
297d04cfe470: Pull complete
4c8a3e0d4e4b: Pull complete
a63160a5eda1: Pull complete
7534d1db9f8d: Pull complete
49ec2dab01d9: Download complete
49ec2dab01d9: Pull complete
ab24264a27e9: Pull complete
96d30d9fbee8: Pull complete
Digest: sha256:7dcddc01f13bab2f15cde676d44d01f61fc9f99fe7785e86196dfc07d358ae2b
Status: Downloaded newer image for mysql:8.0
840aa950516e5e54d899831222289517fe3306f04458658174727242bc3235c4
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ sleep 2
+ for attempt in {1..60}
+ docker exec devops-a06-backend sh -c 'nc -z -w 2 devops-a06-database 3306'
+ break
+ docker exec devops-a06-frontend ping -c 2 devops-a06-backend
PING devops-a06-backend (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.107 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.101 ms

--- devops-a06-backend ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.101/0.104/0.107 ms
+ docker exec devops-a06-backend ping -c 2 devops-a06-database
PING devops-a06-database (172.19.0.3): 56 data bytes
64 bytes from 172.19.0.3: seq=0 ttl=64 time=0.053 ms
64 bytes from 172.19.0.3: seq=1 ttl=64 time=0.110 ms

--- devops-a06-database ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.053/0.081/0.110 ms
+ docker exec devops-a06-frontend ping -c 1 -W 2 devops-a06-database
ping: bad address 'devops-a06-database'
+ echo 'Frontend cannot resolve isolated database: expected.'
Frontend cannot resolve isolated database: expected.
+ docker inspect devops-a06-backend --format '{{range $name,$network := .NetworkSettings.Networks}}{{$name}} {{end}}'
devops-a06-data devops-a06-front 
+ docker network ls --filter label=devops.assignment=06
NETWORK ID     NAME                  DRIVER    SCOPE
1dabde3af4c5   devops-a06-data       bridge    local
038977fa2c4a   devops-a06-front      bridge    local
3010b54aeb71   devops-a06-isolated   bridge    local
+ docker pull httpd:2.4-alpine
2.4-alpine: Pulling from library/httpd
Digest: sha256:3440c39d8d6f54fa9ad2549e5a60c19ddd435faadc29c1ad28aa795f71888889
Status: Downloaded newer image for httpd:2.4-alpine
docker.io/library/httpd:2.4-alpine
+ docker run -d --name devops-a06-apache --label devops.assignment=06 --network host httpd:2.4-alpine
30bb3bb8aad562571fd718b2ce4da325740e0f95a319992f423120a987c6ce13
+ ../../.local-tools/vm.sh 'curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://127.0.0.1:80'
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>It works! Apache httpd</title>
</head>
<body>
<p>It works!</p>
</body>
</html>
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-apache-host-network --url http://127.0.0.1:8088
+ mkdir -p bind-site
+ printf '<h1>Hello students</h1>\n'
+ docker run -d --name devops-a06-bind --label devops.assignment=06 -p 8081:80 --mount type=bind,source=/workspace/DevOps-Assignments/Assignment-06-Session-07/bind-site,target=/usr/share/nginx/html,readonly nginx:alpine
67d2129ba511e8e3fb340da7de1b1258eb52e495f12437214f976350e55b172d
+ curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://127.0.0.1:8081
+ tee evidence/bind-before.html
<h1>Hello students</h1>
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 03-bind-before --url http://127.0.0.1:8081
+ docker inspect devops-a06-bind --format '{{.Id}} {{.State.StartedAt}}'
+ printf '<h1>Hello students — updated without restart</h1>\n'
+ tee evidence/bind-after.html
+ curl -fsS http://127.0.0.1:8081
<h1>Hello students — updated without restart</h1>
+ grep -q 'updated without restart' evidence/bind-after.html
+ docker inspect devops-a06-bind --format '{{.Id}} {{.State.StartedAt}}'
+ cmp evidence/bind-container-before.txt evidence/bind-container-after.txt
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 04-bind-after --url http://127.0.0.1:8081
+ docker ps --filter label=devops.assignment=06 --format 'table {{.Names}}\t{{.Ports}}\t{{.Status}}'
NAMES                 PORTS                                     STATUS
devops-a06-bind       0.0.0.0:8081->80/tcp, [::]:8081->80/tcp   Up 4 seconds
devops-a06-apache                                               Up 6 seconds
devops-a06-database   3306/tcp, 33060/tcp                       Up About a minute
devops-a06-backend    80/tcp                                    Up 2 minutes
devops-a06-frontend   80/tcp                                    Up 2 minutes

```
