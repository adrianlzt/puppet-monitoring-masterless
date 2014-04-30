En el modulo puppetclient de deploy he puesto en el fichero puppet.conf una sección "[master]".
No se como hacer para que ese fichero lo escriba puppetclient, pero si también se carga el módulo puppetmaster, pues ese fichero lo sobreescriba el módulo de puppetmaster.



BORRADO EN EL PUPPET MASTER
Idea con HPOO:
  Hace querys a los openstack / vcenter para preguntar que máquinas se han borrado.
  Ejecuta en puppetmaster 
    puppet node deactivate fqdn-host  (quita los exported resources)
    puppet node clean fqdn-host       (borra el certificado)
  Ejecuta puppet agent -t en icinga para que borre los ficheros de los hosts y servicios que ya no se usan.

README.md
  Puesto como se haría a mano.



Borrar el directorio objects/ tras mover los ficheros que hay dentro a formato postgre-heira



Cosas que puede querer definir un proyecto:
Hosts			SI-HECHO (automáticamente al registrarse en puppet)
Services		SI-HECHO (UI RoR)
Host groups		SI-HECHO
			Creo que queda más sencillo con la idea de roles, y que cada host se aplique los suyos. Los hostgroups solo para ordenar vistas.
			Cada rol crea un hostgroup, pero también se pueden definir hostgroups a mano (como funcionalidad extendida pero no común)
