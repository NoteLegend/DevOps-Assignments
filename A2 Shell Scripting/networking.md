# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euo pipefail
../../.local-tools/vm.sh 'cd /workspace/DevOps-Assignments/Assignment-02-Session-03 && bash practice-networking.sh'

```

```text
Executed 2026-10-07T13:10:55.768114+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-02-Session-03
Script: verify.sh
Exit status: 0

+ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    inet 10.0.2.15/24 metric 100 brd 10.0.2.255 scope global dynamic ens3
       valid_lft 86237sec preferred_lft 86237sec
    inet6 fec0::5054:ff:fe12:3456/64 scope site dynamic mngtmpaddr noprefixroute 
       valid_lft 86239sec preferred_lft 14239sec
    inet6 fe80::5054:ff:fe12:3456/64 scope link 
       valid_lft forever preferred_lft forever
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 8e:18:34:a1:d5:64 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
+ ip -s link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX:  bytes packets errors dropped  missed   mcast           
         29171     238      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
         29171     238      0       0       0       0 
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast           
     161510875  112316      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
        441614    6077      0       0       0       0 
    altname enp0s3
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 8e:18:34:a1:d5:64 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast           
             0       0      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
             0       0      0       0       0       0 
+ ip route
default via 10.0.2.2 dev ens3 proto dhcp src 10.0.2.15 metric 100 
10.0.2.0/24 dev ens3 proto kernel scope link src 10.0.2.15 metric 100 
10.0.2.2 dev ens3 proto dhcp scope link src 10.0.2.15 metric 100 
10.0.2.3 dev ens3 proto dhcp scope link src 10.0.2.15 metric 100 
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown 
+ ip route get 1.1.1.1
1.1.1.1 via 10.0.2.2 dev ens3 src 10.0.2.15 uid 1000 
    cache 
+ ip neigh
10.0.2.3 dev ens3 lladdr 52:55:0a:00:02:03 REACHABLE 
10.0.2.2 dev ens3 lladdr 52:55:0a:00:02:02 REACHABLE 
fec0::2 dev ens3 lladdr 52:56:00:00:00:02 router STALE 
fe80::2 dev ens3 lladdr 52:56:00:00:00:02 router REACHABLE 
+ ss -tuln
Netid State  Recv-Q Send-Q  Local Address:Port  Peer Address:PortProcess
udp   UNCONN 0      0          127.0.0.54:53         0.0.0.0:*          
udp   UNCONN 0      0       127.0.0.53%lo:53         0.0.0.0:*          
udp   UNCONN 0      0      10.0.2.15%ens3:68         0.0.0.0:*          
tcp   LISTEN 0      4096          0.0.0.0:22         0.0.0.0:*          
tcp   LISTEN 0      4096        127.0.0.1:46573      0.0.0.0:*          
tcp   LISTEN 0      4096       127.0.0.54:53         0.0.0.0:*          
tcp   LISTEN 0      4096    127.0.0.53%lo:53         0.0.0.0:*          
tcp   LISTEN 0      4096             [::]:22            [::]:*          
+ ping -c 3 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.029 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.068 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.067 ms

--- 127.0.0.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2074ms
rtt min/avg/max/mdev = 0.029/0.054/0.068/0.018 ms
+ ping -c 3 -W 2 google.com
PING google.com (192.178.174.102) 56(84) bytes of data.
64 bytes from lcbomo-in-f102.1e100.net (192.178.174.102): icmp_seq=1 ttl=255 time=28.1 ms
64 bytes from lcbomo-in-f102.1e100.net (192.178.174.102): icmp_seq=2 ttl=255 time=40.5 ms
64 bytes from lcbomo-in-f102.1e100.net (192.178.174.102): icmp_seq=3 ttl=255 time=33.4 ms

--- google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 28.057/33.995/40.516/5.103 ms
+ traceroute -m 6 -w 1 google.com
traceroute to google.com (192.178.174.139), 6 hops max, 60 byte packets
 1  _gateway (10.0.2.2)  0.350 ms  0.297 ms  0.286 ms
 2  wifi.height8tech.com (100.128.160.1)  35.686 ms  35.674 ms  37.096 ms
 3  202.131.133.9.convergentindia.com (202.131.133.9)  39.106 ms  37.077 ms  39.087 ms
 4  * * *
 5  * * *
 6  115.112.15.114.static-chennai.vsnl.net.in (115.112.15.114)  41.967 ms  27.050 ms  26.992 ms
+ netstat -tuln
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:46573         0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
udp        0      0 127.0.0.54:53           0.0.0.0:*                          
udp        0      0 127.0.0.53:53           0.0.0.0:*                          
udp        0      0 10.0.2.15:68            0.0.0.0:*                          
+ printf 'GET / HTTP/1.0\r\nHost: google.com\r\n\r\n'
+ timeout 10 telnet google.com 80
Trying 192.178.174.113...
Connected to google.com.
Escape character is '^]'.
Connection closed by foreign host.
+ nslookup google.com
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	google.com
Address: 192.178.174.139
Name:	google.com
Address: 192.178.174.101
Name:	google.com
Address: 192.178.174.102
Name:	google.com
Address: 192.178.174.113
Name:	google.com
Address: 192.178.174.138
Name:	google.com
Address: 192.178.174.100
Name:	google.com
Address: 2404:6800:4000:1010::8b
Name:	google.com
Address: 2404:6800:4000:1010::66
Name:	google.com
Address: 2404:6800:4000:1010::64
Name:	google.com
Address: 2404:6800:4000:1010::71

+ dig google.com

