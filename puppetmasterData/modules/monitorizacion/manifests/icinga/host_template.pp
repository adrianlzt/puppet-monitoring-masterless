define monitorizacion::icinga::host_template (
  $templatename = undef,
  $nagiosalias = undef,
  $export = false,
)
{
  include monitorizacion::params

  # Cannot reassing class variable
  if empty($templatename) {
    $host_template = $name
  } else {
    $host_template = $templatename
  }

  $target = "$monitorizacion::params::templates_dir/$host_template-host.cfg"

  if $export {

    ensure_resource(file, $target, {
      ensure => present,
      owner => $monitorizacion::params::user,
      group => $monitorizacion::params::group,
      mode => 0644,
      before => Nagios_host[$host_template],
    })
    
    ensure_resource(nagios_host, $host_template, {
      ensure => present,
      alias => $nagiosalias,
      target => $target,
      register => 0, # This parameter makes the host a template
      use => $monitorizacion::params::host_template_default,
      contact_groups => $templatename, # Don't know can't use $::project
    })
  
  } else {

    file { $target:
      ensure => present,
      owner => $monitorizacion::params::user,
      group => $monitorizacion::params::group,
      mode => 0644,
      before => Nagios_host[$host_template],
    }
    
    nagios_host { $host_template:
      ensure => present,
      alias => $nagiosalias,
      target => $target,
      register => 0, # This parameter makes the host a template
      use => $monitorizacion::params::host_template_default,
      contact_groups => $::project,
      require => File[$target],
      before => Anchor['conf-after-run'],
      notify => Service['icinga'],
    }
  }
}
