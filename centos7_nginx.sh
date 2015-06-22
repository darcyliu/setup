#!/bin/sh
# NGINX install srcript for CentOS 7

yum -y update

# install EPEL
yum -y install epel-release

# install nginx
yum -y install nginx

# enable firewall
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

# start nginx service
systemctl start nginx.service
systemctl enable nginx.service