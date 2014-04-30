class monitorizacion::gearman_worker
{
  include monitorizacion::params
  include monitorizacion::gearman_mod

  # Configuration
  # file { '/etc/mod_gearman/mod_gearman_worker.conf':
  #   content => template("${module_name}/mod_gearman_worker.conf.erb"),
  #   require => Package['mod_gearman'],
  # }

  ensure_resource('group', 'icingacmd', {
    ensure => 'present',
    before => User['icinga'],
  })

  ensure_resource('user', 'icinga', {
    ensure           => 'present',
    comment          => 'icinga',
    groups           => ['icingacmd'],
    home             => '/var/spool/icinga',
    password         => '!!',
    password_max_age => '-1',
    password_min_age => '-1',
    shell            => '/sbin/nologin',
    before           => File['/etc/init.d/mod_gearman_worker'],
  })

  file { '/etc/init.d/mod_gearman_worker':
    content => template("${module_name}/mod_gearman_worker.erb"),
    owner => 'root',
    group => 'root',
    mode => 755,
    require => Package['mod_gearman'],
    before => Service['mod_gearman_worker'],
  }

  file { '/var/log/mod_gearman/mod_gearman_worker.log':
    ensure => present,
    owner => 'icinga',
    group => 'root',
    mode => 0640,
    require => Package['mod_gearman'],
    before => Service['mod_gearman_worker'],
  }

  service { 'mod_gearman_worker':
    ensure => running,
    require => Package['mod_gearman'],
  }

}
