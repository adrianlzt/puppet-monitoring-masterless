class monitorizacion::gearman_mod
{
  include monitorizacion::params

  # Mod gearman worker
  ensure_resource(package, 'mod_gearman', {
    ensure => latest,
  })

  file { '/var/log/mod_gearman':
    ensure => directory,
    owner => 'icinga',
    group => 'root',
    require => Package['mod_gearman'],
  }

}
