#!/bin/bash
sudo yum -y install httpd
sudo yum install httpd-devel.x86_64 -y
mkdir mod_jk
cd mod_jk/
wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.41-src.tar.gz
tar xzvf tomcat-connectors-1.2.41-src.tar.gz
cd tomcat-connectors-1.2.41-src/native/
sudo ./configure --with-apxs=/usr/sbin/apxs
make
sudo make install
sudo cp -f /vagrant/sources/httpd.conf /etc/httpd/conf
sudo cp -f /vagrant/sources/worker.properties /etc/httpd/conf
sudo service httpd start
