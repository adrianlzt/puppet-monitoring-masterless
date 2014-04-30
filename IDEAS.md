http://www.linuxjournal.com/content/puppet-and-nagios-roadmap-advanced-configuration

manage our hostgroup memberships via the hostgroup parameter of the nagios_host type

Cuando exportemos un recurso nagios (host, service, ...) definir donde debe escribirse, para separar las confs en ficheros distintos:
    target => "/etc/nagios/resource.d/host_${::hostname}.cfg",


Cuidado:
  -como eliminar hosts
  -hostgroups?



En vez de usar templates, definir una clase ::params
El common.json de cada iniciativa define ahí que cosas quiere (tiempo cuando se hacen los checks, notification_interval, etc
La clase basic debe tener todos esos parámetros configurables, que si no tienen nada los pilla del ::params

Los checks todos heredarán también de una clase más genérica donde también se definen como parámetros de la clase todos esos parámetros.


Los nodos deben tener como hostgroup a su iniciativa, y también otro hostgroup que sea iniciativa-rol



Posibilidad de tener varios roles?
Por que no asociar checks a hostgroups, y así solo con asociar una máquina a un hostgroup determinado ya tiene los checks?
Como desplegar?

Creo que se haría de la misma manera, una clase MySQL, que al heredarla un host se puede hacer que ese host pertenezca a un hostgroup donde ya estén configurados todos los services, y donde se desplieguen en la máquina los ficheros de configuración nrpe correspondientes.



hiera como ENC no ordena



Separar los checks en clases y defined types, según si el check se puede definir varias veces (check_tcp por ejemplo), o solo una (check_load por ejemplo)?

Si los separo, es un poco coñazo, porque depende del check tendrá que meterse en una parte del json o en otra.
Si no los separo, y alguien define dos veces el check de load con distinto nombre de recurso, habrá colisión.
Error: Could not retrieve catalog from remote server: Error 400 on SERVER: Duplicate declaration: Package[nagios-plugins-load] is already declared in file /etc/puppet/modules/monitorizacion/manifests/checks/load.pp:27; cannot redeclare at /etc/puppet/modules/monitorizacion/manifests/checks/load.pp:27 on node client.com



Gestionar correctamente los permisos. Ahora se arreglan en el reset de icinga:
    restart   => '/bin/chmod -R a+rX /etc/icinga && /sbin/service icinga restart',



IMPORTANTE:
You can purge Nagios resources using the resources type, but only in the default file locations. This is an architectural limitation.
http://docs.puppetlabs.com/references/stable/type.html#nagioscontact
