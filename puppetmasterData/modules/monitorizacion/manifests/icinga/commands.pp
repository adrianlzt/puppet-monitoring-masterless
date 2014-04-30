define monitorizacion::icinga::commands (
  $command_line,
)
{
  include monitorizacion::params

  $target = "$monitorizacion::params::commands_dir/${name}.cfg"

  file { $target:
    ensure => present,
    owner => $monitorizacion::params::user,
    group => $monitorizacion::params::group,
    mode => 0644,
    before => Nagios_command[$name],
  }

  nagios_command { $name:
    ensure => present,
    command_line => $command_line,
    target => $target,
    require => File[$target],
    before => Anchor['conf-after-run'],
    notify => Service['icinga'],
  }
}
