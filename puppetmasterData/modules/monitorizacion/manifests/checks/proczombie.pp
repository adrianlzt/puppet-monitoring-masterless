#
#   proczombie should be defined:
#   Name: proczombie
#   Puppet type: monitorizacion::checks::proczombie
#   Example: {"args":"-w 5 -c 10"}
#
define monitorizacion::checks::proczombie (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args =  '-w 5 -c 10'
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]

    $final_args = $args
  } 

  # Set params
  $check_name = "check_proc_zombie"
  $package_name = "nagios-plugins-procs"
  $exec = "check_procs $final_args -s Z"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
