class monitorizacion::gearman_graphite (
  $gearman_host = 'localhost',
  $gearman_key = 'should_be_changed',
  $workers = 5,
  $graphite_host = 'localhost',
  $graphite_port = 2003,
  $conf_file = "/etc/metricfactory/modgearman2graphite.yaml",
  $pid_file = "/var/run/metricfactory.pid",
)
{
  package { ['libyaml-devel','python-pip'] :
    ensure => latest,
  }
  ->
  package { ['python-metricfactory','python-wishbone','python-gearman','python-wb_input_gearman','python-wb_output_tcp']:
    ensure => latest,
  }
  ->
  # Configuration files
  file {'/etc/metricfactory':
    ensure => directory,
    owner => 'root',
    group => 'root',
  }
  ->
  file {$conf_file:
    content => template("${module_name}/modgearmand2graphite.yaml.erb"),
    owner => 'root',
    group => 'root',
  }
  ->
  service {'metricfactory':
    ensure     => running,
    provider   => base,
    binary     => '/usr/bin/metricfactory',
    start      => "/usr/bin/metricfactory start --config $conf_file --pid $pid_file",
    stop       => "/usr/bin/metricfactory stop --pid $pid_file",
    hasstatus  => false,
  }
}
