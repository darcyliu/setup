#pptp
yum -y update

rpm -Uvh http://poptop.sourceforge.net/yum/stable/rhel6/pptp-release-current.noarch.rpm
yum -y install policycoreutils policycoreutils
yum -y install pptpd ppp iptables

#ip_forward
echo "1" > /proc/sys/net/ipv4/ip_forward
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
sysctl -p

echo "localip 192.168.9.1" >> /etc/pptpd.conf
echo "remoteip 192.168.9.2-254" >> /etc/pptpd.conf
echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd
echo "ms-dns 8.8.4.4" >> /etc/ppp/options.pptpd

service iptables start
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -I FORWARD -p tcp --syn -i ppp+ -j TCPMSS --set-mss 1356
service iptables save
service iptables restart

service pptpd stop
echo "test pptpd 123456 *" >> /etc/ppp/chap-secrets
service pptpd start
chkconfig pptpd on
