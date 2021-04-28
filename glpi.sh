#!/bin/bash
set -x

#VARIABLES
DB_GLPI=glpi_db
USER_GLPI=glpi_user
PASSWD_GLPI=glpi_password


#Actualizamos 
apt update -y

#Instalamos Apache
apt install apache2 -y

#Instalamos MySQL
apt install mysql-server -y

# Actualizamos la contraseña de root de MySQL
mysql -u root <<< "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'root';"

#Instalamos módulos de PHP
apt install php libapache2-mod-php php-mysql php-mbstring -y 

# LAMP FINALIZADA

# Creamos la base de datos
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_GLPI;"
mysql -u root <<< "CREATE DATABASE $USER_GLPI;"
mysql -u root <<< "CREATE USER user_glpi@localhost IDENTIFIED BY '$PASSWD_GLPI';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_GLPI.* TO USER_GLPI@localhost;"
mysql -u root <<< "FLUSH PRIVILEGES;"

# Clonamos repositorio para el archivo 000-default.conf
#git clone
#mv 

#--------------------------------------------------

# INSTALACIÓN DE GLPI

#Descargamos GLPI
wget https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz

#Descomprimimos
tar -xvzf glpi-9.5.5.tgz

#Movemos el archivo a la carpeta de Apache
mv glpi /var/www/html/

#Damos permisos para que a la hora de instalar errores de folders
sudo chown www-data:www-data /var/www/html/glpi/* -R

#Instalamos extensiones
apt-get install php7.4-curl php7.4-gb2 php7.4-imap php7.4-ldap php7.4-mbstring php7.4-xmlrpc php7.4-xsl php7.4-openssl php7.4-sodium -y
apt-get install php7.4-mysqli php7.4-json php7.4-simplexml php7.4-session php7.4-intl php7.4-zlib -y
#Descomentamos extensiones
sed -i "s/;extension=curl/extension=curl/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=gd2/extension=gd2/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=imap/extension=imap/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=ldap/extension=ldap/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=mbstring/extension=mbstring/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=xmlrpc/extension=xmlrpc/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=xsl/extension=xsl/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=openssl/extension=openssl/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=sodium/extension=sodium/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=mysqli/extension=mysqli/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=json/extension=json/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=simplexml/extension=simplexml/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=session/extension=session/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=intl/extension=intl/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=zlib/extension=zlib/" /etc/php/7.4/apache2/php.ini

# Reiniciamos Apache
systemctl restart apache2
