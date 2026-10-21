# Kubernetes Volumes · Lifetimes & Persistence

[Portfolio](../../README.md) · [Assignment](../README.md)

> Compare ephemeral, node-local and claim-backed storage using the actual exercises.

## Practical record

`volumes.sh` applies the course's real examples in namespace a12-volumes and writes/reads data. It deletes and recreates the Pods to distinguish lifetimes.

| Mechanism | Lifetime / purpose | Local demonstration |
| --- | --- | --- |
| emptyDir | Shared Pod storage, survives container restart but lost with Pod | File disappears after Pod replacement |
| hostPath | Directory on the specific node | File survives replacement on this single node |
| PV | Cluster-scoped declared storage capacity/access/reclaim policy | Retained hostPath PV student-pv |
| PVC | Namespaced storage request bound to a PV | student-pvc explicitly binds the static PV |
| StorageClass | Provisioner and storage policy | Minikube standard class inspected |
| Dynamic provisioning | Provisioner creates PV for a PVC | dynamic-pvc becomes Bound without a handwritten PV |

The static claim sets storageClassName to empty to prevent the default class from provisioning a different PV. ReadWriteOnce limits writable attachment to a node, not necessarily a single Pod; this demo uses one local node. Retain preserves backing data after claim deletion; the assignment-owned static PV is deleted explicitly afterward.
