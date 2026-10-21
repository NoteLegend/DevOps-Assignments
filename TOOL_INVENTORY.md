# Historical tool inventory · 7 October 2026

> These versions and runtime listings were captured for the original course execution. The README review is dated 21 October 2026; see [execution environment](EXECUTION_ENVIRONMENT.md) for the later host observation.

Actual command output captured after assignment workloads were cleaned up, before stopping the assignment-owned Minikube control plane and VM. The pre-existing host Docker service was not changed. Versions below are observed, not assumed.

```text
Linux 7.2.0-1-cachyos
Python 3.14.7
1.7.12
installed by downloading from release page
built with go1.26.1 compiler for linux/amd64
8.30.1
Version: 0.75.0
Vulnerability DB:
  Version: 2
  UpdatedAt: 2026-10-07 07:38:55.515026687 +0000 UTC
  NextUpdate: 2026-10-08 07:38:55.515026457 +0000 UTC
  DownloadedAt: 2026-10-07 08:32:57.40972978 +0000 UTC
Terraform v1.16.5
on linux_amd64
bandit 1.9.4
  python version = 3.14.7 (main, Aug 14 2026, 06:38:32) [GCC 16.2.1 20260810]
pip-audit 2.10.1
PRETTY_NAME="Ubuntu 24.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
29.1.3
Docker Compose version 2.40.3+ds1-0ubuntu1~24.04.1
minikube version: v1.39.0
commit: 7a9f6a841470a207de8cf4bafcccee0969d8ba10
Client Version: v1.37.1
Kustomize Version: v5.8.1
Server Version: v1.36.0
v4.3.0+gbec5b06
ShellCheck - shell script analysis tool
version: 0.9.0
license: GNU General Public License, version 3
website: https://www.shellcheck.net
devops-course gcr.io/k8s-minikube/kicbase:v0.0.51 Up About an hour
NAME              STATUS   AGE
default           Active   81m
ingress-nginx     Active   64m
kube-node-lease   Active   81m
kube-public       Active   81m
kube-system       Active   81m
NAMESPACE       NAME                                        READY   STATUS      RESTARTS   AGE
ingress-nginx   ingress-nginx-admission-create-vzhxf        0/1     Completed   0          64m
ingress-nginx   ingress-nginx-admission-patch-xdf6t         0/1     Completed   0          64m
ingress-nginx   ingress-nginx-controller-7b86db8c55-g68hh   1/1     Running     0          64m
kube-system     coredns-589f44dc88-7r7bm                    1/1     Running     0          81m
kube-system     etcd-devops-course                          1/1     Running     0          81m
kube-system     kindnet-w2tvm                               1/1     Running     0          77m
kube-system     kube-apiserver-devops-course                1/1     Running     0          81m
kube-system     kube-controller-manager-devops-course       1/1     Running     0          81m
kube-system     kube-proxy-qg2k5                            1/1     Running     0          81m
kube-system     kube-scheduler-devops-course                1/1     Running     0          81m
kube-system     metrics-server-84c57757c7-pwt54             1/1     Running     0          61m
kube-system     storage-provisioner                         1/1     Running     0          81m
```

The host received user-local downloads/virtual environments, not a replacement Docker installation. Docker, Compose, networking packages and ShellCheck were installed in the one prepared Ubuntu VM. Minikube, kubectl and Helm run there through workspace adapters. The VM and cluster are stopped after the final audit; see [CLEANUP.md](CLEANUP.md).

## October-21 follow-up

The follow-up used native host Docker 29.9.1, AWS CLI 2.37.9, Terraform 1.16.5 and locked AWS provider 6.67.0. GitHub-hosted Ubuntu runners executed the calculator and DevSecOps pipelines; the DevSecOps job checksum-verified kind 0.33.0 and used Kubernetes 1.35.8 in an ephemeral runner-local cluster. The VM was not restarted.

Bandit 1.9.4, pip-audit 2.10.1, Gitleaks 8.30.1 and Trivy 0.76.0 versions are recorded in the hosted workflow/logs. No host Docker replacement or second VM was installed. Local Python PDF/browser/Markdown validation dependencies were kept in the workspace tooling environment outside submission.
