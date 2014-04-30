#
#   mysql_health check should be defined:
#   Name: mysql_health
#   Puppet type: monitorizacion::checks::mysql_health
#   Example: {"hostname":"localhost","username":"icinga","password":"icinga","mode":"connection-time","args":"--warning 80 --critical 70"}


define monitorizacion::checks::mysql_health (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  
 # Parse JSON data
  $params_parsed = parsejson($params)
  $hostname = $params_parsed["hostname"]
  $username = $params_parsed["username"]
  $password = $params_parsed["password"]
  $mode = $params_parsed["mode"]
  $args = $params_parsed["args"]

  if empty($mode) {
    fail("You must define at least the mode")
  }

  if $hostname {
     $_hostname = "--hostname $hostname"
  }else{
     $_hostname = ""
  }
  
  if $username { 
     $_username = "--username $username"
  }else{
     $_username = ""
  }
  
  if $password { 
     $_password = "--password $password"
  }else{
     $_password = "" 
  }
   
  if $args { 
     $_args = "$args"
  }else{
     $_args = ""
  }
      
  $final_args = "$_hostname $_username $_password --mode $mode $_args"
  
  # Set params
  $check_name = "check_mysql_health_${name}"
  $package_name = "dsmctools-mysql-health"
  $exec = "check_mysql_health.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }
}

