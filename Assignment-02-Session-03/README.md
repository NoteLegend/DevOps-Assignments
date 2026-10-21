# 02 · Networking Homework Tasks

**Session 03** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Practice the instructor’s networking diagnostics and explain what each command can establish about connectivity.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 3 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 1 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Referenced networking commands | [practice-networking.sh](practice-networking.sh) | Ten command families plus socket/interface inspection and a bounded DNS packet capture. |
| Outputs and understanding | [networking.md](networking.md) | Actual command output and short explanations, including the limits of ICMP, DNS, TCP and HTTP observations. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
bash practice-networking.sh
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Loopback/external ping, DNS resolution, HTTPS HTTP 200 and generated DNS packet capture are recorded. Traceroute was deliberately bounded to six hops; it is not presented as reaching the remote destination.

## Troubleshooting and observations

A working DNS lookup, reachable TCP port and successful HTTP response prove different parts of the network path. The VM used systemd-networkd for its service-log example.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 networking](evidence/01-networking.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (1 images)</summary>

![01 networking](screenshots/01-networking.png)

</details>
