docker network create wordpress


docker run -d \
--name mysql-server \
--network wordpress \
-e MYSQL_ROOT_PASSWORD=rootpassword \
-e MYSQL_DATABASE=mysql-database \
-v ./mysql_data:/var/lib/mysql \
-p 3306:3306 \
mysql:latest


docker run -d \
--name wordpress \
--network wordpress \
-e WORDPRESS_DB_HOST=mysql-server \
-e WORDPRESS_DB_NAME=mysql-database \
-e WORDPRESS_DB_USER=root \
-e WORDPRESS_DB_PASSWORD=rootpassword \
-v ./wordpress:/var/www/html \
-p 8088:80 \
wordpress:latest