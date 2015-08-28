#!/bin/sh
# Apache install script for CentOS 7

yum -y update

# install Apache
yum -y install httpd

# enable firewall
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

# enable httpd service
systemctl start httpd.service
systemctl enable httpd.service
