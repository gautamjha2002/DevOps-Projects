# Project Title: IAC with Terraform

Terraform project for creating EC2 instance, ALB, S3 bucket, CloudFront and generate output

## Description  
This Terraform project creates an EC2 instance, installs Nginx-core using user data, then creates an Application load balancer (ALB), Security groups, target group, and an S3 bucket. 

The S3 bucket is then used to upload a PNG image object, A CloudFront distribution is also created to allow faster access to the image object, and DNS names of the CloudFront distribution and ALB are outputted at the end.

## Requirements
- Terraform 
- An AWS Account
- AWS access key and secret key is set as Environment variable of your PC

## Usage
1. Clone the repository and navigate to the project directory
2. Run `terraform init` to initialize the object
3. Run `terraform plan` to preview the changes that will be made
4. Run `terraform apply` to create the resources
5. The DNS names of the CloudFront distribution and the ALB will be outputted at the end

## Note
In aws_instance resource user_data section you will fine the nginx installation code You can replace it with any web server you want. 

