# VPC — networking

[Portfolio](../../../README.md) · [Assignment 17](../../README.md)

## Concepts and use cases

A VPC is an isolated virtual network with a CIDR address range. Subnets partition that range within Availability Zones. Route tables determine destinations and next hops. An Internet Gateway connects an eligible public subnet to the internet. A NAT Gateway supports outbound internet connections from private subnets without direct public addressing.

Security Groups are stateful resource-level filters; Network ACLs are stateless subnet-level filters. A public subnet has an Internet Gateway route; a private subnet lacks that direct route. Having a public route alone does not assign public IPs.

The example uses a private subnet without Internet/NAT Gateway and no public EC2 IP. No networking resources were created.

Source: [AWS VPC guide](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).

## Assignment scope

This is the PDF-required research document. It does not claim that a corresponding AWS service was provisioned. The actual S3 lifecycle gap is tracked in the assignment README.
