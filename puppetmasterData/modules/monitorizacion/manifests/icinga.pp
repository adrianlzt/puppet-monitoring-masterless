class monitorizacion::icinga (
  $perfdata = true,
)
{
  validate_bool($perfdata)

  # tagname define which exported resources should take icinga node
  # Should be defined in a custom fact in icinga node
  $tagname = "icinga-${::env}"
 
  include monitorizacion::params
 
  $icinga_root_dir = $monitorizacion::params::icinga_root_dir

  ### Instalacion ###

  # Needed to read custom facts
  # Install json gem for ruby-1.8
  package { 'rubygem-json':
    ensure => 'present',
    before => Anchor['conf-after-run'],
  }

  package { 'icinga':
    ensure => 'present',
  }

  $plugins = ['nagios-plugins-disk.x86_64','nagios-plugins-http.x86_64','nagios-plugins-load.x86_64','nagios-plugins-nrpe.x86_64','nagios-plugins-ping.x86_64','nagios-plugins-procs.x86_64','nagios-plugins-ssh.x86_64','nagios-plugins-swap.x86_64','nagios-plugins-users.x86_64','nagios-plugins-dummy.x86_64']
  package { $plugins :
    ensure => present,
    require => Package['icinga']
  }

  if hiera('pacemaker') == "true" {
    $pacemaker_icinga_rsc = hiera('pacemaker-icinga-resource','not-needed')
    service { 'icinga' :
      ensure     => running,
      enable     => false,
      hasrestart => false,
      hasstatus  => false,
      noop       => true,
      restart    => '/bin/touch /root/reboot_icinga',
      status     => "/usr/sbin/crm resource status $pacemaker_icinga_rsc",
      require    => Package['icinga'],
    }
  } else {
    service { 'icinga' :
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['icinga'],
    }
  }

  ### Configuracion ###

  anchor { 'conf-after-run' :
    before => Service['icinga'],
  }

  if $perfdata {
    $process_performance_data = 1
  } else {
    $process_performance_data = 0
  }

  file { [$icinga_root_dir,$monitorizacion::params::icinga_conf_dir]:
    ensure => 'directory',
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    mode => 0755,
    notify => Service['icinga'],
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
  }

  # Fichero de configuracion de icinga
  $nagiosql = hiera('nagiosql_dir','false')
  file { "$icinga_root_dir/icinga.cfg":
    content => template("${module_name}/icinga.cfg.erb"),
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::apache_group,
    mode => '0640',
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
    notify => Service['icinga'],
  } 

  file { "$icinga_root_dir/resource.cfg":
    content => template("${module_name}/resource.cfg.erb"),
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::apache_group,
    mode => '0640',
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  file { $monitorizacion::params::icinga_passwd:
    ensure => file,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::apache_group,
    mode => 0660,
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
  }

  file { "/etc/sysconfig/icinga":
    content => template("${module_name}/icinga.erb"),
    owner => 'root',
    group => 'root',
    mode => '0600',
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
    notify => Service['icinga'],
  } 

  # Creamos los subdirectorios donde meteremos los .cfg
  file { [ $monitorizacion::params::services_resource_dir, $monitorizacion::params::hosts_resource_dir, $monitorizacion::params::hostgroups_dir, $monitorizacion::params::templates_dir, $monitorizacion::params::contacts_dir, $monitorizacion::params::commands_dir ]:
    ensure => 'directory',
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    mode => 0755,
    recurse => true,
    purge => true,
    force => true,
    notify => Service['icinga'],
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
  }

  ensure_resource('file', "${icinga_root_dir}/objects", {
    ensure => directory,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
  })

  # Conf files not generated by automatic monitoring
  file { "$icinga_root_dir/objects/timeperiods.cfg":
    source => "puppet:///modules/${module_name}/timeperiods.cfg",
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::apache_group,
    mode => '0640',
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
    notify => Service['icinga'],
  } 

  file { "$icinga_root_dir/objects/templates.cfg":
    source => "puppet:///modules/${module_name}/templates.cfg",
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::apache_group,
    mode => '0640',
    require => Package['icinga'],
    before => Anchor['conf-after-run'],
    notify => Service['icinga'],
  } 

  ### Importando recursos ###
  # Require del servicio icinga para asegurarme que están los dir creados

  Nagios_host <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  Nagios_service <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  # Uso Monitorizacion::Icinga::Hostgroup
  #Nagios_hostgroup <<| tag == $tagname |>> {
  #  require => Anchor['conf-after-run'],
  #  notify => Service['icinga'],
  #}

  File <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  Monitorizacion::Icinga::Host <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  Monitorizacion::Icinga::Service <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  Monitorizacion::Icinga::Hostgroup <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  Monitorizacion::Icinga::Host_template <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  Monitorizacion::Icinga::Service_template <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  Monitorizacion::Icinga::Contact_group <<| tag == $tagname |>> {
    require => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

}