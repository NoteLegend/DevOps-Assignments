# Local GitOps demonstration

Git main is the desired-state source. `reconcile.py` reads the committed Deployment every five seconds and applies it to namespace a19. Uncommitted working-tree edits do not affect reconciliation. This is an educational local controller, not a claimed Argo CD or Flux installation.

The demonstration commits version one, starts continuous reconciliation, changes the live replica count manually, observes restoration to the committed count, then commits version two and verifies the changed HTTP response. There is no remote, push or GitHub dependency. `history.bundle` preserves the actual local commits for portable review.

A GitOps workflow reviews/commits declarative state; the controller repeatedly compares/applies it to the cluster. Drift and application readiness must both be checked. Here the controller owns replicas; in the final project the HPA owns replicas and that field is omitted from Git's desired Deployment.

Source: [OpenGitOps principles](https://opengitops.dev/). The demonstrated local Git source is versioned, declarative and continuously reconciled; its custom polling controller is intentionally small and does not claim a hosted GitOps platform.
