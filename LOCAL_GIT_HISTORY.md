# Actual local Git history

Four isolated local repositories were initialized for the practical work. Their histories were scanned with Gitleaks, all with zero findings. Each portable bundle was verified before archiving the assignment-owned `.git` metadata outside this submission. This prevents nested repositories becoming Git submodule links when the owner publishes the combined repository. Working files remain in place. No remote was configured for these four isolated exercise repositories. The enclosing assignment portfolio was subsequently published separately.

## assignment03

Original working folder: `Assignment-03-Session-04/exercise-repo`. Branches: `feature`, `main`. No remote was configured.

[Verified portable history bundle](Assignment-03-Session-04/exercise-history.bundle)

```text
1fe8a61 feature 3: leave on branch
2eaa8f2 feature 2: selected change
b4c5394 feature 2: selected change
709814f main 3: explicitly stage new file
8573c5e feature 1: independent change
f652f08 main 2: tracked modification auto-staged
51567ac main 1: add tracked file
```

Local Git metadata preserved outside the submission at `/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/git-metadata/assignment03`.

## assignment19-gitops

Original working folder: `Assignment-19-Session-20/gitops/desired`. Branches: `main`. No remote was configured.

[Verified portable history bundle](Assignment-19-Session-20/gitops/history.bundle)

```text
464b74e Declare version two in Git
b742bd6 Declare initial local Kubernetes workload
```

Local Git metadata preserved outside the submission at `/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/git-metadata/assignment19-gitops`.

## assignment20-source

Original working folder: `Assignment-20-Session-21/final-devops-project`. Branches: `main`. No remote was configured.

[Verified portable history bundle](Assignment-20-Session-21/application-source.bundle)

```text
25c495d Document verified local implementation and pending external stages
88848c9 Add final DevOps application and local deployment configuration
```

Local Git metadata preserved outside the submission at `/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/git-metadata/assignment20-source`.

## assignment20-gitops

Original working folder: `Assignment-20-Session-21/final-devops-project/gitops/desired`. Branches: `main`. No remote was configured.

[Verified portable history bundle](Assignment-20-Session-21/final-devops-project/gitops/history.bundle)

```text
0de532f Promote final app to v2 through desired Git state
7e665ca Declare verified final application in local Git
```

Local Git metadata preserved outside the submission at `/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/git-metadata/assignment20-gitops`.

To inspect a bundle later, use `git clone <bundle-path> <new-local-directory>`. That command is a suggested inspection step, not an additional executed clone. To rerun a GitOps controller, restore its Git history first; its current working YAML records the final v2 desired state. Machine-specific verification scripts require the original workspace adapters.
