# S3 — storage

[Portfolio](../../../README.md) · [Assignment 17](../../README.md)

## Concepts and use cases

S3 stores objects addressed by keys inside buckets. Objects include data and metadata. Storage classes trade retrieval behavior and cost for different access patterns, including Standard, Intelligent-Tiering, infrequent-access and archive classes.

Versioning preserves multiple object versions; lifecycle rules transition or expire objects and versions. Encryption protects stored data using supported server-side key options. Bucket policies define resource-based access; Public Access Block prevents accidental public exposure. Applications use S3 for static assets, backups, data lakes and build artifacts.

The Terraform example defines a bucket plus Public Access Block. No bucket exists from this assignment, and no console/cloud screenshot is claimed.

Source: [AWS S3 guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html).

## Assignment scope

This is the PDF-required research document. It does not claim that a corresponding AWS service was provisioned. The actual S3 lifecycle gap is tracked in the assignment README.
