# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source /home/rushixd/Wurk/Scaler/DevOps/.local-tools/env.sh
cd "$DEVOPS_WORKSPACE"
for num in 16 20; do
  if [[ $num == 16 ]]; then image=devops-a16-app:local; workflow=DevOps-Assignments/Assignment-16-Session-17/.github/workflows/devsecops.yml; else image=devops-a20-final:local; workflow=DevOps-Assignments/Assignment-20-Session-21/final-devops-project/.github/workflows/pipeline.yml; fi
  actionlint -shellcheck= "$workflow"
  original=$(docker image inspect "$image" --format '{{.Id}}')
  docker save "$image" -o "/workspace/.local-tools/runtime/verified-image-$num.tar"
  docker load -i "/workspace/.local-tools/runtime/verified-image-$num.tar"
  docker tag "$image" "devops-a$num-artifact-check:local"
  loaded=$(docker image inspect "devops-a$num-artifact-check:local" --format '{{.Id}}')
  [[ "$original" == "$loaded" ]]
  echo "Assignment $num: saved/loaded/tagged image is identical: $loaded"
  docker image rm "devops-a$num-artifact-check:local"
  rm "/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/verified-image-$num.tar"
done

```

```text
Executed 2026-10-07T14:46:29.083268+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21
Script: verify-scanned-image-artifacts.sh
Exit status: 0

+ source /home/rushixd/Wurk/Scaler/DevOps/.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ cd /home/rushixd/Wurk/Scaler/DevOps
+ for num in 16 20
+ [[ 16 == 16 ]]
+ image=devops-a16-app:local
+ workflow=DevOps-Assignments/Assignment-16-Session-17/.github/workflows/devsecops.yml
+ actionlint -shellcheck= DevOps-Assignments/Assignment-16-Session-17/.github/workflows/devsecops.yml
++ docker image inspect devops-a16-app:local --format '{{.Id}}'
+ original=sha256:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213
+ docker save devops-a16-app:local -o /workspace/.local-tools/runtime/verified-image-16.tar
+ docker load -i /workspace/.local-tools/runtime/verified-image-16.tar
Loaded image: devops-a16-app:local
+ docker tag devops-a16-app:local devops-a16-artifact-check:local
++ docker image inspect devops-a16-artifact-check:local --format '{{.Id}}'
+ loaded=sha256:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213
+ [[ sha256:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213 == sha256\:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213 ]]
+ echo 'Assignment 16: saved/loaded/tagged image is identical: sha256:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213'
Assignment 16: saved/loaded/tagged image is identical: sha256:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213
+ docker image rm devops-a16-artifact-check:local
Untagged: devops-a16-artifact-check:local
+ rm /home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/verified-image-16.tar
+ for num in 16 20
+ [[ 20 == 16 ]]
+ image=devops-a20-final:local
+ workflow=DevOps-Assignments/Assignment-20-Session-21/final-devops-project/.github/workflows/pipeline.yml
+ actionlint -shellcheck= DevOps-Assignments/Assignment-20-Session-21/final-devops-project/.github/workflows/pipeline.yml
++ docker image inspect devops-a20-final:local --format '{{.Id}}'
+ original=sha256:c5b01c997eccc20d5c9c048eb0bc788bfb11e515e0427cd39b4b563395607fe5
+ docker save devops-a20-final:local -o /workspace/.local-tools/runtime/verified-image-20.tar
+ docker load -i /workspace/.local-tools/runtime/verified-image-20.tar
Loaded image: devops-a20-final:local
+ docker tag devops-a20-final:local devops-a20-artifact-check:local
++ docker image inspect devops-a20-artifact-check:local --format '{{.Id}}'
+ loaded=sha256:c5b01c997eccc20d5c9c048eb0bc788bfb11e515e0427cd39b4b563395607fe5
+ [[ sha256:c5b01c997eccc20d5c9c048eb0bc788bfb11e515e0427cd39b4b563395607fe5 == sha256\:c5b01c997eccc20d5c9c048eb0bc788bfb11e515e0427cd39b4b563395607fe5 ]]
+ echo 'Assignment 20: saved/loaded/tagged image is identical: sha256:c5b01c997eccc20d5c9c048eb0bc788bfb11e515e0427cd39b4b563395607fe5'
Assignment 20: saved/loaded/tagged image is identical: sha256:c5b01c997eccc20d5c9c048eb0bc788bfb11e515e0427cd39b4b563395607fe5
+ docker image rm devops-a20-artifact-check:local
Untagged: devops-a20-artifact-check:local
+ rm /home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/verified-image-20.tar

```
