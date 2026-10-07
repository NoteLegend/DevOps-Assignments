# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker logs devops-a07-demo-frontend-1 --tail 4
docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml config -q
docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml up -d
curl --retry 15 --retry-connrefused --retry-delay 2 -fsS http://127.0.0.1:8081

```

```text
Executed 2026-10-07T13:25:37.830033+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-07-Session-08
Script: fix-startup.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ docker logs devops-a07-demo-frontend-1 --tail 4
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/10/07 07:54:25 [emerg] 1#1: host not found in upstream "backend" in /etc/nginx/conf.d/default.conf:13
nginx: [emerg] host not found in upstream "backend" in /etc/nginx/conf.d/default.conf:13
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml config -q
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml up -d
 Container devops-a07-demo-database-1  Running
 Container devops-a07-demo-backend-1  Recreate
 Container devops-a07-demo-backend-1  Recreated
 Container devops-a07-demo-backend-1  Starting
 Container devops-a07-demo-backend-1  Started
 Container devops-a07-demo-backend-1  Waiting
 Container devops-a07-demo-backend-1  Healthy
 Container devops-a07-demo-frontend-1  Starting
 Container devops-a07-demo-frontend-1  Started
+ curl --retry 15 --retry-connrefused --retry-delay 2 -fsS http://127.0.0.1:8081
<!DOCTYPE html>

<html>

<head>
    <title>Docker Network Demo</title>
</head>

<body>

    <h1>Docker 3-Tier Application</h1>

    <button onclick="getData()">
        Get Data From Backend
    </button>

    <h2>Response:</h2>

    <pre id="result"></pre>

    <script>

        async function getData() {

            const response = await fetch('/api');

            const data = await response.json();

            document.getElementById("result").textContent =
                JSON.stringify(data, null, 2);
        }

    </script>

</body>

</html>
```
