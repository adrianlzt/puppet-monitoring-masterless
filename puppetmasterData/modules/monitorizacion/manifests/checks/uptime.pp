#
#   uptime should be defined:
#   Name: uptime
#   Puppet type: monitorizacion::checks::uptime
#   Example: {"args":"-w 25"}
#
define monitorizacion::checks::uptime (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args =  '-w 25'
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  } 

  # Set params
  $check_name = "check_uptime"
  $package_name = "dsmctools-commonlinux-uptime"
  $exec = "check_uptime.pl -f $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
