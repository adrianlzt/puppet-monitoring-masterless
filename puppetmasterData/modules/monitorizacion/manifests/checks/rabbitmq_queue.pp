#
#   rabbitmq_queue should be defined:
#   Name: rabbitmq_queue
#   Puppet type: monitorizacion::checks::rabbitmq_queue
#   Example: {"hostname":"localhost","args":"--queue=newMessages --warning 200,200,200 --critical 1000,1000,1000"}

define monitorizacion::checks::rabbitmq_queue (
  $params = undef,
  $vip_name = undef,
)
{
  include monitorizacion::params

  # Set default values
  if empty($params) {
    fail("You must define at least the hostname ")
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
  $check_name = "check_rabbitmq_queue"
  $package_name = "dsmctools-rabbitmq-queue"
  $exec = "check_rabbit_queue.py $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
