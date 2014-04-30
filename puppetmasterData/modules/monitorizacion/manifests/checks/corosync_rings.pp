#
#   corosync_rings should be defined:
#   Name: corosync_rings
#   Puppet type: monitorizacion::checks::corosync_rings
#   Example: {"args":"-r 1"}

define monitorizacion::checks::corosync_rings (
  $params = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define at least args option")
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
  }


  if empty($args) {
    fail("You must define at least the args option")
  }else {
    $final_args = "$args"
  }

  # Set params
  $check_name = "check_corosync_rings"
  $package_name = "dsmctools-corosync-rings"
  $exec = "${check_name}.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
  }

}

