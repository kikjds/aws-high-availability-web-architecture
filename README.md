# AWS 3-Tier Architecture with Terraform

This project demonstrates a classic 3-tier cloud architecture in AWS, fully deployed using **Terraform**.

The goal is to build a secure, highly available (HA) environment with strict isolation between the public and private layers.

## Architecture - Overview

The project provisions the following resources within a single VPC - `10.10.0.0/16`:

- **Public Layer:**
    - 3 public subnets - across different Availability Zones - AZ1, AZ2, AZ3.
    - Application Load Balancer - ALB - the entry point for internet traffic.
    - Internet Gateway - IGW - provides connectivity to the outside world.
    - NAT Gateway - allows private subnets to access the internet - e.g. for package updates.
    - Bastion Host - a hardened EC2 instance in a public subnet, used exclusively for secure SSH access to private instances.
- **Private Layer:**
    - 3 private subnets - in AZ1, AZ2, AZ3.
    - EC2 Instances - hosting the application, not directly accessible from the internet.
    - Target Group - routes traffic from the ALB to the appropriate EC2 instances.
- **Data Layer and Connectivity:**
    - VPC Gateway Endpoint for DynamoDB - provides secure, private connectivity from private subnets to DynamoDB without traversing the public internet or NAT Gateway - cost-optimized.

# Diagram
![AWS 3-Tier Architecture](docs/ALB%20architecture%20.svg)