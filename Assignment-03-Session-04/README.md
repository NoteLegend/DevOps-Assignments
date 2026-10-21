# 03 · Git Homework Tasks

**Session 04** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Demonstrate staging behavior and move one selected feature commit into main with cherry-pick.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 4 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 1 |
| Execution environment | Host Git |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| commit -m versus commit -a -m | [practice-git.sh](practice-git.sh) | Observe an unstaged commit failure; verify -a includes tracked changes while leaving a new file untracked. |
| Main and feature history | [exercise-history.bundle](exercise-history.bundle) | Three initial main commits, three feature commits and one selected cherry-pick into main. |
| Verify the selected change | [evidence/01-git-history.md](evidence/01-git-history.md) | Selected feature file is present on main; unrelated feature files are absent. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
git log --graph --oneline --all
git commit -a -m 'main 2: tracked modification auto-staged'
git cherry-pick b4c5394
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

The selected change was copied into main and the portable Git bundle verified successfully. The selected source commit and its new main-branch commit are retained in the transcript and verified history bundle.

## Troubleshooting and observations

Commit messages do not stage files. -a stages tracked modifications/deletions, while cherry-pick applies a particular commit and creates a new commit on the destination branch.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 git history](evidence/01-git-history.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (1 images)</summary>

![01 git history](screenshots/01-git-history.png)

</details>
