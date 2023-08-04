#!/bin/bash
yum -y update
yum -y install httpd

echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html

cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Power of Terraform <font color="red"> v1.5.4</font></h2><br>
Owner ${first_name} ${last_name} <br>

%{ for i in names ~}
Intermidate 2 group members ${i}<br>
%{ endfor ~}

%{ for x in names ~}
Hello to ${x} from ${first_name}<br>
%{ endfor ~}

</html>
EOF

systemctl start httpd
systemctl enable httpd