class monitorizacion::grafana (
  $elasticsearch = 'http://"+window.location.hostname+":9200',
  $elasticsearch_index = 'grafana-dash',
  $graphite = 'http://"+window.location.hostname+":8080',
  $default_route = "/dashboard/file/default.json",
  $panel_names = ['text','graphite']
)
{
  include monitorizacion::params

  $_panel_names = join($panel_names,"','")

  package { 'grafana':
    ensure => latest,
  }
  
  file { "${monitorizacion::params::grafana_root}/config.js":
    content => template("${module_name}/config.js.erb"),
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['grafana'],
  }

  file { "${monitorizacion::params::grafana_root}/app/dashboards":
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
    recurse => true,
    purge => true,
    force => true, 
    require => Package['grafana'],
  }

  file { "${monitorizacion::params::grafana_root}/app/dashboards/default.json":
    source => "puppet:///modules/${module_name}/default.json",
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => File["${monitorizacion::params::grafana_root}/app/dashboards"],
  }
}
