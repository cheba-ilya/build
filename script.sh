#!/bin/bash
sudo apt -y update
sudo apt -y install apache2
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
sudo echo "<h1>Web Server with ip: $myip</h1><br>Build by Terraform!<br>Use bash to have more" > /var/www/html/index.html
sudo service httpd start
sudo chkconfig httpd on
