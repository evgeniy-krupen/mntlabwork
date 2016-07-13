#!/bin/bash
#Commit virtual host block in global config httpd
sed -i '/<VirtualHost/,/<\/VirtualHost>/s/^/# /' /etc/httpd/conf/httpd.conf
#In vitual host box in vhosts.conf change "mntlab" on "*" in /etc/httpd/conf.d/vhost.conf
sed -i '/<VirtualHost/s/mntlab/*/g' /etc/httpd/conf.d/vhost.conf
#Comment two stings with export in /home/tomcat/.bashrc (comment last 2 strings)
sed -i '/export/s/^/# /' /home/tomcat/.bashrc
#Change java version on x64
alternatives --config java <<< 1
#Change owner on tomcat for /opt/apache/tomcat/current/logs
chown tomcat.tomcat /opt/apache/tomcat/current/logs
#Change workers from "worker-jk@ppname" to "tomcat.worker" in /etc/httpd/conf.d/worker.properties file
sed -i '/worker/s/worker-jk@ppname/tomcat.worker/g' /etc/httpd/conf.d/workers.properties
#Change ip address from 192.168.56.100 to 192.168.56.10 in /etc/httpd/conf.d/worker.properties file
sed -i '/worker/s/192.168.56.100/192.168.56.10/g' /etc/httpd/conf.d/workers.properties
#Change attribute for iptables
chattr -i /etc/sysconfig/iptables
#Change iptables
cat > /etc/sysconfig/iptables <<EOF
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [71:8305]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOF
#Change attribute for iptables
chattr +i /etc/sysconfig/iptables
#Start service iptable
service iptables start
#Add tomcat to startup
chkconfig --level 2345 tomcat on
service tomcat start
service httpd restart


