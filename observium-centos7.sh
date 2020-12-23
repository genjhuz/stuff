echo Observium on Centos 7

echo Adding MariaDB Repository
wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
chmod +x mariadb_repo_setup
sudo ./mariadb_repo_setup

echo Adding EPEL and REMI Repository
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils
yum-config-manager --enable remi-php74

echo Update
yum -y update

echo Installing Package
yum -y install nano httpd php php-cli php-mysql php-gd php-snmp vixie-cron php-mcrypt php-pear net-snmp net-snmp-utils graphviz subversion mysql-server mysql rrdtool fping ImageMagick jwhois nmap ipmitool php-pear.noarch MySQL-python ggc

echo Making Directory
mkdir -p /opt/observium && cd /opt
wget http://www.observium.org/observium-community-latest.tar.gz
tar zxvf observium-community-latest.tar.gz

echo Enabling DB Service
systemctl start mariadb
systemctl enable mariadb

echo Create DB password
mysql_secure_installation

echo Create Database
mysql -u root -p
CREATE DATABASE dbobservium;
CREATE USER 'observuser'@'localhost' IDENTIFIED BY 'pring1000';
GRANT ALL PRIVILEGES ON dbobservium.* TO 'observuser'@'localhost';
exit

echo Config Observium
cd observium
cp config.php.default config.php
nano config.php
// Database config ---  This MUST be configured
// $config['db_extension'] = 'mysqli';
// $config['db_host']      = 'localhost';
// $config['db_user']      = 'observuser';
// $config['db_pass']      = 'pring1000';
// $config['db_name']      = 'dbobservium';

echo Restarting MariaDB Service
systemctl restart mariadb

echo Insert MySQL Schema
./discovery.php -u

which fping
nano config.php
// Tambahkan baris berikut
// $config['fping'] = "fping directory";

echo Starting httpd
systemctl start httpd
systemctl enable httpd

echo Creating Observium Config
nano /etc/httpd/conf.d/observium.conf
// Tambahkan Script berikut
// <VirtualHost *>
//   DocumentRoot /opt/observium/html/
//   ServerName  observium.domain.com
//   CustomLog /opt/observium/logs/access_log combined
//   ErrorLog /opt/observium/logs/error_log
//   <Directory "/opt/observium/html/">
//     AllowOverride All
//     Options FollowSymLinks MultiViews
//     Require all granted
//   </Directory>
// </VirtualHost>

echo Cretae logs and rrd directory
mkdir logs
chown apache:apache logs
mkdir rrd
chown apache:apache rrd

echo Restarting httpd Service
systemctl restart httpd

echo adding user for Observium
./adduser.php admin pring1000 10

echo Adding Cronjob
nano /etc/cron.d/observium
// Tambahkan Script Berikut
// # Run a complete discovery of all devices once every 6 hours
// 33  */6   * * *   root    /opt/observium/discovery.php -h all >> /dev/null 2>&1
//
// # Run automated discovery of newly added devices every 5 minutes
// */5 *     * * *   root    /opt/observium/discovery.php -h new >> /dev/null 2>&1
//
// # Run multithreaded poller wrapper every 5 minutes
// */5 *     * * *   root    /opt/observium/poller-wrapper.py >> /dev/null 2>&1
// 
// # Run housekeeping script daily for syslog, eventlog and alert log
// 13 5 * * * root /opt/observium/housekeeping.php -ysel

echo Reload Cron Service
systemctl reload crond

echo Setting SNMP
wget -O /usr/local/bin/distro https://gitlab.com/observium/distroscript/raw/master/distro
chmod +x /usr/local/bin/distro
mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.bak
cp snmpd.conf.example /etc/snmp/
mv /etc/snmp/snmpd.conf.example /etc/snmp/snmpd.conf
systemctl start snmpd
systemctl enable snmpd

echo Edit SNMP Conf
nano /etc/snmp/snmpd.conf
// rocommunity observium  default    -V all
// syslocation Jakarta
// syscontact sysadmin <admin@example.com>

echo Restart SNMP
systemctl restart snmpd
systemctl status snmpd

echo Testing SNMP
snmpwalk -v2c -c observium localhost

echo Finish
echo Access Web GUI via http://ip-address

echo bye...
