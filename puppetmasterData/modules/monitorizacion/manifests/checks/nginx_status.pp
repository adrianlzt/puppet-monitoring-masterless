#
#   nginx_status should be defined:
#   Name: nginx_status
#   Puppet type: monitorizacion::checks::nginx_status
#   Example: {"hostname":"localhost","args":"-p 1024 -t 10"}

define monitorizacion::checks::nginx_status (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params){
    fail("You must define at least the hostname")
  }
  else {
    $params_parsed = parsejson($params)
    $hostname = $params_parsed["hostname"]
    $args = $params_parsed["args"]
  } 
  
  if empty($hostname){
    fail("You must define at least the hostname")
  }

  if $args {
     $final_args = "-H $hostname $args"
  }else{
     $final_args = "-H $hostname"
  }

  # Set params
  $check_name = "check_nginx_status"
  $package_name = "dsmctools-nginx-status"
  $exec = "check_nginx_status.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
