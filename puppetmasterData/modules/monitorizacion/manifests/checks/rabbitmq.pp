#
#   rabbitmq should be defined:
#   Name: rabbitmq
#   Puppet type: monitorizacion::checks::rabbitmq
#   Example: {"args":"-c"}

define monitorizacion::checks::rabbitmq (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params


  # Set default values
  if empty($params) {
    fail("You must define at least the args")
  }
  else {
    $params_parsed = parsejson($params)
    $args = $params_parsed["args"]
  } 
  
  if empty($args) {
    fail("You must define at least the args")
  }else{
    $final_args = "$args"
  }

  # Set params
  $check_name = "check_rabbitmq"
  $package_name = "dsmctools-rabbitmq"
  $exec = "${check_name}.sh $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
