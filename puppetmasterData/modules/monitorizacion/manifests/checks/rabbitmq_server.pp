#
#   rabbitmq_server should be defined:
#   Name: rabbitmq_server
#   Puppet type: monitorizacion::checks::rabbitmq_server
#   Example: {"hostname":"localhost","args":" --username usrname --password pass -w 100 -c 200"}

define monitorizacion::checks::rabbitmq_server (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define at least the hostname")
  }
  else {
    $params_parsed = parsejson($params)
    $hostname = $params_parsed["hostname"]
    $args = $params_parsed["args"]
  } 
  
  if empty($hostname) {
    fail("You must define at least the hostname")
  }

  if $args {
     $final_args = "-H $hostname $args"
  }else{
     $final_args = "-H $hostname"
  }

  # Set params
  $check_name = "check_rabbitmq_server"
  $package_name = "dsmctools-rabbitmq-server"
  $exec = "check_rabbit_server.py $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
