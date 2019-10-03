#!/usr/bin/env bash

# Ubuntu 18.04.3 LTS (Bionic Beaver), Apache HTTP Server version 2.4, PHP 7.2, MySQL 5.7, phpMyAdmin, Composer

start=`date +%s`

echo -e "\e[96m Updating & Upgrading  \e[39m"
sudo apt-get update
sudo apt-get -upgrade

echo -e "\e[96m Installing some tools  \e[39m"
sudo apt-get -y install curl zip git nano unzip

echo -e "\e[96m Installing Apache HTTP Server version 2.4  \e[39m"
sudo apt-get -y install apache2

echo -e "\e[96m Installing PHP 7.2  \e[39m"
sudo apt-get -y install php7.2

# Install some php extsensions
sudo apt-get -y install  php-mbstring php-cli php7.2-mysql php7.2-curl php7.2-json php7.2-mbstring php7.2-gd php7.2-intl php7.2-xml php7.2-zip php-gettext php7.2-pgsql
sudo apt-get -y install php7.2-mongodb php7.2-sqlite3 php7.2-bcmath libapache2-mod-php7.2

#sudo apt-get -y install php-xdebug
sudo phpenmod curl

# Enable some apache modules
sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod headers

echo -e "\e[96m Restart apache server to reflect changes  \e[39m"
sudo service apache2 restart

echo -e "\e[96m Installing mysql server \e[39m"
echo -e "\e[93m User: root, Password: root \e[39m"

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server-5.7 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt-get -y install mysql-server-5.7

### Run next command on production server
#sudo mysql_secure_installation

echo -e "\e[96m Begin silent install phpMyAdmin \e[39m"
echo -e "\e[93m User: root, Password: root \e[39m"
# Set non-interactive mode
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'﻿

sudo apt-get -y install phpmyadmin
sudo sed -i "s/|\s*\((count(\$analyzed_sql_results\['select_expr'\]\)/| (\1)/g" /usr/share/phpmyadmin/libraries/sql.lib.php

# Restart apache server
sudo service apache2 restart
echo -e "\e[92m phpMyAdmin installed successfully. \e[39m"

if [[ -f /vagrant/default.conf ]]; then
    cp /vagrant/default.conf /etc/apache2/sites-available/default.conf
fi

sudo a2ensite default.conf

# Restart apache server
sudo service apache2 restart

 Download and install composer
echo -e "\e[96m Installing composer \e[39m"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# Download and install WP-CLI
echo -e "\e[96m Installing WP-CLI \e[39m"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info

# Check php version
php -v

# Check apache version
apachectl -v

# Check mysql version
mysql --version

# Check if php is working or not
php -r 'echo "\nYour PHP installation is working fine.\n";'

# Check composer version
composer --version

echo -e "\e[92m Open http://192.168.33.10/ to check if apache is working or not. \e[39m"

# Clean up cache
sudo apt-get clean

end=`date +%s`
echo -e "\e[92m Execution time was \e[39m" `expr $end - $start` "\e[92m seconds. \e[39m"
