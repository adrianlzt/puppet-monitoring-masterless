#
# One active check execute check_multi to trigger the rest of checks.
# That checks send their results as passive checks
#
class monitorizacion::checks::exec_passive (
  $icinga_host,
)
{
  require monitorizacion::basic

  # Only one nrpe command, to trigger the execution of all passive checks
  file { "/etc/nrpe.d/exec_passive.cfg" :
    content => "command[exec_passive]=LC_ALL=C /usr/lib/nagios/plugins/check_multi -f /etc/check_multi -r 256 -t 8 | send_multi --timeout=9 --server=$icinga_host --encryption=yes --key=should_be_changed --host=${::project}_$fqdn",
    require => Package['nrpe'],
    notify => Service['nrpe'],
  }

  # Clean up check multi examples
  file { '/etc/check_multi' :
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    recurse => true,
    purge => true,
    require => Package['check_multi'],
  }
  file { ['/etc/check_multi/cluster','/etc/check_multi/feed_passive']:
    ensure => absent,
    force => true,
  }


  # Configure this service in Icinga
  $host_name = $monitorizacion::params::resourcehost
  $name_target = "${monitorizacion::params::resourcehost}_exec_passive"
  $target = inline_template("${monitorizacion::params::services_resource_dir}/<%= @name_target.gsub(/\\s+/, '_').downcase %>.cfg")
  $tagname = "icinga-${::env}"

  @@nagios_service { "${monitorizacion::params::resourcehost}_exec_passive":
    check_command => "check_nrpe!exec_passive",
    use => $::project,
    host_name => $host_name,
    service_description => "Trigger passive checks",
    tag => $tagname,
    target => $target,
  }

  @@file { $target:
    ensure => present,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    tag => $tagname,
    require => Nagios_service[$name],
  }

}
