define monitorizacion::icinga::contact (
  $encrypted_password,
  $email,
  $contactgroups = undef,
  $contact_alias = undef,
  $use = undef,
  $address1 = undef,
  $address2 = undef,
  $address3 = undef,
  $address4 = undef,
  $address5 = undef,
  $address6 = undef,
  $can_submit_commands = undef,
  $host_notification_commands = "notify-host-by-email",
  $host_notification_options = undef,
  $host_notification_period = "24x7",
  $host_notifications_enabled = undef,
  $pager = undef,
  $retain_nonstatus_information = undef,
  $retain_status_information = undef,
  $service_notification_commands = "notify-service-by-email",
  $service_notification_options = undef,
  $service_notification_period = "24x7",
  $service_notifications_enabled = undef,
)
{
  include monitorizacion::params

  # See https://github.com/adrianlzt/puppet-monitoring/issues/157
  if !empty($contactgroups) {
    $contactgroups_dash = regsubst($contactgroups, ',', '_', 'G')
    $nagios_contact = "${contactgroups_dash}-${name}"
    $_contactgroups = $contactgroups
  } else {
    $nagios_contact = $name
    $_contactgroups = undef
  }
    
  $target = "$monitorizacion::params::contacts_dir/${nagios_contact}.cfg"

  file { $target:
    ensure => present,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    mode => 0644,
    before => Nagios_contact[$nagios_contact],
  }

  nagios_contact { $nagios_contact:
    contact_name => $name,
    ensure => present,
    email => $email,
    alias => $alias,
    contactgroups => $_contactgroups,
    use => $use,
    register => $register,
    address1 => $address1,
    address2 => $address2,
    address3 => $address3,
    address4 => $address4,
    address5 => $address5,
    address6 => $address6,
    can_submit_commands => $can_submit_commands,
    host_notification_commands => $host_notification_commands,
    host_notification_options => $host_notification_options,
    host_notification_period => $host_notification_period,
    host_notifications_enabled => $host_notifications_enabled,
    pager => $pager,
    retain_nonstatus_information => $retain_nonstatus_information,
    retain_status_information => $retain_status_information,
    service_notification_commands => $service_notification_commands,
    service_notification_options => $service_notification_options,
    service_notification_period => $service_notification_period,
    service_notifications_enabled => $service_notifications_enabled,
    target => $target,
    require => File[$target],
    before => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }

  # Insert user in passwd file for Web access
  htpasswd { $name:
    cryptpasswd => "{SHA}$encrypted_password",
    target      => $monitorizacion::params::icinga_passwd,
    require     => File[$monitorizacion::params::icinga_passwd],
  }
}
