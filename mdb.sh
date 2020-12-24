#!/bin/bash
# Observium on Centos 7
# Usage: ./observium-centos7.sh
# Copyright (c) 2020 GMP
# GNU License

{
echo Observium on Centos 7
echo .
echo .
echo Adding MariaDB Repository
wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
chmod +x mariadb_repo_setup
./mariadb_repo_setup
echo .
echo Adding EPEL and REMI Repository
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils
yum-config-manager --enable remi-php74
echo .
echo Updating System
yum -y update
echo .
echo Installing Package
yum -y install nano libvirt httpd php php-cli php-mysql php-gd php-snmp vixie-cron php-mcrypt php-pear net-snmp net-snmp-utils graphviz subversion mysql-server mysql rrdtool fping ImageMagick jwhois nmap ipmitool php-pear.noarch MySQL-python
echo .
echo Enabling DB Service
systemctl start mariadb
systemctl enable mariadb
echo .
echo .
echo Create DB password
/usr/bin/mysqladmin -u root password 'pring1000'
echo .
echo .
echo Create Database
mysql -u root -p
CREATE DATABASE dbobservium;
CREATE USER 'observuser'@'localhost' IDENTIFIED BY 'pring1000';
GRANT ALL PRIVILEGES ON dbobservium.* TO 'observuser'@'localhost';
exit
}

{
fping google.com detik.com
}
