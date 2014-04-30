#
#   check swap should be defined:
#   Name: swap
#   Puppet type: monitorizacion::checks::swap
#   Example: {"args":"-w 99% -c 40%"}
#
define monitorizacion::checks::swap (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args =  '-w 99% -c 40%'
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  } 

  # Set params
  $check_name = "check_swap"
  $package_name = "nagios-plugins-swap"
  $exec = "${check_name} -a $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
