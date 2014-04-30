#
#   check cpu should be defined:
#   Name: cpu
#   Puppet type: monitorizacion::checks::cpu
#   Example: without params
#
define monitorizacion::checks::cpu (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set params
  $check_name = "check_cpu"
  $package_name = "dsmctools-commonlinux-cpu"
  $exec = "${check_name}.pl"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
