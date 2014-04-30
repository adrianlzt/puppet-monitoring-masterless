class monitorizacion::gearman_neb (
  $perfdata = true,
)
{
  validate_bool($perfdata)

  include monitorizacion::params
  include monitorizacion::gearman_mod

  # Configuration

   ensure_resource('file', "${icinga_root_dir}/modules", {
     ensure => directory,
     owner => $user,
     group => $group,
   })

  file { "$monitorizacion::params::icinga_root_dir/modules/mod_gearman.cfg":
    source => "puppet:///modules/${module_name}/mod_gearman.cfg",
    owner => root,
    group => root,
    mode => 0644,
    require => [Package['mod_gearman'],Package['icinga']],
    notify => Service['icinga'],
  }

  if $perfdata {
    $perfdata_val = 'yes'
  } else {
    $perfdata_val = 'no'
  }

  file { '/etc/mod_gearman/mod_gearman_neb.conf':
    content => template("${module_name}/mod_gearman_neb.conf.erb"),
    require => Package['mod_gearman'],
    notify => Service['icinga'],
  }

  file { '/var/log/mod_gearman/mod_gearman_neb.log':
    ensure => present,
    owner => 'icinga',
    group => 'icinga',
    mode => 0640,
    require => Package['mod_gearman'],
    notify => Service['icinga'],
  }
}
