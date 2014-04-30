#
#   check net interfaces should be defined:
#   Name: net_interfaces
#   Puppet type: monitorizacion::checks::netinterfaces
#   Example: no params
#
define monitorizacion::checks::netinterfaces (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set params
  $check_name = "check_netinterfaces"
  $package_name = "dsmctools-commonlinux-netinterfaces"
  $exec = "${check_name}.sh"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
