#
#   check calltrace should be defined:
#   Name: calltrace
#   Puppet type: monitorizacion::checks::calltrace
#   Example: no params
#
define monitorizacion::checks::calltrace (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set params
  $check_name = "check_calltrace"
  $package_name = "dsmctools-commonlinux-calltrace"
  $exec = "${check_name}.sh"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
