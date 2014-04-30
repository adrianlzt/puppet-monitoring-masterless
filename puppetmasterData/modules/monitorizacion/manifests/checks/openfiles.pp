#
#   openfiles check should be defined:
#   Name: openfiles
#   Puppet type: monitorizacion::checks::openfiles
#   Example: {"args":"-w 1 -c 7"}


define monitorizacion::checks::openfiles (
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
     $final_args = "-w 1 -c 7"
  }
      
  # Set params
  $check_name = "check_open_files"
  $package_name = "dsmctools-commonlinux-openfiles"
  $exec = "${check_name}.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}

