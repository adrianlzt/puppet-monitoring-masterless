class monitorizacion::check_mk_multisite (
  $graphite = "http://localhost",
)
{
  include monitorizacion::params

  ensure_resource('class', 'apache', { })
  ensure_resource('class', 'apache::dev', { })

  $icinga_root_dir = $monitorizacion::params::icinga_root_dir

  package { 'mk-livestatus':
    ensure => latest,
  }

  package {'mod_python':
    ensure => latest,
  }
  ->
  # apache module delete all conf.d file not puppetized
  file {'/etc/httpd/conf.d/python.conf':
    source => "puppet:///modules/${module_name}/python.conf",
    notify => Class['apache::service'],
  }
  ->
  package { 'mk-multisite':
    ensure => latest,
    require => Class['apache'],
  }
  


  # Configure multisite apache conf
  $url_prefix = "/"
  $web_dir = "/usr/share/multisite"
  $nagios_auth_name = $monitorizacion::params::user
  $htpasswd_file = $monitorizacion::params::icinga_passwd
  $apache_config_dir = "/etc/httpd/conf.d"
  # python.conf should be loaded before multisite conf
  $conf_name = "zzz_multisite.conf"
  file {"${apache_config_dir}/${conf_name}":
    content => template("${module_name}/multisite.conf.erb"),
    require => Package['mk-multisite'],
    notify => Class['apache::service'],
  }

  # Delete rpm-latest conf file
  file {"${apache_config_dir}/multisite.conf":
    ensure => absent,
    require => Package['mk-multisite'],
    notify => Class['apache::service'],
  }

  file {"${web_dir}/htdocs/defaults.py":
    content => template("${module_name}/defaults.py.erb"),
    require => Package['mk-multisite'],
    before => File["${apache_config_dir}/${conf_name}"],
  }

  # Modify to use graphite graphs instead of pnp4nagios
  file { "${web_dir}/plugins/views/painters.py" :
    content => template("${module_name}/painters.py.erb"),
    owner => root,
    group => root,
    mode => 0644,
    require => Package['mk-multisite'],
    notify => Class['apache::service'],
  }

  file {"${icinga_root_dir}/multisite.mk":
    source => "puppet:///modules/${module_name}/multisite.mk",
    owner => $monitorizacion::params::apache_user,
    group => $monitorizacion::params::group,
    mode => 0640,
    require => [Package['mk-multisite'],Package['icinga']],
    before => File["${apache_config_dir}/${conf_name}"],
  }

  file { ["${icinga_root_dir}/wato","${icinga_root_dir}/multisite.d","${icinga_root_dir}/multisite.d/wato","/var/lib/check_mk","/var/lib/check_mk/web","/var/lib/check_mk/wato","/var/lib/check_mk/wato/auth","/var/lib/check_mk/web/icingaadmin"]:
    ensure => directory,
    owner => $monitorizacion::params::apache_user,
    group => $monitorizacion::params::group,
    mode => 0770,
    require => [Package['mk-multisite'],Package['icinga']],
    before => File["${apache_config_dir}/${conf_name}"],
  }

  file { "${icinga_root_dir}/wato/contacts.mk":
    ensure => file,
    owner => $monitorizacion::params::apache_user,
    group => $monitorizacion::params::apache_group,
    require => File["${icinga_root_dir}/wato"],
    before => File["${apache_config_dir}/${conf_name}"],
  }

  file { "${icinga_root_dir}/auth.serials":
    ensure => file,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::apache_group,
    mode => 0660,
    require => [Package['mk-multisite'],Package['icinga']],
    before => File["${apache_config_dir}/${conf_name}"],
  }

   ensure_resource('file', "${icinga_root_dir}/modules", {
     ensure => directory,
     owner => $user,
     group => $group,
   })

  file { "${icinga_root_dir}/modules/livestatus.cfg": 
    source => "puppet:///modules/${module_name}/livestatus.cfg",
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    mode => 0644,
    notify => Service[icinga],
    require => [Package['icinga'],Package['mk-livestatus']],
  }

}
