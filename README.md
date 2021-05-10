# PROYECTO INTEGRADO - GLPI

## GLPI - Gestionnaire de Parc Informatique

Es una **aplicación web** que ayuda a las empresas con la gestión de su sistema de información.

Este proyecto es de **código abierto**, por lo que se puede ejecutar, modificar o desarrollar contribuyendo a la evolución de la solución proponiendo módulos adicionales libres y de código abierto en GitHub.  

Las funcionalidades de este software ayudan a los administradores a **crear una de base de datos de activos técnicos** así como a gestionarla y proporciona un historial de las intervenciones de mantenimiento. La funcionalidad de asistencia (ticket) ofrece a los usuarios un servicio de declaración de incidencias o de solicitudes basadas en activos técnicos o no.


## Técnologías utilizadas 

GLPI utiliza:

- **PHP** 5.4 o más
- **MySQL/MariaDB** para la base de datos
- **HTML** para las páginas web
- **CSS** para las hojas de estilo
- **XML** para lña generación de informes





## Características específicas: 

### **Inventario**
```
- Inventario de ordenadres, impresorasperiféricas en red y componentes asociados a través de una interfaz compuesta por OCS iventory y FusionInventory. 

- Gestión administrativa, contratos, documentos relacionados con componentes del inventario. 
```

### **ServiceDesk ITIL Compliant**

```
- Gestión de problemas en varios entornos vía la creación de tickets, gestión de los tickets, asignación, planificación de los tikets, etc...

- Gestión de problemas, proyectos y cambios.
```

### **Usuario finales**

```
- Historial de las intervenciones

- Encuesta de satisfacción

- Comentarios en solicitud

- Seguimiento de correos de la solicitud de intervención
```

### **Técnicos**

```
- Gestión de las solicitudes de intervención

- Escalamiento de los tickets
```

### **Estadísticas**

```
- Informes en varios formatos (PNG, SVG, CSV)

- Estadísticas globales

- Estadística por categoría (por técnico, hardware, usuario, categoria, prioridad, ubicación...)
```

### **Administración**

```
- Gestión del estado y de reservas del material

- Gestión de los contratos y documentos

- Sistema básico de gestión de sistema de conocimientos

- Gestión de las solicitudes de soporte para todo tipo de inventario de material

- Gestión de la información comercial y financiera (adquisición, garantía y extensión, amortización)
```

### **Reserva**

```
- Gestión de reservas

- Interfaz usuario (calendario)
```

### **Base de datos de conocimientos**

```
- Gestión de artículos de la base de datos de conocimientos y de la FAQ (preguntas frecuentes)

- Gestión de contenidos por objetivos (perfiles, grupos, etc..)
```

### **Informes**
```
- Generación de informes de dispositivos (tipo de dispositivos, contrato asociado, informes comerciales)
```

Esto es lo que trae por defecto en su instalación, aunque además de todo esto, GLPI tiene muchos plugins que añaden otras características: 

> - https://plugins.glpi-project.org/#/

De entre ellas los más populares son por ejemplo: 

- **FusionInventory**: Es un proyecto de código abierto y gratuito que proporciona hardware, inventario de software, implementación de software y descubrimiento de redes para la gestión de activos de TI y el software de asistencia técnica llamado GLPI.

- **FormCreator**: Permite la creación de formularios personalizados y de fácil acceso para los usuarios cuando desean crear uno o más tickets o cambios.

- **Red De Arquitectura**: Permite generar automáticamente una representación gráfica de la arquitectura de la red.

- **Informe de IP**: Permite crear informes de IP para visualizar las direcciones IP utilizadas y gratuitas en una red determinada.

En general son plugins para aumentar la variedad de inventariado dentro de la empresa. 


## INSTALACIÓN  

Se puede instalar tanto en un sistema Windows como en un sistema Linux. 

En Windown se instalarría dentro de IIS (Internet Information Server) y en Linux mediante la pila LAMP. 

Para está práctica instalaremos esta aplicación web en un servidor Linux y para ello necesitaremos instalar:

- Apache
- MySQL/MariaDB
- PHP

Además de que le podemos añadir herramientas administrativas como phpMyAdmin, Adminer, Webmin...

