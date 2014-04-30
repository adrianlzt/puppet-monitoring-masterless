#
# Ephemeral_ports check should be defined:
# Name: ephemeral_ports
# Puppet type: monitorizacion::checks::ephemeral_ports
# Example: {"args":"-w 30 -c 40"}
#

define monitorizacion::checks::ephemeral_ports (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

 # Set default values
  if empty($params) {
    $final_args = "-w 30 -c 40"  
  }

  else {
    $params_parsed = parsejson($params)
    $final_args = $params_parsed["args"]
  } 

 # Set params
  $check_name = "check_ephemeral_ports"
  $package_name = "dsmctools-commonlinux-ephemeralports"
  $exec = "${check_name}.sh $final_args" 

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}


