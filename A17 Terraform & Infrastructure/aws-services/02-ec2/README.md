# EC2 — compute

EC2 provides configurable virtual servers. An AMI supplies the operating-system/software image. Instance types choose CPU, memory and network capacity. Key pairs allow supported SSH authentication: AWS keeps the public key; the owner protects the private key. Security Groups filter instance traffic. EBS provides persistent block storage.

Private IPs support VPC communication. Public IPs require appropriate addressing and routes for internet access. Instances move through pending, running, stopping/stopped and shutting-down/terminated states. Stopping preserves attached EBS according to configuration; termination can delete configured volumes. EC2 supports application servers, batch jobs and development environments.

The prepared Terraform EC2 resource has no public IP or inbound rule. No EC2 instance was created.

Source: [AWS EC2 concepts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html).
