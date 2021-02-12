# Advance_AWSVPC_with_Terraform
Build an AWS VPC as code with Terraform

###### Cloud - :cloud:
![AWS](https://img.shields.io/badge/-AWS-000000?style=flat&logo=Amazon%20AWS&logoColor=FF9900)

###### IaaC
![Terraform](https://img.shields.io/badge/-Terraform-000000?style=flat&logo=Terraform)

![alt text](https://github.com/ValAug/AWS_Security/blob/master/security.jpg)

# Purpose
Shows how to use AWS with Terraform to accomplish the following tasks:

* Create one or multiple full VPC's with a few configurations
* Create one or multiple ec2's of any type for a webservice hosting

# Prerequisites
* You must have an AWS account, and have your default credentials and AWS Region
  configured
* You must have Terraform installed

# Cautions
* As an AWS best practice, grant this code least privilege, or only the 
  permissions required to perform a task. For more information, see 
  [Grant Least Privilege](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege) 
  in the *AWS Identity and Access Management 
  User Guide*.
* This code has been tested in us-east-1 AWS Regions only. However it should work in any other region. 
* Running this code might result in charges to your AWS account.
* This project will be adding more services

# Running the code
* terraform init
* terraform plan
* terraform apply
* Alternate command : terraform apply -auto-approve
* terraform destroy
* Alternate command : terraform destroy -auto-approve
* terraform fmt # A way to format the terraform code
