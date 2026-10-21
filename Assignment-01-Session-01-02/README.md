# 01 · Linux Homework Tasks and Shell Scripting Homework Task

**Session 01-02** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Explore Linux filesystem behavior and write an interactive system-information script. Sessions 1 and 2 form one assignment: both Linux and Bash work are included here.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 1, 2 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 3 · actual screenshots: 3 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Soft and hard links | [practice-host.sh](practice-host.sh) | Create/delete links, compare inodes and observe a dangling symlink. |
| Ubuntu user management and logs | [practice-ubuntu.sh](practice-ubuntu.sh) | Create a locked test user with adduser; inspect system and Docker service journal entries; clean up the test account. |
| Linux command practice | [work/](work/) | Filesystem, search, permissions, processes and log commands are captured in the execution record. |
| System-information script | [system-information.sh](system-information.sh) | Date, hostname, username, disk/process data, variables, read -p, mkdir, touch and redirected process output. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
bash system-information.sh
# Supply a simple report-directory name when prompted.
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

All three verification transcripts completed successfully. The script produced a process-report file; the link and user-management exercises were executed rather than described only.

## Troubleshooting and observations

A hard link shares an inode; a symbolic link stores a path and can become dangling. Ubuntu adduser supplies higher-level account setup. journalctl queries the systemd journal.

## Submission status

**COMPLETE.** None in the practical work. The revised documentation and restored folder names still need to be published by the owner.

## Execution evidence

- [01 links linux journal](evidence/01-links-linux-journal.md) — successful execution
- [02 system information](evidence/02-system-information.md) — successful execution
- [03 ubuntu user and commands](evidence/03-ubuntu-user-and-commands.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (3 images)</summary>

![01 links linux journal](screenshots/01-links-linux-journal.png)

![02 system information](screenshots/02-system-information.png)

![03 ubuntu user and commands](screenshots/03-ubuntu-user-and-commands.png)

</details>
