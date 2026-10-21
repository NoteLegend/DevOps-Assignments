# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker build -t devops-a19-monitor:local monitoring
docker run -d --name devops-a19-app --label assignment=19 --network host devops-a19-monitor:local
docker run -d --name devops-a19-node --label assignment=19 --network host --pid host -v /:/host:ro,rslave prom/node-exporter:v1.10.2 --path.rootfs=/host
docker run -d --name devops-a19-prom --label assignment=19 --network host -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/alerts.yml:/etc/prometheus/alerts.yml:ro prom/prometheus:v3.5.0
curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8090/health
curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:9090/-/ready
sleep 15
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=up' | tee evidence/targets.json
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' | tee evidence/cpu.json
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)' | tee evidence/memory.json
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=application_requests_total' | tee evidence/requests.json
docker logs --tail 12 devops-a19-app
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-prometheus-targets --url http://127.0.0.1:9090/targets
docker stop devops-a19-app
sleep 20
curl -fsS http://127.0.0.1:9090/api/v1/alerts | tee evidence/alerts-firing.json
python -c "import json; a=json.load(open('evidence/alerts-firing.json')); assert any(x['state']=='firing' for x in a['data']['alerts'])"
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 03-prometheus-alert --url http://127.0.0.1:9090/alerts
docker start devops-a19-app
sleep 15
curl -fsS http://127.0.0.1:8090/health
curl -fsS http://127.0.0.1:9090/api/v1/alerts | tee evidence/alerts-recovered.json
python -c "import json; assert not json.load(open('evidence/alerts-recovered.json'))['data']['alerts']"
docker ps --filter label=assignment=19
docker rm -f devops-a19-app devops-a19-prom devops-a19-node

```

```text
Executed 2026-10-07T14:20:18.287025+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-19-Session-20
Script: monitoring.sh
Exit status: 1

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ docker build -t devops-a19-monitor:local monitoring
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 140B 0.0s done
#1 DONE 0.3s

#2 [internal] load metadata for docker.io/library/python:3.12-slim
#2 DONE 1.7s

#3 [internal] load .dockerignore
#3 transferring context:
#3 transferring context: 2B 0.0s done
#3 DONE 0.3s

#4 [internal] load build context
#4 transferring context: 1.06kB 0.0s done
#4 DONE 0.4s

#5 [1/3] FROM docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f
#5 resolve docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f 0.2s done
#5 DONE 0.3s

#6 [2/3] WORKDIR /app
#6 CACHED

#7 [3/3] COPY application/app.py .
#7 DONE 0.3s

