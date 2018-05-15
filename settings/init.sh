#!/usr/bin/env bash

# datetime
systemctl enable chronyd.service
timedatectl set-timezone Asia/Tokyo

# japanese
yum -y install ibus-kkc vlgothic-*
yum reinstall -y glibc-common
localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf
localectl set-keymap jp106

# package
yum -y install git unzip
yum -y install libpng12-1.2.50-10.el7.x86_64 libpng12-devel-1.2.50-10.el7.x86_64

# selinux
setenforce 0
sed -i "s/\(^SELINUX=\).*/\1disabled/" /etc/selinux/config

# apache
yum -y install httpd
rm -rf /var/www/html /var/www/cgi-bin
rm -rf /etc/httpd/conf.d/welcome.conf
sed -i 's/\(DocumentRoot "\/var\/www\/html"\)/# \1/' /etc/httpd/conf/httpd.conf
cp -f /var/www/settings/apache/httpd.conf /etc/httpd/conf.d/httpd.conf

# ssl
yum -y install mod_ssl
openssl genrsa 2024 > server.key
openssl req -new -key server.key -out server.csr -subj "/C=JP/ST=Tokyo/L=Tokyo/O=/OU=/CN=$1"
openssl x509 -req -days 3650 -signkey server.key < server.csr > server.crt
mkdir /etc/httpd/conf/ssl
mv server.key /etc/httpd/conf/ssl/server.key
mv server.csr /etc/httpd/conf/ssl/server.csr
mv server.crt /etc/httpd/conf/ssl/server.crt
cp -f /var/www/settings/apache/ssl.conf /etc/httpd/conf.d/ssl.conf
## start
systemctl start httpd
systemctl enable httpd

# Node.js npm
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
yum -y install nodejs
