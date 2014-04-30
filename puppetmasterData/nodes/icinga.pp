node 'icinga' inherits default {
  $graphite_web_servername = hiera('graphite_web_servername',"graphite.monit.inet")
  class { 'monitorizacion::icinga' : } # Icinga installation, configuration and resource recollection
  class { 'monitorizacion::icinga-gui' : } # Icinga classic interface
  class { 'monitorizacion::check_mk_multisite':
    graphite => "http://${$graphite_web_servername}",
    # Grafana is supposed to be in "icingahost/check_mk/../grafana"
  }
  include monitorizacion::gearman_server
  include monitorizacion::gearman_neb
  include monitorizacion::gearman_worker

  $gr_storage_schemas = [
    {
      name       => 'icinga',
      pattern    => '^icinga\.',
      retentions => '1m:7d,10m:150d,1h:1y,1d:4y'
    },
    {
      name       => 'carbon',
      pattern    => '^carbon\.',
      retentions => '1m:90d'
    },
    {
      name       => 'default',
      pattern    => '.*',
      retentions => '1s:30m,1m:1d,5m:2y'
    }
  ]
  $gr_storage_aggregation_rules = {
    '00_icinga'      => { pattern => '^icinga\.',factor => '0.0', method => 'average' },
    '10_min'         => { pattern => '\.min$',   factor => '0.1', method => 'min' },
    '11_max'         => { pattern => '\.max$',   factor => '0.1', method => 'max' },
    '12_sum'         => { pattern => '\.count$', factor => '0.1', method => 'sum' },
    '99_default_avg' => { pattern => '.*',       factor => '0.5', method => 'average'}
  }
  class { 'apache::mod::headers': }
  class { 'graphite':
    gr_timezone => 'Europe/Madrid',
    secret_key => hiera('graphite_secret_key',"xxxxxxx"),
    gr_web_cors_allow_from_all => true,
    gr_web_servername => $graphite_web_servername,
    gr_storage_schemas => $gr_storage_schemas,
    gr_storage_aggregation_rules => $gr_storage_aggregation_rules,
    require => Class['apache::mod::headers'],
  }
  class { 'monitorizacion::gearman_graphite':
    require => Class['graphite'],
  }
  class { 'monitorizacion::grafana': 
    graphite => "http://${$graphite_web_servername}",
  }

  hiera_resources('hostgroups')
  hiera_resources('commands')
  hiera_resources('contacts')
}

#node 'node1pacemaker','node2-pacemaker' inherits icinga { }
