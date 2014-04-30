#
#   rabbitmq_watermark should be defined:
#   Name: rabbitmq_watermark
#   Puppet type: monitorizacion::checks::rabbitmq_watermark
#   Example: {"hostname":"localhost","args":" --username usrname --vhost /foo"}

define monitorizacion::checks::rabbitmq_watermark (
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
  $check_name = "check_rabbitmq_watermark"
  $package_name = "dsmctools-rabbitmq-watermark"
  $exec = "check_rabbitmq_watermark.pl $final_args"

  monitorizacion::check { "${monitorizacion::params::resourcehost}.${check_name}":
    check_name => $check_name,
    package => $package_name,
    exec => $exec,
    vip_name => $vip_name,
  }

}
