# Kubernetes fully qualified names

A Service address follows `<service>.<namespace>.svc.<cluster-domain>`. This cluster uses `cluster.local`: `clusterip.a10.svc.cluster.local`. Short names resolve using the Pod's namespace search list; cross-namespace clients should qualify the namespace or use the FQDN.

The transcript runs `nslookup` for all five Services from the actual client Pod. Regular Services resolve to their virtual IP. Headless resolves ready Pod addresses; ExternalName returns the configured CNAME.

Source: [Kubernetes DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/).