; <<>> DiG 9.18.39-0ubuntu0.24.04.7-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 10765
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 4, ADDITIONAL: 5

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		82	IN	A	192.178.174.138
google.com.		82	IN	A	192.178.174.100
google.com.		82	IN	A	192.178.174.101
google.com.		82	IN	A	192.178.174.102
google.com.		82	IN	A	192.178.174.113
google.com.		82	IN	A	192.178.174.139

;; AUTHORITY SECTION:
google.com.		82	IN	NS	ns1.google.com.
google.com.		82	IN	NS	ns3.google.com.
google.com.		82	IN	NS	ns2.google.com.
google.com.		82	IN	NS	ns4.google.com.

;; ADDITIONAL SECTION:
ns3.google.com.		82	IN	A	216.239.36.10
ns1.google.com.		82	IN	A	216.239.32.10
ns4.google.com.		82	IN	A	216.239.38.10
ns2.google.com.		82	IN	A	216.239.34.10

;; Query time: 1 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Wed Oct 07 07:40:54 UTC 2026
;; MSG SIZE  rcvd: 271

+ curl -sSI --max-time 20 https://www.google.com
+ sed '/^set-cookie:/Id'
HTTP/2 200 
content-type: text/html; charset=ISO-8859-1
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-zQWBuDKfLNmTrAYZYESFzA' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
accept-ch: Sec-CH-Prefers-Color-Scheme
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
date: Wed, 07 Oct 2026 07:40:54 GMT
server: gws
x-xss-protection: 0
x-frame-options: SAMEORIGIN
expires: Wed, 07 Oct 2026 07:40:54 GMT
cache-control: private
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000

+ arp -a
? (10.0.2.3) at 52:55:0a:00:02:03 [ether] on ens3
_gateway (10.0.2.2) at 52:55:0a:00:02:02 [ether] on ens3
+ systemctl status systemd-networkd --no-pager
● systemd-networkd.service - Network Configuration
     Loaded: loaded (/usr/lib/systemd/system/systemd-networkd.service; enabled; preset: enabled)
     Active: active (running) since Wed 2026-10-07 07:38:04 UTC; 2min 49s ago
TriggeredBy: ● systemd-networkd.socket
       Docs: man:systemd-networkd.service(8)
             man:org.freedesktop.network1(5)
   Main PID: 653 (systemd-network)
     Status: "Processing requests..."
      Tasks: 1 (limit: 7064)
   FD Store: 0 (limit: 512)
     Memory: 3.1M (peak: 3.4M)
        CPU: 36ms
     CGroup: /system.slice/systemd-networkd.service
             └─653 /usr/lib/systemd/systemd-networkd

Oct 07 07:38:04 devops-local-vm systemd-networkd[653]: lo: Link UP
Oct 07 07:38:04 devops-local-vm systemd-networkd[653]: lo: Gained carrier
Oct 07 07:38:04 devops-local-vm systemd-networkd[653]: Enumeration completed
Oct 07 07:38:04 devops-local-vm systemd[1]: Started systemd-networkd.service - Network Configuration.
Oct 07 07:38:04 devops-local-vm systemd-networkd[653]: ens3: Configuring with /run/systemd/network/10-netplan-ens3.network.
Oct 07 07:38:04 devops-local-vm systemd-networkd[653]: ens3: Link UP
Oct 07 07:38:04 devops-local-vm systemd-networkd[653]: ens3: Gained carrier
Oct 07 07:38:04 devops-local-vm systemd-networkd[653]: ens3: DHCPv4 address 10.0.2.15/24, gateway 10.0.2.2 acquired from 10.0.2.2
Oct 07 07:38:06 devops-local-vm systemd-networkd[653]: ens3: Gained IPv6LL
Oct 07 07:38:57 devops-local-vm systemd-networkd[653]: docker0: Link UP
+ sudo timeout 8 tcpdump -i ens3 -nn -c 2 'port 53'
+ capture_pid=3433
+ sleep 1
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on ens3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
+ dig @10.0.2.3 example.org
07:40:55.751732 IP 10.0.2.15.44164 > 10.0.2.3.53: 316+ [1au] A? example.org. (52)
07:40:55.752680 IP 10.0.2.3.53 > 10.0.2.15.44164: 316 2/2/7 A 172.66.157.237, A 104.20.26.136 (227)
2 packets captured
2 packets received by filter
0 packets dropped by kernel

; <<>> DiG 9.18.39-0ubuntu0.24.04.7-Ubuntu <<>> @10.0.2.3 example.org
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 316
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 7

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;example.org.			IN	A

;; ANSWER SECTION:
example.org.		215	IN	A	172.66.157.237
example.org.		215	IN	A	104.20.26.136

;; AUTHORITY SECTION:
example.org.		215	IN	NS	katelyn.ns.cloudflare.com.
example.org.		215	IN	NS	mitch.ns.cloudflare.com.

;; ADDITIONAL SECTION:
mitch.ns.cloudflare.com. 215	IN	A	173.245.59.208
katelyn.ns.cloudflare.com. 215	IN	A	162.159.38.235
katelyn.ns.cloudflare.com. 215	IN	A	172.64.34.235
mitch.ns.cloudflare.com. 215	IN	A	108.162.193.208
mitch.ns.cloudflare.com. 215	IN	A	172.64.33.208
katelyn.ns.cloudflare.com. 215	IN	A	108.162.194.235

;; Query time: 1 msec
;; SERVER: 10.0.2.3#53(10.0.2.3) (UDP)
;; WHEN: Wed Oct 07 07:40:55 UTC 2026
;; MSG SIZE  rcvd: 227

+ wait 3433

```
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
