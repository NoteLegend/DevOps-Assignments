# 06 · Docker Networking & Volume

**Session 07** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Demonstrate Docker network membership, isolation, VM host networking and live updates through a bind mount.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 9, 10 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 4 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Three containers / three networks | [network-volume.sh](network-volume.sh) | Nginx frontend/backend and MySQL; backend connected to two networks; connectivity and isolation verified. |
| Apache host network | [evidence/01-networking-volume.md](evidence/01-networking-volume.md) | Apache served directly on port 80 of the Ubuntu VM; the host browser used the VM forward. |
| Bind mount | [bind-site/index.html](bind-site/index.html) | Hello students page changed without a container restart; container ID and start time stayed the same. |
| Overlay research | [overlay-networks.md](overlay-networks.md) | Cross-host overlay purpose, transport and use cases documented. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
docker network ls --filter label=devops.assignment=06
docker inspect devops-a06-backend
# network-volume.sh contains the actual creation and connectivity sequence.
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Backend-to-database connectivity succeeded while the frontend could not resolve the isolated database. Actual before/after bind-mount responses and unchanged container identity were retained.

## Troubleshooting and observations

Network membership controls discovery/reachability. The host-network result is explicitly a VM result; overlay behavior is research, as requested by the PDF.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 networking volume](evidence/01-networking-volume.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (4 images)</summary>

![01 networking volume](screenshots/01-networking-volume.png)

![02 apache host network](screenshots/02-apache-host-network.png)

![03 bind before](screenshots/03-bind-before.png)

![04 bind after](screenshots/04-bind-after.png)

</details>
