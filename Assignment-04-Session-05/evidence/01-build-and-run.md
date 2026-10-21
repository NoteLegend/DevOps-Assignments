# Executed commands and captured output

```bash
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

```

```text
Executed 2026-10-07T13:14:22.255339+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-04-Session-05
Script: build-run.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ export DEVOPS_WORKSPACE=/home/rushixd/Wurk/Scaler/DevOps
++ DEVOPS_WORKSPACE=/home/rushixd/Wurk/Scaler/DevOps
++ export PATH=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0XEF9Mq:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0x3FaAZ:/home/rushixd/.local/npm/lib/node_modules/@openai/codex/node_modules/@openai/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-path:/home/rushixd/.local/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
++ PATH=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0XEF9Mq:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0x3FaAZ:/home/rushixd/.local/npm/lib/node_modules/@openai/codex/node_modules/@openai/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-path:/home/rushixd/.local/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
++ export MINIKUBE_HOME=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/minikube
++ MINIKUBE_HOME=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/minikube
++ export KUBECONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/kubeconfig
++ KUBECONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/kubeconfig
+ docker version
Client:
 Version:           29.1.3
 API version:       1.52
 Go version:        go1.24.4
 Git commit:        29.1.3-0ubuntu3~24.04.2
 Built:             Wed Apr 29 16:41:06 2026
 OS/Arch:           linux/amd64
 Context:           default

Server:
 Engine:
  Version:          29.1.3
  API version:      1.52 (minimum version 1.44)
  Go version:       go1.24.4
  Git commit:       29.1.3-0ubuntu3~24.04.2
  Built:            Wed Apr 29 16:41:06 2026
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          2.2.1
  GitCommit:        
 runc:
  Version:          1.3.4-0ubuntu1~24.04.1
  GitCommit:        
 docker-init:
  Version:          0.19.0
  GitCommit:        
+ folders=(nodejs-app python-app java-app Apache-app React-app nginx-app)
+ container_ports=(3000 8000 8080 80 80 80)
+ for i in "${!folders[@]}"
+ folder=nodejs-app
+ name=devops-a04-nodejs-app
+ host_port=8081
+ docker build -t devops-a04-nodejs-app:local nodejs-app
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 135B 0.0s done
#1 DONE 0.5s

#2 [internal] load metadata for docker.io/library/node:24-alpine
#2 DONE 4.0s

#3 [internal] load .dockerignore
#3 transferring context:
#3 transferring context: 64B 0.0s done
#3 DONE 0.3s

#4 [internal] load build context
#4 transferring context: 223B 0.0s done
#4 DONE 0.6s

#5 [1/3] FROM docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1
#5 resolve docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1 0.3s done
#5 DONE 1.3s

#5 [1/3] FROM docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1
#5 sha256:7ce7dcbafb7f750cf0c6be3c30e34372b06dd1182fa67f6ae30782c8150c5444 0B / 444B 0.2s
#5 sha256:7ce7dcbafb7f750cf0c6be3c30e34372b06dd1182fa67f6ae30782c8150c5444 444B / 444B 0.3s
#5 sha256:02f40d53b06f6b91fec0cd6a6719656da99270bff8ee54ed8dcdf4c157763fc1 0B / 1.26MB 0.2s
#5 sha256:7ce7dcbafb7f750cf0c6be3c30e34372b06dd1182fa67f6ae30782c8150c5444 444B / 444B 0.3s done
#5 sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5 0B / 3.85MB 0.2s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 0B / 56.52MB 0.2s
#5 sha256:02f40d53b06f6b91fec0cd6a6719656da99270bff8ee54ed8dcdf4c157763fc1 1.05MB / 1.26MB 1.1s
#5 sha256:02f40d53b06f6b91fec0cd6a6719656da99270bff8ee54ed8dcdf4c157763fc1 1.26MB / 1.26MB 1.2s done
#5 sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5 1.05MB / 3.85MB 2.6s
#5 sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5 2.10MB / 3.85MB 2.9s
#5 sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5 3.85MB / 3.85MB 3.2s
#5 sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5 3.85MB / 3.85MB 3.2s done
#5 extracting sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 3.15MB / 56.52MB 3.3s
#5 extracting sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5 0.3s done
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 6.29MB / 56.52MB 3.9s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 9.44MB / 56.52MB 4.2s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 12.58MB / 56.52MB 5.0s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 15.73MB / 56.52MB 5.7s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 18.87MB / 56.52MB 6.2s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 23.07MB / 56.52MB 6.5s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 26.21MB / 56.52MB 7.2s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 30.70MB / 56.52MB 7.5s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 33.55MB / 56.52MB 7.8s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 37.75MB / 56.52MB 8.3s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 40.89MB / 56.52MB 9.2s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 45.09MB / 56.52MB 9.8s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 48.23MB / 56.52MB 10.2s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 51.38MB / 56.52MB 10.5s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 54.53MB / 56.52MB 11.0s
#5 sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 56.52MB / 56.52MB 11.2s done
#5 extracting sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0
#5 extracting sha256:3c504d5a797be28f9de43147d49cd8ecb2eea46dfaf7beb8715db695d5f0a7f0 1.8s done
#5 DONE 14.7s

#5 [1/3] FROM docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1
#5 extracting sha256:02f40d53b06f6b91fec0cd6a6719656da99270bff8ee54ed8dcdf4c157763fc1
#5 extracting sha256:02f40d53b06f6b91fec0cd6a6719656da99270bff8ee54ed8dcdf4c157763fc1 0.2s done
#5 DONE 14.8s

#5 [1/3] FROM docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1
#5 extracting sha256:7ce7dcbafb7f750cf0c6be3c30e34372b06dd1182fa67f6ae30782c8150c5444
#5 extracting sha256:7ce7dcbafb7f750cf0c6be3c30e34372b06dd1182fa67f6ae30782c8150c5444 0.2s done
#5 DONE 15.0s

#6 [2/3] WORKDIR /app
#6 DONE 0.6s

#7 [3/3] COPY server.js .
#7 DONE 0.4s

#8 exporting to image
#8 exporting layers
#8 exporting layers 1.3s done
#8 exporting manifest sha256:0b3dcc50afd9ed6747ea62ec3ccd28bfc4a77b3d8510cf63f619a56ae8437815
#8 exporting manifest sha256:0b3dcc50afd9ed6747ea62ec3ccd28bfc4a77b3d8510cf63f619a56ae8437815 0.2s done
#8 exporting config sha256:9d38e5ec0513a3a8a386d890cfb9eeadabaea8fa8ec152e17c65f10567bb21b8
#8 exporting config sha256:9d38e5ec0513a3a8a386d890cfb9eeadabaea8fa8ec152e17c65f10567bb21b8 0.2s done
#8 exporting attestation manifest sha256:14266e95ce2b43c3d75301b4502728d348eb18ff830ba31c78926bf5bc925f69
#8 exporting attestation manifest sha256:14266e95ce2b43c3d75301b4502728d348eb18ff830ba31c78926bf5bc925f69 0.3s done
#8 exporting manifest list sha256:33dd05b6189ead95014737de245809a5807307b497587914ee712921626b659b
#8 exporting manifest list sha256:33dd05b6189ead95014737de245809a5807307b497587914ee712921626b659b 0.2s done
#8 naming to docker.io/library/devops-a04-nodejs-app:local
#8 naming to docker.io/library/devops-a04-nodejs-app:local 0.0s done
#8 unpacking to docker.io/library/devops-a04-nodejs-app:local
#8 unpacking to docker.io/library/devops-a04-nodejs-app:local 0.3s done
#8 DONE 2.7s
+ docker run -d --name devops-a04-nodejs-app --label devops.assignment=04 -p 8081:3000 devops-a04-nodejs-app:local
243ff3a1e2835cfd741384c08dcefd8767ab9bb3106de962f78b140aa5821970
+ for attempt in {1..30}
+ curl -fsS http://127.0.0.1:8081
+ break
+ [[ nodejs-app == React-app ]]
+ grep -q 'Hello World' evidence/nodejs-app-response.html
+ docker logs devops-a04-nodejs-app
+ for i in "${!folders[@]}"
+ folder=python-app
+ name=devops-a04-python-app
+ host_port=8082
+ docker build -t devops-a04-python-app:local python-app
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 136B 0.0s done
#1 DONE 0.3s

#2 [internal] load metadata for docker.io/library/python:3.13-alpine
#2 DONE 3.3s

#3 [internal] load .dockerignore
#3 transferring context:
#3 transferring context: 64B 0.0s done
#3 DONE 0.3s

#4 [internal] load build context
#4 transferring context: 385B 0.0s done
#4 DONE 0.6s

#5 [1/3] FROM docker.io/library/python:3.13-alpine@sha256:2d9aefe2fef018a7eb2c13064c89c71929800fd2e5dccdbf52ea5da5bb8d929a
#5 resolve docker.io/library/python:3.13-alpine@sha256:2d9aefe2fef018a7eb2c13064c89c71929800fd2e5dccdbf52ea5da5bb8d929a 0.3s done
#5 DONE 1.1s

#5 [1/3] FROM docker.io/library/python:3.13-alpine@sha256:2d9aefe2fef018a7eb2c13064c89c71929800fd2e5dccdbf52ea5da5bb8d929a
#5 sha256:82c48d7f22df9ea2f3393a3daf83a7abb5e933e5fb7f4d1b701dc8f71ebff248 0B / 247B 0.2s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 0B / 15.24MB 0.2s
#5 sha256:48f6a258842734fe23e0e4c69db9996cbaefd41c1cde2372b95449f9fc5601eb 0B / 416.27kB 0.2s
#5 sha256:82c48d7f22df9ea2f3393a3daf83a7abb5e933e5fb7f4d1b701dc8f71ebff248 247B / 247B 0.6s done
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 1.05MB / 15.24MB 1.1s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 4.19MB / 15.24MB 1.4s
#5 sha256:48f6a258842734fe23e0e4c69db9996cbaefd41c1cde2372b95449f9fc5601eb 416.27kB / 416.27kB 1.5s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 6.29MB / 15.24MB 1.7s
#5 sha256:48f6a258842734fe23e0e4c69db9996cbaefd41c1cde2372b95449f9fc5601eb 416.27kB / 416.27kB 1.6s done
#5 extracting sha256:48f6a258842734fe23e0e4c69db9996cbaefd41c1cde2372b95449f9fc5601eb
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 8.39MB / 15.24MB 2.0s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 9.44MB / 15.24MB 2.1s
#5 extracting sha256:48f6a258842734fe23e0e4c69db9996cbaefd41c1cde2372b95449f9fc5601eb 0.3s done
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 11.53MB / 15.24MB 2.7s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 12.58MB / 15.24MB 2.9s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 13.63MB / 15.24MB 3.0s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 15.24MB / 15.24MB 3.2s
#5 sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 15.24MB / 15.24MB 3.2s done
#5 extracting sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0
#5 extracting sha256:6f4c23997e2db272b9d27917c421c0322c90ce90f0b4eeecd39ce268bdb688d0 0.7s done
#5 DONE 5.2s

#5 [1/3] FROM docker.io/library/python:3.13-alpine@sha256:2d9aefe2fef018a7eb2c13064c89c71929800fd2e5dccdbf52ea5da5bb8d929a
#5 extracting sha256:82c48d7f22df9ea2f3393a3daf83a7abb5e933e5fb7f4d1b701dc8f71ebff248
#5 extracting sha256:82c48d7f22df9ea2f3393a3daf83a7abb5e933e5fb7f4d1b701dc8f71ebff248 0.2s done
#5 DONE 5.4s

#6 [2/3] WORKDIR /app
#6 DONE 0.4s

#7 [3/3] COPY app.py .
#7 DONE 0.4s

#8 exporting to image
#8 exporting layers
#8 exporting layers 1.4s done
#8 exporting manifest sha256:964a2774991d1c1e6b550ee558defefe81c68e26731653de21e4d89fa0e53be1
#8 exporting manifest sha256:964a2774991d1c1e6b550ee558defefe81c68e26731653de21e4d89fa0e53be1 0.2s done
#8 exporting config sha256:507b14e0d79683c1837bf038ac9399abdd884f68bb352937bbe2564349c54131
#8 exporting config sha256:507b14e0d79683c1837bf038ac9399abdd884f68bb352937bbe2564349c54131 0.2s done
#8 exporting attestation manifest sha256:a3f5fcef175141c1d19c1f234e623e7c28de1d49f659357d60a1c5593921cc9b
#8 exporting attestation manifest sha256:a3f5fcef175141c1d19c1f234e623e7c28de1d49f659357d60a1c5593921cc9b 0.3s done
#8 exporting manifest list sha256:a8c803a65a7da8607c2ae358e126202ecebfa398f3339088f3a415681d4c669f
#8 exporting manifest list sha256:a8c803a65a7da8607c2ae358e126202ecebfa398f3339088f3a415681d4c669f 0.2s done
#8 naming to docker.io/library/devops-a04-python-app:local
#8 naming to docker.io/library/devops-a04-python-app:local 0.0s done
#8 unpacking to docker.io/library/devops-a04-python-app:local
#8 unpacking to docker.io/library/devops-a04-python-app:local 0.3s done
#8 DONE 2.7s
+ docker run -d --name devops-a04-python-app --label devops.assignment=04 -p 8082:8000 devops-a04-python-app:local
0cf31d0a8556d77265719b4593c13167d0da03ab85de472231454f49f9592735
+ for attempt in {1..30}
+ curl -fsS http://127.0.0.1:8082
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..30}
+ curl -fsS http://127.0.0.1:8082
+ break
+ [[ python-app == React-app ]]
+ grep -q 'Hello World' evidence/python-app-response.html
+ docker logs devops-a04-python-app
10.0.2.2 - - [07/Oct/2026 07:42:33] "GET / HTTP/1.1" 200 -
+ for i in "${!folders[@]}"
+ folder=java-app
+ name=devops-a04-java-app
+ host_port=8083
+ docker build -t devops-a04-java-app:local java-app
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 265B 0.0s done
#1 DONE 0.3s

#2 [internal] load metadata for docker.io/library/eclipse-temurin:21-jdk-alpine
#2 DONE 4.9s

#3 [internal] load metadata for docker.io/library/eclipse-temurin:21-jre-alpine
#3 DONE 5.0s

#4 [internal] load .dockerignore
#4 transferring context:
#4 transferring context: 64B 0.0s done
#4 DONE 0.3s

#5 [internal] load build context
#5 DONE 0.0s

#6 [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 resolve docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 resolve docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555 0.3s done
#6 ...

#5 [internal] load build context
#5 transferring context: 643B 0.0s done
#5 DONE 0.9s

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 resolve docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159 0.3s done
#7 ...

#6 [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 DONE 1.8s

#6 [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 sha256:5abc2579d091ef7359d2654aa76115280a45a0c81c04e644017e6cb1ef45295b 0B / 2.46kB 0.2s
#6 sha256:5abc2579d091ef7359d2654aa76115280a45a0c81c04e644017e6cb1ef45295b 2.46kB / 2.46kB 0.3s
#6 sha256:b3405c83ad56324f504856a713a1a5d6c28d82a78170a4dd4097c209f8517c18 0B / 128B 0.2s
#6 sha256:b3405c83ad56324f504856a713a1a5d6c28d82a78170a4dd4097c209f8517c18 128B / 128B 0.3s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 0B / 53.26MB 0.2s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 0B / 16.97MB 0.2s
#6 sha256:5abc2579d091ef7359d2654aa76115280a45a0c81c04e644017e6cb1ef45295b 2.46kB / 2.46kB 0.4s done
#6 sha256:b3405c83ad56324f504856a713a1a5d6c28d82a78170a4dd4097c209f8517c18 128B / 128B 0.4s done
#6 ...

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 DONE 2.8s

#6 [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 3.15MB / 53.26MB 0.8s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 6.29MB / 53.26MB 1.4s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 1.05MB / 16.97MB 1.2s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 2.10MB / 16.97MB 1.4s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 9.44MB / 53.26MB 2.0s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 3.15MB / 16.97MB 1.8s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 4.19MB / 16.97MB 2.0s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 5.24MB / 16.97MB 2.4s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 12.58MB / 53.26MB 2.7s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 6.29MB / 16.97MB 2.7s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 7.34MB / 16.97MB 3.3s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 15.73MB / 53.26MB 3.6s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 8.39MB / 16.97MB 4.1s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 18.87MB / 53.26MB 4.7s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 9.44MB / 16.97MB 4.5s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 10.49MB / 16.97MB 5.0s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 22.02MB / 53.26MB 5.3s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 11.53MB / 16.97MB 5.4s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 12.58MB / 16.97MB 5.7s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 25.17MB / 53.26MB 6.3s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 13.63MB / 16.97MB 6.2s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 14.68MB / 16.97MB 6.6s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 15.73MB / 16.97MB 6.9s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 28.31MB / 53.26MB 7.7s
#6 sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 16.97MB / 16.97MB 7.5s done
#6 extracting sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 31.46MB / 53.26MB 8.7s
#6 extracting sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 1.0s done
#6 ...

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 sha256:f75bb0de4136d37b665782e892fb7132a0c4d32a3d4bf6989609487696b5e32f 2.46kB / 2.46kB 0.7s done
#7 sha256:0aeafda7b1fad5c53a3b22b763dd94158c78503c46b440abd39af469e9184f21 130B / 130B 1.0s done
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 2.10MB / 158.33MB 8.7s
#7 sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 5.24MB / 21.44MB 8.3s
#7 ...

#6 [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 34.60MB / 53.26MB 10.2s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 37.75MB / 53.26MB 11.3s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 40.89MB / 53.26MB 13.2s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 44.04MB / 53.26MB 14.4s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 47.19MB / 53.26MB 15.6s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 50.33MB / 53.26MB 16.2s
#6 sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 53.26MB / 53.26MB 16.8s done
#6 extracting sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221
#6 ...

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 5.24MB / 158.33MB 16.2s
#7 sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 12.58MB / 21.44MB 15.9s
#7 sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 14.68MB / 21.44MB 16.5s
#7 ...

#6 [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 extracting sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 1.7s done
#6 extracting sha256:b3405c83ad56324f504856a713a1a5d6c28d82a78170a4dd4097c209f8517c18
#6 extracting sha256:b3405c83ad56324f504856a713a1a5d6c28d82a78170a4dd4097c209f8517c18 0.2s done
#6 DONE 20.9s

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 16.78MB / 21.44MB 17.1s
#7 ...

#6 [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8b5cd648eafbc3c0c90dd79d6537684e4555
#6 extracting sha256:5abc2579d091ef7359d2654aa76115280a45a0c81c04e644017e6cb1ef45295b 0.2s done
#6 DONE 21.1s

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 ...

#8 [stage-1 2/3] WORKDIR /app
#8 DONE 0.6s

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 18.87MB / 21.44MB 18.0s
#7 sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 20.97MB / 21.44MB 18.6s
#7 sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 21.44MB / 21.44MB 18.8s done
#7 extracting sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608
#7 extracting sha256:8e0e05dd51e5ffe47d317144d69de9a3946dc8d83750c639d76c40e723b3b608 0.9s done
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 12.58MB / 158.33MB 21.3s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 20.97MB / 158.33MB 23.1s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 29.36MB / 158.33MB 24.6s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 38.80MB / 158.33MB 25.8s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 47.19MB / 158.33MB 27.3s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 55.57MB / 158.33MB 28.4s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 63.96MB / 158.33MB 29.4s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 72.35MB / 158.33MB 30.6s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 80.74MB / 158.33MB 31.8s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 89.13MB / 158.33MB 33.0s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 97.52MB / 158.33MB 34.1s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 105.91MB / 158.33MB 35.1s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 114.29MB / 158.33MB 36.5s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 122.68MB / 158.33MB 37.5s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 131.07MB / 158.33MB 38.6s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 139.46MB / 158.33MB 39.8s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 147.85MB / 158.33MB 40.8s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 157.29MB / 158.33MB 42.2s
#7 sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 158.33MB / 158.33MB 42.4s done
#7 extracting sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423
#7 extracting sha256:802e35573aa7ee42b46fd9714582af48caf0f6aebbf2992311da030c8ff5a423 2.9s done
#7 DONE 49.0s

#7 [build 1/4] FROM docker.io/library/eclipse-temurin:21-jdk-alpine@sha256:0bfc69a4758a86710e5c474032d28400a8bd00874766f9e8b1642ac2fd293159
#7 extracting sha256:0aeafda7b1fad5c53a3b22b763dd94158c78503c46b440abd39af469e9184f21
#7 extracting sha256:0aeafda7b1fad5c53a3b22b763dd94158c78503c46b440abd39af469e9184f21 0.2s done
#7 extracting sha256:f75bb0de4136d37b665782e892fb7132a0c4d32a3d4bf6989609487696b5e32f
#7 extracting sha256:f75bb0de4136d37b665782e892fb7132a0c4d32a3d4bf6989609487696b5e32f 0.2s done
#7 DONE 49.3s

#9 [build 2/4] WORKDIR /app
#9 DONE 0.7s

#10 [build 3/4] COPY Hello.java .
#10 DONE 0.4s

#11 [build 4/4] RUN javac Hello.java
#11 DONE 1.6s

#12 [stage-1 3/3] COPY --from=build /app/Hello.class .
#12 DONE 0.5s

#13 exporting to image
#13 exporting layers
#13 exporting layers 1.3s done
#13 exporting manifest sha256:ed66ccb6e61a4939ebf9f8e866789bd96abd4a2d02497f723f014229e7ff5a8a
#13 exporting manifest sha256:ed66ccb6e61a4939ebf9f8e866789bd96abd4a2d02497f723f014229e7ff5a8a 0.2s done
#13 exporting config sha256:eacf83a5dd14b9e1979a45d821173d5ee858c98fdd0e3f48159f7f9964f628f1
#13 exporting config sha256:eacf83a5dd14b9e1979a45d821173d5ee858c98fdd0e3f48159f7f9964f628f1 0.2s done
#13 exporting attestation manifest sha256:a257a8dc50d3d7b1746aa8f45591e4c99abc3ed42ad86ce6fd2b9c22b2bf84ea
#13 exporting attestation manifest sha256:a257a8dc50d3d7b1746aa8f45591e4c99abc3ed42ad86ce6fd2b9c22b2bf84ea 0.3s done
#13 exporting manifest list sha256:e40277b54fec28dc2f778554dd5fd004d3779f8a7546c8771b6a549cbc5bde0f
#13 exporting manifest list sha256:e40277b54fec28dc2f778554dd5fd004d3779f8a7546c8771b6a549cbc5bde0f 0.2s done
#13 naming to docker.io/library/devops-a04-java-app:local
#13 naming to docker.io/library/devops-a04-java-app:local 0.0s done
#13 unpacking to docker.io/library/devops-a04-java-app:local
#13 unpacking to docker.io/library/devops-a04-java-app:local 0.3s done
#13 DONE 2.6s
+ docker run -d --name devops-a04-java-app --label devops.assignment=04 -p 8083:8080 devops-a04-java-app:local
8f0b5e71dd9ba3d626faab2ee41dcebe4ad1872879021d65e92e343e50309c0e
+ for attempt in {1..30}
+ curl -fsS http://127.0.0.1:8083
+ break
+ [[ java-app == React-app ]]
+ grep -q 'Hello World' evidence/java-app-response.html
+ docker logs devops-a04-java-app
+ for i in "${!folders[@]}"
+ folder=Apache-app
+ name=devops-a04-apache-app
+ host_port=8084
+ docker build -t devops-a04-apache-app:local Apache-app
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 112B 0.0s done
#1 DONE 0.3s

#2 [internal] load metadata for docker.io/library/httpd:2.4-alpine
#2 DONE 3.4s

#3 [internal] load .dockerignore
#3 transferring context:
#3 transferring context: 64B 0.0s done
#3 DONE 0.3s

#4 [1/2] FROM docker.io/library/httpd:2.4-alpine@sha256:3440c39d8d6f54fa9ad2549e5a60c19ddd435faadc29c1ad28aa795f71888889
#4 resolve docker.io/library/httpd:2.4-alpine@sha256:3440c39d8d6f54fa9ad2549e5a60c19ddd435faadc29c1ad28aa795f71888889
#4 resolve docker.io/library/httpd:2.4-alpine@sha256:3440c39d8d6f54fa9ad2549e5a60c19ddd435faadc29c1ad28aa795f71888889 0.3s done
#4 ...

#5 [internal] load build context
#5 transferring context: 131B 0.0s done
#5 DONE 0.6s

#4 [1/2] FROM docker.io/library/httpd:2.4-alpine@sha256:3440c39d8d6f54fa9ad2549e5a60c19ddd435faadc29c1ad28aa795f71888889
#4 DONE 1.6s

#4 [1/2] FROM docker.io/library/httpd:2.4-alpine@sha256:3440c39d8d6f54fa9ad2549e5a60c19ddd435faadc29c1ad28aa795f71888889
#4 sha256:8e97dd6176d7ad95a03527a95c49545e107c16bd82433ac3fb31ce345635f4cb 0B / 287B 0.2s
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 0B / 8.42MB 0.2s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 0B / 11.03MB 0.3s
#4 sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1 0B / 32B 0.2s
#4 sha256:8e97dd6176d7ad95a03527a95c49545e107c16bd82433ac3fb31ce345635f4cb 287B / 287B 0.5s done
#4 sha256:3c7c286fbbd5c96dc5245ed50b1cbd505d13fb7351fcbd588749ef72a5c67329 0B / 147B 0.2s
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 1.05MB / 8.42MB 0.8s
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 2.10MB / 8.42MB 0.9s
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 3.15MB / 8.42MB 1.2s
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 5.24MB / 8.42MB 1.4s
#4 sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1 32B / 32B 1.2s
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 6.29MB / 8.42MB 1.5s
#4 sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1 32B / 32B 1.2s done
#4 sha256:3c7c286fbbd5c96dc5245ed50b1cbd505d13fb7351fcbd588749ef72a5c67329 147B / 147B 1.0s done
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 7.34MB / 8.42MB 1.7s
#4 sha256:269898e769d0265d6960f09acced623283a40480a04b6c4e789e264bde8bbebd 0B / 932B 0.2s
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 8.42MB / 8.42MB 1.8s
#4 sha256:269898e769d0265d6960f09acced623283a40480a04b6c4e789e264bde8bbebd 932B / 932B 0.4s done
#4 sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 8.42MB / 8.42MB 1.9s done
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 1.05MB / 11.03MB 2.0s
#4 extracting sha256:269898e769d0265d6960f09acced623283a40480a04b6c4e789e264bde8bbebd
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 2.10MB / 11.03MB 2.3s
#4 extracting sha256:269898e769d0265d6960f09acced623283a40480a04b6c4e789e264bde8bbebd 0.2s done
#4 extracting sha256:3c7c286fbbd5c96dc5245ed50b1cbd505d13fb7351fcbd588749ef72a5c67329
#4 extracting sha256:3c7c286fbbd5c96dc5245ed50b1cbd505d13fb7351fcbd588749ef72a5c67329 0.2s done
#4 extracting sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1 0.2s done
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 3.15MB / 11.03MB 2.6s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 4.19MB / 11.03MB 2.7s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 5.24MB / 11.03MB 2.9s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 6.29MB / 11.03MB 3.2s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 7.34MB / 11.03MB 3.3s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 8.39MB / 11.03MB 3.5s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 9.44MB / 11.03MB 3.6s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 11.03MB / 11.03MB 3.9s
#4 sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 11.03MB / 11.03MB 3.9s done
#4 extracting sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857
#4 extracting sha256:db577887d90fccc89dea6cb7313d1ada178c2d115ff6a8a36812f86dd07b3857 0.7s done
#4 DONE 6.6s

#4 [1/2] FROM docker.io/library/httpd:2.4-alpine@sha256:3440c39d8d6f54fa9ad2549e5a60c19ddd435faadc29c1ad28aa795f71888889
#4 extracting sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69
#4 extracting sha256:a61ab206ac8a5a4e9ac8826f1091588c3aa4a35536c3e752a9e4311d24d35b69 0.4s done
#4 extracting sha256:8e97dd6176d7ad95a03527a95c49545e107c16bd82433ac3fb31ce345635f4cb
#4 extracting sha256:8e97dd6176d7ad95a03527a95c49545e107c16bd82433ac3fb31ce345635f4cb 0.2s done
#4 DONE 7.2s

#6 [2/2] COPY index.html /usr/local/apache2/htdocs/
#6 DONE 0.4s

#7 exporting to image
#7 exporting layers
#7 exporting layers 1.4s done
#7 exporting manifest sha256:314c5b22b5369865549e208ba7ae0ceddc721b29a90592de50aa9d1f54155a33
#7 exporting manifest sha256:314c5b22b5369865549e208ba7ae0ceddc721b29a90592de50aa9d1f54155a33 0.2s done
#7 exporting config sha256:491d0df98a0e18e335d5ab9ccd32d2c4fe6348a11a72c92ef70be4c371147012
#7 exporting config sha256:491d0df98a0e18e335d5ab9ccd32d2c4fe6348a11a72c92ef70be4c371147012 0.1s done
#7 exporting attestation manifest sha256:f7c5c3bc10d9d0c687e4f1e11a67210cc371e6638af486bccefb56fa7c022a8e
#7 exporting attestation manifest sha256:f7c5c3bc10d9d0c687e4f1e11a67210cc371e6638af486bccefb56fa7c022a8e 0.3s done
#7 exporting manifest list sha256:162888457867bdfb598957bf8cb381be6346594a08f630e9bf6931bef48dc569
#7 exporting manifest list sha256:162888457867bdfb598957bf8cb381be6346594a08f630e9bf6931bef48dc569 0.2s done
#7 naming to docker.io/library/devops-a04-apache-app:local
#7 naming to docker.io/library/devops-a04-apache-app:local 0.0s done
#7 unpacking to docker.io/library/devops-a04-apache-app:local
#7 unpacking to docker.io/library/devops-a04-apache-app:local 0.2s done
#7 DONE 2.5s
+ docker run -d --name devops-a04-apache-app --label devops.assignment=04 -p 8084:80 devops-a04-apache-app:local
cb59523ee720b933913219ec51b4b7e04e5483b10e73bf3b3a66f39e42638aed
+ for attempt in {1..30}
+ curl -fsS http://127.0.0.1:8084
+ break
+ [[ Apache-app == React-app ]]
+ grep -q 'Hello World' evidence/Apache-app-response.html
+ docker logs devops-a04-apache-app
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.5. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.5. Set the 'ServerName' directive globally to suppress this message
[Wed Oct 07 07:43:55.190606 2026] [mpm_event:notice] [pid 1:tid 1] AH00489: Apache/2.4.69 (Unix) configured -- resuming normal operations
10.0.2.2 - - [07/Oct/2026:07:43:55 +0000] "GET / HTTP/1.1" 200 94
[Wed Oct 07 07:43:55.190729 2026] [core:notice] [pid 1:tid 1] AH00094: Command line: 'httpd -D FOREGROUND'
+ for i in "${!folders[@]}"
+ folder=React-app
+ name=devops-a04-react-app
+ host_port=8085
+ docker build -t devops-a04-react-app:local React-app
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 262B 0.0s done
#1 DONE 0.3s

#2 [internal] load metadata for docker.io/library/node:24-alpine
#2 DONE 1.1s

#3 [internal] load metadata for docker.io/library/nginx:alpine
#3 DONE 3.4s

#4 [internal] load .dockerignore
#4 transferring context:
#4 transferring context: 64B 0.0s done
#4 DONE 0.3s

#5 [internal] load build context
#5 DONE 0.0s

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 resolve docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 ...

#7 [build 1/6] FROM docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1
#7 resolve docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1 0.3s done
#7 DONE 0.3s

#8 [build 2/6] WORKDIR /app
#8 CACHED

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 resolve docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2 0.3s done
#6 ...

#5 [internal] load build context
#5 transferring context: 16.36kB 0.1s done
#5 DONE 0.6s

#9 [build 3/6] COPY package*.json ./
#9 DONE 0.6s

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 DONE 2.6s

#10 [build 4/6] RUN npm ci
#10 ...

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 sha256:e72112c14215406dc7f23ef8e5cfdfddeb8662176167382ad64ec86f52b7a88e 17.83MB / 20.53MB 3.9s
#6 sha256:64c8194480fee2c03e01cc561cf5542733627d2c7de493a028139677025f975c 1.21kB / 1.21kB 0.6s done
#6 sha256:e76228b47809e8a4bd37a6ba52a04d282d8c72ddf0ff9e8b83fd6318631abd52 1.40kB / 1.40kB 0.8s done
#6 sha256:9a9a644fdd6a3681d43dace44c8cfef374cfd7b24f433113379ea483692498a8 404B / 404B 0.8s done
#6 sha256:745dfb2690dd8627e1593941caccc756f14943df7930a478beb4e808c5695cb9 965B / 965B 0.7s done
#6 sha256:6c53d0b2a666ed8f8fad8d9982e30cf24eb085036c17b27591665ca25e1ba40c 629B / 629B 0.8s done
#6 sha256:d9aae54b58315e84b9c3ac5f00bad6610e0e28ad9ff28fcde694647e0be13131 1.05MB / 1.93MB 3.0s
#6 sha256:e72112c14215406dc7f23ef8e5cfdfddeb8662176167382ad64ec86f52b7a88e 18.87MB / 20.53MB 4.1s
#6 sha256:e72112c14215406dc7f23ef8e5cfdfddeb8662176167382ad64ec86f52b7a88e 19.92MB / 20.53MB 4.2s
#6 sha256:d9aae54b58315e84b9c3ac5f00bad6610e0e28ad9ff28fcde694647e0be13131 1.93MB / 1.93MB 3.3s
#6 sha256:e72112c14215406dc7f23ef8e5cfdfddeb8662176167382ad64ec86f52b7a88e 20.53MB / 20.53MB 4.4s done
#6 sha256:d9aae54b58315e84b9c3ac5f00bad6610e0e28ad9ff28fcde694647e0be13131 1.93MB / 1.93MB 3.4s done
#6 extracting sha256:d9aae54b58315e84b9c3ac5f00bad6610e0e28ad9ff28fcde694647e0be13131
#6 extracting sha256:d9aae54b58315e84b9c3ac5f00bad6610e0e28ad9ff28fcde694647e0be13131 0.3s done
#6 DONE 7.5s

#10 [build 4/6] RUN npm ci
#10 ...

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 extracting sha256:6c53d0b2a666ed8f8fad8d9982e30cf24eb085036c17b27591665ca25e1ba40c
#6 extracting sha256:6c53d0b2a666ed8f8fad8d9982e30cf24eb085036c17b27591665ca25e1ba40c 0.2s done
#6 DONE 7.6s

#10 [build 4/6] RUN npm ci
#10 ...

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 extracting sha256:745dfb2690dd8627e1593941caccc756f14943df7930a478beb4e808c5695cb9
#6 extracting sha256:745dfb2690dd8627e1593941caccc756f14943df7930a478beb4e808c5695cb9 0.2s done
#6 extracting sha256:9a9a644fdd6a3681d43dace44c8cfef374cfd7b24f433113379ea483692498a8
#6 extracting sha256:9a9a644fdd6a3681d43dace44c8cfef374cfd7b24f433113379ea483692498a8 0.2s done
#6 extracting sha256:64c8194480fee2c03e01cc561cf5542733627d2c7de493a028139677025f975c
#6 ...

#10 [build 4/6] RUN npm ci
#10 6.410 
#10 6.410 added 5 packages, and audited 6 packages in 5s
#10 6.411 
#10 6.411 found 0 vulnerabilities
#10 6.413 npm warn install-scripts 1 package has install scripts not yet covered by allowScripts:
#10 6.413 npm warn install-scripts   esbuild@0.25.12 (postinstall: node install.js)
#10 6.413 npm warn install-scripts
#10 6.413 npm warn install-scripts Run `npm install-scripts ls` to review, or `npm install-scripts approve <pkg>` to allow.
#10 6.415 npm notice
#10 6.415 npm notice New major version of npm available! 11.19.0 -> 12.2.0
#10 6.415 npm notice Changelog: https://github.com/npm/cli/releases/tag/v12.2.0
#10 6.415 npm notice To update run: npm install -g npm@12.2.0
#10 6.415 npm notice
#10 DONE 6.7s

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 extracting sha256:64c8194480fee2c03e01cc561cf5542733627d2c7de493a028139677025f975c 0.2s done
#6 extracting sha256:e76228b47809e8a4bd37a6ba52a04d282d8c72ddf0ff9e8b83fd6318631abd52
#6 extracting sha256:e76228b47809e8a4bd37a6ba52a04d282d8c72ddf0ff9e8b83fd6318631abd52 0.3s done
#6 DONE 8.5s

#11 [build 5/6] COPY src.jsx index.html ./
#11 DONE 0.7s

#6 [stage-1 1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#6 extracting sha256:e72112c14215406dc7f23ef8e5cfdfddeb8662176167382ad64ec86f52b7a88e
#6 extracting sha256:e72112c14215406dc7f23ef8e5cfdfddeb8662176167382ad64ec86f52b7a88e 0.8s done
#6 DONE 9.3s

#12 [build 6/6] RUN npm run build && cp index.html dist/
#12 0.848 
#12 0.848 > react-hello-world@1.0.0 build
#12 0.848 > esbuild src.jsx --bundle --minify --outfile=dist/app.js
#12 0.848 
#12 0.926 
#12 0.926   dist/app.js  189.0kb
#12 0.926 
#12 0.926 ⚡ Done in 70ms
#12 DONE 1.1s

#13 [stage-1 2/2] COPY --from=build /app/dist/ /usr/share/nginx/html/
#13 DONE 0.3s

#14 exporting to image
#14 exporting layers
#14 exporting layers 0.8s done
#14 exporting manifest sha256:d84c21a923774ad4f9a3325a8dd2136badb64943aa37024a80c97e3fff7b94c9 0.1s done
#14 exporting config sha256:150360a05d30a4d67d698040455703d0f0e01af83ea81dab5268d0923580d138
#14 exporting config sha256:150360a05d30a4d67d698040455703d0f0e01af83ea81dab5268d0923580d138 0.1s done
#14 exporting attestation manifest sha256:a7b9d29a6d93e80df922c28322995b26349d4e4f3742ded3e248b813ad70c24e
#14 exporting attestation manifest sha256:a7b9d29a6d93e80df922c28322995b26349d4e4f3742ded3e248b813ad70c24e 0.3s done
#14 exporting manifest list sha256:64ca16f27d51d43d7d73a51e9c52afb8cceb38dcd36ec634b24236cdee192e61
#14 exporting manifest list sha256:64ca16f27d51d43d7d73a51e9c52afb8cceb38dcd36ec634b24236cdee192e61 0.1s done
#14 naming to docker.io/library/devops-a04-react-app:local
#14 naming to docker.io/library/devops-a04-react-app:local 0.0s done
#14 unpacking to docker.io/library/devops-a04-react-app:local
#14 unpacking to docker.io/library/devops-a04-react-app:local 0.2s done
#14 DONE 1.9s
+ docker run -d --name devops-a04-react-app --label devops.assignment=04 -p 8085:80 devops-a04-react-app:local
48fe90a84266d9c1d1af02b70dd1e24eccb628c299713870df50a67677f49cbf
+ for attempt in {1..30}
+ curl -fsS http://127.0.0.1:8085
+ break
+ [[ React-app == React-app ]]
+ curl -fsS http://127.0.0.1:8085/app.js -o /dev/null
+ docker logs devops-a04-react-app
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
10.0.2.2 - - [07/Oct/2026:07:44:14 +0000] "GET / HTTP/1.1" 200 113 "-" "curl/8.22.0" "-"
10.0.2.2 - - [07/Oct/2026:07:44:14 +0000] "GET /app.js HTTP/1.1" 200 193583 "-" "curl/8.22.0" "-"
2026/10/07 07:44:14 [notice] 1#1: using the "epoll" event method
2026/10/07 07:44:14 [notice] 1#1: nginx/1.31.6
2026/10/07 07:44:14 [notice] 1#1: built by gcc 15.2.0 (Alpine 15.2.0) 
2026/10/07 07:44:14 [notice] 1#1: OS: Linux 6.8.0-142-generic
2026/10/07 07:44:14 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1024:524288
2026/10/07 07:44:14 [notice] 1#1: start worker processes
2026/10/07 07:44:14 [notice] 1#1: start worker process 30
2026/10/07 07:44:14 [notice] 1#1: start worker process 31
2026/10/07 07:44:14 [notice] 1#1: start worker process 32
2026/10/07 07:44:14 [notice] 1#1: start worker process 33
+ for i in "${!folders[@]}"
+ folder=nginx-app
+ name=devops-a04-nginx-app
+ host_port=8086
+ docker build -t devops-a04-nginx-app:local nginx-app
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 104B 0.0s done
#1 DONE 0.3s

#2 [internal] load metadata for docker.io/library/nginx:alpine
#2 DONE 0.6s

#3 [internal] load .dockerignore
#3 transferring context:
#3 transferring context: 64B 0.0s done
#3 DONE 0.3s

#4 [1/2] FROM docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#4 resolve docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
#4 resolve docker.io/library/nginx:alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2 0.3s done
#4 CACHED

#5 [internal] load build context
#5 transferring context: 129B 0.0s done
#5 DONE 0.4s

#6 [2/2] COPY index.html /usr/share/nginx/html/
#6 DONE 0.3s

#7 exporting to image
#7 exporting layers
#7 exporting layers 0.7s done
#7 exporting manifest sha256:5d5cf632137f7fdcc42d56c05a9d5be9453cdcc936d9bd9e0aba7f4df3b7cec4 0.1s done
#7 exporting config sha256:198d31fb4f166c8b2fece6af1eb56efa994e53179209f6b92fb170ac5dce6708
#7 exporting config sha256:198d31fb4f166c8b2fece6af1eb56efa994e53179209f6b92fb170ac5dce6708 0.1s done
#7 exporting attestation manifest sha256:7f6a62c6a79fe747688131fd201fbea865f7d6bc2cd968769475d809f98cd554
#7 exporting attestation manifest sha256:7f6a62c6a79fe747688131fd201fbea865f7d6bc2cd968769475d809f98cd554 0.3s done
#7 exporting manifest list sha256:766299cf27353a5f76c61c39ee525ca239ce58257a850fc26d027de115003998
#7 exporting manifest list sha256:766299cf27353a5f76c61c39ee525ca239ce58257a850fc26d027de115003998 0.2s done
#7 naming to docker.io/library/devops-a04-nginx-app:local
#7 naming to docker.io/library/devops-a04-nginx-app:local 0.0s done
#7 unpacking to docker.io/library/devops-a04-nginx-app:local
#7 unpacking to docker.io/library/devops-a04-nginx-app:local 0.2s done
#7 DONE 1.7s
+ docker run -d --name devops-a04-nginx-app --label devops.assignment=04 -p 8086:80 devops-a04-nginx-app:local
56b171b9a593a73c3bbe720dfc66c936ebe123677c9c994f4de93073293a4013
+ for attempt in {1..30}
+ curl -fsS http://127.0.0.1:8086
+ break
+ [[ nginx-app == React-app ]]
+ grep -q 'Hello World' evidence/nginx-app-response.html
+ docker logs devops-a04-nginx-app
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
10.0.2.2 - - [07/Oct/2026:07:44:21 +0000] "GET / HTTP/1.1" 200 92 "-" "curl/8.22.0" "-"
2026/10/07 07:44:21 [notice] 1#1: using the "epoll" event method
2026/10/07 07:44:21 [notice] 1#1: nginx/1.31.6
2026/10/07 07:44:21 [notice] 1#1: built by gcc 15.2.0 (Alpine 15.2.0) 
2026/10/07 07:44:21 [notice] 1#1: OS: Linux 6.8.0-142-generic
2026/10/07 07:44:21 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1024:524288
2026/10/07 07:44:21 [notice] 1#1: start worker processes
2026/10/07 07:44:21 [notice] 1#1: start worker process 30
2026/10/07 07:44:21 [notice] 1#1: start worker process 31
2026/10/07 07:44:21 [notice] 1#1: start worker process 32
2026/10/07 07:44:21 [notice] 1#1: start worker process 33
+ docker ps --filter label=devops.assignment=04 --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}'
NAMES                   IMAGE                         PORTS                                         STATUS
devops-a04-nginx-app    devops-a04-nginx-app:local    0.0.0.0:8086->80/tcp, [::]:8086->80/tcp       Up Less than a second
devops-a04-react-app    devops-a04-react-app:local    0.0.0.0:8085->80/tcp, [::]:8085->80/tcp       Up 7 seconds
devops-a04-apache-app   devops-a04-apache-app:local   0.0.0.0:8084->80/tcp, [::]:8084->80/tcp       Up 27 seconds
devops-a04-java-app     devops-a04-java-app:local     0.0.0.0:8083->8080/tcp, [::]:8083->8080/tcp   Up 44 seconds
devops-a04-python-app   devops-a04-python-app:local   0.0.0.0:8082->8000/tcp, [::]:8082->8000/tcp   Up About a minute
devops-a04-nodejs-app   devops-a04-nodejs-app:local   0.0.0.0:8081->3000/tcp, [::]:8081->3000/tcp   Up 2 minutes

```
