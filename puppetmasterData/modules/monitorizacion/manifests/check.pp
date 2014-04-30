define monitorizacion::check (
  $check_name,
  $package,
  $exec,
  $vip_name = undef,
)
{
  require monitorizacion::basic

  # Define vars needed
  $tagname = "icinga-${::env}"

  # If we are defining a vip service, host_name should point to the vip host
  if $vip_name {
    $host_name = $vip_name
    $srv_name = "${host_name}.${check_name}" 
  } else {
    $host_name = $monitorizacion::params::servername
    $srv_name = $name
  }

  # Ensure check package is already installed
  ensure_resource('package', $package, {'ensure' => 'latest' })

  
  # Determine if check will be active or passive, and configure check in client
  if $::passive {
    #
    # BROKEN
    # El check activo va a ejecutar los checks de la vip, y si no estan corriendo
    # los servicios en este nodo va a enviar mensajes de error
    #
    $active_checks = 0
    $check_command = "check_dummy!0!passive checks"

    file { "/etc/check_multi/${check_name}.cmd" :
      content => "command[${check_name}]=/usr/lib64/nagios/plugins/${exec}",
      require => Package['check_multi'],
    }

  } else {
    $active_checks = 1
    $check_command = "check_nrpe!${check_name}"

    file { "/etc/nrpe.d/${check_name}.cfg" :
      content => "command[${check_name}]=/usr/lib64/nagios/plugins/${exec}",
      require => Package['nrpe'],
      notify => Service['nrpe'],
    }
  }


  # Configure icinga and grafana
  @@monitorizacion::icinga::service { $name:
    srv_name => $srv_name,
    check_name => $check_name,
    check_command => $check_command,
    project => $::project,
    host_name => $host_name,
    service_description => $check_name,
    active_checks_enabled => $active_checks,
    tag => $tagname,
  }
}
