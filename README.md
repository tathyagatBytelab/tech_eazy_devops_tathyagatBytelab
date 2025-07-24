# TechEazy DevOps Internship Project

## Project Overview

This project was developed as part of the TechEazy Consulting DevOps Internship. It consists of two main assignments:

- **Assignment 1:** Setup an EC2 instance that runs a Spring Boot application and uploads application logs to S3.
- **Assignment 2:** Implement CI/CD using GitHub Actions to deploy the application automatically.

---

## Technologies Used

- **AWS EC2:** Hosts the Spring Boot application  
- **AWS S3:** Stores application logs  
- **AWS IAM:** Manages instance profile and permissions  
- **GitHub Actions:** CI/CD pipeline  
- **Bash:** Deployment and log upload scripts  
- **Spring Boot:** Java web application framework  

---

<<<<<<< HEAD
=======
```

>>>>>>> main
## 📁 Project Structure
tech_eazy_devops_tathyagatBytelab/
├── .github/
│ └── workflows/
│ └── deploy.yml # GitHub Actions CI/CD workflow
├── config/
│ ├── dev_config.json # Dev environment config
│ └── prod_config.json # Placeholder for prod
├── scripts/
│ ├── deploy_ec2.sh # Deploys EC2 and sets up app
│ └── upload_logs.sh # Uploads logs to S3
├── terraform/
│ ├── main.tf # Terraform infra (optional)
│ └── variables.tf # Terraform variables
├── trust-policy.json # Trust policy for IAM role
├── README.md # Project documentation
<<<<<<< HEAD

=======
>>>>>>> main

 ``` 
 
---

## 🚀 How to Deploy

### 1. Create and Configure EC2 Instance

```bash
./scripts/deploy_ec2.sh dev
This script:

Imports your SSH key to AWS

Launches an EC2 instance

Installs Java, clones the app repo, and runs the app

2. Access the App
Once the EC2 is live, access the app:

arduino
Copy
Edit
http://<public-ip>:8080/hello
3. Upload Logs to S3
From inside the EC2 instance:

bash
Copy
Edit
./scripts/upload_logs.sh dev
This uploads the app.log to your designated S3 bucket.

⚙️ CI/CD with GitHub Actions
Workflow file: .github/workflows/deploy.yml

Trigger: Push to main branch

Action: Connects to EC2 via SSH and redeploys the application automatically

GitHub Secrets to Configure:
EC2_HOST – Public IP of the EC2 instance

EC2_USER – Typically ubuntu

EC2_KEY – Your base64-encoded private SSH key

🐞 Issues Faced & Fixes
Issue	Fix
SSH timeout	Added inbound rule for port 22 in security group
Java app crashed on port 80	Switched to port 8080
git push failed	Renamed branch to main using git branch -M
EC2 couldn't access S3	Created and attached IAM role
app.log not uploading	Fixed log path and IAM permissions

🔄 Pull Request Workflow
Create a new branch:

bash
Copy
Edit
git checkout -b feature-xyz
Push your code:

bash
Copy
Edit
git push origin feature-xyz
Open a pull request on GitHub

Request a reviewer and get approval

Click "Merge Pull Request"

✅ Status
✅ Assignment 1 Completed (EC2 + Spring Boot + Logs + S3)

🔄 Assignment 2 In Progress (IAM + Lifecycle + Terraform + GitHub Actions)

   Maintainer
GitHub: @tathyagatBytelab
Internship: TechEazy Consulting (July 2025)


