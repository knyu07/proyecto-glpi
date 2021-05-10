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
mysql -u root <<< "FLUSH PRIVILEGES;"

#Instalamos módulos de PHP
apt install php libapache2-mod-php php-mysql php-mbstring -y 

# LAMP FINALIZADA

# Creamos la base de datos
mysql -u root  <<< "DROP DATABASE IF EXISTS $DB_GLPI;"
mysql -u root  <<< "CREATE DATABASE $USER_GLPI;"
mysql -u root  <<< "CREATE USER $USER_GLPI@localhost IDENTIFIED BY '$PASSWD_GLPI';"
mysql -u root  <<< "GRANT ALL PRIVILEGES ON $DB_GLPI.* TO $USER_GLPI@localhost;"
mysql -u root  <<< "FLUSH PRIVILEGES;"

# Clonamos repositorio para el archivo 000-default.conf
git clone https://github.com/knyu07/proyecto-integrado
cd proyecto-integrado
mv 000-default.conf /etc/apache2/sites-available/000-default.conf
cd 

#--------------------------------------------------

# INSTALACIÓN DE GLPI

#Descargamos GLPI
wget https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz

#Descomprimimos
tar -xvzf glpi-9.5.5.tgz

#Movemos el archivo a la carpeta de Apache
mv glpi /var/www/html/

#Damos permisos para que a la hora de instalar errores de folders
chown www-data:www-data /var/www/html/glpi/* -R

#Instalamos extensiones

sudo apt-get install php-cas php-xml php-bz2 php-curl php-openssl php-imap php-ldap php-intl php-gb php-mbstring php-xmlrpc php-sodium php-mysqli php-zip

#Descomentamos extensiones
sed -i "s/;extension=bz2/extension=bz2/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=curl/extension=curl/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=ffi/extension=ffi/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=ftp/extension=ftp/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=fileinfo/extension=fileinfo/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=gd2/extension=gd2/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=gettext/extension=gettext/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=gmp/extension=gmp/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=intl/extension=intl/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=imap/extension=imap/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=ldap/extension=ldap/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=mbstring/extension=mbstring/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=xmlrpc/extension=xmlrpc/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=exif/extension=exif/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=mysqli/extension=mysqli/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=odbc/extension=odbc/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=openssl/extension=openssl/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=pdo_firebird/extension=pdo_firebird/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=pdo_mysql/extension=pdo_mysql/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=pdo_oci/extension=pdo_oci/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=pdo_odbc/extension=pdo_odbc/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=pdo_pgsql/extension=pdo_pgsql/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=pdo_sqlite/extension=pdo_sqlite/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=pgsql/extension=pgsql/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=shmop/extension=shmop/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=snmp/extension=snmp/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=soap/extension=soap/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=sockets/extension=sockets/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=sodium/extension=sodium/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=sqlite3/extension=sqlite3/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=tidy/extension=tidy/" /etc/php/7.4/apache2/php.ini
sed -i "s/;extension=xsl/extension=xsl/" /etc/php/7.4/apache2/php.ini

#Borramos lo sobrante 
rm -rf glpi-9.5.5.tgz

# Reiniciamos Apache
systemctl restart apache2
