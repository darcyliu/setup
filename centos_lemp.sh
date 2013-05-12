#nginx
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum -y update
yum -y install nginx sudo

/etc/init.d/nginx start
chkconfig --add nginx
chkconfig nginx on

#php
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum -y update
yum -y install php-cli php spawn-fcgi wget

#mysql
yum -y install mysql-server php-mysql
/etc/rc.d/init.d/mysqld start
chkconfig mysqld on
#mysql_secure_installation