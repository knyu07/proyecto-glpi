# FUSION INVENTORY

Es un proyecto de software libre que sigue la filosofía open source. Proporciona un completo inventario de hardware y software, además de incorporar herraminetas de implementación de programas y de descubrimiento de redes.

- Proyecto comunitario desarrollado por David Durieux

GLPI es una aplicación web que ayuda a las empresas con la gestión de su sistema de información. Entre sus características, esta solución es capaz de contruir un inventario de todos los recursos de la organización y de gestionar tareas administrativas y financieras. 

> Información sobre GLPI: https://github.com/glpi-project/glpi

> https://www.nettix.com.pe/documentacion/soporte-documentacion/que-es-glpi-y-como-me-ayuda#:~:text=GLPI%2C%20es%20una%20herramienta%20web,incidencias%20(ticketing%20%2F%20helpdesk).

> https://blog.redigit.es/glpi-caracteristicas-instalacion-y-configuracion/

GLPI, es una herramienta web en software libre que ofrece una gestión integral del inventario informático de una empresa además de incluir un sistema de gestión de incidencias (ticketing / helpdesk).


## MONTAJE

- Server Linux - Instalar pila LAMP
- Server Windows - Crear Dominio
- Cliente Windows - Inventario

## SCRIPT DE AUTOMATIZACIÓN

https://forum.glpi-project.org/viewtopic.php?id=164630

## VULNERABILIDAD
http://seguridadxredes.blogspot.com/2015/12/apache-glpi-los-descuidos-se-pagan.html

Eliminar el archivo install/install.php por razones de seguridad

## USUARIOS POR DEFECTO DE GLPI
Usuario: glpi
Clave: glpi
Uso: Administrador

Usuario: tech
Clave: tech
Uso: Técnico

Usuario: post-only
Clave: postonly
Uso: Usuario de solo lectura

Usuario: normal
Clave: normal
Uso: Usuario normal

## SCRIPT EN ANISBLE
https://www.ansible.com 
https://github.com/Webelys/glpi_ansible

## GLPI CON DOCKER-COMPOSE
https://hub.docker.com/r/diouxx/glpi

## PLUGIN FUSION INVENTORY
https://github.com/fusioninventory/fusioninventory-for-glpi/archive/refs/tags/glpi9.5+3.0.tar.gz

## MANUAL DE INSTALACIÓN FUSIONINVENTORY
https://fusioninventory.org/documentation/agent/installation/linux/deb.html


## SNMP CON FUSIONINVENTORY
https://rdr-it.com/es/fusioninventory-configurar-tareas-de-descubrimiento-e-inventario/2/

## ALTERNATIVAS A GLPI  
https://www.capterra.es/alternatives/126254/glpi

https://progsoft.net/es/software/glpi

https://appmus.com/vs/glpi-vs-spiceworks
