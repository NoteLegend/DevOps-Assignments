#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cp app/calculator.py ../../.local-tools/runtime/a15-calculator-original.py
trap 'cp ../../.local-tools/runtime/a15-calculator-original.py app/calculator.py' EXIT
sed -i 's/return a + b$/return a + b + 1/' app/calculator.py
if ../../.local-tools/security-venv/bin/pytest -v; then exit 1; else echo 'Intentional add regression failed tests as expected; build is gated'; fi
cp ../../.local-tools/runtime/a15-calculator-original.py app/calculator.py
trap - EXIT
../../.local-tools/security-venv/bin/pytest -v
printf '10 + 5\nq\n' | ../../.local-tools/security-venv/bin/python app/calculator.py
bash build.sh
python -m compileall -q app tests
actionlint -shellcheck= .github/workflows/*.yml
if find . -type f \( -name '.env' -o -name '*.pem' -o -name '*.key' \) | grep .; then exit 1; fi
docker build -t devops-a15-calculator:local .
printf '10 + 5\nq\n' | docker run --rm -i devops-a15-calculator:local
