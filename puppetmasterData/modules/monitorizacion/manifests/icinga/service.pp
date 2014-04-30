define monitorizacion::icinga::service (
  $srv_name,
  $check_name,
  $check_command,
  $host_name,
  $project,
  $service_description,
  $active_checks_enabled,
)
{
  include monitorizacion::params

  $dir_project = "${monitorizacion::params::services_resource_dir}/${project}"
  $dir_host = "${dir_project}/${host_name}"
  $target = inline_template("${dir_host}/<%= @check_name.gsub(/\\s+/, '_').downcase %>.cfg")

  ensure_resource(file, [$dir_project,$dir_host], {
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
    require => File[$dir_host],
    before => Nagios_service[$srv_name],
  })

  ensure_resource(nagios_service, $srv_name, {
    ensure => present,
    target => $target,
    check_command => $check_command,
    use => $project,
    host_name => "${project}_${host_name}",
    service_description => $service_description,
    active_checks_enabled => $active_checks_enabled,
    notify => Service['icinga'],
  })

  # Generate a per-service Grafana dashboard
  #
  # BROKEN by VIPs?
  #
  $servername_no_dots = regsubst($host_name, '\.', '_', 'G')
  $target_dash = inline_template("${monitorizacion::params::grafana_root}/app/dashboards/<%= @srv_name.gsub(/\\s+/, '_').gsub(/\./, '_').downcase %>.json")

  # Only generate file if grafana is puppetized
  if defined_with_params(Class[monitorizacion::grafana], {}) {
    ensure_resource(file, $target_dash, {
      content => template("${module_name}/dashboard-service.json.erb"),
      owner => 'root',
      group => 'root',
      mode => 0644,
      tag => $tagname,
      require => Package['grafana'],
    })
  }
}
