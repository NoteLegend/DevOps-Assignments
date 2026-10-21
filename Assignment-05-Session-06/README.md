# Assignment 05 — Docker Multi-Stage Build

A Node.js multi-stage image serving the required greeting on port 8080, with additional runtime examples.

[Portfolio](../README.md) · [Requirements](REQUIREMENTS.md) · [Execution evidence](evidence/)

## The problem

Build dependencies and runtime dependencies have different purposes. The container must serve the required greeting on port 8080 while keeping the production stage focused on execution.

## Approach

1. Installed dependencies in a named Node.js builder stage.
2. Created a production stage with production-only dependencies and copied the server from the builder.
3. Built and ran the multi-stage application, verified the exact greeting on port 8080, and repeated container execution for Node.js, Python and Java examples.

## How it works

```mermaid
flowchart TB
  subgraph BUILD["Builder stage"]
    direction LR
    A["Source + package lock"] --> B["npm ci"]
  end
  subgraph PROD["Production stage"]
    direction LR
    C["Copy package files + server"] --> D["npm ci --omit=dev"]
    D --> E["Node server: port 8080"]
  end
  BUILD --> PROD
  PROD --> F["Verify required greeting"]
  classDef default fill:#eff6ff,stroke:#3b82f6,color:#172554;
  classDef verified fill:#ecfdf5,stroke:#059669,color:#064e3b;
  class F verified;
  style BUILD fill:#f8fafc,stroke:#cbd5e1,color:#334155;
  style PROD fill:#f8fafc,stroke:#cbd5e1,color:#334155;
```

## Implementation

| Component | Implementation | Behavior verified |
| --- | --- | --- |
| Multi-stage build | [multi-stage-app/Dockerfile](multi-stage-app/Dockerfile) | Build and run the image; confirm Hello World from Docker multi-stage build. |
| Port and container evidence | [evidence/01-build-and-run.md](evidence/01-build-and-run.md) | HTTP verification and docker ps show the application on published port 8080. |
| Three application types | [Node.js](nodejs-app/), [Python](python-app/) and [Java](java-app/) | Node.js, Python and Java images were built and run. |

**Tools:** Docker multi-stage builds, Node.js/npm, Python and Java.

## Commands used

These are representative recorded commands. Complete scripts and output are linked in the evidence section.

```bash
docker build -t devops-a05-multistage:local multi-stage-app
docker run -d --name devops-a05-multistage --label devops.assignment=05 \
  -p 8080:8080 devops-a05-multistage:local
curl -fsS http://127.0.0.1:8080
docker ps --filter label=devops.assignment=05
```

## Verification & results

The required literal greeting was returned on port 8080. The three additional application types also served their expected responses.

The linked records identify the original local execution environment. Privileged Docker/Minikube exercises used the prepared Ubuntu VM; application endpoints shown in that evidence are historical.

## Troubleshooting & decisions

A multi-stage Dockerfile separates build tooling from the runtime. Verify the actual exposed service and port rather than inferring success from the image alone.

## Evidence

- [01 build and run](evidence/01-build-and-run.md) — successful execution

## Screenshots

Actual application pages and recorded command-output views from the practical execution.

![01 build and run](screenshots/01-build-and-run.png)

<details>
<summary>More screenshots: implementation, diagnostics and verification</summary>

![02 multistage page](screenshots/02-multistage-page.png)

</details>

## Key takeaways

A stage boundary makes the build/runtime separation explicit. This Dockerfile still uses a Node.js runtime image; no unmeasured image-size reduction is claimed.
