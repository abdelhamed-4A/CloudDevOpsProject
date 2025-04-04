# 🌐 AWS VPC with CloudWatch Monitoring & Alerts using Terraform

A step-by-step guide to provisioning a Virtual Private Cloud (VPC) with EC2 instances, CloudWatch monitoring, and SNS alerts using **Terraform**.

---

## 📚 Table of Contents
1. [🧭 Architecture Overview](#-architecture-overview)
2. [✅ Prerequisites](#-prerequisites)
3. [⚙️ Steps to Implement](#️-steps-to-implement)
4. [🧯 Troubleshooting](#-troubleshooting)
5. [🏁 Conclusion](#-conclusion)

---

## 🧭 Architecture Overview
This project provisions a basic AWS environment with the following components:

- 🏗️ A **VPC** and **subnet**.
- 🔐 A **Security Group** to control access.
- 🖥️ An **EC2 instance** within the subnet.
- 📊 **CloudWatch Alarm** for CPU monitoring (triggering at 70% usage).
- 📧 **SNS Topic** for email notifications.

![architecture](https://github.com/user-attachments/assets/8cc0bd95-e630-4dc9-b6ca-d8fcffc6bf6e)

---

## ✅ Prerequisites
- AWS Account (with EC2, VPC, CloudWatch, and SNS permissions)
- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI configured with IAM credentials

---

## ⚙️ Steps to Implement

### 📝 Step 1: Write Terraform Configuration Files
Create a file `main.tf` with the following components:

- **VPC** with CIDR `10.0.0.0/16`
- **Subnet** with CIDR `10.0.0.0/24`
- **Security Group**: allows SSH (port 22) and HTTP (port 80)
- **EC2 instance**: provisioned into subnet with the security group
- **CloudWatch Alarm**: triggers at 70% CPU usage
- **SNS Topic**: email subscription for alerts

### 💾 Step 2: Configure Remote Backend (S3)
To store Terraform state securely and enable collaboration:
```bash
aws s3api create-bucket --bucket ams2025-s3-bucket-ivolve --region us-east-1
aws s3api put-bucket-versioning --bucket ams2025-s3-bucket-ivolve --versioning-configuration Status=Enabled
```

### 🔑 Step 3: Create EC2 Key Pair
```bash
aws ec2 create-key-pair --key-name ivolve --query 'KeyMaterial' --output text > ivolve.pem
chmod 400 ivolve.pem
```

### 📦 Step 4: Initialize Terraform
```bash
terraform init
```
This initializes your Terraform directory and downloads required providers.

### 🚀 Step 5: Apply Terraform Configuration
```bash
terraform plan     # Review the infrastructure changes
terraform apply    # Deploy resources (confirm with 'yes')
```

---

## 🔍 Step 6: Verify the Setup
### 🔹 AWS Resources Created
- ✅ VPC and Subnet
- ✅ EC2 Instances
- ✅ CloudWatch Alarms

![vpc](/assets/Terraform/vpc.jpg)
![ec2](/assets/Terraform/ec2.jpg)
![alarms](/assets/Terraform/alarms.jpg)

### 🔹 Test SSH Access
Retrieve EC2 public IPs:
```bash
terraform output
```
Connect to the instances:
```bash
ssh -i ivolve.pem ec2-user@<public_ip>
```
![ssh](/assets/Terraform/ssh.jpg)

---

## 🧯 Troubleshooting
- 🧪 **Terraform errors**: Run `terraform validate` to check config syntax.
- 🔐 **SSH access issues**: Ensure correct key permissions (`chmod 400`), and security group rules allow SSH.
- 📧 **SNS Email not received**: Confirm subscription in your email inbox.
- 📉 **CloudWatch not triggering**: Simulate CPU load using `stress` or similar.

---

## 🏁 Conclusion
🎉 You've successfully automated:
- 🔧 VPC, subnet, and EC2 provisioning
- 📈 CloudWatch monitoring with alarms
- 📬 SNS notifications

This Terraform-based solution is scalable, modular, and production-ready for AWS infrastructure automation. 🛠️☁️

