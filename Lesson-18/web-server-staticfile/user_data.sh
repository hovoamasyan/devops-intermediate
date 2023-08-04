#!/bin/bash
yum -y update
yum -y install httpd
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd