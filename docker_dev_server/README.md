
# Spinning up a Docker Development Server on AWS using Terraform

We will be using terraform to spinup a development server with docker preinstalled on it.

## Configuring network

We will start with creating a VPC with 10.1.0.0/16 cidr block and move on to make a public subnet.

We will also create a Internet Gateway and attach it to our VPC. To allow the subnet to connect to internet we will create a route table and attach the route table to our VPC and associate this route table with our subnet.

This route table will have a default route to access everything on public domain via internet gateway.

For us to access the new ec2 instance , we will create a security group with the ingress rule having the cidr block or rather the public ip of our system , while allowing it to egress on `0.0.0.0/0` for all protocols.

## Configure a ssh key pair

As we will be using a pre generated ssh key pair. We can use following command to generate a key.

    ssh-keygen -t ed25519


## Configure EC2 instance

At this point we should have all the pre-requisites to configure our EC2 instance.

We will be using a `t2.micro` instance to stay in the free tier limit of AWS.

And will configure the ec2 instance with the VPC , Subnet  and Security Group created previously.

We will also use `user_data` to specify the required commands to install pre-requisites of `docker` and eventually install docker.

We will use a provisioner `local-exec` to configure our `~/.ssh/config` to access the newly built ec2 instance with the pre-generated key. 

To configure `~/.ssh/config` we will be using a template  in our case we are using a linux system and hence `linux-ssh-config.tpl` template file will be used.

## Additional Information

### Datasources

We have setup two datasources. One for the ami and another one to fetch the public ip of our local system.

### Variables

We have also configured a variable `host_os= "linux"` and built conditions around it to pickup the correct template file to configure  `~/.ssh/config`.

### Output

We have configured two output. One to print ec2 public ip and another to print our local public ip.
