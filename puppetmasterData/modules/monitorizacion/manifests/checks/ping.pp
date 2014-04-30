#
#   ping check should be defined:
#   Name: ping
#   Puppet type: monitorizacion::checks::ping
#   Example: {"host":"192.168.0.1","args":"-w 100.0,60% -c 200.0,90%"}

define monitorizacion::checks::ping (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  
 # Parse JSON data
  if empty($params){
    fail ("You must define at least a host and warning and critical args")
  }else{
    $params_parsed = parsejson($params)
    $host = $params_parsed["host"]
    $args = $params_parsed["args"] 
  }
  if empty($host) or empty($args){
    fail ("You must define at least a host and warning and critical args")
  }else{ 
    $final_args = "-H $host $args"
  }
  
      
  # Set params
  $check_name = "check_ping_${name}"
  $package_name = "nagios-plugins-ping"
  $exec = "check_ping $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}

