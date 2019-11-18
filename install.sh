#!/bin/bash

# Update Package Index
sudo apt update

# Install Apache2, MySQL, PHP
sudo apt install apache2 mysql-server php php-mysql libapache2-mod-php php-cli

# Secure the MySQL installation
mysql_secure_installation

# Removing Extra PHP ini modules
rm /etc/php.d/sqlite3.ini

# Allow to run Apache on boot up
sudo systemctl enable apache2

# Restart Apache Web Server
sudo systemctl start apache2

# Adjust Firewall
sudo ufw allow in "Apache Full"

# Allow Read/Write for Owner
sudo chmod -R 0755 /var/www/html/

# Copy new Apache file
# Hides version an os id
# Disables directory listing

mv apache2.conf /etc/apache2

# apply changes to apache
sudo systemctl start apache2

# copy new php file
# disables remote code execution
# limit php to only access /var/www files
mv php.ini /etc/php/7.0/apache2

# write protect all the config files so an attacker canoot change them
chattr +i /etc/php.ini
chattr +i /etc/php.d/*
chattr +i /etc/my.cnf
chattr +i /etc/httpd/conf/httpd.conf
