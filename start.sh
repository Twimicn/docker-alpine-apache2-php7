#!/bin/sh

# Configure php
sed -i "s/[;]\?\s\?memory_limit = .*/memory_limit = 2048M/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?max_execution_time = .*/max_execution_time = 3600/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?max_input_time = .*/max_input_time = 120/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?max_input_vars = .*/max_input_vars = 10000/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?memory_limit = .*/memory_limit = 2048M/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?error_reporting = .*/error_reporting = E_ALL/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?display_errors = .*/display_errors = On/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?display_startup_errors = .*/display_startup_errors = On/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?track_errors = .*/track_errors = On/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?post_max_size = .*/post_max_size = 512M/" /etc/php7/php.ini
sed -i "s/[;]\?\s\?upload_max_filesize = .*/upload_max_filesize = 512M/" /etc/php7/php.ini

# Enable apache modules
sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf
sed -i 's/#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf
sed -i 's/#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf

# Configure apache2
sed -i 's/^#ServerName.*/ServerName localhost/' /etc/apache2/httpd.conf
sed -i "s#^DocumentRoot \".*#DocumentRoot \"/app/$WEBAPP_ROOT\"#g" /etc/apache2/httpd.conf
sed -i "s#/var/www/localhost/htdocs#/app/$WEBAPP_ROOT#" /etc/apache2/httpd.conf
printf "\n<Directory \"/app/$WEBAPP_ROOT\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

chown -R apache:apache /app

httpd -D FOREGROUND
