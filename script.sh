#!/bin/bash
apt -y update
apt -y install httpd
echo "<h1>Web Server with ip: $myip</h1><br>Build by Terraform!<br>Use bash to have more" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
