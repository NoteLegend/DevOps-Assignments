# Assignment 02 — Networking Homework Tasks

Sessions 03. [Exact PDF requirements](REQUIREMENTS.md).

## Objective

Practice the networking diagnostics referenced by the PDF's devops-hero resource.

## Tasks Performed

Executed the ten command families from the instructor's Network-Troubleshooting README, plus iproute2/socket inspection, in the local Ubuntu VM. Created `networking.md` and added real outputs and explanations.

## Tools Used

Ubuntu 24.04 VM: iproute2, iputils, traceroute, net-tools, telnet, tcpdump, DNS utilities, curl and systemd.

## Implementation

`practice-networking.sh` runs bounded diagnostics. Packet capture uses only DNS traffic generated for this exercise. HTTPS response cookies are excluded from submission evidence.

## Verification

Loopback and external ping received replies; DNS returned addresses; HTTPS returned HTTP 200; routing selected the VM gateway; tcpdump captured the query and response. Traceroute was intentionally bounded to six hops and does not imply it reached the destination.

## Output / Results

See `networking.md` and the complete executed transcript.

## Troubleshooting / Observations

`ip addr` lists addresses; `ip route`/`route get` show forwarding decisions; `ip neigh`/`arp` show local next-hop address mappings, not remote Google server MAC addresses. `ss`/`netstat` list sockets. Ping measures ICMP reachability. Traceroute reports responding hops, with missing replies represented by stars. Telnet tests a TCP port. `nslookup`/`dig` test DNS. Curl tests HTTP/TLS separately from ICMP. Tcpdump reveals actual packets. The VM uses systemd-networkd, so that service replaces the course's NetworkManager example.

## Lessons Learned

DNS, routing, transport and HTTP can fail independently. A bounded traceroute or an empty socket list alone does not establish a service outage.


## Commands Executed

The linked transcripts contain the exact executed scripts, stdout/stderr and exit status.

- [01-networking.md](evidence/01-networking.md)

## Screenshots

Command screenshots are browser views of real captured output, labeled as such; application screenshots show actual accessed pages.

![01-networking](screenshots/01-networking.png)
