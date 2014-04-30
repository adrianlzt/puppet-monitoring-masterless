class monitorizacion::gearman_server
{
  include monitorizacion::params

  # Gearman server
  package { 'gearmand-server':
    ensure => latest,
  }

  service { 'gearmand':
    ensure => running,
    require => Package['gearmand-server'],
  }
}
