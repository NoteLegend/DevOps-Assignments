# Docker overlay networks

Overlay networks join containers across Docker hosts. Docker Swarm membership coordinates discovery and network membership; VXLAN carries container traffic over the underlying host network. They suit distributed services and attachable standalone containers spanning hosts. User-defined bridge networks instead operate within one Docker daemon host.

Participating hosts require Swarm control traffic (normally TCP 2377), node discovery (TCP/UDP 7946), and VXLAN data traffic (UDP 4789). `--attachable` permits standalone containers; `--opt encrypted` enables application-data encryption with a performance cost.

This assignment asks for research, not a multi-host deployment. No extra VM or cloud host was created to simulate cross-host evidence.

Source: [Docker overlay driver documentation](https://docs.docker.com/engine/network/drivers/overlay/).
