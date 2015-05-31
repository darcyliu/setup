#!/bin/sh
# NGINX install srcript for CentOS 7

#nginx
yum -y update
yum -y install nginx

sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

systemctl start nginx.service
