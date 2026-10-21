# PDF requirement coverage

**Primary source:** the complete 54-page DevOps Homework.pdf. Assignment 01 combines Sessions 1–2; Assignments 02–20 cover Sessions 3–21. [Readiness report](SUBMISSION_READINESS.md) identifies every remaining mandatory stage.

Each linked REQUIREMENTS.md preserves its exact mapped source text. The coverage below groups related PDF bullets; the full source remains available for line-by-line review. Recorded local execution and same-project cloud execution are distinguished.

## 01 · Sessions 01-02 · Linux Homework Tasks and Shell Scripting Homework Task

[Exact PDF text](Assignment-01-Session-01-02/REQUIREMENTS.md) · [Implementation and evidence](Assignment-01-Session-01-02/README.md)

PDF pages: 1, 2. **COMPLETE**.

- **Soft and hard links:** Create/delete links, compare inodes and observe a dangling symlink.
- **Ubuntu user management and logs:** Create a locked test user with adduser; inspect system and Docker service journal entries; clean up the test account.
- **Linux command practice:** Filesystem, search, permissions, processes and log commands are captured in the execution record.
- **System-information script:** Date, hostname, username, disk/process data, variables, read -p, mkdir, touch and redirected process output.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 02 · Sessions 03 · Networking Homework Tasks

[Exact PDF text](Assignment-02-Session-03/REQUIREMENTS.md) · [Implementation and evidence](Assignment-02-Session-03/README.md)

PDF pages: 3. **COMPLETE**.

- **Referenced networking commands:** Ten command families plus socket/interface inspection and a bounded DNS packet capture.
- **Outputs and understanding:** Actual command output and short explanations, including the limits of ICMP, DNS, TCP and HTTP observations.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 03 · Sessions 04 · Git Homework Tasks

[Exact PDF text](Assignment-03-Session-04/REQUIREMENTS.md) · [Implementation and evidence](Assignment-03-Session-04/README.md)

PDF pages: 4. **COMPLETE**.

- **commit -m versus commit -a -m:** Observe an unstaged commit failure; verify -a includes tracked changes while leaving a new file untracked.
- **Main and feature history:** Three initial main commits, three feature commits and one selected cherry-pick into main.
- **Verify the selected change:** Selected feature file is present on main; unrelated feature files are absent.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 04 · Sessions 05 · Docker Hello World Applications

[Exact PDF text](Assignment-04-Session-05/REQUIREMENTS.md) · [Implementation and evidence](Assignment-04-Session-05/README.md)

PDF pages: 5, 6. **COMPLETE**.

- **Node.js:** Build the image and verify its HTTP page.
- **Python:** Build the image and verify its HTTP page.
- **Java:** Compile/package in Docker and serve Hello World.
- **Apache:** Serve the actual page from Apache.
- **React:** Build the frontend and verify rendered Hello World in a browser.
- **Nginx:** Serve and verify the page with Nginx.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 05 · Sessions 06 · Docker Multi-Stage Build

[Exact PDF text](Assignment-05-Session-06/REQUIREMENTS.md) · [Implementation and evidence](Assignment-05-Session-06/README.md)

PDF pages: 7, 8. **COMPLETE**.

- **Multi-stage build:** Build and run the image; confirm Hello World from Docker multi-stage build.
- **Port and container evidence:** HTTP verification and docker ps show the application on published port 8080.
- **Three application types:** Node.js, Python and Java images were built and run.
- **Student documentation:** Rushi Jadhav · enrollment 10144, supplied in the workspace identity file.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 06 · Sessions 07 · Docker Networking & Volume

[Exact PDF text](Assignment-06-Session-07/REQUIREMENTS.md) · [Implementation and evidence](Assignment-06-Session-07/README.md)

PDF pages: 9, 10. **COMPLETE**.

- **Three containers / three networks:** Nginx frontend/backend and MySQL; backend connected to two networks; connectivity and isolation verified.
- **Apache host network:** Apache served directly on port 80 of the Ubuntu VM; the host browser used the VM forward.
- **Bind mount:** Hello students page changed without a container restart; container ID and start time stayed the same.
- **Overlay research:** Cross-host overlay purpose, transport and use cases documented.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 07 · Sessions 08 · Docker Networking & Volume: remaining session exercises

[Exact PDF text](Assignment-07-Session-08/REQUIREMENTS.md) · [Implementation and evidence](Assignment-07-Session-08/README.md)

PDF pages: 10. **COMPLETE**.

- **Basic Compose example:** Build/start, HTTP verification and cleanup.
- **Application Compose example:** Run and inspect the required services.
- **Full-stack exercise:** Frontend/backend/MySQL verification including real database creation, insertion and selection.
- **Startup troubleshooting:** Capture the Nginx/backend startup race and fix readiness ordering.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 08 · Sessions 09 · Kubernetes Fundamentals

