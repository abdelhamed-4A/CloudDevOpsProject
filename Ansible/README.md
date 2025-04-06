# 🚀 Ansible Configuration Management for AWS EC2

This directory contains an Ansible automation setup for configuring two EC2 instances provisioned via Terraform in AWS. The configuration installs essential packages, deploys Jenkins on a **master** node, and SonarQube on a **slave** node using modular roles and a dynamic inventory.

---

## 📋 Overview

Ansible is used to automate the configuration of two EC2 instances:

- 🧑‍💻 **Master** — Jenkins is installed and configured.
- 🧪 **Slave** — SonarQube is deployed.
- 🔧 **Common** — Both nodes are provisioned with Git, Docker, and Java.

Dynamic AWS EC2 inventory is used to identify and group instances by their `Name` tag values: `jenkins_master` and `jenkins_slave`.

---

## 📁 Directory Structure

```
Ansible/
├── ansible.cfg              # Ansible configuration file
├── inventory_aws_ec2.yaml   # AWS EC2 dynamic inventory plugin config
├── roles                    # Role-based modular configuration
│   ├── common               # Base packages
│   │   └── tasks/main.yaml
│   ├── jenkins              # Jenkins setup
│   │   ├── defaults/main.yaml
│   │   └── tasks/main.yaml
│   └── SonarQube            # SonarQube setup
│       ├── tasks/main.yaml
│       └── vars/main.yaml
└── site.yaml                # Master playbook
```

---

## ✅ Prerequisites

Ensure you have the following:

- ✅ Ansible (v2.9+)  
- ✅ AWS CLI configured (`aws configure`)  
- ✅ Terraform-provisioned EC2 instances tagged as `jenkins_master` and `jenkins_slave`  
- ✅ SSH key (`ivolve-key.pem`) saved at `/home/ubuntu/environment/Ansible/ivolve.pem`  
- ✅ Python `boto3` package installed

### 🛠️ Install Required Packages
```bash
pip install boto3
ansible-galaxy collection install amazon.aws community.aws
```

---

## ⚙️ Configuration Files

### `ansible.cfg`
```ini
[defaults]
inventory = /home/ubuntu/environment/Ansible/inventory_aws_ec2.yaml
private_key_file = /home/ubuntu/environment/Ansible/ivolve.pem
host_key_checking = False
remote_user = ec2-user
enable_plugins = amazon.aws.aws_ec2

[privilege_escalation]
become = True
become_method = sudo
become_user = root
```

### `inventory_aws_ec2.yaml`
```yaml
plugin: amazon.aws.aws_ec2
strict: False
regions:
  - us-east-1
hostnames:
  - ip-address
filters:
  instance-state-name: running
  tag:Name:
    - jenkins_master
    - jenkins_slave
keyed_groups:
  - key: tags.Name
    prefix: tag
    separator: ""
```

### `site.yaml`
```yaml
---
- name: Configure all instances with common packages
  hosts: all
  roles:
    - common

- name: Configure master with Jenkins
  hosts: 44.200.236.246
  roles:
    - jenkins
    
- name: Configure slave with SonarQube
  hosts: 44.192.55.229
  become: yes
  roles:
    - SonarQube
```

---

## 🚦 Setup Instructions

### 1️⃣ Verify AWS Credentials
```bash
aws configure
```

### 2️⃣ Test Inventory Resolution
```bash
ansible-inventory -i /home/ubuntu/environment/Ansible/inventory_aws_ec2.yaml --graph
```
Expected groups:
- `tagjenkins_master`
- `tagjenkins_slave`

📸
![Inventory Output](/assets/Ansible/graph.jpg)

### 3️⃣ Run the Playbook
```bash
ansible-playbook -i /home/ubuntu/environment/Ansible/inventory_aws_ec2.yaml site.yaml --private-key /home/ubuntu/environment/Ansible/ivolve.pem
```

📸
![Playbook Execution](/assets/Ansible/playbook.jpg)

---

## 🔍 Verification Steps

### 🧪 On Both Instances
```bash
git --version
java -version
sudo systemctl status docker
```
📸
![Verification](/assets/Ansible/git_java.jpg)

### 🧑‍💻 On Master (Jenkins)
```bash
sudo systemctl status jenkins
```
📸
![Jenkins Status 1](/assets/Ansible/jenkins.jpg)
![Jenkins Status 2](/assets/Ansible/jenkinsport.jpg)
![Jenkins Status 3](/assets/Ansible/jenkinslogin.jpg)

### ⚙️ On Slave (SonarQube)
```bash
docker ps -a
```
📸
![SonarQube Container](/assets/Ansible/dockerps.jpg)
![SonarQube UI](/assets/Ansible/sonarqube.jpg)

---

## 📦 Deliverables

- ✅ Ansible playbooks and roles organized in a version-controlled repo  
- 📸 Screenshots verifying installation (optional)  
- 📖 Documented steps (this file!)  

---

## 🧯 Troubleshooting

| Issue | Solution |
|-------|----------|
| 🔒 Inventory returns empty | Confirm AWS credentials, region, and tag filters |
| 🔑 SSH connection fails | Ensure `ivolve.pem` path is valid and SG allows port 22 |
| ❌ Role/task errors | Check syntax and ensure package repos are accessible |

---

Happy Automation! 🤖💻

