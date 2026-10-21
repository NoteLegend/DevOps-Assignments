# 05 · Docker Multi-Stage Build

**Session 06** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Run the referenced multi-stage build, verify its exact greeting on port 8080, and deploy three additional application runtimes.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 7, 8 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 2 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Multi-stage build | [multi-stage-app/Dockerfile](multi-stage-app/Dockerfile) | Build and run the image; confirm Hello World from Docker multi-stage build. |
| Port and container evidence | [evidence/01-build-and-run.md](evidence/01-build-and-run.md) | HTTP verification and docker ps show the application on published port 8080. |
| Three application types | [nodejs-app/](nodejs-app/) | Node.js, Python and Java images were built and run. |
| Student documentation | [../IDENTITY.md](../IDENTITY.md) | Rushi Jadhav · enrollment 10144, supplied in the workspace identity file. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
docker build -t devops-a05-multistage:local multi-stage-app
docker ps --filter label=devops.assignment=05
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

The required literal greeting was returned on port 8080. The three additional application types also served their expected responses. Student: **Rushi Jadhav**. Enrollment: **10144**.

## Troubleshooting and observations

A multi-stage Dockerfile separates build tooling from the runtime. Verify the actual exposed service and port rather than inferring success from the image alone.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 build and run](evidence/01-build-and-run.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (2 images)</summary>

![01 build and run](screenshots/01-build-and-run.png)

![02 multistage page](screenshots/02-multistage-page.png)

</details>
