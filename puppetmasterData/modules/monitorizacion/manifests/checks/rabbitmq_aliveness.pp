#
#   rabbitmq_aliveness should be defined:
#   Name: rabbitmq_aliveness
#   Puppet type: monitorizacion::checks::rabbitmq_aliveness
#   Example: {"hostname":"localhost","args":"--username user --password pass --vhost vhost"}

define monitorizacion::checks::rabbitmq_aliveness (
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
  $check_name = "check_rabbit_aliveness"
  $package_name = "dsmctools-rabbitmq-aliveness"
  $exec = "${check_name}.py $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
