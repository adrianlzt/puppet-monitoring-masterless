#
#   mountpoints should be defined:
#   Name: mountpoints
#   Puppet type: monitorizacion::checks::mountpoints
#   Example: {"args":"-A"}
#
define monitorizacion::checks::mountpoints (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    $final_args =  '-A'
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
    $final_args = $args
  } 

  # Set params
  $check_name = "check_mountpoints"
  $package_name = "dsmctools-commonlinux-mountpointsnfs"

  $exec = "check_mountpoints_nfs.sh $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
