#!/bin/bash
# Install script for Centos 7
# Please install wget before using this script
# Usage: ./centoz.sh
# Copyright (c) 2019 GMP.
# GNU License

{

# update
yum -y update
yum -y install epel-release

# install apache
yum -y install httpd
systemctl start httpd
systemctl enable httpd
systemctl status httpd

# install mysql
yum -y install mariadb-server
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb

# install nano
yum -y install nano

# install iptraf
yum -y install iptraf

# install midnight commander
yum -y install mc

#install webmin
wget http://prdownloads.sourceforge.net/webadmin/webmin-1.930-1.noarch.rpm
yum -y install perl perl-Net-SSLeay openssl perl-IO-Tty perl-Encode-Detect perl-Data-Dumper unzip
rpm -U webmin-1.930-1.noarch.rpm
yum -y install webmin
chkconfig webmin on
service webmin start
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart

# install phpmyadmin
yum -y install phpmyadmin
yum -y install php

}
