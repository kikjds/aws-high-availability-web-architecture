# AWS 3-Tier Architecture with Terraform

This project demonstrates a classic 3-tier cloud architecture in AWS, fully deployed using **Terraform**.

The goal is to build a secure, highly available (HA) environment with strict isolation between the public and private layers.

## Resource tagging

Configure common resource tags through the required `resource_tags` map in
`terraform.tfvars`. The AWS provider applies them to every resource that supports
tags. Resource-specific `Name` tags remain defined in their respective modules.

```hcl
resource_tags = {
  Project     = "aws-high-availability-web-architecture"
  Environment = "development"
  ManagedBy   = "Terraform"
}
```

## Architecture - Overview

The project provisions the following resources within a single VPC - `10.10.0.0/16`:

- **Public Layer:**
    - 3 public subnets - across different Availability Zones - AZ1, AZ2, AZ3.
    - Application Load Balancer - ALB - the entry point for internet traffic.
    - Internet Gateway - IGW - provides connectivity to the outside world.
    - NAT Gateway - deployed in a single public subnet to allow private subnets to access the internet (e.g. for package updates) while reducing NAT Gateway costs.
    - Bastion Host - a hardened EC2 instance in a public subnet, used exclusively for secure SSH access to private instances.
- **Private Layer:**
    - 3 private subnets - in AZ1, AZ2, AZ3.
    - EC2 instances managed by an Auto Scaling Group - hosting the application and not directly accessible from the internet.
    - Target Group - routes traffic from the ALB to the appropriate EC2 instances.
- **Data Layer and Connectivity:**
    - VPC Gateway Endpoint for DynamoDB - provides secure, private connectivity from private subnets to DynamoDB without traversing the public internet or NAT Gateway - cost-optimized.
- **Scaling and Notifications:**
    - Auto Scaling Group - manages instances in the private subnets across all Availability Zones.
    - Target tracking scaling policy - adjusts capacity to maintain approximately 60% average CPU utilization.
    - Capacity - minimum 3, desired 3, and maximum 6 instances.
    - ELB health checks - replace unhealthy instances and maintain application availability.
    - SNS topic - sends ASG notifications for instance launches, terminations, and launch or termination errors to a configured email address.

## Auto Scaling and SNS configuration

The private EC2 instances are created from a launch template and managed by an
Auto Scaling Group named `application-instances-asg`. The group uses the private
subnets, the ALB target group, ELB health checks, and a rack spread placement
group.

The SNS module creates the `asg-notifications` topic and an email subscription
for `asg_notification_email`. AWS sends a confirmation email after deployment;
the subscription must be confirmed before notifications are delivered.

ASG notifications cover:

- successful instance launches,
- successful instance terminations,
- instance launch failures,
- instance termination failures.

# Diagram
![AWS 3-Tier Architecture](docs/ALB%20architecture%20.svg)