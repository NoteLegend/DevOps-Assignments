#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl -n production-webapp exec deployment/web-app -- sh -c 'echo "Student: <YOUR NAME>" > /data/student.txt; cat /data/student.txt'
../../.local-tools/vm.sh 'nohup kubectl -n production-webapp port-forward --address=0.0.0.0 svc/web-service 8092:80 >/tmp/devops-a12-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a12-forward.pid'
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8092
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 04-mini-project-page --url http://127.0.0.1:8092
../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a12-forward.pid)"'
