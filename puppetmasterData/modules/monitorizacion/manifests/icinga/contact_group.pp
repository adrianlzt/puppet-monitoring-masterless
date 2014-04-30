define monitorizacion::icinga::contact_group (
  $groupname = undef,
  $nagiosalias = undef,
  $export = false,
)
{
  include monitorizacion::params

  # Cannot reassing class variable
  if empty($groupname) {
    $contact_group = $name
  } else {
    $contact_group = $groupname
  }

  $target = "$monitorizacion::params::contacts_dir/$contact_group.cfg"

  if $export {
    ensure_resource(file, $target, {
      ensure => present,
      owner => $monitorizacion::params::user,
      group => $monitorizacion::params::group,
      mode => 0644,
      before => Nagios_contactgroup[$contact_group],
    })

    ensure_resource(nagios_contactgroup, $contact_group, {
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
      before => Nagios_contactgroup[$contact_group],
    }

    nagios_contactgroup { $contact_group:
      ensure => present,
      alias => $nagiosalias,
      target => $target,
      require => File[$target],
      before => Anchor['conf-after-run'],
      notify => Service['icinga'],
    }
  }
}
