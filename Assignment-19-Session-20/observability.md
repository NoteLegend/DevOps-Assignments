# Observability and Kubernetes

Metrics are numeric measurements over time: request counts, CPU and memory trends help quantify a condition. Logs record discrete events: this demo logs actual request path/status/duration and a generated trace ID. Traces describe linked spans of a request across components, helping locate latency and failures. This single-process application emits request correlation IDs and durations; it does not claim a distributed tracing backend or multi-service trace.

Observability helps infer why a system behaves unexpectedly rather than only whether it is up. Prometheus collects time-series metrics and evaluates alerts; Grafana commonly visualizes metrics, Loki/Elasticsearch commonly index logs, and OpenTelemetry/Jaeger commonly instrument or examine traces. These are examples, not claims that all were installed.

In Kubernetes, Pod/container/node metrics, workload events, application logs and request traces answer different questions. `kubectl top`, `logs`, `describe` and events support local diagnosis. The demo measures its local Ubuntu VM's CPU/memory with node-exporter, checks real application scrape health, fires ApplicationDown by stopping the application and records recovery. Prometheus's `up` reports scrape success; it is not a synthetic replacement for application logs or endpoint testing.

Sources: [Prometheus overview](https://prometheus.io/docs/introduction/overview/), [OpenTelemetry signals](https://opentelemetry.io/docs/concepts/signals/), [node-exporter](https://github.com/prometheus/node_exporter).