#8 exporting to image
#8 exporting layers
#8 exporting layers 0.6s done
#8 exporting manifest sha256:3e2ba122d5eddcee7ab83a6c5fe424ea17b2685c317a47a62bd8303d3343d50a 0.1s done
#8 exporting config sha256:260d54a5526d805b2000b407a2a5a59c3061394ec3568db2196fef3033f3f7a9
#8 exporting config sha256:260d54a5526d805b2000b407a2a5a59c3061394ec3568db2196fef3033f3f7a9 0.1s done
#8 exporting attestation manifest sha256:7217c301b3f1bc2a28a3a038786a938fe76f72c3bd42b934e0e4db9604de9cdd
#8 exporting attestation manifest sha256:7217c301b3f1bc2a28a3a038786a938fe76f72c3bd42b934e0e4db9604de9cdd 0.3s done
#8 exporting manifest list sha256:5c98ae0b59c219b48f6f1609070fde799bf583a13fa80cdbeba881fa66e0f639
#8 exporting manifest list sha256:5c98ae0b59c219b48f6f1609070fde799bf583a13fa80cdbeba881fa66e0f639 0.2s done
#8 naming to docker.io/library/devops-a19-monitor:local
#8 naming to docker.io/library/devops-a19-monitor:local 0.0s done
#8 unpacking to docker.io/library/devops-a19-monitor:local 0.2s done
#8 DONE 1.7s
+ docker run -d --name devops-a19-app --label assignment=19 --network host devops-a19-monitor:local
2722d1dab4813efa8e82b803aca957b05583d48757022b3ec98ba3be486b64b9
+ docker run -d --name devops-a19-node --label assignment=19 --network host --pid host -v /:/host:ro,rslave prom/node-exporter:v1.10.2 --path.rootfs=/host
e00b663cab2a8e201725e50e8e345f4a1e6f46225c3a9d30329f35220e79a983
+ docker run -d --name devops-a19-prom --label assignment=19 --network host -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/alerts.yml:/etc/prometheus/alerts.yml:ro prom/prometheus:v3.5.0
d6b1c5a779b88ce1f3338d5d02335bdb597c2c385da36802cb35a6870f0fca81
+ curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8090/health
{"status":"healthy"}+ curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:9090/-/ready
curl: (56) Recv failure: Connection reset by peer
Prometheus Server is Ready.
+ sleep 15
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=up
+ tee evidence/targets.json
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"up","instance":"127.0.0.1:9100","job":"local-node"},"value":[1791362986.981,"1"]},{"metric":{"__name__":"up","instance":"127.0.0.1:8090","job":"application"},"value":[1791362986.981,"0"]}]}}+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))'
+ tee evidence/cpu.json
{"status":"success","data":{"resultType":"vector","result":[{"metric":{},"value":[1791362986.993,"83.48926102671747"]}]}}+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ tee evidence/memory.json
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"instance":"127.0.0.1:9100","job":"local-node"},"value":[1791362987.002,"22.7891862813157"]}]}}+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=application_requests_total
+ tee evidence/requests.json
{"status":"success","data":{"resultType":"vector","result":[]}}+ docker logs --tail 12 devops-a19-app
{"trace_id": "92a0830b2d904d388e2835d823c2cbcb", "path": "/health", "status": 200, "duration_ms": 0.174}
{"trace_id": "43a230fe7c35434cbeb2210e2b43940a", "path": "/metrics", "status": 200, "duration_ms": 0.186}
{"trace_id": "011987a199184a6faac432cc4cd4e56f", "path": "/metrics", "status": 200, "duration_ms": 0.251}
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-prometheus-targets --url http://127.0.0.1:9090/targets
Traceback (most recent call last):
  File "/home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-19-Session-20/../../.local-tools/evidence.py", line 18, in <module>
    page.goto(a.url,wait_until='networkidle');page.screenshot(path=str(d/'screenshots'/f'{a.name}.png'),full_page=True)
    ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/tmp/devops-tools-venv/lib/python3.14/site-packages/playwright/sync_api/_generated.py", line 9903, in goto
    self._sync(
    ~~~~~~~~~~^
        self._impl_obj.goto(
        ^^^^^^^^^^^^^^^^^^^^
    ...<4 lines>...
        )
        ^
    )
    ^
  File "/tmp/devops-tools-venv/lib/python3.14/site-packages/playwright/_impl/_sync_base.py", line 115, in _sync
    return task.result()
           ~~~~~~~~~~~^^
  File "/tmp/devops-tools-venv/lib/python3.14/site-packages/playwright/_impl/_page.py", line 562, in goto
    return await self._main_frame.goto(**locals_to_params(locals()))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/tmp/devops-tools-venv/lib/python3.14/site-packages/playwright/_impl/_frame.py", line 157, in goto
    await self._channel.send(
        "goto", self._navigation_timeout, locals_to_params(locals())
    )
  File "/tmp/devops-tools-venv/lib/python3.14/site-packages/playwright/_impl/_connection.py", line 76, in send
    return await self._connection.wrap_api_call(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ...<3 lines>...
    )
    ^
  File "/tmp/devops-tools-venv/lib/python3.14/site-packages/playwright/_impl/_connection.py", line 632, in wrap_api_call
    raise rewrite_error(error, f"{parsed_st['apiName']}: {error}") from None
playwright._impl._errors.TimeoutError: Page.goto: Timeout 30000ms exceeded.
Call log:
  - navigating to "http://127.0.0.1:9090/targets", waiting until "networkidle"


```