[Exact PDF text](Assignment-08-Session-09/REQUIREMENTS.md) · [Implementation and evidence](Assignment-08-Session-09/README.md)

PDF pages: 11, 12. **COMPLETE**.

- **Cluster installation and status:** Local Minikube profile, node/control-plane inspection and basic Kubernetes objects.
- **Deploy, expose, scale, update and undo:** Actual bootcamp application responses and Deployment transitions.
- **Explore/API/labels/replacement:** kubectl proxy, Service proxy response, selectors and Pod replacement.
- **Failed update and repair:** Invalid v10 image fails rollout; undo restores v1.
- **Environment troubleshooting:** Preserved initial CNI problem and the real local repair.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 09 · Sessions 10 · Kubernetes Pods, ReplicaSets & Deployments

[Exact PDF text](Assignment-09-Session-10/REQUIREMENTS.md) · [Implementation and evidence](Assignment-09-Session-10/README.md)

PDF pages: 13, 14, 15. **COMPLETE**.

- **Rolling update:** Observe old/new replica changes during an application update.
- **Blue-green and canary:** Switch active Service selection; sample traffic across stable/canary Pods.
- **Recreate:** Observe old Pods terminating before replacement Pods start.
- **All twelve lifecycle examples:** Apply each YAML, record status/details, explain the observation and embed screenshots.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 10 · Sessions 11 · Kubernetes Networking & Services

[Exact PDF text](Assignment-10-Session-11/REQUIREMENTS.md) · [Implementation and evidence](Assignment-10-Session-11/README.md)

PDF pages: 16, 17, 18, 19. **COMPLETE**.

- **Five Service types:** ClusterIP, NodePort, local-tunnel LoadBalancer, ExternalName and Headless all deployed and checked.
- **Object comparisons:** Deployment/ReplicaSet, Deployment/DaemonSet/StatefulSet, and ReplicaSet/Service.
- **FQDN document:** Namespace-qualified Service names and Pod-to-Service examples.
- **CoreDNS document:** Configuration, discovery, query resolution and troubleshooting.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 11 · Sessions 12 · Kubernetes Ingress, ConfigMaps & Secrets

[Exact PDF text](Assignment-11-Session-12/REQUIREMENTS.md) · [Implementation and evidence](Assignment-11-Session-12/README.md)

PDF pages: 20, 21, 22. **COMPLETE**.

- **ConfigMap:** Store configuration, inject it into the Pod and verify the observed value.
- **Secret template and runtime injection:** Submit a placeholder template; verify runtime injection without printing the temporary value.
- **Ingress routing:** Actual ingress-nginx routing through the application Service.
- **Troubleshooting:** Before/after newline check, corrected Secret source and restarted workload.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 12 · Sessions 13 · Kubernetes Storage, HPA & Probes

[Exact PDF text](Assignment-12-Session-13/REQUIREMENTS.md) · [Implementation and evidence](Assignment-12-Session-13/README.md)

PDF pages: 23, 24, 25. **COMPLETE**.

- **Required volume documentation:** emptyDir, hostPath, PV, PVC, StorageClass and dynamic provisioning.
- **HPA exercise and load generator:** Actual CPU load, get hpa/pods, top pods and describe hpa.
- **Persistent mini project:** PVC-backed content survives Pod replacement; startup/readiness/liveness probes inspected.
- **Default recovery behavior:** Observed scale-up and return to two replicas using default stabilization.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 13 · Sessions 14 · Kubernetes Troubleshooting

[Exact PDF text](Assignment-13-Session-14/REQUIREMENTS.md) · [Implementation and evidence](Assignment-13-Session-14/README.md)

PDF pages: 26, 27, 28. **COMPLETE**.

- **All requested diagnostic commands:** get, describe, logs, exec, events, explain, top and wide output.
- **Container and scheduling failures:** CrashLoopBackOff, ErrImagePull/ImagePullBackOff, Pending, ContainerCreating and configuration errors.
- **Service / DNS / Pod addressing:** Wrong selector, wrong DNS name and unopened client port repaired and tested.
- **Course mini project:** Problem, investigation, cause, correction and successful verification documented.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 14 · Sessions 15 · Helm

[Exact PDF text](Assignment-14-Session-15/REQUIREMENTS.md) · [Implementation and evidence](Assignment-14-Session-15/README.md)

PDF pages: 29, 30, 31, 32. **COMPLETE**.

- **Helm commands:** create, install, list, status, get, upgrade, history, rollback, uninstall, repo and search.
- **Chart scaffold:** The chart generated by helm create and its rendered manifest.
- **Mini-project chart:** Deployment, ConfigMap, Service and environment-specific values.
- **Rollback verification:** Bad-image upgrade diagnosed; rollback restores working HTTP response and configuration.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 15 · Sessions 16 · CI/CD & GitHub Actions

