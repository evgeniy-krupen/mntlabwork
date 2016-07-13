# Labwork "Troubleshooting" report
## Report table
|   |     Issue     |  How to find  | Time to find (min) | How to fix | Time to fix (min) |
|:-:|:-------------:|:-------------:|:------------:|:----------:|:-----------:|
| 1 | Site doesn't working (redirect on http://mntlab) | Command "curl -IL 192.168.56.10" on the host machine and virtual machine | 1 | Comment virtual host block in global config httpd (/etc/httpd/conf/httpd.conf) | 10 |
| 2 | Site doesn't working (error 503 on vitual machine and 200 Ok on the host machine) | Curl -IL 127.0.0.1 from virtual machine and curl -IL 192.168.56.10 from the host machine | 1 | In vitual host box in vhosts.conf change "mntlab" on "*" in /etc/httpd/conf.d/vhost.conf| 10 |
| 3 | Site doesn't work (error 503 on vitual machine and on the host machine) | Curl -IL 192.168.56.10 from virtual machine and curl -IL 192.168.56.10 from the host machine | 1 | Try to start tomcat service. Run commnad "service tomcat start" | 1 |
| 4 | Tomcat service doesn't start | Run command "service tomcat start" and then run command "ps -ef" with "grep tomcat" | 1 | Comment string "export CATALINA_HOME=/tmp" and "export JAVA_HOME=/tmp" in /home/tomcat/.bashrc, then change java version on x64 and change owner on tomcat for /opt/apache/tomcat/current/logs. Run commnad "service tomcat start"| 40 |
| 5 | Site doesn't working (error 503 on vitual machine and 200 Ok on the host machine) | Curl -IL 192.168.56.10 from virtual machine and curl -IL 192.168.56.10 from the host machine | 1 | Change workers name in last 3 strings from "worker-jk@ppname" to "tomcat.worker" and change ip address from 192.168.56.100 to  192.168.56.10 in /etc/httpd/conf.d/worker.properties file. Run command "service httpd restart" | 10 |
| 6 | Service iptables doesn't work | Run command "service iptables start" | 2 | Change attribute for iptables, in first INPUT add ESTABLISHED to a comma after the word RELATED, and add in input port 80. Run command "service iptables start" | 15 |
| 7 | Tomcat doesn't run after reboot virtual machine | Run command "chkconfig" | 1 | Run command "chkconfig --level 2345 tomcat on" | 3 |

## Answers on additional questions:
### What java version is installed?
      Run command "java -version" 
      java version "1.7.0_79" 
      Java(TM) SE Runtime Environment (build 1.7.0_79-b15) 
      Java HotSpot(TM) 64-Bit Server VM (build 24.79-b02, mixed mode) 

  
### How was it installed and configured?
      It has been installed installed by unzipping rpm
      Java has been configured with "alternatives"
### Where are log files of tomcat and httpd?
      Httpd: /var/log/httpd/  
      tomcat: /opt/apache/tomcat/7.0.62/logs/
### Where is JAVA_HOME and what is it?
      In general located in user ~/.bash_profile
      JAVA_HOME is a variables that helps to locate JDK and JRE to other applications.
### Where is tomcat installed?
      Tomcat installed in /opt/apache/tomcat/7.0.62/
### What is CATALINA_HOME?
      CATALINA_HOME is tomcat home directory
### What users run httpd and tomcat processes? How is it configured?
      User appache start httpd this user is configured in httpd.conf   
      User tomcat start tomcat this user is configured in init.d   
### What configuration files are used to make components work with each other?
      httpd.conf, vhost.conf, workers.properties, server.xml
### What does it mean: “load average: 1.18, 0.95, 0.83”?
      For one core processor that means 
      for 1 min load average= 1.18
      for 5 min load average= 0.95
      for 15 min load average= 0.83
