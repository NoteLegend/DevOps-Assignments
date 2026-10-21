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