[Exact PDF text](Assignment-15-Session-16/REQUIREMENTS.md) · [Implementation and evidence](Assignment-15-Session-16/README.md)

PDF pages: 33, 34. **COMPLETE**.

- **Referenced calculator application:** Five unit tests, interactive calculator output and a timestamped build artifact.
- **Docker packaging:** Image built and calculator executed in a container.
- **CI and CD definitions:** Root and standalone workflows are supplied; actual calculator CI/CD runs, build artifacts and GHCR publication passed.
- **Regression gate:** Intentional arithmetic defect fails a test; restoring the implementation restores five passes.

Result / remaining: Calculator CI and CD passed on GitHub; actual GHCR push, artifact and successful run screenshots retained.

## 16 · Sessions 17 · Complete CI/CD & DevSecOps

[Exact PDF text](Assignment-16-Session-17/REQUIREMENTS.md) · [Implementation and evidence](Assignment-16-Session-17/README.md)

PDF pages: 35, 36, 37. **COMPLETE**.

- **Application build and tests:** Three application tests and compile validation.
- **SAST / SCA / secret scanning:** Bandit, pip-audit and Gitleaks with actual retained reports.
- **Container scanning and gate:** Trivy rejects all HIGH/CRITICAL findings, including unfixed findings.
- **Kubernetes and artifact integrity:** Real local two-replica deployment; saved/loaded scanned image IDs are identical.
- **Hosted pipeline execution:** Complete ordered hosted flow passed; GHCR publication and runner-local kind deployment/health were verified; the cluster was removed.

Result / remaining: Full hosted security-gated build/test/scan/GHCR/Kubernetes pipeline passed; runner-local kind was deleted after verification.

## 17 · Sessions 18 · Terraform & Infrastructure as Code

[Exact PDF text](Assignment-17-Session-18/REQUIREMENTS.md) · [Implementation and evidence](Assignment-17-Session-18/README.md)

PDF pages: 38, 39, 40, 41, 42, 43. **COMPLETE**.

- **Exact Terraform project files:** main, variables, outputs, provider, actual nonsecret tfvars and README.
- **Actual Terraform lifecycle:** init, fmt, fmt -check, validate, plan, apply, show, output, state inspection and destroy succeeded for this S3 bucket.
- **Five AWS research folders:** IAM, EC2, S3, VPC, and DynamoDB/RDS with the PDF’s listed concepts.

Result / remaining: Approved AWS Terraform lifecycle actually executed and verified; assignment-owned resources destroyed after evidence capture.

## 18 · Sessions 19 · Cloud & Terraform in Action

[Exact PDF text](Assignment-18-Session-19/REQUIREMENTS.md) · [Implementation and evidence](Assignment-18-Session-19/README.md)

PDF pages: 44, 45, 46. **COMPLETE**.

- **Cloud architecture definition:** VPC, private subnet, Security Group, EC2 and protected S3 resources.
- **Inputs and outputs:** Region/AMI/bucket/instance inputs and computed outputs.
- **Real infrastructure lifecycle:** init/format/validate/plan/apply, AWS inspection, state/outputs and destroy completed; EC2 passed both status checks, and root-disk deletion was independently verified.
- **Architecture and state explanation:** Diagram and the difference between declared configuration and real cloud state.

Result / remaining: Approved AWS Terraform lifecycle actually executed and verified; assignment-owned resources destroyed after evidence capture.

## 19 · Sessions 20 · Monitoring, Observability & GitOps

[Exact PDF text](Assignment-19-Session-20/REQUIREMENTS.md) · [Implementation and evidence](Assignment-19-Session-20/README.md)

PDF pages: 47, 48. **COMPLETE**.

- **Monitoring demo:** Application health/request metrics and VM CPU/memory via Prometheus and node-exporter.
- **Actual alert and recovery:** Target outage produces a firing alert; restored target clears it.
- **Observability documentation:** Metrics/logs/traces, tools and Kubernetes diagnosis.
- **GitOps demonstration:** Five-second reconciliation corrects manual drift and deploys a newly committed version.

Result / remaining: Required practical implementation, successful recorded execution, screenshots and documentation are present.

## 20 · Session 21 · Final DevOps Project & Troubleshooting

[Exact PDF text](Assignment-20-Session-21/REQUIREMENTS.md) · [Submitted project link](Assignment-20-Session-21/README.md)

PDF pages: 49, 50, 51, 52, 53, 54. **COMPLETE**.

The owner explicitly requested link-only delivery of the existing [devOps-TaskBoard project](https://github.com/NoteLegend/devOps-TaskBoard). Its implementation, documentation and evidence remain in that repository. No duplicate capstone source is included or further capstone implementation performed under this delivery instruction.
