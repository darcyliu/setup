#!/bin/sh
# Google Authenticator 2 factor authentication install srcript for CentOS 7

yum -y update

yum -y groupinstall "Development Tools"

# authentication policies
yum -y install pam-devel

# ntp
yum -y install ntp
#chkconfig ntpd on
#service ntpd start
systemctl start ntpd.service
systemctl enable ntpd.service

# git 
yum -y install git

# google authenticator
#yum -y install google-authenticator
git clone https://github.com/google/google-authenticator
cd google-authenticator/libpam
./bootstrap.sh
./configure
make
make install
cp /usr/local/lib/security/pam_google_authenticator.* /usr/lib64/security/
cd ../../
rm -rf google-authenticator

google-authenticator -tdf --rate-limit=3 --rate-time=30 --window-size=17

# active 2 factor authentication
sed -i '/#%PAM/a auth\ \ \ \ \ \ \ required\ \ \ \ \ pam_google_authenticator.so' /etc/pam.d/sshd
sed -i 's/#ChallengeResponseAuthentication\ yes/ChallengeResponseAuthentication\ yes/g' /etc/ssh/sshd_config
sed -i 's/ChallengeResponseAuthentication\ no/#ChallengeResponseAuthentication\ no/g' /etc/ssh/sshd_config
systemctl reload sshd

