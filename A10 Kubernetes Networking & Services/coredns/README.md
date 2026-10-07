# CoreDNS in the local cluster

CoreDNS answers cluster DNS queries using Kubernetes resource information. Its Corefile configures the Kubernetes zone, forwarding, caching and health behavior. The kube-dns Service gives Pods a stable DNS server address.

`verify-services.sh` inspects the actual `kube-system/coredns` ConfigMap and CoreDNS logs after resolving the application's Services. Those captured values describe this cluster, rather than a copied example.

For diagnosis, check CoreDNS Pod readiness/logs, the kube-dns Service and EndpointSlices, the client `/etc/resolv.conf`, and the target Service/namespace. No custom DNS configuration was needed here.

Source: [Customizing DNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
