# Automated MySQL Server Deployment with Terraform & Ansible

This project demonstrates how to **automate the provisioning and configuration of a MySQL database server** using **Terraform** (Infrastructure as Code) and **Ansible** (Configuration Management).  

The setup creates an **AWS EC2 instance** with Terraform and then uses Ansible to:  
- Install MySQL Server  
- Configure root password  
- Create a demo database (`test_db`)  
- Create a non-root user (`test_user`) with privileges  

## Prerequisites

- AWS account with IAM credentials configured (`~/.aws/credentials`)  
- Terraform installed   
- Ansible installed   
- SSH key pair in AWS (used to connect to EC2)  


## 🚀 Deployment Steps

### 1. Provision Infrastructure with Terraform
```console
cd terraform
terraform init
terraform apply -var 'key_name=your_aws_key'
```

- key_name must match an existing AWS key pair.
- After success, Terraform outputs the public IP of the EC2 instance.

### 2. Configure Inventory for Ansible

Edit ansible/inventory.ini and paste the Terraform output IP:
```ini
[mysql]
<MYSQL_PUBLIC_IP> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
```

### 3. Run Ansible Playbook
```console
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```
This will:

- Install MySQL server

- Set root password

- Create database (test_db)

- Create user test_user

### 4. Verify the Setup

From your local machine (requires MySQL client):
```console
mysql -h <MYSQL_PUBLIC_IP> -u test_user -p
# Enter password: TestPass123
mysql> SHOW DATABASES;
```