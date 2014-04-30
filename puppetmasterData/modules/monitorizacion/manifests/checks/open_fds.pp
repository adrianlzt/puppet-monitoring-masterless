#
#   open_fds check should be defined:
#   Name: open_fds
#   Puppet type: monitorizacion::checks::open_fds
#   Example: {"args":"-W 75 -C 90"}


define monitorizacion::checks::open_fds (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  
 # Parse JSON data
  if $params{
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
  }

  if $args { 
     $final_args = "$args"
  }else{
     $final_args = "-W 75 -C 90"
  }
      
  # Set params
  $check_name = "check_open_fds"
  $package_name = "dsmctools-commonlinux-openfds"
  $exec = "${check_name}.sh $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}

