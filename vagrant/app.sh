#!/bin/bash
sudo yum install -y java
sudo mkdir /home/vagrant/tomcat
cd /home/vagrant/tomcat
sudo wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.3/bin/apache-tomcat-8.5.3.tar.gz
sudo tar xzvf apache-tomcat-8.5.3.tar.gz
cd /home/vagrant/tomcat/apache-tomcat-8.5.3/bin
sudo ./startup.sh
