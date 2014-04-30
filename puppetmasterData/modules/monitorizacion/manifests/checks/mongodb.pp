#
#   mongodb check should be defined:
#   Name: mongodb
#   Puppet type: monitorizacion::checks::mongodb
#   Example: {"hostname":"localhost","action":"replication_lag","args":"-P 27017 -W 15 -C 30"}

define monitorizacion::checks::mongodb (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  
 # Parse JSON data
  $params_parsed = parsejson($params)
  $hostname = $params_parsed["hostname"]
  $action = $params_parsed["action"]
  $args = $params_parsed["args"]

  if empty($hostname) or empty($action) {
    fail("You must define at least the hostname and action")
  }

  if $args {
     $final_args = "-H $hostname -A $action $args"
  }else{
     $final_args = "-H $hostname -A $action "
  }
  
  # Set params
  $check_name = "check_mongodb_${name}"
  $package_name = "dsmctools-mongodb"
  $exec = "check_mongodb.py $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}

