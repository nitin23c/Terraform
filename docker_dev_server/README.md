# Deploying EC2 Instance with Docker and Network Resources

This Terraform project aims to automate the deployment of an EC2 instance with Docker preinstalled for development purposes, along with the necessary network resources. By leveraging Terraform's infrastructure-as-code capabilities, we can easily define and manage our infrastructure in a declarative manner.

### Prerequisites:

* Install Terraform: Make sure you have Terraform installed on your local machine. You can download it from the official Terraform website (https://www.terraform.io/downloads.html) and follow the installation instructions for your operating system.

### Project Structure:

The project consists of the following files:

* `state/main.tf` : This file creates S3 bucket to be utilized as remote state for our project.

* `state/locals.tf` : This file defines our bucket name which will be created.

* `main.tf`: This file contains the Terraform configuration code for defining and provisioning the EC2 instance, including the necessary networking resources.

* `variables.tf`: In this file we have defined host os to pickup required template file to setup passwordless ssh to the ec2 instance

* `provider.tf`: The provider file specifies the required provider (in this case, AWS) and the authentication details.

* `outputs.tf`: This file defines the outputs that will be displayed after the infrastructure is provisioned.

* `datasources.tf` : This file has the datasource for the ami which will be used to provision the ec2 instance.

* `linux-ssh-config.tpl` or `windows-ssh-config.tpl` : This file has has the template which is used to configure passwordless ssh on host system.

* `userdata.tpl` : This file has the bash script which runs on ec2 instance to install Docker.

### Steps to Deploy the Infrastructure:

1. Configure AWS Credentials: Ensure you have valid AWS access and secret keys with the necessary permissions to create EC2 instances, VPCs, and subnets. You can set these credentials using environment variables or by using the AWS CLI (aws configure).

2. Open the `variables.tf` file and update the default value of host_os according to your own system. 

3. Open the `state/locals.tf` and modify the bucket name which needs to be created. Use the same bucket name in `backend.tf`.

4. Initialize Terraform: Open a terminal, navigate to the project directory, and run the following command to initialize Terraform and download the required providers:

```HCL
terraform init
```

5. Preview Changes: Run the following command to see a preview of the infrastructure changes that will be applied:

```HCL
terraform plan
```
This will display the resources that Terraform plans to create or modify based on the configuration.

6. Apply Changes: If the preview looks correct, apply the changes by running the following command:

```HCL
terraform apply
```
Terraform will prompt for confirmation before proceeding. Enter "yes" to proceed with the deployment.

7. Monitor Provisioning Progress: Terraform will now provision the defined resources on AWS. You can monitor the progress in the terminal as Terraform outputs the status of each step.

8. Access the EC2 Instance: Once the provisioning is complete, Terraform will display the outputs defined in the `outputs.tf` file. Look for `demo_ec2_ip` which is EC2 instance's public IP address.

9. Connect to the EC2 Instance.

### Cleanup:

To clean up the resources created by Terraform, run the following command:

```HCL
terraform destroy
```

Terraform will prompt for confirmation before deleting the resources. Enter "yes" to proceed with the cleanup.

By following this Terraform project, you can easily provision an EC2 instance with Docker preinstalled and set up the required network resources for development purposes. This automation eliminates manual configuration and ensures consistent, reproducible infrastructure deployments.