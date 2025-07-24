TechEazy DevOps Internship Project

🔧 Project Overview

This project was developed as part of the TechEazy Consulting DevOps Internship. It consists of two main assignments:

Assignment 1: Setup an EC2 instance that runs a Spring Boot application and uploads application logs to S3.

Assignment 2: Implement CI/CD using GitHub Actions to deploy the application automatically.

🌐 Technologies Used

AWS EC2: Hosts the Spring Boot application

AWS S3: Stores application logs

AWS IAM: Manages instance profile and permissions

GitHub Actions: CI/CD pipeline

Bash: Deployment and log upload scripts

Spring Boot: Java web application framework


📁Project Structure
 tech_eazy_devops_tathyagatBytelab/
 ├── .github/
 │   └── workflows/
 │       └── deploy.yml              # GitHub Actions CI/CD workflow
 ├── config/
 │   ├── dev_config.json            # Dev environment config
 │   └── prod_config.json           # Placeholder for prod
 ├── scripts/
 │   ├── deploy_ec2.sh              # Deploys EC2 and sets up app
 │   └── upload_logs.sh             # Uploads logs to S3
 ├── terraform/
 │   ├── main.tf                    # Terraform infra (optional)
 │   └── variables.tf
 ├── trust-policy.json              # Trust policy for IAM role
 ├── README.md                      # Project documentation


🚀 How to Deploy

1. Create and configure EC2 instance

 ./scripts/deploy_ec2.sh dev

This script:

Imports your SSH key to AWS

Launches an EC2 instance

Installs Java, clones the app repo, and runs the app

2. Access the app

Once the EC2 is live, access the app:

 http://<public-ip>:8080/hello

 3. Upload logs to S3

Run this from inside the EC2 instance:

 ./scripts/upload_logs.sh dev

 This uploads app.log to your S3 bucket.

🔁 CI/CD with GitHub Actions 
 Workflow: .github/workflows/deploy.yml

Trigger: Push to main

It connects to EC2 via SSH and redeploys the application automatically.

Ensure you set the following GitHub secrets:

EC2_HOST

EC2_USER

EC2_KEY (base64 encoded private key)

⚠️ Issues Faced & Fixes

Issue

Fix

SSH timeout

Added inbound rule for port 22 in security group

Java app crashed on port 80

Ran app on port 8080 instead

Git push error main not found

Renamed branch: git branch -M main

EC2 didn’t have S3 access

Attached IAM role to EC2

app.log upload failed

Fixed IAM permissions and log path

🔄 Pull Request Workflow

Create new branch: git checkout -b feature-xyz

Push code: git push origin feature-xyz

Open PR on GitHub

Add reviewer, get approval

Click Merge Pull Request