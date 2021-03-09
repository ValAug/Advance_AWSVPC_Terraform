<!-- retro visitor counter -->
<p align="center"> 
  <img src="https://profile-counter.glitch.me/ValAug/count.svg" />
</p>

# Advance_AWSVPC_with_Terraform
Build an AWS VPC as code with Terraform

###### Cloud - :cloud:
![AWS](https://img.shields.io/badge/-AWS-000000?style=flat&logo=Amazon%20AWS&logoColor=FF9900)

###### IaaC
![Terraform](https://img.shields.io/badge/-Terraform-000000?style=flat&logo=Terraform)

# AWS VPC architecture diagram with Public and Private Subnets
![alt text](https://github.com/ValAug/Advance_AWSVPC_Terraform/blob/master/vpc_diagram_v1.png)

# Purpose
Shows how to use AWS with Terraform to accomplish the following tasks:

* Create one or multiple full VPC with a few configurations
* Create one or multiple ec2 of any type for a web-service hosting
* Create Key pairs per ec2
* Create one or multiple Security group
* Create one or multiple Route table and Route table association
* Create multiple public and private subnets
* Create one or multiple Internet gateway

# Prerequisites
* You must have an AWS account, and have your default credentials and AWS Region
  configured
* You must have Terraform installed

# Cautions
* As an AWS best practice, grant this project least privilege, or only the 
  permissions required to perform a task. For more information, see 
  [Grant Least Privilege](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege) 
  in the *AWS Identity and Access Management 
  User Guide*
* This code has been tested in us-east-1 AWS Regions only. However it should work in any other region
* Running this code might result in charges to your AWS account
* This project will be adding more services

# How to run this code
* Clone this repo
* cd to Advance_AWSVPC_Terraform folder
* terraform init
* terraform plan
* terraform validate
* terraform apply
* Alternate command : terraform apply -auto-approve
* terraform destroy
* Alternate command : terraform destroy -auto-approve
* terraform fmt # A way to format the terraform code
