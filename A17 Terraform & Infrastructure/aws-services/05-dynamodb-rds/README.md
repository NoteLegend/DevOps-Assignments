# DynamoDB and RDS — databases

DynamoDB is a managed NoSQL database. Tables contain items consisting of attributes. A partition key selects data placement and lookup; an optional sort key orders related items sharing a partition key. Typical uses include application key-value state, shopping carts and event metadata.

Source: [DynamoDB introduction](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html).

RDS manages relational database instances. Supported engines include PostgreSQL, MySQL, MariaDB, Oracle, SQL Server and Db2; Aurora provides compatible managed relational engines. VPC placement, Security Groups, credentials and encryption control access. Automated backups and snapshots support recovery. Multi-AZ configurations improve availability; read replicas serve supported read-scaling workloads and are distinct from standby failover configurations. Typical uses include transactional applications and relational reporting.

Source: [RDS guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html).

This assignment documents both services; it creates neither database resources nor credentials.
