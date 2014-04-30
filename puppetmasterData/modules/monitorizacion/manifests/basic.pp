class monitorizacion::basic (
  $allowed_hosts = ['127.0.0.1'],
  $icinga_host,
)
{
  include monitorizacion::params

  # Instalamos el demonio nrpe
  class { 'nrpe':
    allowed_hosts => $allowed_hosts,
  }

  $tagname = "icinga-${::env}"

  if empty($::hostgroup) {
    $hostgroups = $::project
  } else {
    # Prefix project name to hostgroups. fronted -> project-frontend
    $hg_array = split($::hostgroup,",")
    $hg_array_prefix = prefix($hg_array,"$::project-")
    $hg_string_prefix = join($hg_array_prefix,",")

    $hostgroups = join([$::project,$hg_string_prefix],",")
  }

  # Define general hostgroup for project
  @@monitorizacion::icinga::hostgroup { $monitorizacion::params::resourcehost: 
    nagiosalias => "$::project generic group",
    servicename => $::project,
    tag => $tagname, 
    export => true,
  }

  # Define host template for project
  @@monitorizacion::icinga::host_template { $monitorizacion::params::resourcehost: 
    nagiosalias => "$::project generic host template",
    templatename => $::project,
    tag => $tagname, 
    export => true,
  }

  # Define service template for project
  @@monitorizacion::icinga::service_template { $monitorizacion::params::resourcehost: 
    nagiosalias => "$::project generic service template",
    templatename => $::project,
    tag => $tagname, 
    export => true,
  }

  # Define contact group for project
  @@monitorizacion::icinga::contact_group { $monitorizacion::params::resourcehost: 
    nagiosalias => "$::project generic contact group",
    groupname => $::project,
    tag => $tagname, 
    export => true,
  }

  # Export host for icinga
  # If host define a floating ip, use that
  # Use eth0 by default. Can change interface with custom fact
  if $::floating_ip {
    $address = $::floating_ip
  } else {
    if $::interface {
      $address = inline_template("<%= scope.lookupvar('::ipaddress_${::interface}') %>")
    } else {
      $address = $::ipaddress_eth0
    }
  }

  @@monitorizacion::icinga::host { $monitorizacion::params::resourcehost:
    host_name => $monitorizacion::params::resourcehost,
    hostgroups => $hostgroups,
    nagiosalias => $monitorizacion::params::servername,
    address => $address,
    project => $::project,
    tag => $tagname,
  }

  #
  # BROKEN by VIPs?
  #
  if $::passive {
    # send_gearman to submit passive checks
    include monitorizacion::gearman_mod

    # check_multi to configure passive checks
    package { 'check_multi':
        ensure => latest,
    }

    # One active check to trigger all passives
    class { 'monitorizacion::checks::exec_passive':
      icinga_host => $icinga_host,
    }
  }

}
