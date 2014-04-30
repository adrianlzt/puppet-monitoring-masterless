Ejemplo de automatización de la monitorización con puppet, hiera e icinga
==========

La estructura de directorios tiene el siguiente significado:
 - deploy: manifests y módulos que usa vagrant al desplegar las máquinas
 - puppetmasterData: módulos y ficheros de configuración de hiera que usa el puppet master

El módulo donde se lleva a cabo prácticamente todo es: develop/puppetmasterData/modules/monitorizacion

Los nodos pueden definir que proyecto/rol/etc son mediante custom facts en /etc/facter/facts.d

Mirar deploy/modules/hiera/files/hiera.yaml y develop/deploy/modules/puppetmaster/files/site.pp para ver que clases y defined types se aplican a cada nodo.

Los ficheros .json de puppetmasterData/hiera/ definen que se aplica a cada host.

He realizado una modificación al módulo hiera_resources de http://blog.yo61.com/assigning-resources-to-nodes-with-hiera-in-puppet/ para poder definir varias veces un mismo defined type con hiera. El código está en: develop/deploy/modules/puppetmaster/files/hiera_resources.rb

Entorno vagrant con tres máquinas, SO centos 6.4, provider virtualbox.
 - puppet
 - icinga
 - client
 - client2

# Bootstrap
``./bootstrap.sh``

Tras esto deberemos tener icinga configurado y monitorizando las dos máquina clientes.

Para acceder a la interfaz web: http://icingaadmin:icingaadmin@192.168.51.4/icinga/


# Salir de la monitorización
## Dejar de monitorizar un nodo
En la máquina en cuestión deberemos desmarcar la opción de monitorización del facter

```
/etc/facter/facts.d/general.json
{
    "monitoring": "false", 
    ...
}
```
Y lanzar puppet:
``puppet agent -t``

Esto borrará los ficheros de configuración de nrpe, pero no los rpms que se hubiesen instalado.

En el icinga:
``puppet agent -t``


## Borrado permanente de un nodo
Si una máquina la queremos sacarla de puppet y de la monitorización:

En el puppet:
```
puppet node deactivate fqdn-del-host
puppet node clean fqdn-del-host
```
En el icinga:
``puppet agent -t``


# Notas
Si destruímos el nodo cliente o el nodo icinga, al intentar unirlos de nuevo al puppet nos dará error en el certificado.
Deberemos limpiar el certificado antiguo en el puppet:

``puppet cert clean client``

Borrar los generados en el nodo:

``rm -f /etc/puppet/ssl/certs/client.pem``

Y volver a ejecutar puppet:

``puppet agent -t``


# Webs

Necesario tener en el /etc/hosts:

192.168.51.4 monit.inet graphite.monit.inet test.monit.inet
192.168.51.2 ui.monit.inet


http://ui.monit.inet

http://graphite.monit.inet

http://monit.inet/grafana

http://monit.inet/icinga

http://monit.inet/check_mk

Para tener acceso como superusuario a check_mk deberemos crear el usuario icingaadmin (sin proyectos asociados) desde la sección 'contacts' de la interfaz web.


# Entornos

Icinga y los clientes determinarán en que entorno están mediante un custom fact, definido en /etc/facter/facts.d/general.json

``{ "env": "pro" }``

Icinga mediante este fact decidirá que entorno monitoriza.


# Passive / Active checks

Los clientes decidirán si son chequeados activamente o pasivamente definiendo en /etc/facter/facts.d/general.json

``{ "passive": "true" }``

Por defecto serán activos.

# Interfaces

Por defecto el nodo a monitorizar se configurará con la interfaz eth0. Si queremos que usa otra crearemos el fichero /etc/facter/facts.d/interface.json con el contenido

``{"interface":"eth1"}``

# Virtual IP

Si un nodo tiene configuradas una o varias VIPs, estan deben definirse en etc/facter/facts.d/vip.json con el nombre definido en la interfaz web.

``{"vip":"nombre-de-la-vip,nombre-de-otra-vip"}``


# NRPE manual

Se puede poner configuraciones manuales en /etc/nrpe.manual/

Este directorio no está gestionado por Puppet


# Script para monitorizar una máquina OpenStack

Si queremos monitorizar una máquina OpenStack primero deberemos asignarle una ip flotante de la red de Management.

Después haremos

``curl -H "hostgroup: webserver,gearman" -H "vip: esjc-dsmm-cl01s,esjc-dsmn-cl99s" http://localhost:3000/monit/openstack/dev``

No es obligatorio configurar las cabeceras de hostgroup y vip. El entorno si es obligatorio.

Esto cogerá la vip desde que nos ataca el cliente y atacará la API de OpenStack para obtener el tenant al que pertenece. Este tenant name se usará como nombre del proyecto de la máquina.
