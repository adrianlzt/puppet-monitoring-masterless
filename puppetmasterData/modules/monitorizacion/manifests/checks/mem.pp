#
#   mem should be defined:
#   Name: mem
#   Puppet type: monitorizacion::checks::mem
#   Example:{"args":"-w 85 -c 95"}
#
define monitorizacion::checks::mem (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args = "-w 85 -c 95"
  }else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  } 

  # Set params
  $check_name = "check_pmp_memory"
  $package_name = "dsmctools-commonlinux-memory"
  $exec = "${check_name}.sh $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
