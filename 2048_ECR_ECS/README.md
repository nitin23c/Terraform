![image](https://github.com/nitin23c/Terraform/assets/11648754/e93dbef3-5c08-468f-81e5-872340d734ab)

# Deploying a 2048 Game on ECS using Terraform

## Create S3 Bucket for remote state

We will create s3 bucket to be used as backend to store state.

To do this , we will switch to backend directory and run `terraform init` `terraform plan` and `terraform apply`

```HCL
cd backend
terraform init
terraform plan
terraform apply
```
Thing to be noted that we are using `force_destroy = true` in `main.tf` which is not to be used in a production environment.

## Deploy Application

To deploy the application in our case `2048` game we will run `terraform init` `terraform plan` and `terraform apply`

This will in all create 16 resources.

```Apply complete! Resources: 16 added, 0 changed, 0 destroyed.```

## Modules

The application is split into two modules ecr and ecs 

### ECR Module

This is the module which creates the ECR repo , Builds docker image locally and then pushes it to ECR

### ECS Module

This module is responsible for the rest of resources like 
* Creates the cluster
* VPC , Subnet
* ECS Task definition
* IAM role
* Application Load Balancer
* Security groups
* Target group , Listener and Service

**Ingress rule allows 0.0.0.0/0 on all ports, Make sure to change this accordingly**