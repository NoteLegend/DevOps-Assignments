# Remaining external stages

The current, per-assignment checklist is [SUBMISSION_READINESS.md](SUBMISSION_READINESS.md). It distinguishes existing real Helpdesk cloud evidence from unperformed S3/EC2 exercises and same-project integration gaps.

## Ready locally

Root workflow entry points are in [.github/workflows](.github/workflows/): Assignment 15 CI/CD, Assignment 16 DevSecOps and Assignment 20 Flask final project. They use manual dispatch. Delivery is behind a named owner-controlled environment; configure its approval policy before any run. Prepare registry credentials, the approved Kubernetes target and runtime Secret through protected external configuration.

## Still unexecuted

Assignment 17 needs its actual S3 lifecycle; Assignment 18 needs its actual EC2/S3 architecture lifecycle. Placeholder AMI/bucket inputs must be replaced after approval. No new cloud plan/apply/show/output/destroy was executed in this review.

## Owner publication

The existing assignment remote is already configured. After reviewing and finishing the practical gaps, run these commands yourself; they are documentation only:

```bash
cd /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments
git status --short
git add .
git commit -m "Prepare verified DevOps course submission"
git push origin main
```

The portfolio was already public before this review. No new login, workflow trigger, registry publication, Git push or cloud-resource operation was performed here.