Service Groups		?? (issue #113)
Host templates		SI (dejarles definir el propio?)
service templates	SI (dejarles definir el propio?)
contacts		SI-HECHO 
contact templates	NO - con los contacts es suficiente
contact groups		SI-HECHO (uno automático con el nombre del proyecto)	
time periods		permitir a cada iniciativa definir los suyos? Problemas de colision, que pongan antes el nombre de la iniciativa
commands		no, solo check_nrpe. esto lo controlamos nosotros
especialidades:		??
  host dependency
  host escalation
  extended host
  service dependency
  service escalation
  extended service


Estilizar el código.
Por ejemplo alinear todos los =>


Hacer módulo para el hiera_resources
Convertirlo en una gema? En que sitios busca puppet una función de este tipo?



Meter en el bootstrap la app en rails.




Usar el nombre que definen los usuarios en la UI para el servicename (se puede poner un description con el nombre que tengo puesto actualmente?)


Explicar en el README.md como debe ser la estructura en la base de datos para que funcione hiera_resources.rb



Como pasar parámetros tipo, quiero que este check se ejecute cada 5' -> formulario avanzado
poder crear eventhandler



url_notes: se puede especifir una URL que creará un icono en el icinga, para que el usuario piche y se le de más información sobre el check particular.


Vista sobre un nodo particular para ver que chequeos y que parámetros tiene instalados.


reiniciar icinga tras borrar definiciones de un nodo.


check_mk? autodiscover?



Poner las dependencias que tiene el modulo monitoring.
De memoria: epel, stdlib...
Los repos los he sacado al deploy de vagrant. Dejar escrito que paquetes necesita instalar y que cada uno se gestione los repos que crea



Convertir el hiera_resources en una gema para que sea más sencillo de instalar.
Instalarla con el modulo monitorizacion



Cambiar el nombre de la jerarquia "common", para que no colisione con lo que se usa ya en puppet.



Definir clave en el gearman.


Parece que al meter graphite me he cargado el virtualhost de la UI.


Poner validate_xxx a todos los parametros


Metricfactory, corregir para que bluevia_client.com en graphite sea bluevia.client_com.
Tambien para que los checks tcp o http, que pueden llevar un punto en el host target, se conviertan por _



Parece que el /etc/icinga/passwd alguien lo reescribe en blanco al desplegar la máquina. Ha vuelto a pasar al iniciar desde 0?


Meter elasticsearch para usar grafana bien.


Meter una clase params, y usarla por ejemplo para tener una variable donde esté definida la instalación de grafana.
Se usaría por ejemplo al crear los dashboards de cada cliente (basic.pp al final)



Alguna forma de poner la clave para gearman de forma aleatoria?? Con datos del facter de la máquina? Pero despues como pasarlo al resto?


Rehacer el modulo de graphite con rpms. Ahora se baja un tar.gz


Generar pdf de las metricas de grafana (owd)


Quitar check_multi? 
  Ventajas: sin problemas de timeouts
  Inconvenientes: distintas conexiones para enviar los datos
  Otra opción: desarrollar un check_multi en paralelo
  Mejor pasar a usar collectd, para poder definir un time distinto para cada check. Un check de disco no tiene sentido ejecutarlo cada 10s, pero si uno de cpu.
  Hacer checks activos contra collectd?



Como meter graphite/dashboard en icinga-web.
  Generar un dashboard específico por check.
  Como generar el dashboard por host con todos los checks que tenga este host?? (puppet append?)


Que cuando una máquina haga monitoring=false se le borren los chequeos, nrpe y configuraciones?


Pensar como se podría hacer para entornos externos (por ejemplo en Amazon), como podríamos hacer para tener un punto único donde toda la plataforma enviase datos, y desde ese punto se comunicase con el entorno de monitorización (incluyendo icinga, graphite, etc)



Usar collectd para recolectar datos en los clientes, y mediante thresholds y notificacions enviar los datos como checks pasivos a icinga.
Las métricas enviarlas diréctamente a graphite
  Mejora de thresholds, histéresis, error si no hay datos nuevos, esperar n puntos antes de alertar...
Creo que se puede usar un servidor intermedio para casos en que se desee monitorizar un entorno exterior y solo permitir una conectividad hacia nosotros.



Sacar la conf de epel del paquete monitoring, ponerla en el site.pp


Separar el site.pp en manifests/nodes/blabla.pp



En el grafana meter lineas horizontales con el threshold warning y critical





Separar el monitorizacion::icinga en instalacion, configuracion, servicio y recolección, para que sea más sencillo pasarlo a producción y por ejemplo olvidarnos de la instalación y configuración.


Hell-Depency instalando los rubygems:
Necesito rubygem-rack 1.5.2
Pero en el EPEL hay un rubygem-rack con epoch=0, por lo que ese tiene preferencia.
Aunque fuerce la versión no me deja:
[root@icinga yum.repos.d]# /usr/bin/yum -d 0 -e 0 -y install rubygem-rack-1.5.2
Package matching rubygem-rack-1.5.2-1.noarch already installed. Checking for update.
[root@icinga yum.repos.d]# rpm -qa | grep -i rubygem-rack
rubygem-rack-1.1.0-2.el6.noarch

Instalo a mano los rpms


Generar rvm: fpm -s dir -t rpm -v 1.25.19 --iteration 3 -n ruby-rvm -e etc/ usr/
Meter en el spec:

Summary: Ruby Version Manager

Requires(pre): shadow-utils

%description
RVM is a command-line tool which allows you to easily install, manage, and 
work with multiple ruby environments from interpreters to sets of gems.

%pre
getent group rvm >/dev/null || groupadd -r rvm
exit 0

%config(noreplace) /etc/rvmrc
%config(noreplace) /etc/profile.d/rvm.sh
%config(noreplace) /etc/bash.bashrc

Quitar esos ficheros de la lista del final.


Meter RVM dentro del webui


Ruby-devel necesario al tener ya los rpms compilados??


rubygem-pg-0.17.1-1.x86_64.rpm al instalarse en producción no da permisos a g y o.
Tengo que ejecutar a mano: chmod -R go+rX /usr/lib/ruby/gems/1.8/gems/pg-0.17.1


Usar hiera para determinar la versión de icinga a instalar?


Administrar icingas con https://forge.puppetlabs.com/puppetlabs/corosync
Se podría configurar el service determinando los comandos start, stop, restart, status con el crm.
En plan:
  start => "crm start Icinga_..."
  restart => /etc/cron.hourly/recargar-icinga.sh  #habría que usar este, porque pacemaker hace stop&start, no hace restart
    Habría que asegurarse que devuelve los códigos correctos.


Parametrizar el directorio de logs de icinga
Tambien el spool, object_cache, temp_file, temp_path, check_result_path
status_file
external_command_buffer_slots=32768
use_syslog=0
check_result_reaper_frequency=1
service_check_timeout=120
allow_empty_hostgroup_assignment=1
service_check_timeout_state=c
date_format=euro
use_large_installation_tweaks=1
child_processes_fork_twice=0


Usar las últimas versiones de icinga.


En vez de modificar el script de init.d de icinga, hacer esto:
[root@ESJC-DSMM-MS06S alopez]# less /etc/sysconfig/icinga 
IcingaCfgFile=/srv/nagios/icinga/etc/icinga.cfg


El monitoring.sql en algunos comandos tiene definidos espacios en blanco al final


El service.pp usa check_nrpe sin saber si ese comando existe, o se llama así.
Linea:     $check_command = "check_nrpe!${check_name}"
Debería buscar que existe en Command.all ?


Los usuarios están asociados a proyectos. Si un usuario admin se asocia a un proyecto y se borra, se borrará el usuario.
Hacer que los users admin no estén asociados a proyectos, o si no, al common.


Poder configurar eventhadlers.
http://docs.icinga.org/latest/en/eventhandlers.html
http://docs.puppetlabs.com/references/latest/type.html#nagios_service-attribute-event_handler


Si definen dos services con el mismo nombre solo funciona uno


Checks pasivos ROTOS por la introducción de las VIPs




LO MAS IMPORTANTE:

infinitos chequeos para algunos checks


interfaz para crear "plantillas" de checks (plantilla mysql, plantilla apache, etc)


interfaz para ver que chequeos tiene cada host


dsn y github muy parecido


configurar tiempo de ejecucción, check_interval, check_retry, etc


configuración específica de host, como pasar de pre a pro


sacar la conf de los repos y ponerla en el site.pp


Los ficheros que tienen como owner/group a root/root revisarlo por si hay que cambiarlos.


Configurar correctamente grafana. Definir apache_root. Generar los directorios de grafana con puppet (aunque ya los genera el rpm).
Hacer purge de los directorios para que se borren automáticamente los dashboards?
Separar dashboards pro proyecto y host (como con las conf de icinga)?
Mirar si funciona correctamente con hosts normales y con VIPs
Chequear que si dos hosts definen la misma vip los dashboards se generen correctamente.
No se generan los dashboards para servicios de lost hosts VIPs.
No tiene sentido el dashboard default por host para las VIPs


Meter las mejoras como issues en github


Ordenar los ficheros de templates y files en subdirectorios. Empieza a ser un caos.


El error
Error: Could not retrieve catalog from remote server: Error 400 on SERVER: Could not find class monitorizacion::params for client.com on node client.com
Parece que puede deberse a que intenta leer el include de monitorizacion::params antes de que se haya cargado ese manifest.
Buscar por google solución.


Mirar también porque sale de vez en cuando este error:
Error: Could not retrieve catalog from remote server: Error 400 on SERVER: Puppet::Parser::AST::Resource failed with error ArgumentError: Invalid resource type monitorizacion::check at /etc/puppet/modules/monitorizacion/manifests/checks/tcp.pp:41 on node client.com


hiera para definir las variables del site.pp


Que las máquinas arranquen sin errores
  Paquete uglify que luego se instaló bien?


Al mover webui de sitio he tenido que comentar postgresql. Puede ser porque el ensure_resource posgres se produce antes que la configuración de la postgres?


poner el select guay para los checks
