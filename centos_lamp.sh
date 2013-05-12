yum -y update

#httpd
yum -y install httpd
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/_httpd.conf.backup
/etc/init.d/httpd start
/sbin/chkconfig --levels 235 httpd on

#mysql
yum -y install mysql-server
/sbin/chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start

#php
yum -y install php php-pear
yum -y install php-mysql
yum -y install php-gd

#python
yum -y install mod_wsgi