Podemos realizar la instalación de diferentes maneras: 

### **SCRIPT EN BASH**

Comenzaremos actualizando los repositorios y instalando la pila LAMP. 

```
#!/bin/bash

apt update -y 

apt install apache2 -y 

apt install mysql-server -y

apt install  php libapache2-mod-php php-mysql php-mbstring -y 
```

Seguidamente actualizamos la contraseña de root de MySQL y creamos la base de datos con la que conectará.

```
mysql -u root <<< "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'root';"
mysql -u root <<< "FLUSH PRIVILEGES;"

mysql -u root  <<< "DROP DATABASE IF EXISTS db_glpi;"
mysql -u root  <<< "CREATE DATABASE user_glpi;"
mysql -u root  <<< "CREATE USER user_glpi@localhost IDENTIFIED BY 'passwd_glpi';"
mysql -u root  <<< "GRANT ALL PRIVILEGES ON db_glpi.* TO user_glpi@localhost;"
mysql -u root  <<< "FLUSH PRIVILEGES;"

```

Una vez finalizada con la instalación de la pila LAMP y creación de su base de datos podemos proceder a la instalación del GLPI.

Descargamos el archivo, descomprimimos y moveremos esos archivos a la carpeta de Apache, dentro de /var/www/html. Seguidamente daremos permisos de Apache para  evitar errores de folders 

```
wget https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz

tar -xvzf glpi-9.5.5.tgz

mv glpi /var/www/html/

chown www-data:www-data /var/www/html/glpi/* -R

```
A continuación si accedemos dentro de nuestro navegador a la aplicación GLPI veremos que será necesario instalarle las extensiones que se encuentran pendientes, esto se hace haciendo uso del: 

```
apt-get install php-nombre_extension
```
Y para activarlas, dentro del archivo php.ini, que se encuentra dentro de /etc/php/7.2/apache2, descomentamos las líneas en donde aparezca el nombre de la extensión:

Por ejemplo: 

```
#Instalamos extensión
sudo apt-get install php-curl

#Descomentamos en el archivo
sed -i "s/;extension=curl/extension=curl/" /etc/php/7.4/apache2/php.ini
```

Finalmente para que se apliquen los cambios reiniciamos apache 

```
systemctl restart apache2
```
· CONFIGURACIÓN:

Ahora queda evitar tener agujeros de seguridad, como puede ser con el archivo .htaccess que para que surgan efecto dentro de la configuración del virtual host de apache haríamos una serie de cambios. 

```
        <Directory />
                Options FollowSymLinks
                AllowOverride None
                Require all denied
        </Directory>

        <Directory /usr/share>
                AllowOverride None
                Require all granted
        </Directory>

        <Directory /var/www/>
                Options Indexes FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>
```

- La directiva AllowOverride None implica que el fichero .htaccess no es leído.

- La directiva allow from All implica que cualquiera puede acceder a los directorios bajo www.

- La directiva Indexes implica que el contenido del directorio será mostrado.

Otra vulnerabilidad que podemos encontrar es que una vez instalado la aplicación web, este nos pide que por seguridad se elimine el archivo install/install.php para evitar que los datos sean expuestos. 


## **Docker-Compose**

Otra manera que podemos optar para la instalación de GLPI es haciendo uso de un contenedor/imagen docker-compose, que podemos encontrar en internet.

- https://hub.docker.com/r/diouxx/glpi

```
version: "3.2"

services:
#Mysql Container
  mysql:
    image: mysql:5.7.23
    container_name: mysql
    hostname: mysql
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    env_file:
      - ./mysql.env
    restart: always

#GLPI Container
  glpi:
    image: diouxx/glpi
    container_name : glpi
    hostname: glpi
    ports:
      - "80:80"
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
      - /var/www/html/glpi/:/var/www/html/glpi
    environment:
      - TIMEZONE=Europe/Brussels
    restart: always
```

A diferencia con la instalación con script en bash es que lo mencionado anterior mente de configuraciones, extensiones php, vulnerabilidades... Nos lo ahorramos con esto, lo que hace que sea mas sencillo de desplegar. 