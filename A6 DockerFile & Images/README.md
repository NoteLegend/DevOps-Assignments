# Assignment 06 — Docker Networking & Volume

Sessions 07. [Exact PDF requirements](REQUIREMENTS.md).

## Objective

Demonstrate Docker network membership, host networking and live bind-mounted content.

## Tasks Performed

Created three labeled networks and frontend/backend/MySQL containers. Backend joined frontend and database networks. Checked permitted connectivity and frontend/database isolation. Ran Apache using host networking. Mounted an Nginx website and edited it without container restart. Researched overlay networking.

## Tools Used

Local Ubuntu VM Docker, Nginx Alpine, MySQL 8.0, Apache httpd 2.4, host Playwright browser.

## Implementation

`network-volume.sh` creates isolated assignment-owned resources. The temporary MySQL runtime password lives outside the submission and is never printed. `bind-site/index.html` is the mounted website.

## Verification

Frontend reached backend; backend reached database; frontend could not resolve the database. Backend inspection listed two networks. Apache responded directly at VM-host port 80; the host browser accessed its forwarded port 8088. Nginx reflected modified HTML and identical container ID/start-time records proved it was not restarted.

## Output / Results

Network checks, actual webpages, Docker process output and before/after bind-mount evidence are retained. Resources were cleaned up after collection.

## Troubleshooting / Observations

The Docker host for this exercise is the local Ubuntu VM, not CachyOS. Host networking therefore shares the VM's network namespace. See [overlay research](overlay-networks.md) for multi-host behavior; no multi-host execution is claimed.

## External Steps Pending

GitHub screenshot submission is deferred. The remaining referenced session Compose exercises are in Assignment 07 / Session 08, with the mapping explanation in its REQUIREMENTS.md.

## Lessons Learned

Network membership controls service-name discovery and reachability. Bind mounts expose host file changes immediately without rebuilding an image.


## Commands Executed

The linked transcripts contain the exact executed scripts, stdout/stderr and exit status.

- [01-networking-volume.md](evidence/01-networking-volume.md)

## Screenshots

Command screenshots are browser views of real captured output, labeled as such; application screenshots show actual accessed pages.

![01-networking-volume](screenshots/01-networking-volume.png)
![02-apache-host-network](screenshots/02-apache-host-network.png)
![03-bind-before](screenshots/03-bind-before.png)
![04-bind-after](screenshots/04-bind-after.png)
