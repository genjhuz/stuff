#!/bin/bash
# Verify Install Script For Centos 7
# Usage: ./verify.sh
# Copyright (c) 2019 GMP.
# GNU License

{
echo "Check Apache Status"
rpm -qa | grep httpd
systemctl status httpd

echo "Check MariaDB Status"
systemctl status mariadb

echo "Check Webmin Status"
rpm -qa | grep webmin
service webmin status

echo "Check iptraf"
rpm -qa | grep iptraf

echo "Check Midnight Commander"
rpm -qa | grep mc

echo "Check PHP"
rpm -qa | grep php
}
