#!/bin/bash
# Verify Install Script For Centos 7
# Usage: ./verify.sh
# Copyright (c) 2019 GMP.
# GNU License

{
echo "Check Apache Status"
systemctl status httpd

echo "Check MariaDB Status"
systemctl status mariadb

echo "Check iptraf"
rpm -qa | grep iptraf

echo "Check Midnight Commander"
rpm -qa | grep mc
}
