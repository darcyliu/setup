# pptp install srcript for CentOS 7
yum -y update

#rpm -Uvh http://download.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-1.noarch.rpm
#yum -y install policycoreutils policycoreutils
yum -y install ppp pptpd

# ip_forward
echo "1" > /proc/sys/net/ipv4/ip_forward
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
sysctl -p

echo "localip 192.168.9.1" >> /etc/pptpd.conf
echo "remoteip 192.168.9.2-254" >> /etc/pptpd.conf
echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd
echo "ms-dns 8.8.4.4" >> /etc/ppp/options.pptpd
echo "ms-dns 208.67.220.220" >> /etc/ppp/options.pptpd
echo "ms-dns 208.67.220.123" >> /etc/ppp/options.pptpd

# firewalld
firewall-cmd --permanent --new-service=pptp
cat >/etc/firewalld/services/pptp.xml<<EOF
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>pptp</short>
  <description>Point-to-Point Tunneling Protocol (PPTP)</description>
  <port protocol="tcp" port="1723"/>
</service>
EOF

firewall-cmd --permanent --zone=public --add-service=pptp
firewall-cmd --permanent --zone=public --add-masquerade
firewall-cmd --reload

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv6 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --reload


echo "test pptpd 123456 *" >> /etc/ppp/chap-secrets

# start pptpd
systemctl start pptpd
systemctl enable pptpd.service