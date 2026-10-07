# Security configuration

Bandit excludes test assertions; pip-audit resolves declared dependencies. Gitleaks uses its default detectors and excludes generated evidence reports from the source scan. The initial scan of a Trivy report matched public base-image GPG fingerprints in metadata, not runtime credentials; its redacted finding report is retained.

Trivy retains full OS/language findings. The gate policy is specified in gate.sh and the assignment README. Actual reports and scanner exit statuses are retained in assignment evidence.
