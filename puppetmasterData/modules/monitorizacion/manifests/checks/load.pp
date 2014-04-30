#
# Load check should be defined:
#   Name: load
#   Puppet type: monitorizacion::checks::load
#   Example:{"args":"-w 20,15,15 -c 35,30,30"} 
#
define monitorizacion::checks::load (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    if ( $::processorcount > 16 ) {
      $final_args = '-w 60,40,40 -c 90,70,70'
    } elsif ( $::processorcount > 8 ) and ( $::processorcount <= 16 ) {
      $final_args = '-w 25,20,20 -c 40,35,35'
    } elsif ( $::processorcount > 4 ) and ( $::processorcount <= 8 ) {
      $final_args = '-w 20,15,15 -c 35,30,30'
    } else {
      $final_args = '-w 15,10,10 -c 30,25,25'
    }
  } else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  }

  # Set params
  $check_name = "check_load"
  $package_name = "nagios-plugins-load"
  $exec = "$check_name $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}

