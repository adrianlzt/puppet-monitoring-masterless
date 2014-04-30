#
# When used as exported resource, name should be different for each host, that's why servicename exists 
#
define monitorizacion::icinga::hostgroup (
  $servicename = undef,
  $nagiosalias = undef,
  $export = false,
)
{
  include monitorizacion::params

  # Cannot reassing class variable
  if empty($servicename) {
    $hostgroup = $name
  } else {
    $hostgroup = $servicename
  }

  $target = "$monitorizacion::params::hostgroups_dir/$hostgroup.cfg"

  if $export {

    ensure_resource(file, $target, {
      ensure => present,
      owner => $monitorizacion::params::user,
      group => $monitorizacion::params::group,
      mode => 0644,
      before => Nagios_hostgroup[$hostgroup],
    })
  
    ensure_resource(nagios_hostgroup, $hostgroup, {
      ensure => present,
      alias => $nagiosalias,
      target => $target,
    })

  } else {

    file { $target:
      ensure => present,
      owner => $monitorizacion::params::user,
      group => $monitorizacion::params::group,
      mode => 0644,
      before => Nagios_hostgroup[$hostgroup],
    }

    nagios_hostgroup { $hostgroup:
      ensure => present,
      alias => $nagiosalias,
      target => $target,
      require => File[$target],
      before => Anchor['conf-after-run'],
      notify => Service['icinga'],
    }
  
  }
}
