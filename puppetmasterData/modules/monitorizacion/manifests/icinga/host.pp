define monitorizacion::icinga::host (
  $host_name,
  $hostgroups,
  $nagiosalias,
  $address,
  $project,
)
{
  include monitorizacion::params

  $dir = "${monitorizacion::params::hosts_resource_dir}/${project}"
  $target = "${dir}/${host_name}.cfg"

  ensure_resource(file, $dir, {
    ensure => directory,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    mode => 0755,
    recurse => true,
    purge => true,
    force => true,
  })

  ensure_resource(file, $target, {
    ensure => present,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    mode => 0644,
    require => File[$dir],
    before => Nagios_host[$host_name],
  })

  ensure_resource(nagios_host, $host_name, {
    ensure => present,
    alias => $nagiosalias,
    address => $address,
    hostgroups => $hostgroups,
    target => $target,
    check_command => $check_command,
    use => $project,
    host_name => $host_name,
    notify => Service['icinga'],
  })

  #
  # BROKEN by VIPs?
  #
  $servername_no_dots = regsubst($nagiosalias, '\.', '_', 'G')
  # Only generate file if grafana is puppetized
  if defined_with_params(Class[monitorizacion::grafana], {}) {
    ensure_resource( file, "${monitorizacion::params::grafana_root}/app/dashboards/${project}_${servername_no_dots}.json", {
      content => template("${module_name}/dashboard.json.erb"),
      owner => 'root',
      group => 'root',
      mode => 0644,
      require => File["${monitorizacion::params::grafana_root}/app/dashboards"],
    })
  }
}
