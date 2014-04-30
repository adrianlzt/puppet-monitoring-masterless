define monitorizacion::icinga::service_template (
  $templatename = undef,
  $nagiosalias = undef,
  $export = false,
)
{
  include monitorizacion::params

  # Cannot reassing class variable
  if empty($templatename) {
    $service_template = $name
  } else {
    $service_template = $templatename
  }

  $target = "$monitorizacion::params::templates_dir/$service_template-service.cfg"

  if $export {

    ensure_resource(file, $target, {
      ensure => present,
      owner => $monitorizacion::params::user,
      group => $monitorizacion::params::group,
      mode => 0644,
      before => Nagios_service[$service_template],
    })

    ensure_resource(nagios_service, $service_template, {
      ensure => present,
      notes => $nagiosalias,
      target => $target,
      register => 0, # This parameter makes the service a template
      use => $monitorizacion::params::service_template_default,
      contact_groups => $templatename, # Don't know can't use $::project
    })
  
  } else {

    file { $target:
      ensure => present,
      owner => $monitorizacion::params::user,
      group => $monitorizacion::params::group,
      mode => 0644,
      before => Nagios_service[$service_template],
    }
    
    nagios_service { $service_template:
      ensure => present,
      alias => $nagiosalias,
      target => $target,
      register => 0, # This parameter makes the service a template
      use => $monitorizacion::params::service_template_default,
      contact_groups => $templatename, # Don't know can't use $::project
      require => File[$target],
      before => Anchor['conf-after-run'],
      notify => Service['icinga'],
    }
  }
}
