# Terraform Projects

#### 1.  EC2 Instance with Docker and Network Resources:

The first Terraform project provisions an EC2 instance with Docker preinstalled and configures all the necessary network resources for accessibility. By following the instructions in the project, you will be able to automate the deployment process and avoid manual configuration. This project includes the following features:

* Creation of a Virtual Private Cloud (VPC) and subnets
* Configuration of security groups to control inbound and outbound traffic
* Provisioning of an EC2 instance with Docker preinstalled
* Definition of any additional network resources required, such as an internet gateway, route tables, and network interfaces

Link to the project: [Terraform EC2 Instance with Docker and Network Resources](https://github.com/nitin23c/Terraform/tree/main/docker_dev_server)

#### 2. Containerized 2048 Game Deployment on ECS:

The second Terraform project focuses on containerizing the popular game 2048, pushing it to AWS ECR, and deploying it on ECS. This project streamlines the process of packaging the game as a Docker container, managing the container image in ECR, and orchestrating the deployment on ECS. It covers the following steps:

* Containerization of the 2048 game using a Dockerfile
* Creation of an ECS cluster and task definition for running the game container
* Configuration of load balancers and target groups for distributing incoming traffic
* Provisioning of the required network resources, such as subnets and security groups.

Link to the project: [Terraform Containerized 2048 Game Deployment on ECS](https://github.com/nitin23c/Terraform/tree/main/2048_ECR_ECS)