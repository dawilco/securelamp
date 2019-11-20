#!/bin/bash

# Update Package Index
sudo apt update

# autmotically keep our machine up to date
sudo apt-get install unattended-upgrades

# install fail to ban
sudo apt-get install fail2ban

# configuratoin of fail to ban
sudo mv jail.local /etc/fail2ban

# apply confif and allow to start on boot
sudo systemctl restart fail2ban.service
sudo systemctl enable fail2ban.service

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

sudo mv apache2.conf /etc/apache2

# apply changes to apache
sudo systemctl start apache2

# copy new php file
# disables remote code execution
# limit php to only access /var/www files
sudo mv php.ini /etc/php/7.0/apache2

# Mod_security is a web application firewall (WAF) which can be installed as an additional module for Apache. It can be used to protect the web server from numerous attacks like SQL injections, session hijacking, cross site scripting, bad user agents and many others
# sudo apt-get install libapache2-modsecurity
# sudo a2enmod security2
# sudo mv modsecurity.conf /etc/modsecurity/modsecurity.conf

# write protect all the config files so an attacker canoot change them
# sudo chattr +i /etc/php/7.0/apache2/php.ini
# sudo chattr +i /etc/apache2/apache2.conf
# sudo chattr +i /etc/fail2ban/jail.local
# sudo chattr +i /etc/modsecurity/modsecurity.conf
