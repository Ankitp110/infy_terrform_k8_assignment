#!/bin/bash
# Update system
yum update -y

# Install Docker
amazon-linux-extras enable docker
yum install -y docker
systemctl start docker
systemctl enable docker

# Install Nginx
amazon-linux-extras enable nginx1
yum install -y nginx
systemctl start nginx
systemctl enable nginx

# Verification (writes to cloud-init-output.log)
docker --version >> /var/log/cloud-init-output.log 2>&1
systemctl status docker >> /var/log/cloud-init-output.log 2>&1
nginx -v >> /var/log/cloud-init-output.log 2>&1
systemctl status nginx >> /var/log/cloud-init-output.log 2>&1
