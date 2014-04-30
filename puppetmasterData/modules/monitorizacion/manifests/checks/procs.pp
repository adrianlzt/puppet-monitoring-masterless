#
#   procs check should be defined:
#   Name: procs
#   Puppet type: monitorizacion::checks::procs
#   Example: {"process":"ssh","args":"-w 10 -c 20 --metric=CPU"}

define monitorizacion::checks::procs (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  

  if empty($params) {
    fail("You must define the process name, the args or both")
  }
   # Parse JSON data
  $params_parsed = parsejson($params)
  $process = $params_parsed["process"]
  $args = $params_parsed["args"]

  if !$process {
     $final_args = $args
  }else {
    if !$args { 
       $final_args = "-w 1:1 -c 1:1 -C $process"
    }else{
       $final_args = "-C $process $args"
    }
  }
  # Set params
  $check_name = "check_procs_${name}"
  $package_name = "nagios-plugins-procs"
  $exec = "check_procs $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}
