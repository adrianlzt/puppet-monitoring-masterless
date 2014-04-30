# Puppet Master - Desplegamos puppet server
# Icinga - Desplegamos puppet client y configuración básica
# Cliente 1 - Desplegamos puppet client y configuración básica
# Cliente 2 - Desplegamos puppet client y configuración básica
vagrant up --provision-with puppet

# Desplegamos PuppetDB (usando el nuevo puppet)
vagrant provision puppet --provision-with shell

# Configuramos el cliente y exportamos recursos para el nodo icinga
vagrant provision client --provision-with shell

# Configuramos el cliente2 y exportamos recursos para el nodo icinga
vagrant provision client2 --provision-with shell

# Desplegamos Icinga (usando el nuevo puppet)
# Importamos los recursos exportados por los clientes
vagrant provision icinga --provision-with shell


echo "Acceder a la interfaz web: http://icingaadmin:icingaadmin@192.168.51.4/icinga"
